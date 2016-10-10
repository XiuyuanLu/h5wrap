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

.container .middle .middle-img .buy1 img,
.container .middle .middle-img .buy2 img,
.container .middle .middle-img .buy3 img{
	height: 16vh;
}

.container .middle .middle-img .buy1{
	position: absolute;
	top: 10vh;
	left: 5vw;	
}

.container .middle .middle-img .buy2{
	position: absolute;
	top: 10vh;
	left: 35vw;	
}

.container .middle .middle-img .buy3{
	position: absolute;
	top: 10vh;
	left: 70vw;	
}

.container .middle .tab{
	width: 100%;
	height: 4.5vh;
	padding-top: 2vh;
	position: relative;
}

.container .middle .tab .tab-day{
	height: 4vh;
	width: 10vw;
	background: #f74242;
	position: absolute;
	left: 1vw;
	padding: 0.5vh 2vw 0vh 2vw;
}

.container .middle .tab .tab-day span{
	color: #fff;
	font-size: 2.5em;
}

.container .middle .tab .tab-30{
	height: 4vh;
	width: 10vw;
	background: #2c2c2c;
	position: absolute;
	left: 18vw;
	padding: 0.5vh 2vw 0vh 2vw;
}

.container .middle .tab .tab-30 span{
	color: #fff;
	font-size: 2.5em;
	padding: 0;
}

.container .middle .table table th{
	padding: 0;
	font-size: 2.5em;
	background: #f74242;
	width:25vw;
	height:7vh;
}

.container .middle .table .table-head th{
	color: #fff;
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
    			<div class="buy1" id="buy1" onclick="buy('1')">
	    			<img id="buy1img" src="resources/img/buy-1.png">
	    		</div>
	    		<div class="buy2" id="buy2" onclick="buy('2')">
	    			<img id="buy2img" src="resources/img/buy-2.png">
	    		</div>
	    		<div class="buy3" id="buy3" onclick="buy('3')">
	    			<img id="buy3img" src="resources/img/buy-3.png">
	    		</div>
    		</div>
    		<div class="tab" id="tab">
    			<div id="tab-day" class="tab-day" onclick="tab('day')"><span>日线</span></div>
    			<div id="tab-30" class="tab-30" onclick="tab('30')"><span>30分</span></div>
    		</div>
    		<div class="table" id="table">
    			<table>
    				<tr class="table-head">
    					<th>股票</th>
    					<th>入选时间</th>
    					<th>进入价格</th>
    					<th>累计收益</th>
    				</tr>
    			</table>
    		</div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			highlight('pick');
			buy(1);
			getData();
		}
		
		function getData(){
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
		
		function tab(type){
			if(type=='day'){
				document.getElementById('tab-day').style.background='#f74242';
				document.getElementById('tab-30').style.background='#2c2c2c';
			}else if(type="30"){
				document.getElementById('tab-day').style.background='#2c2c2c';
				document.getElementById('tab-30').style.background='#f74242';
			}
		}
		
		function buy(type){
			if(type=='1'){
				document.getElementById('buy1img').src='resources/img/buy-1-pick.png';
				document.getElementById('buy2img').src='resources/img/buy-2.png';
				document.getElementById('buy3img').src='resources/img/buy-3.png';
			}else if(type=="2"){
				document.getElementById('buy1img').src='resources/img/buy-1.png';
				document.getElementById('buy2img').src='resources/img/buy-2-pick.png';
				document.getElementById('buy3img').src='resources/img/buy-3.png';
			}else if(type=="3"){
				document.getElementById('buy1img').src='resources/img/buy-1.png';
				document.getElementById('buy2img').src='resources/img/buy-2.png';
				document.getElementById('buy3img').src='resources/img/buy-3-pick.png';
			}
		}
		
		function toSearch(){
			location.href="page/stock/search";
		}
	</script>
</body>
</html>

