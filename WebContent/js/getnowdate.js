function getNowDate(){
	var date = new Date(); 
		var d=date.getDate();
		var m=date.getMonth()+1;
		if(d<10){
			d="0"+d;
		}
		if(m<10){
			m="0"+m;
		}
		var str = date.getFullYear()+"-"+m+"-"+d;
		return str;
}