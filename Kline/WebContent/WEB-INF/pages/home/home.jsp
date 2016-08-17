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
	height: 7vh;
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

.container .middle .chart-title{
	width: 100%;
	height: 10vh;
}

.container .middle .chart-title .main-value{
	width: 20%;
	height: 100%;
	display: inline-block;
	float: left;
	text-align: center;
}

.container .middle .chart-title .other-value{
	width: 80%;
	height: 100%;
	display: inline-block;
	float: left;
}

.container .middle .chart-title .other-value table{
	margin-left: 3vw;
	margin-top: 0.3vh;
}

.container .middle .chart-title .other-value table td{
	width: 24vw;
}

.container .middle .chart{
	width: 93vw;
	height: 50vh;
	display: inline-block;
	float: left;
	margin-left: 1vw;
}

.container .middle .right-bar{
	height: 30vh;
	width: 5vw;
	display: inline-block;
	float: right;
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
    		<div class="chart-title">
    			<div class="main-value">
    				<span class="big-value green-value">3109.55</span>
    				<span class="small-value green-value">-0.48&nbsp;-0.02%</span>
    			</div>
    			<div class="other-value">
    				<table>
    					<tr>
    						<td class="medium-value">高&nbsp;<span class="red-value">3114.26</span></td>
    						<td class="medium-value">开&nbsp;<span class="green-value">3106.99</span></td>
    						<td class="medium-value">换手&nbsp;<span>1.05%</span></td>
    					</tr>
    					<tr>
    						<td class="medium-value">低&nbsp;<span class="green-value">3090.28</span></td>
    						<td class="medium-value">额&nbsp;<span>2434亿</span></td>
    						<td class="medium-value">量比&nbsp;<span class="red-value">1.00</span></td>
    					</tr>
    				</table>
    			</div>
    		</div>
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
		
		var textStyle = {
				fontSize: 40,
				fontWeight: 'normal'
		};
		
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
			   	grid:[{
			   			left: 0,
			   			height: '70%',
			   			containLabel: true
			   		},{
			   			left: 0,
			   			height: '16%',
			   			top: '78%',
			   			containLabel: true
			   		}
			   	],
			    xAxis: [{
			        data: xAxisData,
			        splitNumber: 3,
			    	axisLabel:{
			    		show: false
			    	},
			    	axisTick:{
			    		interval: 20
			    	},
			    	splitLine:{
			    		show: true,
			    		interval: 20
			    	}
			    },{
			    	gridIndex: 1,
			    	data: xAxisData,
			        splitNumber: 3,
			        axisLine:{
			    		onZero: false
			    	},
			    	axisLabel:{
			    		show: false
			    	},
			    	axisTick:{
			    		interval: 20
			    	},
			    	splitLine:{
			    		show: true,
			    		interval: 20
			    	}
			    }],
			    yAxis: [{
			    	splitNumber: 3,
			    	axisLine:{},
			    	axisLabel:{
			    		inside: true,
			    		textStyle:{
			    			fontSize: 25
			    		}
			    	},
			    	axisTick:{},
			    	splitLine:{}
			    },{
	                scale: true,
	                gridIndex: 1,
	                splitNumber: 2,
	                axisLabel: {inside: true,show: false},
	                axisLine: {show: false},
	                axisTick: {show: false},
	                splitLine: {show: false}
	            }],
			    series: [{
			        type: 'line',
			        data: data1,
			        animationDelay: function (idx) {
			            return idx * 10;
			        }
			    }, {
			        type: 'bar',
			        data: data2,
			        xAxisIndex: 1,
			        yAxisIndex: 1,
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

