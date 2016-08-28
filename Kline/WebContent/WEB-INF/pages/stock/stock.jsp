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
	font-size: 3em;
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
    <div class="head">
		<div class="head-content">
			<span><a><i class="fa fa-caret-left"></i></a>${code}<a><i class="fa fa-caret-right"></i></a></span>
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
    		<span id="oneM" onclick="toKline('1')">1Min</span>
    		<span id="fiveM" onclick="toKline('2')">5Min</span>
    		<span id="qutrM" onclick="toKline('3')">15Min</span>
    		<span id="thtyM" onclick="toKline('4')">30Min</span>
    		<span id="sxtyM" onclick="toKline('5')">60Min</span>
    	</div>
    	<div class="options">
	    	<span style="color: #f74242">分时</span>
	    	<span onclick="toKline('6')">日</span>
	    	<span onclick="toKline('7')">周</span>
	    	<span onclick="toKline('8')">月</span>
	    	<span onclick="showMinites()">分钟&nbsp;<i id="minites-arrow" class="fa fa-chevron-up"></i></span>
	    	<span style="float:right">指标</span>
	    </div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		function onLoad(){
			$.ajax({
				url:"api/stock/realtime",
				data:{
					stockcode: '000001'
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					chartInit(data.message);
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
		
		function chartInit(data){
			if(data=='error'){
				alert(data);
				return;
			}
			
			var myChart = document.getElementById('chart');
			var category = new Array();
			var posValues = new Array();
			var negValues = new Array();
			var prices = new Array();
			for(var i =0;i<data.length;i++){
				category.push(data[i].timeStamp);
				if(data[i].color=='red'){
					posValues.push(data[i].businessAmount);
					negValues.push(0);
				}else{
					posValues.push(0);
					negValues.push(data[i].businessAmount);
				}
				prices.push(data[i].lastPrice);
			}
			var ma = calculateMA(5,prices);
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
			    	data: category,
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
			    	min: 0,
			    	max: 10,
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
			    	data: prices
			    },{
			    	type:'line',
			    	data: ma
			    }
			    ],
			    animationEasing: 'elasticOut',
			    animationDelayUpdate: function (idx) {
			        return idx * 5;
			    }
			};
			echarts.init(myChart).setOption(option);
		}
		
		function drawTable(data){
			if(data=='error'){
				alert(data);
				return;
			}
			var html = '';
			var len = data.length;
			if(typeof(len)=='undefined' || len==0)
				return;
			if(typeof(data[len-1].bidGroup)!='undefined'){
				html += '<table>';
				for(var i=0;i<data[len-1].bidGroup.length;i++){
					html+='<tr><td>'+data[len-1].bidGroup[i]+'</td></tr>';
				}
				html+='</table>';
			}
			
			if(typeof(data[len-1].offerGroup)!='undefined'){
				html += '<table>';
				for(var i=0;i<data[len-1].offerGroup.length;i++){
					html+='<tr><td>'+data[len-1].offerGroup[i]+'</td></tr>';
				}
				html+='</table>';
			}
			document.getElementById('bids').innerHTML=html;
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
			location.href="page/stock/kline?stockcode="+document.getElementById('pageCode').value+"&type="+type;
		}
		
	</script>
</body>
</html>

