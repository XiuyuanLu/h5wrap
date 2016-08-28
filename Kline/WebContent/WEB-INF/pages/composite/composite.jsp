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
	height: 8vh;
}

.container .middle .chart-title .main-value{
	width: 20%;
	height: 100%;
	display: inline-block;
	float: left;
	text-align: center;
	margin-left: 3vw;
}

.container .middle .chart-title .other-value{
	width: 70%;
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
	width: 100vw;
	height: 65vh;
	float: left;
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
    <div class="head">
		<div class="head-content">
			<span><a><i class="fa fa-caret-left"></i></a>${name}(${code})<a><i class="fa fa-caret-right"></i></a></span>
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
				url:"api/composite/realtime",
				data:{
					stockcode: document.getElementById('code').value
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					chartInit(data.message);
				}
			});
		}
		
		var textStyle = {
				fontSize: 40,
				fontWeight: 'normal'
		};
		
		function chartInit(data){
			var myChart = document.getElementById('chart');
			var category = new Array();
			var posValues = new Array();
			var negValues = new Array();
			for(var i =0;i<data.length;i++){
				category.push(data[i].timeStamp);
				if(data[i].color=='red'){
					posValues.push(data[i].businessAmount);
					negValues.push(0);
				}else{
					posValues.push(0);
					negValues.push(data[i].businessAmount);
				}
			}
			option = {
			   	grid:[{
			   			left: 30,
			   			right: 20,
			   			height: '70%',
			   			containLabel: true
			   		},{
			   			left: 30,
			   			right: 20,
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
			    			if(index==0 || index==120 || index==240)
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
			    	axisLine:{
			    	},
			    	max: 6,
			    	min: -6,
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
		            name: 'bar',
		            type: 'bar',
		            stack: 'one',
		            data: posValues,
		            itemStyle:{
		            	normal:{
		            		color: '#e51818'
		            	}
		            }
		        },
		        {
		            name: 'bar2',
		            type: 'bar',
		            stack: 'one',
		            data: negValues,
		            itemStyle:{
		            	normal:{
		            		color: '#179b09'
		            	}
		            }
		        }
			    ],
			    animationEasing: 'elasticOut',
			    animationDelayUpdate: function (idx) {
			        return idx * 5;
			    }
			};
			echarts.init(myChart).setOption(option);
		}
		
		function toKline(type){
			location.href="page/composite/kline?stockcode="+document.getElementById('code').value+"&type="+type;
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

