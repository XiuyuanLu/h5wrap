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

.container .table table th{
	font-size: 3em;
	background: #f1f4f9;
	width:33.33vw;
	height:7vh;
}

.container .table .table-head th{
	color: #2c2c5c;
	border-bottom: 1px solid #abaaaa;
}

.container .table td{
	font-size: 2em;
	height: 8vh;
	text-align: center;
	border-bottom: 1px solid #abaaaa;
}

</style>

</head>

<body>
	<input id="code" type="hidden" value="${code}" />
    <input id="type" type="hidden" value="${type}" />
    <%@include file="/WEB-INF/pages/common/header.jsp" %>
    <img id="head-search" src="resources/img/head-search.png" onclick="redirect('page/stock/search')">
    <div class="container">
    	<div class="table">
    		<table id="table">
    			<tr class="table-head">
    				<th>购买名称</th>
    				<th>金额（元）</th>
    				<th>购买日期</th>
    			</tr>
    		</table>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			highlight('self');
			getShopping();
		}
		
		function getShopping(){
			$.ajax({
				url:"api/user/shopping",
				data:{
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					drawTable(data.message);
				}
			});
		}
		
		function drawTable(data){
			if(data=='' || data==undefined || data==null)
				data=[];
			var html = '<tr class="table-head"><th>购买名称</th><th>金额（元）</th><th>购买日期</th></tr>';
			if(data.length>0){
				for(var i=0;i<data.length;i++){
					html += '<tr><td>'+data[i].name+'</td>'
					           +'<td>'+data[i].buyMoney+'</td>'
					           +'<td>'+data[i].buyDate+'</td></tr>';
				}
			}
			document.getElementById('table').innerHTML=html;
		}
		
	</script>
</body>
</html>

