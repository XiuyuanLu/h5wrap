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

.container .middle{
	width: 100%;
	height: 78vh;
	margin-top: 5vh;
}

.input-panel{
	width: 80vw;
	height: 8vh;
	margin: 3vh 10vw;
	border: 1px solid #2c2c2c;
	position: relative;
}

.input-panel img{
	height: 3vh;
	position: absolute;
	top: 2.3vh;
	left: 5vw;
}

.input-panel input{
	height: 6vh;
	position: absolute;
	top: 0.5vh;
	left: 13vw;
	border: 0;
	font-size: 2.5em;
}

.login-btn {
	border-radius:15px;
	background: #2c2c2c;
	color: #fff;
	text-align: center;
	font-size: 3.5em;
	position: relative;
}

.login-btn span{
	position: absolute;
	top: 1.2vh;
	left: 30vw;
	right: 30vw;
}


</style>

</head>

<body>
	<%@include file="/WEB-INF/pages/common/header.jsp" %>
    <div class="container">
    	<img id="head-search" src="resources/img/head-search.png" onclick="toSearch()">
    	<div class="middle">
    		<div class="input-panel">
    			<img src="resources/img/login-name.png">
    			<input id="username" type="text" placeholder="昵称">
    		</div>
    		<div class="input-panel">
    			<img src="resources/img/login-mobile.png">
    			<input id="mobile" type="text" placeholder="手机">
    		</div>
    		<div class="input-panel">
    			<img src="resources/img/login-verify.png">
    			<input id="verify" type="text" placeholder="手机验证码">
    		</div>
    		<div class="input-panel">
    			<img src="resources/img/login-password.png">
    			<input id="password" type="password" placeholder="密码">
    		</div>
    		<div class="input-panel">
    			<img src="resources/img/login-password-c.png">
    			<input id="passwordConfirm" type="password" placeholder="确认密码">
    		</div>
    		<div class="input-panel login-btn" onclick="register()"><span>注&nbsp;&nbsp;&nbsp;&nbsp;册</span></div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
		}
		
		function register(){
			var username=document.getElementById("username").value;
			var mobile=document.getElementById("mobile").value;
			var verify=document.getElementById("verify").value;
			var password=document.getElementById("password").value;
			var passwordConfirm=document.getElementById("passwordConfirm").value;
			if($.trim(username)==""){
				alert("请输入昵称");
				return ;
			}
			if($.trim(password)==""){
				alert("请输入密码");
				return ;
			}
			if($.trim(mobile)==""){
				alert("请输入手机");
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
					username: username,
					password: password,
					mobile: mobile,
					verify: verify
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					if(data.message=="success")
						location.href="page/pool/pool";
					else
						alert(data.message);
				}
			});
		}
		
		function toSearch(){
			location.href="page/stock/search";
		}
	</script>
</body>
</html>

