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
<link rel="stylesheet" type="text/css" href="resources/css/slides.css" />
<script src="resources/js/jquery-1.9.1.min.js"></script>
<script src="resources/js/slidesjs/jquery.SuperSlide.2.1.1.js"></script>
<script src="resources/js/common.js"></script>
<script src="resources/js/echarts.js"></script>
<style>

.container .middle{
	width: 100%;
	height: 50vh;
}

.container .middle .chart-title{
	width: 96vw;
	height: 10vh;
	padding-top: 1.5vh;
	padding-left: 4vw;
	background-color: #f1f4f9;
	border-bottom: 1px solid #b2b2b3;
}

.container .middle .chart-title .main-value{
	width: 20%;
	height: 100%;
	display: inline-block;
	float: left;
	text-align: center;
}

.container .middle .chart-title .other-value{
	width: 70%;
	height: 100%;
	display: inline-block;
	float: left;
	margin-left: 3vw;
	margin-top: 0.3vh;
}

.container .middle .chart-title .other-value table{
	margin-left: 3vw;
	margin-top: 0.3vh;
}

.container .middle .chart-title .other-value table td{
	width: 24vw;
	font-size: 2.2em;
}

.container .middle .chart{
	width: 93vw;
	height: 55vh;
	display: inline-block;
	float: left;
}

.container .middle .right-bar-hu img,
.container .middle .right-bar-shen img,
.container .middle .right-bar-chuang img{
	height:4.5vh;
}

.container .middle .right-bar-hu{
	position: absolute;
	right: 0;
	top: 28vh;
}

.container .middle .right-bar-shen{
	position: absolute;
	height: 3vh;
	right: 0;
	top: 40vh;
}

.container .middle .right-bar-chuang{
	position: absolute;
	height: 3vh;
	right: 0;
	top: 52vh;
}

.container .middle .right-bar span a{
	text-decoration: none;
}

</style>

</head>

<body>
    <%@include file="/WEB-INF/pages/common/header.jsp" %>
    <input id="code" type="hidden" value="${code}"/>
    <div class="container">
    	<img id="head-search" src="resources/img/head-search.png" onclick="toSearch()">
    	<div class="middle">
    		<div class="chart-title">
    			<div class="main-value">
    				<span id="last" class="big-value green-value"></span>
    				<span id="chg" class="small-value green-value"></span>
    			</div>
    			<div class="other-value">
    				<table>
    					<tr>
    						<td class="medium-value">高&nbsp;<span id="high" class="red-value"></span></td>
    						<td class="medium-value">开&nbsp;<span id="open" class="green-value"></span></td>
    						<td class="medium-value">换手&nbsp;<span id="turnover"></span></td>
    					</tr>
    					<tr>
    						<td class="medium-value">低&nbsp;<span id="low" class="green-value"></span></td>
    						<td class="medium-value">额&nbsp;<span id="amount" ></span></td>
    						<td class="medium-value">量比&nbsp;<span id="v-ratio"></span></td>
    					</tr>
    				</table>
    			</div>
    		</div>
	    	<div class="chart" id="chart"></div>
	    	<div class="right-bar-hu">
		    	<span><a href="page/home?stockcode=000001"><img id="right-img-hu" src="resources/img/hu.png"></a></span>
	    	</div>
	    	<div class="right-bar-shen">
		    	<span><a href="page/home?stockcode=399001"><img id="right-img-shen" src="resources/img/shen.png"></a></span>
	    	</div>
	    	<div class="right-bar-chuang">
		    	<span><a href="page/home?stockcode=399006"><img id="right-img-chuang" src="resources/img/chuang.png"></a></span>
	    	</div>
    	</div>
    	<img src="resources/img/under-chart.png" style="width:100%;height: 25vh;position:absolute;bottom: 9vh;left:0;" />
    	<!-- <div id="slideBox" class="slideBox">
				<div class="bd">
					<ul>
						<li><img src="resources/img/under-chart.png" onclick="" /></li>
					</ul>
				</div>
				<a class="prev" href="javascript:void(0)"></a>
				<a class="next" href="javascript:void(0)"></a>
		</div> -->
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
		var ma5;
		var ma10;
		var ma20;
		var subChartStatus = 1;
		var difLine = [];
		var deaLine = [];
		var bar = [];
		var vma = [];
		var volumns = [];
		//jQuery(".slideBox").slide({mainCell:".bd ul",autoPlay:true,titCell: ".hd li",trigger:"click"});
		function onLoad(){
			highlight('home');
			var code =document.getElementById('code').value;
			markRightBar();
			if(code=='000001')
				code+='.XSHG.MRI';
			else
				code+='.XSHE.MRI';
			$.ajax({
				url:"api/stock/kline",
				data:{
					stockcode: code,
					candlePeriod: 6
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
				}
			});
			
			$.ajax({
				url:"api/stock/snapshot",
				data:{
					stockcode: code
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					var msg = data.message;
					if(msg=="error")
						alert(msg);
					document.getElementById('turnover').innerHTML=(msg.turnoverRatio*100).toFixed(2)+'%';
					document.getElementById('v-ratio').innerHTML=msg.volRatio.toFixed(2);
				}
			});
			
		}
		var textStyle = {
				fontSize: 40,
				fontWeight: 'normal'
		};
		
		function splitData(rawData) {
		    var categoryData = [];
		    var values = [];
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
		
		function chartInit(){
			var ks = [];
			for(var i=0;i<candlesticks.length;i++){
				if(candlesticks[i].closePrice-candlesticks[i].openPrice>0){
					volumns.push({
									value:candlesticks[i].businessAmount,
									itemStyle:{
										normal:{
											color: '#fff',
											borderColor: 'red'
										}
									}
								});
				}else{
					volumns.push({
						value:candlesticks[i].businessAmount,
						itemStyle:{
							normal:{
								color: 'green'
							}
						}
					});
				}
				
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
								type: 'dashed',
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
								type: 'dashed',
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
			var amountDom = document.getElementById('amount');
			
			openDom.innerHTML=tail[0].toFixed(2);
			lastDom.innerHTML=tail[1].toFixed(2);
			lowDom.innerHTML=tail[2].toFixed(2);
			highDom.innerHTML=tail[3].toFixed(2);
			chgDom.innerHTML=chg+'&nbsp;'+pchg+'%';
			amountDom.innerHTML= (volumns[volumns.length-1].value/100000000).toFixed(2)+'亿';
			
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
			
			ma5 = calculateMAK(5,data0.values);
			ma10 = calculateMAK(10,data0.values);
			ma20 = calculateMAK(20,data0.values);
			vma = calculateMAV(5,volumns);
			option = {
				animation: false,
			   	grid:[{
			   		top: 16,
		   			left: 30,
		   			right: 30,
		   			height: '80%',
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
							
							openDom.innerHTML=params[0].value[0].toFixed(2);
							lastDom.innerHTML=params[0].value[1].toFixed(2);
							lowDom.innerHTML=params[0].value[2].toFixed(2);
							highDom.innerHTML=params[0].value[3].toFixed(2);
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
							document.getElementById('maTip').innerHTML = 'MA5:'+params[1].value.toFixed(2)
																		+'&nbsp;MA10:'+params[2].value.toFixed(2)
																		+'&nbsp;MA20:'+params[3].value.toFixed(2);
							var idx = params[0].dataIndex;
							str += macdCateData[idx]+'&nbsp;&nbsp;MACD:'+bar[idx];
				        	str += '&nbsp;&nbsp;DIF:'+difLine[idx];
				        	str += '&nbsp;&nbsp;DEA:'+deaLine[idx];
				        	document.getElementById('macdTip').innerHTML = str;
							return params[0].value[8];
			        	}else if(params[0].seriesIndex>=4){
			        		c+=1;
			        		console.log(c);
			        		shiftChart();
			        		return '';
			        	}
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
			    }],
			    yAxis: [{
			    	splitNumber: 3,
			    	scale: true,
			    	axisLine:{
			    	},
			    	gridIndex: 0,
			    	axisLabel:{
			    		inside: true,
			    		textStyle:{
			    			fontSize: 24
			    		}
			    	},
			    	axisTick:{show: false},
			    	splitLine:{
			    		lineStyle:{
			    		}
			    	}
			    },{
			    	splitNumber: 3,
			    	scale: true,
			    	axisLine:{
			    	},
			    	gridIndex: 0,
			    	axisLabel:{
			    		inside: true,
			    		show: false
			    	},
			    	axisTick:{
			    		show: false
			    	},
			    	splitLine:{
			    		show: false,
			    		lineStyle:{
			    		}
			    	}
			    }],
			    dataZoom: [
			       {
			          type: 'inside',
			          filterMode: 'filter',
			          start: 96,
			          end: 100
			       }
			    ],
			    series: [{
			    	type: 'candlestick',
			    	data: data0.values,
			    	markLine:{
			    		data: penLine,
						symbol: 'none',
			    		label:{
			    			normal:{
			    				show: false
			    			}
			    		}
			    	},
			    	itemStyle:{
			    		normal:{
			    			color: '#fff',
			    			color0: '#179b09'
			    		}
			    	}
			    },{
		            name: 'kma5',
		            type: 'line',
		            data: ma5
		        },{
		            name: 'kma10',
		            type: 'line',
		            data: ma10
		        },{
		            name: 'kma20',
		            type: 'line',
		            data: ma20
		        }]
			};
			myChart = echarts.init(document.getElementById('chart'));
			myChart.setOption(option);
		}
		
		function jump(code){
			location.href="page/composite?stockcode="+code;
		}
		
		function toSearch(){
			location.href="page/stock/search";
		}
		
		function markRightBar(){
			var code =document.getElementById('code').value;
			if(code=='000001'){
				document.getElementById('right-img-hu').src="resources/img/hu-pick.png";
				document.getElementById('right-img-shen').src="resources/img/shen.png";
				document.getElementById('right-img-chuang').src="resources/img/chuang.png"
			}else if(code=='399001'){
				document.getElementById('right-img-hu').src="resources/img/hu.png";
				document.getElementById('right-img-shen').src="resources/img/shen-pick.png";
				document.getElementById('right-img-chuang').src="resources/img/chuang.png"
			}else {
				document.getElementById('right-img-hu').src="resources/img/hu.png";
				document.getElementById('right-img-shen').src="resources/img/shen.png";
				document.getElementById('right-img-chuang').src="resources/img/chuang-pick.png"
			}
		}
	</script>
</body>
</html>

