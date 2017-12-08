from django.shortcuts import render
from django.http import HttpResponse
from myweb.models import Types,Goods,Users

from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from PIL import Image
import time,json

# ========公共信息加载函数========
def loadinfo():
    context = {}
    context['type0list'] = Types.objects.filter(pid=0)
    return context
# ========网站首页=========
def index(request):
    context={}
    list = Goods.objects.filter(typeid=11)
    #商品点击量排序
    list = list.raw('select * from goods order by clicknum desc')
    list2 = Goods.objects.filter(typeid=2)
    #商品点击量排序
    list2 = list2.raw('select * from goods order by clicknum desc')
    list3 = Goods.objects.filter(typeid=5)
    #商品点击量排序
    list3 = list3.raw('select * from goods order by clicknum desc')
    context['goodslist'] = list
    context['goodslist2'] = list2
    context['goodslist3'] = list3
    return render(request,"myweb/index.html",context)

# ========网站列表页=========
def list(request):
    context = loadinfo()
    list = Goods.objects.filter()
    if request.GET.get('tid','') != '':
    	tid = str(request.GET.get('tid',''))
    	list = list.filter(typeid__in=Types.objects.only('id').filter(path__contains=','+tid+','))
    context['goodslist'] = list
    return render(request,"myweb/list.html",context)
# ==========网站详情页=========
def detail(request,gid):
    context = loadinfo()
    ob = Goods.objects.get(id=gid)
    #累计点击量
    ob.clicknum += 1
    ob.save()
    context['goods'] = ob
    return render(request,"myweb/detail.html",context)

# ================网站登录===退出页面========
def login(request):
    context = loadinfo()
    return render(request,"myweb/login.html",context)

# 会员执行登录
def dologin(request):
    #校验验证码
    verifycode = request.session['verifycode']
    code = request.POST['code']
    if verifycode != code:
        context = {'info':'验证码错误!'}
        return render(request,"myweb/login.html",context)
    try:
        #根据账号获取登录者信息
        user = Users.objects.get(username=request.POST['username'])
        #判断当前用户是否是后台普通用户
        if user.state == 1 or user.state == 0:
            # 验证密码
            import hashlib
            m = hashlib.md5() 
            m.update(bytes(request.POST['password'],encoding="utf8"))
            if user.password == m.hexdigest():
                # 此处登录成功，将当前登录信息放入到session中，并跳转页面
                request.session['vipuser'] = user.toDict()#user.toDict()
                #print(json.dumps(user))
                return redirect(reverse('index'))
            else:
                context = {'info':'登录密码错误！'}
        else:
            context = {'info':'此用户非后台管理用户！'}
    except:
        context = {'info':'登录账号错误！'}
    return render(request,"myweb/login.html",context)
#
def dologout(request):
    request.session['vipuser'] = 0
    return render(request,"myweb/index.html")

# 会员退出
def logout(request):
    # 清除登录的session信息
    del request.session['vipuser']
    # 跳转登录页面（url地址改变）
    return redirect(reverse('login'))
    # 加载登录页面(url地址不变)
    return render(request,"myweb/login.html")
    

# ==============================管理员操作===========================
# 会员登录表单
def verify(request):
    #引入随机函数模块
    import random
    from PIL import Image, ImageDraw, ImageFont
    #定义变量，用于画面的背景色、宽、高
    #bgcolor = (random.randrange(20, 100), random.randrange(
    #    20, 100),100)
    bgcolor = (242,164,247)
    width = 100
    height = 25
    #创建画面对象
    im = Image.new('RGB', (width, height), bgcolor)
    #创建画笔对象
    draw = ImageDraw.Draw(im)
    #调用画笔的point()函数绘制噪点
    for i in range(0, 100):
        xy = (random.randrange(0, width), random.randrange(0, height))
        fill = (random.randrange(0, 255), 255, random.randrange(0, 255))
        draw.point(xy, fill=fill)
    #定义验证码的备选值
    str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
    #随机选取4个值作为验证码
    rand_str = ''
    for i in range(0, 4):
        rand_str += str1[random.randrange(0, len(str1))]
    #构造字体对象，ubuntu的字体路径为“/usr/share/fonts/truetype/freefont”
    font = ImageFont.truetype('static/myweb/fonts/STXIHEI.TTF', 21)
    #font = ImageFont.load_default().font
    #构造字体颜色
    fontcolor = (255, random.randrange(0, 255), random.randrange(0, 255))
    #绘制4个字
    draw.text((5, 0), rand_str[0], font=font, fill=fontcolor)
    draw.text((25, 0), rand_str[1], font=font, fill=fontcolor)
    draw.text((50, 0), rand_str[2], font=font, fill=fontcolor)
    draw.text((75, 0), rand_str[3], font=font, fill=fontcolor)
    #释放画笔
    del draw
    #存入session，用于做进一步验证
    request.session['verifycode'] = rand_str
    """
    python2的为
    # 内存文件操作
    import cStringIO
    buf = cStringIO.StringIO()
    """
    # 内存文件操作-->此方法为python3的
    import io
    buf = io.BytesIO()
    #将图片保存在内存中，文件类型为png
    im.save(buf, 'png')
    #将内存中的图片数据返回给客户端，MIME类型为图片png
    return HttpResponse(buf.getvalue(), 'image/png')

# ===========网站注册页面========
def register(request):
    context = loadinfo()
    return render(request,"myweb/register.html",context)

# 执行添加
#执行会员信息添加    
def usersinsert(request):
    try:
        ob = Users()
        ob.username = request.POST['username']
        ob.name = request.POST['name']
        #获取密码并md5
        import hashlib
        m = hashlib.md5() 
        m.update(bytes(request.POST['password'],encoding="utf8"))
        ob.password = m.hexdigest()
        ob.sex = request.POST['sex']
        ob.address = request.POST['address']
        ob.code = request.POST['code']
        ob.phone = request.POST['phone']
        ob.email = request.POST['email']
        ob.state = 1
        ob.addtime = time.time()
        ob.save()
        context = {'info':'注册成功！请登录!'}

    except:
        context = {'info':'注册失败！此账户已注册或填写错误,请您重新注册!'}

    return render(request,"myweb/info.html",context)
# ===========网站购物车======订单页面========
# 浏览购物车
def shopcart(request):
    context = loadinfo()
    if 'shoplist' not in request.session:
        request.session['shoplist']={}
    return render(request,"myweb/shopcart.html",context)

# 添加商品============待修改===================
def shopcartadd(request,sid):
    # context = loadinfo()
    #获取要添加的购物车信息
    goods = Goods.objects.get(id=sid)
    shop = goods.toDict();
    shop['m'] = int(request.POST['m']) #添加一个购买量属性

    #获取原购物车中的信息
    if 'shoplist' in request.session:
        shoplist = request.session['shoplist']
    else:
        shoplist = {}

    #判断并放置到session中
    if sid in shoplist:
        
        shoplist[sid]['m'] += shop['m'] #若购物车中已包含要购买的商品，就将购买量加1，
        print(shoplist[sid]['m'])
    else:
       
        shoplist[sid] = shop  # 若不存在则将当前商品直接放入购物车goodslist中

    #将购物车信息goodslist放入到session中
    request.session['shoplist'] = shoplist
    return redirect(reverse('shopcart'))

#删除商品
def shopcartdel(request,sid):
    #获取购物车中的商品
    shoplist = request.session['shoplist']
    #删除对应的商品
    del shoplist[sid]
    #放回购物车到session中
    request.session['shoplist']=shoplist
    return redirect(reverse('shopcart'))
#清空购物车
def shopcartclear(request):
    context = loadinfo()
    request.session['shoplist'] = {}
    return render(request,"myweb/shopcart.html",context)

#重新获取购物车数量
def shopcartchange(request):
    context = loadinfo()
    shoplist = request.session['shoplist']
    # 获取信息
    shopid = request.GET['sid']
    num = int(request.GET['num'])
    if num<1:
        num = 1
    shoplist[shopid]['m'] = num #更改商品数量
    request.session['shoplist'] = shoplist
    return redirect(reverse('shopcart'))
    # return render(request,"myweb/shopcart.html",context)
