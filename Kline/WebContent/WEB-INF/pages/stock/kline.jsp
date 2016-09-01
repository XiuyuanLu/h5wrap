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

.container .middle .chart-control{
	font-size: 2.2em;
	text-align: center;
}

.container .middle .chart-control span{
	margin-left: 1.5vw;
}

.container .middle .chart-control .red-control{
	color: #fc4343;
}

.container .middle .chart-control .blue-control{
	color: #218ab1;
}

.container .middle .chart{
	width: 100vw;
	height: 60vh;
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
			<span><a><i class="fa fa-caret-left"></i></a>${code}<a><i class="fa fa-caret-right"></i></a></span>
		</div>
	</div>
    <div class="container">
    	<div class="middle">
    		<div class="chart-title">
    			<div class="main-value">
    				<span id="last"></span>
    				<span id="chg"></span>
    			</div>
    			<div class="other-value">
    				<table>
    					<tr>
    						<td class="medium-value">高&nbsp;<span id="high" class="red-value"></span></td>
    						<td class="medium-value">开&nbsp;<span id="open" class="green-value"></span></td>
    					</tr>
    					<tr>
    						<td class="medium-value">低&nbsp;<span id="low" class="green-value"></span></td>
    						<td class="medium-value">额&nbsp;<span>2434亿</span></td>
    					</tr>
    				</table>
    			</div>
    		</div>
    		<div class="chart-control">
	    		<span class="red-control" onclick="redPenClick()">红色上涨笔</span>
	    		<span class="blue-control" onclick="bluePenClick()">蓝色下降笔</span>
	    		<span class="red-control" onclick="redCenterClick()">红色上涨中枢</span>
	    		<span class="blue-control" onclick="blueCenterClick()">蓝色下降中枢</span>
	    	</div>
	    	<div class="chart" id="chart"></div>
    	</div>
    	<div id="minites" class="sub-options">
    		<span id="oneM" onclick="toKline('1')">1分</span>
    		<span id="fiveM" onclick="toKline('2')">5分</span>
    		<span id="qutrM" onclick="toKline('3')">15分</span>
    		<span id="thtyM" onclick="toKline('4')">30分</span>
    		<span id="sxtyM" onclick="toKline('5')">60分</span>
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
		var wrapSegment;
		var wrapPenCenter;
		var penLine = new Array();
		var redPen = new Array();
		var bluePen = new Array();
		var status = 'both';
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
			chartInit();
			$.ajax({
				url:"api/stock/kline",
				data:{
					stockcode: document.getElementById('code').value,
					type: type
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					var msg = data.message;
					if(msg=="error")
						alert(msg);
					candlesticks=data.message[0];
					wrapPen=data.message[1];
					wrapSegment=data.message[2];
					wrapPenCenter=data.message[3];
					drawData();
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
		
		function drawData(){
			var ks = new Array();
			for(var i=0;i<candlesticks.length;i++){
				var diff1=0;
				var diff2=0;
				var diff3=0;
				var diff4=0;
				if(i>0){
					diff1=candlesticks[i].openPrice-candlesticks[i-1].openPrice;
					diff2=candlesticks[i].closePrice-candlesticks[i-1].closePrice;
					diff3=candlesticks[i].lowPrice-candlesticks[i-1].lowPrice;
					diff4=candlesticks[i].highPrice-candlesticks[i-1].highPrice;
				}
					
				ks.push([candlesticks[i].timeStamp,
				         candlesticks[i].openPrice,
				         candlesticks[i].closePrice,
				         candlesticks[i].lowPrice,
				         candlesticks[i].highPrice,
				         diff1,diff2,diff3,diff4]);
			}
			/* for(var i=0;i<wrapPen.length-1;i++){
				var start=wrapPen[i];
				var end=wrapPen[i+1];
				if(start.value<end.value){
					var x = [{
						coord:[start.timeStamp+'',start.value],
						value:start.value,
						lineStyle:{
							normal:{
								color: '#fc4343',
								type: 'solid',
								width: 4
							}
						}
					},{
						coord:[end.timeStamp+'',end.value],
						value:end.value
					}];
					redPen.push(x);
					penLine.push(x);
				}else{
					var x = [{
						coord:[start.timeStamp+'',start.value],
						value:start.value,
						lineStyle:{
							normal:{
								color: '#218ab1',
								type: 'solid',
								width: 4
							}
						}
					},{
						coord:[end.timeStamp+'',end.value],
						value:end.value
					}];
					bluePen.push(x);
					penLine.push(x);
				}
			} */
		
			/* for(var i=0;i<wrapSegment.length-1;i++){
				var start=wrapSegment[i];
				var end=wrapSegment[i+1];
				penLine.push([{
					coord:[start.timeStamp+'',start.value],
					value:start.value,
					lineStyle:{
						normal:{
							color: '#3b3d3e',
							type: 'solid',
							width: 2
						}
					}
				},{
					coord:[end.timeStamp+'',end.value],
					value:end.value
				}]);
			} */
		
			/* var markArea = new Array();
			for(var i=0;i<wrapPenCenter.length;i++){
				markArea.push(
					[{
						coord:[wrapPenCenter[i].endTime+'',wrapPenCenter[i].high]
					},{
						coord:[wrapPenCenter[i].startTime+'',wrapPenCenter[i].low]
					}]
				);
			} */
			var data0 = splitData(ks);
			option.xAxis.data=data0.categoryData;
			option.series[0].data=data0.values;
			option.series[1].data=calculateMA(5,data0);
			myChart.setOption(option);
			
			var tail = data0.values[data0.values.length-1];
			var chg=(tail[1]-tail[0]).toFixed(2);
			var pchg= (chg/tail[0]*100).toFixed(2);
			var openDom = document.getElementById('open');
			var lastDom = document.getElementById('last');
			var lowDom = document.getElementById('low'); 
			var highDom = document.getElementById('high');
			var chgDom = document.getElementById('chg');
			
			openDom.innerHTML=tail[0];
			lastDom.innerHTML=tail[1];
			lowDom.innerHTML=tail[2];
			highDom.innerHTML=tail[3];
			chgDom.innerHTML=chg+'&nbsp;'+pchg+'%';
			
			if(tail[5]>0)
				openDom.className='red-value';
			else if(tail[5]<0)
				openDom.className='green-value';
			if(tail[7]>0)
				lowDom.className='red-value';
			else if(tail[7]<0)
				lowDom.className='green-value';
			if(tail[8]>0)
				highDom.className='red-value';
			else if(tail[8]<0)
				highDom.className='green-value';
			if(chg>0){
				chgDom.className='small-value red-value';
				lastDom.className='big-value red-value';
			}else if(chg<0){
				chgDom.className='small-value green-value';
				lastDom.className='big-value green-value';
			}
			
		}
		
		function chartInit(){
			option = {
				animation: false,
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
			            type: 'cross',
			            crossStyle:{
			            	color: '#000',
			            	width: 2,
			            	type: 'solid',
			            	textStyle:{
						        fontSize: 0
						    }
			            }
			        },
			        showContent: false
			    },
			    xAxis: [{
			    	type: 'category',
			    	data: [],
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
			    	scale: true,
			    	axisLine:{
			    	},
			    	gridIndex: 0,
			    	axisLabel:{
			    		inside: true,
			    		show: false
			    	},
			    	axisTick:{},
			    	splitLine:{
			    		lineStyle:{
			    		}
			    	}
			    },{
			    	max: 3,
			    	min: 0,
			    	axisLine:{show: false},
			    	gridIndex: 0,
			    	axisLabel:{
			    		show: false,
			    		inside: true
			    	},
			    	axisTick:{show: false},
			    	splitLine:{show: false}
			    }],
			    dataZoom: [
			       {
			          type: 'inside',
			          filterMode: 'filter',
			          start: 80,
			          end: 100
			       }
			    ],
			    series: [{
			    	type: 'candlestick',
			    	data: [],
			    	markLine:{
			    		data: [],//penLine,
			    		label:{
			    			normal:{
			    				show: false
			    			}
			    		}
			    	},
			    	markArea:{
			    		data: [],//markArea,
			    		itemStyle:{
			    			normal:{
			    				borderColor: '#000',
			    				borderWidth: 1,
			    				opacity: 0.3
			    			}
			    		}
			    	},
			    	itemStyle:{
			    		normal:{
			    			color: '#e51818',
			    			color0: '#179b09'
			    		}
			    	}
			    },{
		            name: 'MA5',
		            type: 'line',
		            data: [],
		            smooth: true,
		            lineStyle: {
		                normal: {opacity: 0.5}
		            }
		        }]
			};
			myChart = echarts.init(document.getElementById('chart'));
			myChart.setOption(option);
			myChart.on('click', function (params) {
				if(typeof(params.value)=='undefined')
					return;
				var chg=(params.value[1]-params.value[0]).toFixed(2);
				var pchg= (chg/params.value[0]*100).toFixed(2);
				var openDom = document.getElementById('open');
				var lastDom = document.getElementById('last');
				var lowDom = document.getElementById('low'); 
				var highDom = document.getElementById('high');
				var chgDom = document.getElementById('chg');
				
				openDom.innerHTML=params.value[0];
				lastDom.innerHTML=params.value[1];
				lowDom.innerHTML=params.value[2];
				highDom.innerHTML=params.value[3];
				chgDom.innerHTML=chg+'&nbsp;'+pchg+'%';
				
				if(params.value[5]>0)
					openDom.className='red-value';
				else if(params.value[5]<0)
					openDom.className='green-value';
				if(params.value[7]>0)
					lowDom.className='red-value';
				else if(params.value[7]<0)
					lowDom.className='green-value';
				if(params.value[8]>0)
					highDom.className='red-value';
				else if(params.value[8]<0)
					highDom.className='green-value';
				if(chg>0){
					chgDom.className='small-value red-value';
					lastDom.className='big-value red-value';
				}else if(chg<0){
					chgDom.className='small-value green-value';
					lastDom.className='big-value green-value';
				}
			});
		}
		
		function toKline(type){
			location.href="page/stock/kline?stockcode="+document.getElementById('code').value+"&type="+type;
		}
		
		function toRealtime(){
			location.href="page/stock?stockcode="+document.getElementById('code').value;
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
		
		function redPenClick(){
			if(status=='both'){
				option.series[0].markLine.data=bluePen;
				status='blue';
			}else if(status=='red'){
				option.series[0].markLine.data=[];
				status='none';
			}else if(status=='blue'){
				option.series[0].markLine.data=penLine;
				status='both';
			}else if(status=='none'){
				option.series[0].markLine.data=redPen;
				status='red';
			}
			myChart.setOption(option);
		}
		
		function bluePenClick(){
			if(status=='both'){
				option.series[0].markLine.data=redPen;
				status='red';
			}else if(status=='red'){
				option.series[0].markLine.data=penLine;
				status='both';
			}else if(status=='blue'){
				option.series[0].markLine.data=[];
				status='none';
			}else if(status=='none'){
				option.series[0].markLine.data=bluePen;
				status='blue';
			}
			myChart.setOption(option);
		}
		
		function redCenterClick(){
			
		}
		
		function blueCenterClick(){
			
		}
	</script>
</body>
</html>

