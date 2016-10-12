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
	padding: 0;
	margin:0;
}

.container .middle .middle-img{
	width: 100%;
    position: relative;
}

.container .middle .middle-img .background{
	width: 100%;
}

.container .middle .middle-img .background img{
	width: 100%;
}

.container .middle .option-list{
	width: 100%;
	height: auto;
	background-color: #f1f4f9;
	border-bottom: 1px solid #b2b2b3;
}

.container .middle .option-list .option{
	display: inline-block;
	height: 10vh;
	width: 32vw;
	text-align: center;
}

.container .middle .option-list .option span{
	font-size: 4em;
	color: #2c2c2c;
}

</style>

</head>

<body>
	<input id="code" type="hidden" value="${code}" />
    <input id="type" type="hidden" value="${type}" />
    <div class="container">
    	<img id="head-search" src="resources/img/head-search.png" onclick="toSearch()">
    	<div class="middle">
    		<div class="middle-img">
    			<div class="background" id="background">
    				<img src="resources/img/pool-head-back.png">
    			</div>
    		</div>
    		<div class="option-list">
    			<div class="option" onclick="logout()"><span>登出</span></div>
    		</div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			highlight('self');
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
		
		function toSearch(){
			location.href="page/stock/search";
		}
	</script>
</body>
</html>

