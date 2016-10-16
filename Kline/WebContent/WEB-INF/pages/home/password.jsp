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

.input-panel{
	width: 80vw;
	height: 8vh;
	margin: 3vh 10vw;
	border: 0;
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
	left: 25vw;
	border: 0;
	font-size: 2.5em;
	background-color: #fff;
}

.input-panel label{
	position: absolute;
	font-size: 2.5em;
	top: 2.5vh;
}

.verify-panel{
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

.already-panel{
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
    		<div class="input-panel">
    			<label>原密码</label>
    			<input id="oldPassword" type="text" placeholder="请输入原密码" >
    		</div>
    		<div class="input-panel">
    			<label>新密码</label>
    			<input id="newPassword" type="text" placeholder="请输入新密码" >
    		</div>
    		<div class="input-panel">
    			<label>确认新密码</label>
    			<input id="newPasswordConfirm" type="text" placeholder="请确认新密码" >
    		</div>
    		<div class="input-panel login-btn" onclick="submit()"><span>提&nbsp;&nbsp;&nbsp;&nbsp;交</span></div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			highlight('self');
		}
		
		function submit(){
			var oldPassword=document.getElementById("oldPassword").value;
			var newPassword=document.getElementById("newPassword").value;
			var newPasswordConfirm=document.getElementById("newPasswordConfirm").value;
			if($.trim(oldPassword)==""){
				alert("请输入原密码");
				return ;
			}
			if($.trim(newPassword)==""){
				alert("请输入新密码");
				return ;
			}
			if($.trim(newPasswordConfirm)==""){
				alert("请确认新密码");
				return ;
			}
			$.ajax({
				url:"api/user/password",
				data:{
					oldPassword: oldPassword,
					newPassword: newPassword
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					alert(data.message);
					logout();
				}
			});
		}
		
		function toSearch(){
			location.href="page/stock/search";
		}
		
		function toLogin(){
			location.href="page/home/login";
		}
		
		function logout(){
			$.ajax({
				url:"api/authenticate/logout",
				data:{
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
	</script>
</body>
</html>

