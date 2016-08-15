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
<script src="resources/js/echarts.js"></script>
<style>

.container .search{
	width: 100%;
	height: 15vh;
	text-align: center;
	padding-top: 2vh;
}

.container .search input{
	font-size: 3em;
}

.container .middle{
	width: 100%;
	height: 50vh;
}

.container .middle .chart{
	width: 90vw;
	height: 40vh;
	position: absolute;
	top: 20vh;
	left: 5vw;
}

.container .middle .right-bar{
	height: 30vh;
	width: 5vw;
	position: absolute;
	right: 2vw;
}

.container .middle .right-bar span{
	font-size: 3em;
}

</style>

</head>

<body>
    <%@include file="/WEB-INF/pages/common/header.jsp" %>
    <div class="container">
    	<div class="search">
    		<input type="text" placeholder="股票代码"/>
    	</div>
    	<div class="middle">
	    	<div class="chart" id="chart"></div>
	    	<div class="right-bar">
		    	<span>沪</span>
		    	<span>深</span>
		    	<span>创</span>
	    	</div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			chartInit();
		}
		
		function chartInit(){
			var myChart = document.getElementById('chart');
			var xAxisData = [];
			var data1 = [];
			var data2 = [];
			for (var i = 0; i < 100; i++) {
			    xAxisData.push('类目' + i);
			    data1.push((Math.sin(i / 5) * (i / 5 -10) + i / 6) * 5);
			    data2.push((Math.cos(i / 5) * (i / 5 -10) + i / 6) * 5);
			}

			option = {
			    title: {
			        text: '柱状图动画延迟'
			    },
			    tooltip: {},
			    xAxis: {
			        data: xAxisData,
			        silent: false,
			        splitLine: {
			            show: false
			        }
			    },
			    yAxis: {
			    },
			    series: [{
			        name: 'bar',
			        type: 'bar',
			        data: data1,
			        animationDelay: function (idx) {
			            return idx * 10;
			        }
			    }, {
			        name: 'bar2',
			        type: 'bar',
			        data: data2,
			        animationDelay: function (idx) {
			            return idx * 10 + 100;
			        }
			    }],
			    animationEasing: 'elasticOut',
			    animationDelayUpdate: function (idx) {
			        return idx * 5;
			    }
			};
			echarts.init(myChart).setOption(option);
		}
	</script>
</body>
</html>

