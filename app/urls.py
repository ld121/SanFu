from django.conf.urls import url

from app import views

urlpatterns = [
    url(r'^index/$',views.index,name='index' ),#首页

    url(r'^login/$',views.login,name='login'),#登录
    url(r'^logout/$',views.logout,name='logout'),#退出
    url(r'^regiest/$',views.regiest,name='regiest'),#注册
    url(r'^checkemail/$',views.checkemail,name='checkemail'),#验证账号

    url(r'^goodsList/$',views.goodsList,name='goodsList'),#商品列表
    url(r'^goodsMsg/(\d+)/$',views.goodsMsg,name='goodsMsg'),#商品详情

    url(r'^cart/$',views.cart,name='cart' ),#购物车
    url(r'^addcart/$',views.addcart,name='addcart' ),#添加购物车
    url(r'^chekall/$',views.chekall,name='chekall'),
    url(r'^order/$',views.order,name='order'),

]