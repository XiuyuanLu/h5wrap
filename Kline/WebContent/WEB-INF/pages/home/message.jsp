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

.container .table td{
	font-size: 2em;
	width: 100%;
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
    		</table>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			highlight('self');
			getMessage();
		}
		
		function getMessage(){
			$.ajax({
				url:"api/user/message",
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
			var html = '';
			if(data.length>0){
				for(var i=0;i<data.length;i++){
					html += '<tr><td>'+data[i].content+'</td></tr>';
				}
			}
			document.getElementById('table').innerHTML=html;
		}
		
	</script>
</body>
</html>

