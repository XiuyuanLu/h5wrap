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
	width:33.333333vw;
	height:7vh;
}

.container .table .table-head th{
	color: #2c2c5c;
}

</style>

</head>

<body>
	<input id="code" type="hidden" value="${code}" />
    <input id="type" type="hidden" value="${type}" />
    <%@include file="/WEB-INF/pages/common/header.jsp" %>
    <img id="head-search" src="resources/img/head-search.png" onclick="toSearch()">
    <div class="container">
    	<div class="table">
    		<table id="table">
    			<tr class="table-head">
    				<th>股票</th>
    				<th>最新价</th>
    				<th>涨跌幅</th>
    			</tr>
    		</table>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			highlight('private');
			getStocks();
		}
		
		function getStocks(){
			$.ajax({
				url:"api/portfolio/query",
				data:{
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					if(data.message==undefined || data.message=='' )
						alert('error');
					else
						drawTable(data.message);
				}
			});
		}
		
		function drawTable(data){
			var html = document.getElementById('table').innerHTML;
			if(data.length>0){
				for(var i=0;i<data.length;i++){
					html += '<tr><td>'+data[i].code+'</td></tr>'
				}
			}
			document.getElementById('table').innerHTML=html;
		}
		
		function toSearch(){
			location.href="page/stock/search";
		}
	</script>
</body>
</html>

