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
	text-align: center;
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

.container .middle .volumnTip{
	position: absolute;
	bottom: 40vh;
	left: 3vw;
	z-index: 9999;
	font-size: 2em;
}

.container .middle .macdTip{
	position: absolute;
	bottom: 28vh;
	left: 3vw;
	z-index: 9999;
	font-size: 2em;
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

.container .macd-mode{
	display: none;
	position: absolute;
	background: #2c2c3c;
	right: 0;
}

.container .macd-mode div{
	border: 1px solid #abaaaa;
}

.container .macd-mode span{
	font-size: 4em;
	color: #aaa;
	margin-left: 3vw;
	margin-right: 3vw;
}

</style>

</head>

<body>
	<input id="code" type="hidden" value="${code}" />
	<input id="name" type="hidden" value="${name}" />
    <input id="type" type="hidden" value="${type}" />
    <div class="head">
		<div class="head-content">
			<span><a><i class="fa fa-caret-left"></i></a>${name}(${code})<a><i class="fa fa-caret-right"></i></a></span>
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
	    	<div class="volumnTip" id="volumnTip"></div>
	    	<div class="macdTip" id="macdTip"></div>
    	</div>
    	<div id="minites" class="sub-options">
    		<span id="oneM" onclick="toKline('1')">1分</span>
    		<span id="fiveM" onclick="toKline('2')">5分</span>
    		<span id="qutrM" onclick="toKline('3')">15分</span>
    		<span id="thtyM" onclick="toKline('4')">30分</span>
    		<span id="sxtyM" onclick="toKline('5')">60分</span>
    	</div>
    	<div id="macd-mode" class="macd-mode">
    		<div>
    			<span id="macd-6" onclick="refreshMacd('6')">6</span>
    		</div>
    		<div>
    			<span id="macd-12" onclick="refreshMacd('12')">12</span>
    		</div>
    		<div>
    			<span id="macd-26" onclick="refreshMacd('26')">26</span>
    		</div>
    	</div>
    	<div class="options">
	    	<span onclick="toRealtime()">分时</span>
	    	<span id="day" onclick="toKline('6')">日</span>
	    	<span id="week" onclick="toKline('7')">周</span>
	    	<span id="month" onclick="toKline('8')">月</span>
	    	<span id="minite" onclick="showMinites()">分钟&nbsp;<i id="minites-arrow" class="fa fa-chevron-up"></i></span>
	    	<span style="float:right" >指标</span>
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
		var macd9;
		var macd12;
		var macd26;
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
				url:"api/stock/kline",
				data:{
					stockcode: document.getElementById('code').value,
					candlePeriod: type
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
					chartInit();
					getMacdData('9');
				}
			});

			//prepareMacd();
		}
		
		function getMacdData(mode){
			$.ajax({
				url:"api/stock/macd",
				data:{
					stockcode: document.getElementById('code').value,
					candlePeriod: document.getElementById('type').value,
					macdMode: mode
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					var msg = data.message;
					if(msg=="error" || msg==null)
						alert(msg);
					macd9 = msg;
					refreshMacd('9');
				}
			});
		}
		
		function prepareMacd(){
			$.ajax({
				url:"api/stock/macd",
				data:{
					stockcode: document.getElementById('code').value,
					candlePeriod: document.getElementById('type').value,
					macdMode: '6'
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					var msg = data.message;
					if(msg=="error")
						alert(msg);
					macd6 = msg;
				}
			});
			$.ajax({
				url:"api/stock/macd",
				data:{
					stockcode: document.getElementById('code').value,
					candlePeriod: document.getElementById('type').value,
					macdMode: '26'
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					var msg = data.message;
					if(msg=="error")
						alert(msg);
					macd26 = msg;
				}
			});
		}
		
		function refreshMacd(mode){
			var data;
			if(mode=='9')
				data=macd9;
			else if(mode=='12')
				data=macd12;
			else if(mode=='26')
				data=macd26;
			else 
				return;
			if(data==null || data==undefined || data.length==0)
				return;
			var difLine = [];
			var deaLine = [];
			var bar = [];
			macdCateData = [];
			for(var i=0;i<data.length;i++){
				difLine.push(data[i].dif);
				deaLine.push(data[i].dea);
				bar.push(data[i].bar);
				macdCateData.push(data[i].timeStamp);
			}
			var opt = myChart.getOption();
			opt.series[4].data=bar;
			opt.series[5].data=difLine;
			opt.series[6].data=deaLine;
			myChart.setOption(opt);
			document.getElementById('macdTip').innerHTML = macdCateData[macdCateData.length-1]+'&nbsp;&nbsp;MACD:'+bar[bar.length-1]+'&nbsp;&nbsp;DIF:'+difLine[difLine.length-1]+'&nbsp;&nbsp;DEA:'+deaLine[deaLine.length-1];
			//showMacds();
		}
		
		function chartInit(){
			var ks = [];
			var volumns = [];
			for(var i=0;i<candlesticks.length;i++){
				volumns.push(candlesticks[i].businessAmount);
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
					
				ks.push([candlesticks[i].openPrice,
				         candlesticks[i].closePrice,
				         candlesticks[i].lowPrice,
				         candlesticks[i].highPrice,
				         diff1,diff2,diff3,diff4,candlesticks[i].timeStamp]);
			}
			for(var i=0;i<wrapPen.length-1;i++){
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
			}
			
			var data0 = splitData(ks);
			
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
			}else{
				chgDom.className='small-value';
				lastDom.className='big-value';
			}
			option = {
				animation: false,
			   	grid:[{
		   			left: 30,
		   			right: 30,
		   			height: '54%',
		   			containLabel: true
		   		},{
		   			left: 30,
		   			right: 30,
		   			height: '16%',
		   			top: '65%',
		   			containLabel: true
		   		},{
		   			left: 30,
		   			right: 30,
		   			height: '16%',
		   			top: '85%',
		   			containLabel: true
		   		}
			   	],
			   	tooltip: {
			        trigger: 'axis',
			        formatter: function (params, ticket, callback){
			        	var str='';
			        	if(params[0].seriesIndex==0){
			        		var chg=(params[0].value[1]-params[0].value[0]).toFixed(2);
							var pchg= (chg/params[0].value[0]*100).toFixed(2);
							var openDom = document.getElementById('open');
							var lastDom = document.getElementById('last');
							var lowDom = document.getElementById('low'); 
							var highDom = document.getElementById('high');
							var chgDom = document.getElementById('chg');
							
							openDom.innerHTML=params[0].value[0];
							lastDom.innerHTML=params[0].value[1];
							lowDom.innerHTML=params[0].value[2];
							highDom.innerHTML=params[0].value[3];
							chgDom.innerHTML=chg+'&nbsp;'+pchg+'%';
							
							if(params[0].value[5]>0)
								openDom.className='red-value';
							else if(params[0].value[5]<0)
								openDom.className='green-value';
							if(params[0].value[7]>0)
								lowDom.className='red-value';
							else if(params[0].value[7]<0)
								lowDom.className='green-value';
							if(params[0].value[8]>0)
								highDom.className='red-value';
							else if(params[0].value[8]<0)
								highDom.className='green-value';
							if(chg>0){
								chgDom.className='small-value red-value';
								lastDom.className='big-value red-value';
							}else if(chg<0){
								chgDom.className='small-value green-value';
								lastDom.className='big-value green-value';
							}else{
								chgDom.className='small-value';
								lastDom.className='big-value';
							}
							
							return params[0].value[8];
			        	}else if(params[0].seriesIndex==2){
			        		str += macdCateData[params[0].dataIndex]+'&nbsp;&nbsp;成交量:'+params[0].value;
			        		document.getElementById('volumnTip').innerHTML = str;
			        		return '';
			        	}
			        	str += macdCateData[params[0].dataIndex]+'&nbsp;&nbsp;MACD:'+params[0].value;
			        	str += '&nbsp;&nbsp;DIF:'+params[1].value;
			        	str += '&nbsp;&nbsp;DEA:'+params[2].value;
			        	document.getElementById('macdTip').innerHTML = str;
			        	return '';
			        },
			        textStyle:{
			        	fontSize: 40
			        }
			    },
			    xAxis: [{
			    	type: 'category',
			    	gridIndex: 0,
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
			    },{
			    	type: 'category',
			    	gridIndex: 1,
			    	data: data0.categoryData,
			    	axisLabel:{
			    		show: false
			    	},
			    	axisTick:{
			    		show: false
			    	},
			    	splitLine:{
			    		show: false
			    	}
			    },{
			    	type: 'category',
			    	gridIndex: 2,
			    	data: data0.categoryData,
			    	axisLabel:{
			    		show: false
			    	},
			    	axisTick:{
			    		show: false
			    	},
			    	splitLine:{
			    		show: false
			    	}
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
			    	show: false,
	                scale: true,
	                gridIndex: 1,
	                axisLabel: {inside: true,show: false},
	                axisLine: {},
	                axisTick: {show: false},
	                splitLine: {show: false}
	            },{
			    	show: false,
	                scale: true,
	                gridIndex: 2,
	                axisLabel: {inside: true,show: false},
	                axisLine: {},
	                axisTick: {show: false},
	                splitLine: {show: false}
	            }],
			    dataZoom: [
			       {
			          type: 'inside',
			          filterMode: 'filter',
			          xAxisIndex: [0,1,2],
			          start: 96,
			          end: 100
			       }
			    ],
			    series: [{
			    	type: 'candlestick',
			    	data: data0.values,
			    	markLine:{
			    		data: penLine,
			    		label:{
			    			normal:{
			    				show: false
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
		            name: 'kma5',
		            type: 'line',
		            data: calculateMAK(5,data0.values)
		        },{
		            name: 'volumn',
		            type: 'bar',
		            gridIndex: 1,
		            xAxisIndex: 1,
		            yAxisIndex: 1,
		            data: volumns,
		            barWidth: 10
		        },{
		            name: 'vma5',
		            type: 'line',
		            gridIndex: 1,
		            xAxisIndex: 1,
		            yAxisIndex: 1,
		            data: calculateMAV(5,volumns)
		        },{
		            name: 'MACD',
		            type: 'bar',
		            gridIndex: 2,
		            xAxisIndex: 2,
		            yAxisIndex: 2,
		            data: [],
		            barWidth: 1
		        },{
		            name: 'dif',
		            type: 'line',
		            gridIndex: 2,
		            xAxisIndex: 2,
		            yAxisIndex: 2,
		            data: [],
		            smooth: true
		        },{
		            name: 'dea',
		            type: 'line',
		            gridIndex: 2,
		            xAxisIndex: 2,
		            yAxisIndex: 2,
		            data: [],
		            smooth: true
		        }]
			};
			myChart = echarts.init(document.getElementById('chart'));
			myChart.setOption(option);
			document.getElementById('volumnTip').innerHTML=''+data0.categoryData[data0.categoryData.length-1]+'&nbsp;&nbsp;成交量:'+volumns[volumns.length-1];
		}
		
		var textStyle = {
				fontSize: 40,
				fontWeight: 'normal'
		};
		
		function splitData(rawData) {
		    var categoryData = [];
		    var values = [];
		    var volumns = [];
		    for (var i = 0; i < rawData.length; i++) {
		        values.push(rawData[i]);
		        categoryData.push(rawData[i][8]);
		    }
		    return {
		        categoryData: categoryData,
		        values: values
		    };
		}
		
		function calculateMAK(dayCount,data0) {
		    var result = [];
		    for (var i = 0, len = data0.length; i < len; i++) {
		        if (i < dayCount) {
		            result.push('-');
		            continue;
		        }
		        var sum = 0;
		        for (var j = 0; j < dayCount; j++) {
		            sum += data0[i - j][1];
		        }
		        result.push(sum / dayCount);
		    }
		    return result;
		}
		
		function calculateMAV(dayCount,data0) {
		    var result = [];
		    for (var i = 0, len = data0.length; i < len; i++) {
		        if (i < dayCount) {
		            result.push('-');
		            continue;
		        }
		        var sum = 0;
		        for (var j = 0; j < dayCount; j++) {
		            sum += data0[i - j];
		        }
		        result.push(sum / dayCount);
		    }
		    return result;
		}
		
		function calculateMacd(data0){
			var result = [];
			for (var i = 0, len = data0.values.length; i < len; i++)
		       result.push((i%2==0)?data0.values[i][1]:(-data0.values[i][1]));
			return result;
		}
		
		function toKline(type){
			location.href="page/stock/kline?stockcode="+document.getElementById('code').value
				+"&stockname="+document.getElementById('name').value
				+"&type="+type;
		}
		
		function toRealtime(){
			location.href="page/stock?stockcode="+document.getElementById('code').value
				+"&stockname="+document.getElementById('name').value;
		}
		
		function showMinites(){
			var statusLocal = document.getElementById('minites').style.display;
			if(statusLocal=="block"){
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
		
		function showMacds(){
			var macdDom = document.getElementById('macd-mode');
			var statusLocal = macdDom.style.display;
			if(statusLocal=='block')
				macdDom.style.display="";
			else{
				$('.macd-mode').css('bottom',$('.options').height()+$('.footer').height()-5);
				macdDom.style.display="block";
			}
		}
	</script>
</body>
</html>

