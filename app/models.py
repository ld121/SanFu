from django.db import models

# Create your models here.
#轮播图
class Wheel(models.Model):
    img = models.CharField(max_length=300) #图片地址

    class Meta:
        db_table = 'sf_wheel'

#导航标志图
class BannerUrl(models.Model):
    img = models.CharField(max_length=300) #图片地址
    categoryid = models.CharField(max_length=100)  # 分类id
    class Meta:
        db_table = 'sf_bannerurl'

#商品
class Goods(models.Model):
    img = models.CharField(max_length=300) #图片地址
    name = models.CharField(max_length=300) #图片名
    truckid = models.CharField(max_length=100)  # 商品id
    original = models.DecimalField(max_digits=5, decimal_places=1) #原价
    present = models.DecimalField(max_digits=5, decimal_places=1) #现价
    categoryid = models.CharField(max_length=100) #分类id
    childid = models.CharField(max_length=100) #子类id
    childname = models.CharField(max_length=200) #子类名称
    dealerid  = models.CharField(max_length=100) #详情页id
    hot = models.IntegerField() #是否热卖
    new = models.IntegerField() #是否新品
    class Meta:
        db_table = 'sf_goods'

class User(models.Model):
    # 邮箱
    email = models.CharField(max_length=40, unique=True)
    # 密码
    password = models.CharField(max_length=256)
    # 昵称
    name = models.CharField(max_length=100)
    class Meta:
        db_table = 'sf_user'

class Car(models.Model):
    # 用户信息
    user = models.ForeignKey(User)
    # 商品信息
    goods = models.ForeignKey(Goods)
    #商品数量
    number = models.IntegerField()
    #是否选择
    isselect = models.BooleanField(default=True)
    #是否删除
    isdelete = models.BooleanField(default=False)
    class Meta:
        db_table = 'sf_car'

# 订单
class Order(models.Model):
    user = models.ForeignKey(User)
    # 创建时间
    createtime = models.DateTimeField(auto_now_add=True)
    # 更新时间
    updatetime = models.DateTimeField(auto_now=True)
    # 状态
    # -1 过期
    # 0 未付款
    # 1 已付款，待发货
    # 2 已发货，待收货
    # 3 已收货，待评价
    # 4 已评价
    status = models.IntegerField(default=0)
    # 订单号
    identifier = models.CharField(max_length=256)



# 订单商品
class OrderGoods(models.Model):
    # 订单
    order = models.ForeignKey(Order)
    # 商品
    goods = models.ForeignKey(Goods)

    # 商品选择规格
    number = models.IntegerField()