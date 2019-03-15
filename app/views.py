from django.shortcuts import render

# Create your views here.
from app.models import Wheel, BannerUrl, Goods


def index(request):
    wheels = Wheel.objects.all()
    bannerurl1 = BannerUrl.objects.get(pk=1)
    bannerurl2 = BannerUrl.objects.get(pk=2)
    bannerurl3 = BannerUrl.objects.get(pk=3)
    goodnews = Goods.objects.filter(hot=1).filter(new=1)
    goodhots = Goods.objects.filter(childname='面膜')
    goodmans = Goods.objects.filter(childname='男装')
    goodwomans = Goods.objects.filter(childname='女装')
    responce={
        'wheels':wheels,
        'bannerurl1':bannerurl1,
        'bannerurl2': bannerurl2,
        'bannerurl3': bannerurl3,
        'goodnews': goodnews,
        'goodhots':goodhots,
        'goodwomans':goodwomans,
        'goodmans':goodmans
    }
    return render(request,'index.html',responce)


def cart(request):
    return render(request,'cart.html')


def login(request):
    return render(request,'login.html')


def regiest(request):
    return render(request,'regiest.html')


def goodsList(request):
    return render(request,'goodsList.html')


def goodsMsg(request):
    return render(request,'goodsMsg.html')