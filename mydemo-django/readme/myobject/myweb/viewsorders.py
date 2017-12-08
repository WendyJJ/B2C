from django.shortcuts import render
from django.http import HttpResponse
from myweb.models import Types,Goods,Users,Orders,Detail

from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from PIL import Image
import time,json

# ========公共信息加载函数========
def loadinfo():
    context = {}
    context['type0list'] = Types.objects.filter(pid=0)
    return context

# 订单页面
def ordersform(request):
    # context = loadinfo()
    #获取要结算的商品id信息
    # ids = request.GET['gids']
    ids = request.GET.get('gids','')
    if ids == '':
        return HttpResponse("请选择要结账的商品")
    gids = ids.split(',')
    #获取购物车中的商品信息
    shoplist = request.session['shoplist']
    #封装要结账的商品信息,以及累计总金额
    orderlist = {}
    total = 0
    for sid in gids:
        orderlist[sid] = shoplist[sid]
        total += shoplist[sid]['price']*shoplist[sid]['m']#累计总金额
    request.session['orderlist'] = orderlist
    request.session['total'] = total
    return render(request,"myweb/ordersform.html")

#订单确认页
def ordersconfirm(request):
    return render(request,"myweb/ordersconfirm.html")

#订单确认
def ordersinsert(request):
    #封装订单信息,并执行添加
    orders = Orders()
    orders.uid = request.session['vipuser']['id']
    orders.linkman = request.POST['linkman']
    orders.address = request.POST['address']
    orders.code = request.POST['code']
    orders.phone = request.POST['phone']
    orders.addtime = time.time()
    orders.total = request.session['total']
    orders.status = 0
    orders.save()
    #获取订单详情
    orderlist = request.session['orderlist']
    shoplist = request.session['shoplist']
    #遍历购物信息,并添加订单详情信息
    for shop in orderlist.values():
        del shoplist[str(shop['id'])]
        detail = Detail()
        detail.orderid = orders.id
        detail.goodsid = shop['id']
        detail.name = shop['goods']
        detail.price = shop['price']
        detail.num = shop['m']
        detail.save()
        # del shoplist[shop['id']]
    del request.session['orderlist']
    del request.session['total']
    request.session['shoplist'] = shoplist
    return HttpResponse("订单成功:订单id号:"+str(orders.id))
    # return redirect(reverse('shopcart'))

#浏览我的订单
def ordersdetail(request):
    #从session中获取登录者的id,并从订单表orders中获取当前用户的所有订单
    ww = request.session['vipuser']['id']
    list2 = Orders.objects.filter(uid=ww) 
    #遍历当前用户的所有订单信息,并获取每个订单所对应的订单详情信息,并以detaillist属性放置
    for xx in list2:
        dd = Detail.objects.filter(orderid=xx.id)  #获取当前订单中详情
        xx.detaillist = dd   #将订单详情以detaillist书信放置到订单对象中
        sj = xx.addtime
        xx.sj = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(sj))

        #遍历当前的订单详情,并追加每个商品的图片信息
        for gg in dd:
            goods = Goods.objects.get(id=gg.goodsid)
            gg.picname = goods.picname

            # od = Orders.objects.get(id=gg.orderid)
            # gg.oraddtime = od.addtime
            
    # #封装信息
    context = {"orderlist":list2}
    return render(request,'myweb/ordersdetail.html',context)
#修改订单状态
def orderstatus(request):
    ob = Orders.objects.get(id=request.POST['id'])
    # print(ob.__dict__)
    ob.status = request.POST['status']
    ob.save()
    return redirect(reverse('ordersdetail')) 

# 我的个人中心页面
def member(request):
    context = loadinfo()
    return render(request,"myweb/member.html",context)

#编辑个人中心
def memberedit(request):
    context = loadinfo()
    return render(request,"myweb/memberedit.html",context)

# 执行会员信息编辑
def memberupdate(request,mid):
    try:
        ob = Users.objects.get(id=mid)
        ob.name = request.POST['name']
        ob.address = request.POST['address']
        ob.phone = request.POST['phone']
        ob.email = request.POST['email']
        ob.save()
        context = {'info':'修改成功！'}
    except:
        context = {'info':'修改失败！'}
    return render(request,"myweb/info.html",context)