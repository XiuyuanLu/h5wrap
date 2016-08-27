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
	width: 98vw;
	height: 10vh;
	padding-left: 2vw;
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
}

.container .middle .right-bar{
	height: 10vh;
	width: 6vw;
	display: inline-block;
	float: right;
	margin-top: 5vh;
}

.container .middle .right-bar span{
	font-size: 3.5em;
}

.container .middle .right-bar span a{
	text-decoration: none;
}

</style>

</head>

<body>
    <%@include file="/WEB-INF/pages/common/header.jsp" %>
    <div class="container">
    	<div class="search">
    		<input type="text" placeholder="股票代码" onclick="toSearch()"/>
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
	    	<div class="chart" id="chart" onclick="jump()"></div>
	    	<div class="right-bar">
		    	<span><a href="">沪</a></span>
	    	</div>
	    	<div class="right-bar">
		    	<span><a href="">深</a></span>
	    	</div>
	    	<div class="right-bar">
		    	<span><a href="">创</a></span>
	    	</div>
    	</div>
    </div>
    <%@include file="/WEB-INF/pages/common/footer.jsp" %>
	<script>
		var tradeTime;
		function onLoad(){
			$.ajax({
				url:"api/composite/tradeTime",
				data:{
					code: '000001'
				},
				type: 'POST',
				dataType: 'json',
				success:function(data){
					//tradeTime = data.message;
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
		            data: posValues
		        },
		        {
		            name: 'bar2',
		            type: 'bar',
		            stack: 'one',
		            data: negValues
		        }
			    ],
			    animationEasing: 'elasticOut',
			    animationDelayUpdate: function (idx) {
			        return idx * 5;
			    }
			};
			echarts.init(myChart).setOption(option);
		}
		
		function jump(){
			location.href="page/composite";
		}
		
		function toSearch(){
			location.href="page/stock/search";
		}
	</script>
</body>
</html>

