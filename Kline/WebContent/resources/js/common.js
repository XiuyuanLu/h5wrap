$(document).ready(function (){
	if(typeof(onLoad) != "undefined"){
		onLoad();
	}
});

function redirect(path){
	if(typeof(path)=='undefined' || path==''){
		alert('coming soon');
		return;
	}
	location.href=path;
}

function highlight(item){
	var fthome = document.getElementById('ft-home');
	var ftpick = document.getElementById('ft-pick');
	var ftprivate = document.getElementById('ft-private');
	var fttrade = document.getElementById('ft-trade');
	var ftself = document.getElementById('ft-self');
	if(item=='home'){
		fthome.src='resources/img/home-p.png';
		ftpick.src='resources/img/pick.png';
		ftprivate.src='resources/img/private.png';
		fttrade.src='resources/img/trade.png';
		ftself.src='resources/img/self.png';
	}else if(item=='pick'){
		fthome.src='resources/img/home.png';
		ftpick.src='resources/img/pick-p.png';
		ftprivate.src='resources/img/private.png';
		fttrade.src='resources/img/trade.png';
		ftself.src='resources/img/self.png';
	}else if(item=='private'){
		fthome.src='resources/img/home.png';
		ftpick.src='resources/img/pick.png';
		ftprivate.src='resources/img/private-p.png';
		fttrade.src='resources/img/trade.png';
		ftself.src='resources/img/self.png';
	}else if(item=='trade'){
		fthome.src='resources/img/home.png';
		ftpick.src='resources/img/pick.png';
		ftprivate.src='resources/img/private.png';
		fttrade.src='resources/img/trade-p.png';
		ftself.src='resources/img/self.png';
	}else{
		fthome.src='resources/img/home.png';
		ftpick.src='resources/img/pick.png';
		ftprivate.src='resources/img/private.png';
		fttrade.src='resources/img/trade.png';
		ftself.src='resources/img/self-p.png';
	}
}