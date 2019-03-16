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
    #商品数量

    #是否选择

    #是否删除

    class Meta:
        db_table = 'sf_car'