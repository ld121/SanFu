import hashlib
import random
import time

from django.core.cache import cache
from django.http import JsonResponse
from django.shortcuts import render, redirect

# Create your views here.


from app.models import Wheel, BannerUrl, Goods, User

#首页
def index(request,):
    wheels = Wheel.objects.all()
    bannerurl1 = BannerUrl.objects.get(pk=1)
    bannerurl2 = BannerUrl.objects.get(pk=2)
    bannerurl3 = BannerUrl.objects.get(pk=3)
    goodnews = Goods.objects.filter(hot=1).filter(new=1)
    goodhots = Goods.objects.filter(childname='面膜')
    goodmans = Goods.objects.filter(childname='男装')
    goodwomans = Goods.objects.filter(childname='女装')

    response = {
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
        user = User.objects.get(pk= userid)
        response['user'] = user

    return render(request,'index.html',response)

#购物车
def cart(request):
    return render(request,'cart.html')

#解析密码
def generate_password(param):
    md5 = hashlib.md5()
    md5.update(param.encode('utf-8'))
    return md5.hexdigest()

#登录
def login(request):
    if request.method == 'GET':
        return render(request, 'login.html')
    elif request.method == 'POST':
        #获取账号密码
        email = request.POST.get('username')
        password = request.POST.get('password')
        #记录哪个页面进来的
        back = request.COOKIES.get('back')
        users = User.objects.filter(email=email)
        if users.exists():
            user = users.first()
            if user.password == generate_password(password):
                # 更新token
                token = generate_token()

                # 状态保持
                cache.set(token, user.id, 60 * 60 * 24 * 3)

                # 传递客户端
                request.session['token'] = token
                return redirect('sanfu:'+back)
            else:
                return render(request, 'login.html', context={'ps_err': '密码错误'})
        else:
            return render(request, 'login.html', context={'user_err': '用户不存在'})



#退出
def logout(request):
    request.session.flush()

    return redirect('sanfu:index')

#生成token
def generate_token():
    temp = str(time.time()) + str(random.random())
    md5 = hashlib.md5()
    md5.update(temp.encode('utf-8'))
    return md5.hexdigest()

#注册
def regiest(request):
    if request.method == 'GET':
        return render(request,'regiest.html')
    elif request.method == 'POST':
        #获取数据
        name = request.POST.get('uername')
        email = request.POST.get('email')
        password =request.POST.get('password')
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

    return render(request,'goodsMsg.html')

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


