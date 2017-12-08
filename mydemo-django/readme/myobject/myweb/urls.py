"""myobject URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from . import views,viewsorders

urlpatterns = [
    #=========商品展示=================
    url(r'^$', views.index, name="index"),#网站首页
    url(r'^list$',views.list, name="list"),#商品列表页
    url(r'^detail/(?P<gid>[0-9]+)$',views.detail, name="detail"),#商品详情页
    

    # ==============会员模块==============
    url(r'^login$',views.login, name="login"), #登录页面
    url(r'^dologin$', views.dologin, name="dologin"),
    url(r'^logout$', views.logout, name="logout"),
    url(r'^logout$', views.logout, name="logout"),
    url(r'^dologout$', views.dologout, name="dologout"),

    url(r'^verify$',views.verify, name="verify"),#验证码
    url(r'^register$',views.register, name="register"), #注册页面
    url(r'^usersinsert$',views.usersinsert, name="usersinsert"), #注册页面


    # ===============购物车模块============
    url(r'^shopcart$',views.shopcart, name="shopcart"), #浏览购物车页面
    url(r'^shopcartadd/(?P<sid>[0-9]+)$',views.shopcartadd, name="shopcartadd"), #购物车页面
    url(r'^shopcartdel/(?P<sid>[0-9]+)$',views.shopcartdel, name="shopcartdel"), #删除商品
    url(r'^shopcartclear',views.shopcartclear, name="shopcartclear"), #清空购物车
    url(r'^shopcartchange',views.shopcartchange, name="shopcartchange"), #重新获取购物车数量

    # =============订单模块================

    url(r'^ordersform$',viewsorders.ordersform, name="ordersform"), #下订单页面
    url(r'^ordersconfirm$',viewsorders.ordersconfirm, name="ordersconfirm"), #确认订单页面
    url(r'^ordersinsert$',viewsorders.ordersinsert, name="ordersinsert"), #执行确认订单页面
    url(r'^ordersdetail$',viewsorders.ordersdetail, name="ordersdetail"), #浏览订单页面
    url(r'^orderstatus$',viewsorders.orderstatus, name="orderstatus"), #修改订单状态
    
    # =================个人中心=============
    url(r'^member$',viewsorders.member, name="member"), #会员中心页面
    url(r'^memberedit$',viewsorders.memberedit, name="memberedit"), #会员中心页面
    url(r'^memberupdate/(?P<mid>[0-9]+)$',viewsorders.memberupdate, name="memberupdate"), #会员中心页面

]
