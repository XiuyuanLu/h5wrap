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
	margin-top: 20vh;
}

.input-panel{
	width: 80vw;
	height: 8vh;
	margin: 3vh 10vw;
	border: 0;
	position: relative;
	background-color: #fff;
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
	background: #becfd4;
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


</style>

</head>

<body>
	<%@include file="/WEB-INF/pages/common/header.jsp" %>
    <div class="container">
    	<img id="head-search" src="resources/img/head-search.png" onclick="toSearch()">
    	<div class="middle">
    		<div class="input-panel">
    			<img src="resources/img/login-name.png">
    			<input id="username" type="text" placeholder="用户名">
    		</div>
    		<div class="input-panel">
    			<img src="resources/img/login-password.png">
    			<input id="password" type="password" placeholder="密码">
    		</div>
    		<div class="input-panel login-btn" onclick="login()"><span>登&nbsp;&nbsp;&nbsp;&nbsp;录</span></div>
    		<div class="input-panel login-btn" onclick="toRegister()"><span>注&nbsp;&nbsp;&nbsp;&nbsp;册</span></div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
		}
		
		function toRegister(){
			location.href='page/home/register';
		}
		
		function login(){
			var username=document.getElementById("username").value;
			var password=document.getElementById("password").value;
			if($.trim(username)==""){
				alert("请输入用户名");
				return ;
			}
			if($.trim(password)==""){
				alert("请输入密码");
				return ;
			}
			$.ajax({
				url:"api/authenticate/login",
				data:{
					username: username,
					password: password
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

