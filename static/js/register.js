// $(function() {
//
// 	$.idcode.setCode(); //加载生成验证码方法
// 	var name = $("#name");
// 	var pwd = $("#pwd");
// 	var repwd = $("#repwd");
// 	var allowReg = true;
// 	name.blur(function(){
// 		name.next().text("");
// 		if(name.val() == "") {
// 			name.next().text("邮箱、用户名、手机号不能为空");
// 			allowReg = false;
// 		}else{
// 			allowReg = true;
// 		}
// 	});
// 	pwd.blur(function(){
// 		pwd.next().text("");
// 		if(pwd.val() == "") {
// 			pwd.next().text("密码不能为空");
// 			allowReg = false;
// 		}else if(pwd.val().length<6||pwd.val().length>20){
// 			pwd.next().text("密码长度应在6-20个字符之间");
// 			allowReg = false;
// 		}else{
// 			allowReg = true;
// 		}
// 	});
// 	repwd.blur(function(){
// 		repwd.next().text("");
// 		if(repwd.val() != pwd.val()) {
// 			repwd.next().text("两次密码输入不相同");
// 			allowReg = false;
// 		}else{
// 			allowReg = true;
// 		}
// 	});
// 	$("#register").click(function() {
// 		if(allowReg&&name.val() != ""&&repwd.val() != ""&&pwd.val() != ""){
// 			var protocol = $("#protocol").prop("checked");
// 			if(protocol == false) {
// 				alert("请同意注册协议，方可注册");
// 			} else {
// 					var userInfo = {
// 							"name" : name.val(),
// 							"pwd" : pwd.val()
// 						};
// 					console.log(userInfo);
// 					$.post("http://10.2.166.37:8000/user_register_post",userInfo,function(data){
// 						console.log(data);
// 						if(data.code){
// 							alert(data.msg);
// 							window.location.href = "http://10.2.166.37:8000/login.html";
// 						}else{
// 							name.next().text(data.msg);
// 						}
// 					});
// 				}
// 		}
// 	});
//
// });
$(function () {
    //昵称验证
    $('#uername').blur(function(){

        velue = $(this).val()
        if ( velue == '' ) {
            $('.checkname i').html('昵称不能为空')
            return
        }else {
            nc = false
            $('.checkname i').addClass('greenyellow');
            $('.greenyellow').css('color',' greenyellow')
            $('.checkname i').html('昵称可用')
        }
    })
    //验证账号
    $('#email').blur(function(){//账号失去焦点验证是否可用

        velue = $(this).val()
        if ( velue == '' ) {
            $('.checkemail i').html('账号不能为空')
            return
        }
        data = {
            "email":velue
        }

        $.get('/checkemail',data,function(response){

            if(response.static){
                $('.checkemail i').html(response.msg)
            }else{
                $('.checkemail i').addClass('greenyellow');
                $('.greenyellow').css('color',' greenyellow');
                $('.checkemail i').html(response.msg)
            }

        })
    })
    //验证密码
    $('#pwd').blur(function(){
        velue = $(this).val()
        if ( velue == '' ) {
            $('.checkpwd i').html('密码不能为空')
            return
        }
        else if(velue.length<5||velue.length>16){
            $('.checkpwd i').html("密码长度请在5~16之间")
        }else{
            $('.checkpwd i').addClass('greenyellow');
            $('.greenyellow').css('color',' greenyellow');
            $('.checkpwd i').html("密码有效");

        }
    })
    //验证确认密码
    $('#repwd').blur(function(){
        velue = $(this).val();
        oldvelue = $('#pwd').val();
        if ( velue == ''||velue != oldvelue ) {
            $('.repwd i').html("确认密码错误")
        }
        else{
            $('.repwd i').addClass('greenyellow');
            $('.greenyellow').css('color',' greenyellow');
            $('.repwd i').html("密码正确")
        }
    })

    //注册提交
    $('#register').click(function () {
        var isregister = true
        $('.regForm div i').each(function () {
            if( !$(this).is('.greenyellow') ) {
                isregister = false
            }

        })
        if(isregister){
             $('.regForm form').submit()
        }


     })





})