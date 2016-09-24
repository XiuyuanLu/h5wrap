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
	margin-left: 2vw;
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

.container .middle .right-data .tab-detail table{
	margin-top: 2vh;
	border-bottom: 1px solid #000;
}

.container .middle .right-data .tab-detail table td{
	font-size: 2.5em;
	height: 5vh;
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
	<input id="pageCode" type="hidden" value="${code}"/>
	<input id="pageSuffix" type="hidden" value="${suffix}"/>
	<input id="pageName" type="hidden" value="${name}"/>
    <div class="head">
		<div class="head-content">
			<span>${name}(${code})</span>
		</div>
	</div>
    <div class="container">
    	<div class="middle">
    		<div class="chart-title">
    			<div class="main-value">
    				<span id="lastPrice" class="big-value green-value">3109.55</span>
    				<span id="chg" class="small-value green-value">-0.48&nbsp;-0.02%</span>
    			</div>
    			<div class="other-value">
    				<table>
    					<tr>
    						<td class="medium-value">高&nbsp;<span id="highPrice" class="red-value"></span></td>
    						<td class="medium-value">开&nbsp;<span id="openPrice" class="green-value"></span></td>
    						<td class="medium-value">换手&nbsp;<span id="turnoverRatio"></span></td>
    					</tr>
    					<tr>
    						<td class="medium-value">低&nbsp;<span id="lowPrice" class="green-value"></span></td>
    						<td class="medium-value">额&nbsp;<span id="businessBalance"></span></td>
    						<td class="medium-value">量比&nbsp;<span id="volRatio" class="red-value"></span></td>
    					</tr>
    				</table>
    			</div>
    		</div>
    		<span id="point"></span>
	    	<div class="chart" id="chart"></div>
	    	<div class="right-data">
	    		<div class="tabs">
	    			<span>五档</span>
	    			<span>明细</span>
	    			<span>成交</span>
	    		</div>
	    		<div class="tab-detail">
	    			<div id="bids">
	    			</div>
	    			<div id="detl" style="display:none"></div>
	    			<div id="deal" style="display:none"></div>
	    		</div>
	    	</div>
    	</div>
	    <div id="minites" class="sub-options">
    		<span id="oneM" onclick="toKline('1')">1分</span>
    		<span id="fiveM" onclick="toKline('2')">5分</span>
    		<span id="qutrM" onclick="toKline('3')">15分</span>
    		<span id="thtyM" onclick="toKline('4')">30分</span>
    		<span id="sxtyM" onclick="toKline('5')">60分</span>
    	</div>
    	<div class="options">
	    	<span style="color: #f74242">分时</span>
	    	<span onclick="toKline('6')">日</span>
	    	<span onclick="toKline('7')">周</span>
	    	<span onclick="toKline('8')">月</span>
	    	<span onclick="showMinites()">分钟&nbsp;<i id="minites-arrow" class="fa fa-chevron-up"></i></span>
	    </div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			$.ajax({
				url:"api/stock",
				data:{
					stockcode: document.getElementById('pageCode').value+document.getElementById('pageSuffix').value
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					chartInit(data.message);
				}
			});
			$.ajax({
				url:"api/stock/snapshot",
				data:{
					stockcode: document.getElementById('pageCode').value+document.getElementById('pageSuffix').value
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					drawTable(data.message);
				}
			});
		}
		
		var textStyle = {
				fontSize: 40,
				fontWeight: 'normal'
		};
		
		function calculateMA(dayCount,data0) {
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
		
		function calculateAvg(data0) {
		    var result = [];
		    var sum = 0;
		    for (var i = 0; i < data0.length; i++) {
		    	if(data0[i]==null)
		    		break;
		        sum += data0[i];
		        result.push((sum / (i+1)));
		    }
		    return result;
		}
		
		function chartInit(data){
			if(data=='error'){
				alert(data);
				return;
			}
			
			var category = new Array();
			var posValues = new Array();
			var negValues = new Array();
			var prices = new Array();
			for(var i =0;i<data.length;i++){
				category.push(data[i].timeStamp);
				posValues.push(data[i].businessAmount);
				/* if(data[i].color=='red'){
					posValues.push(data[i].businessAmount);
					negValues.push(0);
				}else{
					posValues.push(0);
					negValues.push(data[i].businessAmount);
				} */
				prices.push(data[i].lastPrice);
			}
			var ma = calculateAvg(prices);
			var option = {
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
			   	tooltip: {
			        trigger: 'axis',
			        formatter: function (params, ticket, callback){
			        	var str = params[0].name+'</br>';
			        	for(var i=0;i<params.length;i++)
			        		str+=params[i].seriesName+':'+params[i].value.toFixed(2)+'</br>';
			        	return str;
			        },
			        textStyle:{
			        	fontSize: 40
			        }
			    },
			    xAxis: [{
			    	type: 'category',
			        data: category,
			    	axisTick:{
			    		interval: 60
			    	},
			    	splitLine:{
			    		show: true,
			    		interval: 60
			    	},
			    	axisLabel:{
			    		interval: function(index,value){
			    			if(index==0 || index==119 || index==240)
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
			    	data: category,
			        splitNumber: 3,
			        axisLine:{
			    		onZero: false
			    	},
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
			    		textStyle:{
			    			fontSize: 25
			    		}
			    	},
			    	axisTick:{},
			    	splitLine:{
			    	}
			    },{
			    	show: false,
	                scale: true,
	                gridIndex: 1,
	                splitNumber: 2,
	                axisLabel: {inside: true,show: false},
	                axisLine: {},
	                axisTick: {show: false},
	                splitLine: {show: false}
	            }],
			    series: [{
			    	name: '价格',
			    	type: 'line',
			    	data: prices
			    },{
			    	name: '均价',
			    	type:'line',
			    	data: ma
			    },{
			    	type: 'bar',
			    	data: posValues,
			    	xAxisIndex: 1,
			    	yAxisIndex: 1
			    }
			    ],
			    animationEasing: 'elasticOut',
			    animationDelayUpdate: function (idx) {
			        return idx * 5;
			    }
			};
			myChart = echarts.init(document.getElementById('chart'));
			myChart.setOption(option);
		}
		
		function drawTable(data){
			if(data=='error'){
				alert(data);
				return;
			}
			var html = '';
			var bids = data.bidGroup;
			var offers = data.offerGroup;
			html += '<table>';
			for(var i=offers.length-1;i>=0;i--){
				var prefix = '卖';
				if(i==4)
					prefix+='五';
				else if(i==3)
					prefix+='四';
				else if(i==2)
					prefix+='三';
				else if(i==1)
					prefix+='二';
				else if(i==0)
					prefix+='一';
				html+='<tr><td>'+prefix+'&nbsp;&nbsp;'+new Number(offers[i]).toFixed(2)+'</td></tr>';
			}
			html+='</table>';
			html += '<table>';
			for(var i=bids.length-1;i>=0;i--){
				var prefix = '买';
				if(i==4)
					prefix+='一';
				else if(i==3)
					prefix+='二';
				else if(i==2)
					prefix+='三';
				else if(i==1)
					prefix+='四';
				else if(i==0)
					prefix+='五';
				html+='<tr><td>'+prefix+'&nbsp;&nbsp;'+new Number(bids[i]).toFixed(2)+'</td></tr>';
			}
			html+='</table>';
			
			document.getElementById('bids').innerHTML=html;
			document.getElementById('highPrice').innerHTML=data.highPrice;
			document.getElementById('lowPrice').innerHTML=data.lowPrice;
			document.getElementById('lastPrice').innerHTML=data.lastPrice;
			document.getElementById('openPrice').innerHTML=data.openPrice;
			document.getElementById('businessBalance').innerHTML=(data.businessBalance/100000000).toFixed(2)+'亿';
			document.getElementById('turnoverRatio').innerHTML=(data.turnoverRatio*100).toFixed(2)+'%';
			document.getElementById('volRatio').innerHTML=data.volRatio;
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
		
		function toKline(type){
			location.href="page/stock/kline?stockcode="+document.getElementById('pageCode').value
					+"&suffix="+document.getElementById('pageSuffix').value
					+"&stockname="+document.getElementById('pageName').value
					+"&type="+type;
		}
		
	</script>
</body>
</html>

