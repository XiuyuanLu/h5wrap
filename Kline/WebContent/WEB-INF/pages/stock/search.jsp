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
<link rel="stylesheet" type="text/css" href="resources/css/font-awesome/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="resources/js/autocomplete/autocomplete.min.css" />
<script src="resources/js/jquery-1.9.1.min.js"></script>
<script src="resources/js/autocomplete/autocomplete.min.js"></script>
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
	text-align: center;
}

.container .middle .stocks span{
	font-size: 3em;
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
    			<input id="code" placeholder="股票代码" />
    		</div>
    		<div class="stocks">
    			<a href="javascript:void(0)" onclick="jump()"><span>000001&nbsp;平安银行</span></a>
    		</div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			/* $('#code').autocomplete('api/stock/fuzzyQuery',{
				minChars: 0, 
				width: 220,
				max: 10, 
				scrollHeight: 300,
				formatItem: function(row, i, max) {
					console.log(row);
				}
			}); */
		}
		
		function jump(){
			location.href="page/stock?stockcode="+'000001';
		}
	</script>
</body>
</html>

