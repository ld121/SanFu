// $(function() {
// 	//获取购物车数据
// 	var cartArr = $.cookie("cart") ? JSON.parse($.cookie("cart")) : [];
// 	console.log(cartArr);
// 	if(cartArr.length == 0) {
// 		var html = "<tr><td colspan='7'>购物车中没有商品记录！</td></tr>";
// 		$("#mycart").append(html);
//
// 	} else {
// 		//console.log(cartArr);
// 		var allnum = 0;
// 		var total = 0;
// 		for(var i = 0; i < cartArr.length; i++) {
// 			var goods = cartArr[i];
// 			allnum += parseInt(goods.count);
// 			var pricestr = goods.price;
// 			pricestr = pricestr.substring(1);
// 			var count = goods.count;
// 			var html = "<tr><td><input type='checkbox'/></td>";
// 			html += "<td><img style='" + goods.colorimg + "'/></td>";
// 			html += "<td><span>" + goods.name + "</span><p>" + goods.colorname + "," + goods.size + "</p></td>";
// 			html += "<td><span>" + goods.price + "元</span></td>";
// 			html += "<td><button class='sub'>-</button><input type='text' value='" + goods.count + "'/><span></span><button class='add'>+</button></td>";
// 			html += "<td><span>￥" + (count * pricestr) + "元</span></td>";
// 			html += "<td><a class='delethis'>删除商品</a></td></tr>";
// 			$("#mycart").find().remove().end().append(html);
// 			total += count * pricestr;
// 		}
// 		//全部数量和总价
// 		$(".cartDele b").text(allnum);
// 		$(".cartToal b").text(total);
// 		//全选按钮事件
// 		$("#checkall").click(function() {
// 			if($("#checkall").prop("checked") == true) {
// 				$("#mycart").find("input[type='checkbox']").attr("checked", true);
// 			}
// 		})
// 		$("#mycart").find("input[type='checkbox']").click(function() {
// 				if($(this).prop("checked") == false) {
// 					$("#checkall").attr("checked", false);
// 				}
// 			})
// 			//删除某行商品
// 		$(".delethis").click(function() {
// 				$(this).parents("tr").remove();
// 				var i = $(this).index();
// 				bindgoods(i);
// 			})
// 			//删除选中商品
// 		$("#deleteGoods").click(function() {
// 				for(var k = 0; k <= cartArr.length; k++) {
// 					if($("#mycart tr td").parent("tr").eq(k).find("input[type='checkbox']").prop("checked") == true) {
// 						$("#mycart tr td").parent("tr").eq(k).remove();
// 						bindgoods(k);
// 						k--;
// 					}
// 				}
//
// 			})
// 			//重新绑定数据
// 		var bindgoods = function(k) {
// 			cartArr.splice(k, 1);
// 			$.cookie("cart", JSON.stringify(cartArr), {
// 				expries: 7,
// 				path: "/"
// 			});
// 			window.location.reload();
// 		}
// 		//加减商品
// 		$(".sub").click(function(){
// 			var index = $(this).parents("tr").index();
// 			index--;
// 			console.log(index);
// 			if($(this).next().val()<=1){
// 				$(this).next().val(1);
// 			}else{
// 				$(this).siblings("input").val($(this).siblings("input").val()*1-1);
// 			}
// 			var cartArr = $.cookie("cart") ? JSON.parse($.cookie("cart")) : [];
// 				cartArr[index].count=$(this).siblings("input").val();
// 				$.cookie("cart", JSON.stringify(cartArr), {
// 				expries: 7,
// 				path: "/"
// 				});
// 			window.location.reload();
// 		});
// 		$(".add").click(function(){
// 			var index = $(this).parents("tr").index();
// 			index--;
// 			console.log(index);
// 			$(this).siblings("input").val($(this).siblings("input").val()*1+1);
// 			var cartArr = $.cookie("cart") ? JSON.parse($.cookie("cart")) : [];
// 				cartArr[index].count=$(this).siblings("input").val();
// 				$.cookie("cart", JSON.stringify(cartArr), {
// 				expries: 7,
// 				path: "/"
// 				});
// 			window.location.reload();
// 		});
// 	}
// 	//跳转
// 	$("#turnBackList").click(function(){
// 		window.location.href ="http://10.2.166.37:8020/sanfu/goodsList.html";
// 	})
//
// })



$(function () {
    $('#noneshop').css('display','none')

    $('.shoping').each(function () {
        //
        var price = $(this).children('.tdp').children('.price').html()
        //
        var num = $(this).children('.tdp').children('.numb').val()
        var mprice = price * num
        $(this).children('.tdp').children('.mprice').html(mprice)
    })

    $('.sub').click(function(){

        data = {
            'status':-1,
            'cartid' : $(this).attr('data-cartid')
        }

        $.get('/cart',data,function (response) {

            window.open('/cart/', '_self')

            console.log(response.isdelete)
            if (response.isdelete){
                $('#noneshop').css('display','block')
            }

        })
    })
    $('.add').click(function(){
        data = {
            'status':1,
            'cartid' : $(this).attr('data-cartid')
        }
        $.get('/cart',data,function (response) {

            window.open('/cart/', '_self')
        })
    })

    $('#turnBackList').click(function () {
        window.open('/index/', '_self')
    })

//    全选
    var checkboxs = $("#mycart").find("input[type='checkbox']")
    checkboxs.attr("checked",true )
    var allprice = 0;
    $('.mprice').each(function () {
        var price = $(this).html()
        allprice += Number(price)
    })
    $('.cartToal').children('span').children('b').html(allprice)
    $('#checkall').click(function(){

        if ($('#checkall').prop("checked")){
            checkboxs.attr("checked",true)
            data={//全选
                'status':1
            }


            $.get('/chekall/',data,function (response) {
                $('.cartToal').children('span').children('b').html(response.allprice)
                window.open('/cart/', '_self')
            })


        }else {
            $('.cartToal').children('span').children('b').html(0.00)
            checkboxs.attr("checked",false)
            data={//全不选
                'status':2
            }
            console.log('全不选')
            $.get('/chekall/',data,function (response) {
                console.log(response.numb)
            })

        }
    })
    //点击控制子选择
    checkboxs.click(function () {
        var checkone = $(this).attr('data-checkid');

        checkboxs.each(function () {
            if($(this).prop("checked")){
                $('#checkall').attr("checked",false);
            }
        })
        if($(this).prop("checked")){
              data={//单个商品选中
                 'status':3,
                 'checkone':checkone
             };

            console.log(checkone)
            console.log('a')
            $.get('/chekall/',data,function (response) {
                $('.cartToal').children('span').children('b').html(response.allprice)
            })
        }else{
            data={//单个商品不选中
                 'status':4,
                 'checkone':checkone
             };

            console.log(checkone)
            console.log('b')
            $.get('/chekall/',data,function (response) {
                $('.cartToal').children('span').children('b').html(response.allprice)
            })
        }

    })

    //点击结算付款
    $('#payoder').click(function () {
        window.open('/order/', '_self')
    })

})