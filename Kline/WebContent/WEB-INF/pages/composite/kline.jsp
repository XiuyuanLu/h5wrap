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
<script src="resources/js/jquery-1.9.1.min.js"></script>
<script src="resources/js/common.js"></script>
<script src="resources/js/echarts.js"></script>
<style>

.container .middle{
	width: 100%;
	height: 78vh;
}

.container .middle .chart-title{
	width: 98vw;
	height: 10vh;
}

.container .middle .chart-title .main-value{
	width: 20%;
	height: 100%;
	display: inline-block;
	float: left;
	text-align: center;
	padding-left: 5vw;
}

.container .middle .chart-title .other-value{
	width: 70%;
	height: 100%;
	display: inline-block;
	float: left;
}

.container .middle .chart-title .other-value table{
	margin-left: 8vw;
	margin-top: 0.3vh;
}

.container .middle .chart-title .other-value table td{
	width: 24vw;
}

.container .middle .chart{
	width: 75vw;
	height: 66vh;
	display: inline-block;
	float: left;
}

.container .middle .right-data{
	height: 10vh;
	width: 25vw;
	display: inline-block;
	float: right;
}

.container .middle .right-data .tabs span{
	font-size: 2em;
	margin-right: 1vw;
	border-bottom: 2px solid #2c2c2c;
}

.container .middle .right-data .tab-detail{
}

.container .options{
	width: 100%;
	height: 5vh;
	background: #2c2c2c;
}

.container .options span{
	font-size: 3em;
	color: #aaa;
	margin-left: 3vw;
	margin-right: 3vw;
}

.container .sub-options{
	display: none;
}

</style>

</head>

<body>
    <div class="head">
		<div class="head-content">
			<span><a><i class="fa fa-caret-left"></i></a>上证指数(000001)<a><i class="fa fa-caret-right"></i></a></span>
		</div>
	</div>
    <div class="container">
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
    					</tr>
    					<tr>
    						<td class="medium-value">低&nbsp;<span class="green-value">3090.28</span></td>
    						<td class="medium-value">额&nbsp;<span>2434亿</span></td>
    					</tr>
    				</table>
    			</div>
    		</div>
	    	<div class="chart" id="chart"></div>
	    	<div class="right-data">
	    		<div class="tabs">
	    			<span>五档</span>
	    			<span>明细</span>
	    			<span>成交</span>
	    		</div>
	    		<div class="tab-detail"></div>
	    	</div>
	    	<div class="index-type"></div>
    	</div>
    	<div class="options">
	    	<span style="color: #f74242">分时</span>
	    	<span onclick="toKline()">日</span>
	    	<span>周</span>
	    	<span>月</span>
	    	<span>分钟</span>
	    	<span style="float:right">指标</span>
	    </div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		var tradeTime;
		function onLoad(){
			$.ajax({
				url:"api/composite/tradeTime",
				data:{
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					tradeTime = data.message;
					chartInit();
				}
			});
		}
		
		var textStyle = {
				fontSize: 40,
				fontWeight: 'normal'
		};
		
		function chartInit(){
			var myChart = document.getElementById('chart');
			var data = new Array();
			for(var i =0;i<242;i++)
				data.push(i);

			option = {
			   	grid:[{
			   			left: 30,
			   			height: '70%',
			   			containLabel: true
			   		},{
			   			left: 30,
			   			height: '16%',
			   			top: '78%',
			   			containLabel: true
			   		}
			   	],
			    xAxis: [{
			    	type: 'category',
			        data: tradeTime,
			    	axisTick:{
			    		interval: 60
			    	},
			    	splitLine:{
			    		show: true,
			    		interval: 60
			    	},
			    	axisLabel:{
			    		interval: function(index,value){
			    			if(index==0 || index==120 || index==241)
			    				return true;
			    		},
			    		textStyle:{
			    			fontSize:24
			    		}
			    	},
			    	z: 999
			    },{
			    	type: 'category',
			    	gridIndex: 1,
			    	data: tradeTime,
			        splitNumber: 3,
			        axisLine:{
			    		onZero: false
			    	},
			    	axisLabel:{
			    	},
			    	axisTick:{
			    		interval: 60
			    	},
			    	splitLine:{
			    		show: true,
			    		interval: 60,
			    		lineStyle:{
			    			width: 0.5,
			    			color: ['#000']
			    		}
			    	}
			    }],
			    yAxis: [{
			    	splitNumber: 3,
			    	axisLine:{
			    	},
			    	gridIndex: 0,
			    	axisLabel:{
			    		inside: true,
			    		textStyle:{
			    			fontSize: 25
			    		}
			    	},
			    	axisTick:{},
			    	splitLine:{
			    	}
			    },{
	                scale: true,
	                gridIndex: 1,
	                splitNumber: 2,
	                axisLabel: {inside: true,show: false},
	                axisLine: {},
	                axisTick: {show: false},
	                splitLine: {show: false}
	            }],
			    series: [{
			    	type: 'line',
			    	data: data
			    }
			    ],
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

