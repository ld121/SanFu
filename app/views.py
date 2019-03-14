from django.shortcuts import render

# Create your views here.
def index(request):
    return render(request,'index.html')


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