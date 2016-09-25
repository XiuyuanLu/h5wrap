<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="functions" %>
<!DOCTYPE html>
<html>
<head>
<base href="${base}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>缠论K线</title>
<link rel="stylesheet" type="text/css" href="resources/css/main.css" />
<script src="resources/js/jquery-1.9.1.min.js"></script>
<script src="resources/js/common.js"></script>
<style>

.container .middle{
	width: 100%;
	height: 78vh;
}

.container .middle .search{
	margin-top: 2vh;
	text-align: center;
}

.container .middle .search input{
	font-size: 3em;
}

.container .middle .stocks{
	margin-top: 3vh;
}

.container .middle .stocks table{
	width: 100%;
	height: 100%;
	text-align: center;
	border-top: 1px solid #abaaaa;
	background-color: #f6f6f6;
}

.container .middle .stocks table tr:ACTIVE{
	background: #2c2c2c;
}

.container .middle .stocks table td{
	font-size: 3.5em;
	text-align: center;
	width: 40vw;
	border-bottom: 1px solid #abaaaa;
	height: 6.2vh;
}

</style>

</head>

<body>
	<input id="code" type="hidden" value="${code}" />
    <input id="type" type="hidden" value="${type}" />
    <%@include file="/WEB-INF/pages/common/header.jsp" %>
    <div class="container">
    	<div class="middle">
    		<div class="search">
    			<input type="number" id="query" placeholder="股票代码" onkeyup="query()"/>
    		</div>
    		<div id="stocks" class="stocks">
    			
    		</div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
		}
		
		function query(){
			$.ajax({
				url:"api/stock/fuzzyQuery",
				data:{
					q: document.getElementById('query').value
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					drawList(data.message);
				}
			});
		}
		
		function drawList(data){
			if(data==null || typeof(data.length)=='undefined')
				return;
			var html='<table>';
			var stocks = document.getElementById('stocks');
			for(var i=0;i<data.length;i++){
				html+='<tr onclick=\"jump(\''+data[i].code+'\',\''+data[i].suffix+'\',\''+data[i].name+'\')\"><td>'+
						'<span>'
						+data[i].code+
						'</td><td>&nbsp;'
						+data[i].name+
						'</span>'
						+'</td></tr>';
			}
			html+='</table>';
			stocks.innerHTML=html;
		}
		
		function jump(code,suffix,name){
			location.href="page/stock/kline?stockcode="+code+"&suffix="+suffix+"&stockname="+name+"&type=6";
		}
	</script>
</body>
</html>

