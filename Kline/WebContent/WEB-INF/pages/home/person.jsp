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

.container .middle .info-panel{
	width: 100%;
	height: auto;
	background-color: #f1f4f9;
	border-bottom: 1px solid #b2b2b3;
}

.container .middle .info-panel .sub-info-panel{
	display: inline-block;
	height: 10vh;
	width: 49vw;
	text-align: center;
	padding-top: 1vh;
}

.container .middle .info-panel .sub-info-panel span{
	font-size: 3em;
	color: #2c2c2c;
}

.option-list .option{
	padding-left: 5vw;
	padding-top: 2vh;
	height: 6vh;
	border-bottom: 1px solid #abaaaa;
}

.option-list .option span{
	font-size: 3em;
}



</style>

</head>

<body>
	<input id="code" type="hidden" value="${code}" />
    <input id="type" type="hidden" value="${type}" />
    <div class="container">
    	<img id="head-search" src="resources/img/head-search.png" onclick="redirect('page/stock/search')">
    	<div class="middle">
    		<div class="middle-img">
    			<div class="background" id="background">
    				<img src="resources/img/pool-head-back.png">
    			</div>
    		</div>
    		<div class="info-panel">
    			<div class="sub-info-panel" style="border-right: 1px solid #abaaaa;"><span>${stockCount}</br>我的股票</span></div>
    			<div class="sub-info-panel"><span>${vipEnddate}</br>会员有效期</span></div>
    		</div>
    		<div class="option-list">
    			<div class="option" onclick="redirect('page/home/password')"><span>修改密码</span></div>
    			<div class="option" onclick="redirect('page/portfolio/portfolio')"><span>我的自选</span></div>
    			<div class="option" onclick="logout()"><span>购买记录</span></div>
    			<div class="option" onclick="logout()"><span>系统消息</span></div>
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
		
	</script>
</body>
</html>

