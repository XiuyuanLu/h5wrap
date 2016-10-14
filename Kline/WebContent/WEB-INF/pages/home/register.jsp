<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="functions" %>
<!DOCTYPE html>
<html>
<head>
<base href="${base}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>缠论君</title>
<link rel="stylesheet" type="text/css" href="resources/css/main.css" />
<script src="resources/js/jquery-1.9.1.min.js"></script>
<script src="resources/js/common.js"></script>
<style>

body{
	background-color: #f1f4f9;
}

.container .middle{
	width: 100%;
	height: 78vh;
	margin-top: 10vh;
}

.input-penal{
	width: 80vw;
	height: 8vh;
	margin: 3vh 10vw;
	border: 0;
	position: relative;
	background-color: #fff;
}

.input-penal img{
	height: 3vh;
	position: absolute;
	top: 2.3vh;
	left: 5vw;
}

.input-penal input{
	height: 6vh;
	position: absolute;
	top: 0.5vh;
	left: 13vw;
	border: 0;
	font-size: 2.5em;
}

.verify-penal{
	position: absolute;
	right: 0vw;
	font-size: 2.5em;
	padding-top: 2vh;
	height: 6vh;
	width: 30vw;
	background-color: #f4bb1f;
	border: 1px solid #d6d6d6;
	text-align: center;
}

.login-btn {
	border-radius:15px;
	background: #becfd4;
	color: #fff;
	text-align: center;
	font-size: 3.5em;
	position: relative;
	box-shadow: -1px 3px 10px 3px #9c9c9c;
}

.login-btn-full {
	border-radius:15px;
	background: #15b58e;
	color: #fff;
	text-align: center;
	font-size: 3.5em;
	position: relative;
	box-shadow: -1px 3px 10px 3px #9c9c9c;
}

.login-btn span{
	position: absolute;
	top: 1.2vh;
	left: 30vw;
	right: 30vw;
}

.already-penal{
	padding-left: 13vw;
	font-size: 2em;
	color: #a6a2a2;
}

</style>

</head>

<body>
	<%@include file="/WEB-INF/pages/common/header.jsp" %>
    <div class="container">
    	<img id="head-search" src="resources/img/head-search.png" onclick="toSearch()">
    	<div class="middle">
    		<div class="input-penal">
    			<img src="resources/img/login-mobile.png">
    			<input id="loginName" type="text" placeholder="手机" >
    		</div>
    		<div class="input-penal">
    			<img src="resources/img/login-verify.png">
    			<input id="verify" type="text" placeholder="手机验证码">
    			<div class="verify-penal">
    				<span onclick="getVerify()">获取验证码</span>
    			</div>
    		</div>
    		<div class="input-penal">
    			<img src="resources/img/login-password.png">
    			<input id="password" type="password" placeholder="密码">
    		</div>
    		<div class="input-penal">
    			<img src="resources/img/login-password-c.png">
    			<input id="passwordConfirm" type="password" placeholder="确认密码">
    		</div>
    		<div class="input-penal login-btn" onclick="register()"><span>注&nbsp;&nbsp;&nbsp;&nbsp;册</span></div>
    		<div class="already-penal" onclick="toLogin()"><span>已有账号</span></div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
		}
		
		function register(){
			var loginName=document.getElementById("loginName").value;
			var verify=document.getElementById("verify").value;
			var password=document.getElementById("password").value;
			var passwordConfirm=document.getElementById("passwordConfirm").value;
			if($.trim(loginName)==""){
				alert("请输入手机号");
				return ;
			}
			if($.trim(password)==""){
				alert("请输入密码");
				return ;
			}
			if($.trim(verify)==""){
				alert("请输入验证码");
				return ;
			}
			if($.trim(passwordConfirm)==""){
				alert("请输入密码确认");
				return ;
			}
			$.ajax({
				url:"api/authenticate/register",
				data:{
					loginName: loginName,
					password: password,
					verify: verify
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					if(data.message=="success")
						location.href="page/home/login";
					else
						alert(data.message);
				}
			});
		}
		
		function getVerify(){
			var loginName=document.getElementById("loginName").value;
			if($.trim(loginName)==""){
				alert("请输入手机号");
				return ;
			}
			$.ajax({
				url:"api/authenticate/getVerify",
				data:{
					mobile:  loginName
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					
				}
			});
		}
		
		function toSearch(){
			location.href="page/stock/search";
		}
		
		function toLogin(){
			location.href="page/home/login";
		}
	</script>
</body>
</html>

