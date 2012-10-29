/*
 *   主界面使用的js
 *
 */
function doModifyPassword(){
    window.showModalDialog("/ModifyPassword.jsf", null, "dialogWidth:300px; dialogHeight:230px;center:center;resizable:no;status:no;scroll:yes;");
}
function doModifyLanguage(){
   window.showModalDialog("/ModifyLanguage.jsf", null, "dialogWidth:300px; dialogHeight:160px;center:center;resizable:no;status:no;scroll:yes;");
   refreshMain(); 
}
function PreloadImages() {
    var d = document;
    if (d.images) {
        if (!d.MM_p) d.MM_p = new Array();
        var i,j = d.MM_p.length,a = PreloadImages.arguments;
        for (i = 0; i < a.length; i++)
            if (a[i].indexOf("#") != 0) {
                d.MM_p[j] = new Image;
                d.MM_p[j++].src = a[i];
            }
    }
}

function SwapImgRestore() {
    var i,x,a = document.MM_sr;
    for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
}

function FindObj(n, d) {
    var p,i,x;
    if (!d) d = document;
    if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
        d = parent.frames[n.substring(p + 1)].document;
        n = n.substring(0, p);
    }
    if (!(x = d[n]) && d.all) x = d.all[n];
    for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
    for (i = 0; !x && d.layers && i < d.layers.length; i++) x = FindObj(n, d.layers[i].document);
    if (!x && d.getElementById) x = d.getElementById(n);
    return x;
}

function SwapImage() {
    var i,j = 0,x,a = SwapImage.arguments;
    document.MM_sr = new Array;
    for (i = 0; i < (a.length - 2); i += 3)
        if ((x = FindObj(a[i])) != null) {
            document.MM_sr[j++] = x;
            if (!x.oSrc) x.oSrc = x.src;
            x.src = a[i + 2];
        }
}

function clearws() {
    document.getElementById("checkSubmitFlg").value = "0";
}

function clearStatew() {
    setInterval("clearws()", 2000);
}


function Year_Month() {
    var now = new  Date();
    var yy = now.getYear();
    var mm = now.getMonth();
    var mmm = new  Array();
    mmm[0] = "1";
    mmm[1] = "2  ";
    mmm[2] = "3";
    mmm[3] = "4";
    mmm[4] = "5";
    mmm[5] = "6";
    mmm[6] = "7";
    mmm[7] = "8";
    mmm[8] = "9";
    mmm[9] = "10";
    mmm[10] = "11";
    mmm[11] = "12";
    mm = mmm[mm];
    return(mm  );
}
function thisYear() {
    var now = new  Date();
    var yy = now.getYear();
    return(yy  );
}
function Date_of_Today() {
    var now = new  Date();
    return(now.getDate()  );
}
function CurentTime() {
    var now = new  Date();
    var hh = now.getHours();
    var mm = now.getMinutes();
    var ss = now.getTime() % 60000;
    ss = (ss - (ss % 1000)) / 1000;
    var clock = hh + ':';
    if (mm < 10)  clock += '0';
    clock += mm + ':';
    if (ss < 10)  clock += '0';
    clock += ss;
    return(clock);
}
function refreshCalendarClock() {
    document.all.calendarClock1.innerHTML = thisYear() + "年";
    document.all.calendarClock2.innerHTML = Year_Month() + "月";
    document.all.calendarClock3.innerHTML = Date_of_Today() + "日";
    document.all.calendarClock4.innerHTML = CurentTime();
}
var Enter="false";

function Enter_Lable(){
  ModuleShow.style.visibility="visible";
}
function Exit_Lable(){
  window.setTimeout("subtime();",1000);
}

function subtime(){
  window.clearTimeout();
  if (Enter=="false") ModuleShow.style.visibility="hidden";
}

function Enter_Div(){
   Enter="true";
   ModuleShow.style.visibility="visible";
}
function Exit_Div(){
   Enter="false";
   ModuleShow.style.visibility="hidden";
}

