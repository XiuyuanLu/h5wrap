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