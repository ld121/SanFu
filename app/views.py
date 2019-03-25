import hashlib
import random
import time

from django.core.cache import cache
from django.http import JsonResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.views.decorators.csrf import csrf_exempt
from urllib.parse import parse_qs

from app.alipay import alipay
from app.models import Wheel, BannerUrl, Goods, User, Car, Order, OrderGoods


#首页
def index(request):
    wheels = Wheel.objects.all()
    bannerurl1 = BannerUrl.objects.get(pk=1)
    bannerurl2 = BannerUrl.objects.get(pk=2)
    bannerurl3 = BannerUrl.objects.get(pk=3)
    goodnews = Goods.objects.filter(hot=1).filter(new=1)
    goodhots = Goods.objects.filter(childname='面膜')
    goodmans = Goods.objects.filter(childname='男装')
    goodwomans = Goods.objects.filter(childname='女装')

    response_data = {
        'wheels': wheels,
        'bannerurl1': bannerurl1,
        'bannerurl2': bannerurl2,
        'bannerurl3': bannerurl3,
        'goodnews': goodnews,
        'goodhots': goodhots,
        'goodwomans': goodwomans,
        'goodmans': goodmans,
        'user': None
    }

    # 获取token,得到对应用户
    token = request.session.get('token')
    userid = cache.get(token)
    if userid:
        user = User.objects.get(pk=userid)
        response_data['user'] = user

    return render(request,'index.html',response_data)

#解析密码
def generate_password(param):
    md5 = hashlib.md5()
    md5.update(param.encode('utf-8'))
    return md5.hexdigest()

#生成token
def generate_token():
    temp = str(time.time()) + str(random.random())
    md5 = hashlib.md5()
    md5.update(temp.encode('utf-8'))
    return md5.hexdigest()

#登录
def login(request):
    if request.method == 'GET':
        return render(request, 'login.html')
    elif request.method == 'POST':
        #获取账号密码
        email = request.POST.get('loginName')
        password = generate_password(request.POST.get('loginPwd'))
        #记录哪个页面进来的
        back = request.COOKIES.get('back')
        users = User.objects.filter(email=email)

        response_data={
            'user':None
        }
        if users.exists():
            user = users.first()
            if user.password == password:
                # 更新token
                token = generate_token()

                # 状态保持
                cache.set(token, user.id, 60 * 60 * 24 * 3)

                # 传递客户端
                request.session['token'] = token


                return redirect('sanfu:index')
            else:
                return render(request, 'login.html', context={'ps_err': '密码错误'})
        else:
            return render(request, 'login.html', context={'user_err': '用户不存在'})



#退出
def logout(request):
    request.session.flush()

    return redirect('sanfu:index')

#注册
def regiest(request):
    if request.method == 'GET':
        return render(request,'regiest.html')
    elif request.method == 'POST':
        #获取数据
        name = request.POST.get('uername')
        email = request.POST.get('email')
        password = generate_password(request.POST.get('password'))
        #储存数据
        user = User()
        user.name = name
        user.email = email
        user.password = password
        user.save()

        #状态保持
        token = generate_token()
        # key-value  >>  token:userid
        cache.set(token, user.id, 60 * 60 * 24 * 3)

        request.session['token'] = token


        return redirect('sanfu:index')


#商品列表
def goodsList(request):
    return render(request,'goodsList.html')

#商品详情
def goodsMsg(request,dealerid):

    good = Goods.objects.get(dealerid=dealerid)

    response_data={
        'good':good
    }
    return render(request,'goodsMsg.html',response_data)

#账号验证
def checkemail(request):
    email = request.GET.get('email')
    check = User.objects.filter(email=email)
    if check.exists():
        response_data = {
            'static':1,
            'msg':'账号已存在！'
        }
    else:
        response_data = {
            'static':0,
            'msg': '账号可用！'
        }
    return JsonResponse(response_data)

#购物车
def cart(request):
    # 拿到token
    token = request.session.get('token')
    userid = cache.get(token)
    thecar = Car.objects.filter(user_id=userid)
    carts = thecar.filter(isdelete=0)
    cselect = thecar.filter(isselect=1)

    cartid = request.GET.get('cartid')


    if cartid:
        mycar = Car.objects.get(pk=cartid)


        status = request.GET.get('status')

        if status == '1':
            mycar.number =  mycar.number+ 1

            mycar.save()


        elif status == '-1':
            if mycar.number != 1:
                mycar.number = mycar.number - 1
                mycar.save()

            else:
                mycar.number = 0
                mycar.isdelete = True
                mycar.save()


    data = {
       'carts':carts
    }

    return render(request,'cart.html',data)

def addcart(request):
    # 拿到token
    token = request.session.get('token')
    # 根据token在缓存中找到对应用户
    if token:
        #获取对应用户
        userid = cache.get(token)
        user = User.objects.get(pk=userid)
        #获取对应商品信息
        goodsid = request.GET.get('goodsid')
        goods = Goods.objects.get(pk=goodsid)
        # 获取商品数量
        numb = request.GET.get('numb')
        # 获取选择的是购物车还是立即购买
        shopway = request.GET.get('shopway')
        #判断商品是否已经存在购物车中
        carts = Car.objects.filter(user=user).filter(goods=goods)

        if carts.exists():
            if shopway:
                cart = carts.first()
                cart.number = cart.number + int(numb)
                cart.isdelete = False
                cart.save()

        else:
            cart = Car()
            cart.user = user
            cart.goods = goods
            cart.number = numb
            cart.save()
        response_data = {
            'status':1,
            'msg':'添加购物车成功'
        }
        return JsonResponse(response_data)

    else:
        response_data = {
            'status': -1,
            'msg': '请登录再操作'
        }
        return JsonResponse(response_data)

# 全选
def chekall(request):
    status = request.GET.get('status')
    cartid = request.GET.get('checkone')
    # 确定用户
    print(cartid)
    token = request.session.get('token')
    userid = cache.get(token)

    carts = Car.objects.filter(user_id=userid)
    # 确定商品选择情况

    allcar = carts.filter(isdelete=0)

    if status == '1':

        allprice = 0
        for car in allcar:
            car.isselect=1
            car.save()
            numb = car.number
            price = car.goods.original
            allprice = allprice+numb*price
        print(allprice)
        response_data = {
            'numb': 1,
            'allprice':allprice
        }
        return JsonResponse(response_data)
    elif status == '2':

        for car in allcar:
            car.isselect=0
            car.save()
        response_data = {
            'numb': 2,
        }
        return JsonResponse(response_data)
    elif status == '3':
        onegood = Car.objects.get(pk=cartid)
        onegood.isselect = 1
        onegood.save()
        cars = carts.filter(isselect=1)
        allprice = 0
        for car in cars:
            numb = car.number
            price = car.goods.original
            allprice = allprice + numb * price

        response_data = {
            'numb': 3,
            'allprice':allprice
        }
        return JsonResponse(response_data)
    elif status == '4':
        onegood = Car.objects.get(pk=cartid)
        onegood.isselect = 0
        onegood.save()
        cars = carts.filter(isselect=1)
        allprice = 0
        for car in cars:
            numb = car.number
            price = car.goods.original
            allprice = allprice + numb * price

        response_data = {
            'numb': 4,
            'allprice': allprice
        }
        return JsonResponse(response_data)

#生成订单号
def generate_identifier():
    temp = str(time.time()) + str(random.randrange(1000, 10000))
    return temp

#订单
def order(request):
    token = request.session.get('token')
    userid = cache.get(token)
    user = User.objects.get(pk=userid)
    cart = Car.objects.filter(user_id=userid)

    # 订单
    order = Order()
    order.user = user
    order.identifier = generate_identifier()
    order.save()

    # 订单商品(购物车中选中)
    carts = cart.filter(isselect=1)
    for cart in carts:
        orderGoods = OrderGoods()
        orderGoods.order = order
        orderGoods.goods = cart.goods
        orderGoods.number = cart.number
        orderGoods.save()

        # 购物车中移除
        cart.delete()

    return render(request, 'order.html', context={'order': order})

def orderlist(request):
    token = request.session.get('token')
    userid = cache.get(token)
    user = User.objects.get(pk=userid)

    orders = user.order_set.all()

    # status_list = ['未付款', '待发货', '待收货', '待评价', '已评价']

    return render(request, 'orderlist.html', context={'orders':orders})

def orderdetail(request, identifier):
    order = Order.objects.filter(identifier=identifier).first()

    return render(request, 'order.html', context={'order': order})

def returnurl(request):
    return redirect('sanfu:index')


# 支付宝异步回调是post请求
@csrf_exempt
def appnotifyurl(request):
    if request.method == 'POST':
        # 获取到参数
        body_str = request.body.decode('utf-8')

        # 通过parse_qs函数
        post_data = parse_qs(body_str)

        # 转换为字典
        post_dic = {}
        for k,v in post_data.items():
            post_dic[k] = v[0]

        # 获取订单号
        out_trade_no = post_dic['out_trade_no']

        # 更新状态
        Order.objects.filter(identifier=out_trade_no).update(status=1)

    return JsonResponse({'msg':'success'})


def pay(request):
    # print(request.GET.get('orderid'))

    orderid = request.GET.get('orderid')
    order = Order.objects.get(pk=orderid)

    sum = 0
    for orderGoods in order.ordergoods_set.all():
        sum += orderGoods.goods.original * orderGoods.number

    # 支付地址信息
    data = alipay.direct_pay(
        subject='MackBookPro [256G 8G 灰色]', # 显示标题
        out_trade_no=order.identifier,    # 订单号
        total_amount=str(sum),   # 支付金额
        return_url='http://39.98.191.182/returnurl/'
    )

    # 支付地址
    alipay_url = 'https://openapi.alipaydev.com/gateway.do?{data}'.format(data=data)

    response_data = {
        'msg': '调用支付接口',
        'alipayurl': alipay_url,
        'status': 1
    }

    return JsonResponse(response_data)