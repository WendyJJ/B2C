from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from myadmin.models import Users,Types,Goods,Orders,Detail
from PIL import Image
import time,json,os



#+================后台商品订单信息管理=======
#浏览商品订单信息
def ordersindex(request):
    # 执行数据查询，并放置到模板中
    list = Orders.objects.filter() #获取所有商品信息
    context = {"orderlist":list}
    return render(request,"myadmin/orders/index.html",context)

#浏览订单详情
def detailindex(request,did):
     # 执行数据查询，并放置到模板中,跨表
    list2 = Detail.objects.filter(orderid=did) #获取所有订单信息
    print(list2)
    #遍历商品信息并查询关联的类别名称
    for orders in list2:
        goods = Goods.objects.get(id=orders.goodsid)
        orders.picname = goods.picname
    # #封装分页信息
    context = {"detaillist":list2}
    return render(request,'myadmin/orders/detailindex.html',context)
#编辑
def ordersedit(request,did):
     # 执行数据查询，并放置到模板中,跨表
    list2 = Detail.objects.filter(orderid=did) #获取所有订单信息
    print(list2)
    #遍历商品信息并查询关联的类别名称
    for orders in list2:
        goods = Goods.objects.get(id=orders.goodsid)
        orders.picname = goods.picname
        od = Orders.objects.get(id=did)
        orders.status = od.status
    # #封装分页信息
    context = {"detaillist":list2}
    print(list2.__dict__)
    return render(request,'myadmin/orders/ordersedit.html',context)
#执行编辑表单操作
def ordersupdate(request):
    try:      
        ob = Orders.objects.get(id=request.POST['id'])
        ob.status = request.POST['status']
        ob.save()
        context = {'info':'修改成功!'}
    except:
        context = {'info':'修改失败!'}
    return render(request,"myadmin/info.html",context)
