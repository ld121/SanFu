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
    url(r'orderlist/$', views.orderlist, name='orderlist'),

    url(r'^returnurl/$', views.returnurl, name='returnurl'),    # 支付成功后，客户端的显示
    url(r'^appnotifyurl/$', views.appnotifyurl, name='appnotifyurl'), # 支付成功后，订单的处理
    url(r'^pay/$', views.pay, name='pay'),  # 支付

]