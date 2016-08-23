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
	width: 100vw;
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
	position: absolute;
	bottom: 14.6vh;
	width: 100%;
	background: #2c2c3c;
}

.container .sub-options span{
	font-size: 3em;
	color: #aaa;
	margin-left: 3vw;
	margin-right: 3vw;
}

</style>

</head>

<body>
	<input id="code" type="hidden" value="${code}" />
    <input id="type" type="hidden" value="${type}" />
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
    	</div>
    	<div id="minites" class="sub-options">
    		<span id="oneM" onclick="toKline('1')">1Min</span>
    		<span id="fiveM" onclick="toKline('2')">5Min</span>
    		<span id="qutrM" onclick="toKline('3')">15Min</span>
    		<span id="thtyM" onclick="toKline('4')">30Min</span>
    		<span id="sxtyM" onclick="toKline('5')">60Min</span>
    	</div>
    	<div class="options">
	    	<span onclick="toRealtime()">分时</span>
	    	<span id="day" onclick="toKline('6')">日</span>
	    	<span id="week" onclick="toKline('7')">周</span>
	    	<span id="month" onclick="toKline('8')">月</span>
	    	<span id="minite" onclick="showMinites()">分钟&nbsp;<i id="minites-arrow" class="fa fa-chevron-up"></i></span>
	    	<span style="float:right">指标</span>
	    </div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		var tradeTime;
		var candlesticks;
		var wrapPen;
		function onLoad(){
			var type=document.getElementById('type').value;
			
			if(type=='1'){
				document.getElementById('oneM').style.color='#f74242';
				document.getElementById('minites').style.display="block";
			}
			else if(type=='2'){
				document.getElementById('fiveM').style.color='#f74242';
				document.getElementById('minites').style.display="block";
			}
			else if(type=='3'){
				document.getElementById('qutrM').style.color='#f74242';
				document.getElementById('minites').style.display="block";
			}
			else if(type=='4'){
				document.getElementById('thtyM').style.color='#f74242';
				document.getElementById('minites').style.display="block";
			}
			else if(type=='5'){
				document.getElementById('sxtyM').style.color='#f74242';
				document.getElementById('minites').style.display="block";
			}
			else if(type=='6')
				document.getElementById('day').style.color='#f74242';
			else if(type=='7')
				document.getElementById('week').style.color='#f74242';
			else if(type=='8')
				document.getElementById('month').style.color='#f74242';
			
			$.ajax({
				url:"api/composite/kline",
				data:{
					code: document.getElementById('code').value,
					type: type
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					var msg = data.message;
					if(msg=="error")
						alert(msg);
					candlesticks=data.message;
					$.ajax({
						url:"api/composite/wrap",
						data:{
							code: document.getElementById('code').value,
							type: type
						},
						type: 'POST',
						dataType: 'json',
						success:function(data){
							var msg = data.message;
							if(msg=="error")
								alert(msg);
							wrapPen = data.message;
							chartInit();
						}
					});
				}
			});
			
		}
		
		var textStyle = {
				fontSize: 40,
				fontWeight: 'normal'
		};
		
		function splitData(rawData) {
		    var categoryData = [];
		    var values = []
		    for (var i = 0; i < rawData.length; i++) {
		        categoryData.push(rawData[i].splice(0, 1)[0]);
		        values.push(rawData[i])
		    }
		    return {
		        categoryData: categoryData,
		        values: values
		    };
		}
		
		function calculateMA(dayCount,data0) {
		    var result = [];
		    for (var i = 0, len = data0.values.length; i < len; i++) {
		        if (i < dayCount) {
		            result.push('-');
		            continue;
		        }
		        var sum = 0;
		        for (var j = 0; j < dayCount; j++) {
		            sum += data0.values[i - j][1];
		        }
		        result.push(sum / dayCount);
		    }
		    return result;
		}
		
		function chartInit(){
			var myChart = document.getElementById('chart');
			var ks = new Array();
			for(var i=0;i<candlesticks.length;i++){
				ks.push([candlesticks[i].timeStamp,candlesticks[i].openPrice,candlesticks[i].closePrice,candlesticks[i].lowPrice,candlesticks[i].highPrice]);
			}
			
			var markLine = new Array();
			for(var i=0;i<wrapPen.length-1;i++){
				var start=wrapPen[i];
				var end=wrapPen[i+1];
				markLine.push([{
					coord:[start.timeStamp+'',start.value],
					value:start.value
				},{
					coord:[end.timeStamp+'',end.value],
					value:end.value
				}]);
			}
			
			var data0 = splitData(ks);
			option = {
			   	grid:[{
			   			left: 30,
			   			right: 30,
			   			height: '80%',
			   			containLabel: true
			   		}
			   	],
			   	tooltip: {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'cross'
			        },
			        textStyle: textStyle
			    },
			    xAxis: [{
			    	type: 'category',
			    	data: data0.categoryData,
			    	axisTick:{
			    		show: false
			    	},
			    	splitLine:{
			    		show: false
			    	},
			    	axisLabel:{
			    		show: false
			    	},
			    	z: 999
			    }],
			    yAxis: [{
			    	splitNumber: 3,
			    	max: 3,
			    	min: -1,
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
			    }],
			    dataZoom: [
			       {
			          type: 'inside',
			          filterMode: 'filter',
			          start: 90,
			          end: 100
			       }
			    ],
			    series: [{
			    	type: 'candlestick',
			    	data: data0.values,
			    	markLine:{
			    		data: markLine
			    	}
			    },{
		            name: 'MA5',
		            type: 'line',
		            data: calculateMA(5,data0),
		            smooth: true,
		            lineStyle: {
		                normal: {opacity: 0.5}
		            }
		        }]
			};
			echarts.init(myChart).setOption(option);
		}
		
		function toKline(type){
			location.href="page/composite/kline?code="+document.getElementById('code').value+"&type="+type;
		}
		
		function toRealtime(){
			location.href="page/composite";
		}
		
		function showMinites(){
			var status = document.getElementById('minites').style.display;
			if(status=="block"){
				document.getElementById('minites').style.display="none";
				$('#minites-arrow').removeClass('fa-chevron-down');
				$('#minites-arrow').addClass('fa-chevron-up');
			}
			else{
				document.getElementById('minites').style.display="block";
				$('#minites-arrow').removeClass('fa-chevron-up');
				$('#minites-arrow').addClass('fa-chevron-down');
			}
		}
	</script>
</body>
</html>

