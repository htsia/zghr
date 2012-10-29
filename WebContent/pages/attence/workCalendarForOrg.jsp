<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassDetailBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassGroupBO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.attence.ucc.impl.AttenceSetUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
User user = (User) (session.getAttribute(Constants.USER_INFO));
String personID=(String)request.getParameter("superId");
String isFeaste=(new SimpleDateFormat("yyyy-MM").format(new java.util.Date()));
SimpleDateFormat df =new SimpleDateFormat("yyyy-MM-dd");   
Date now=new Date();   
String time=df.format(now);
String year=time.substring(0,4);
String month=time.substring(5,7);
String day=time.substring(8,10);
%>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="Author" content="Jiang Hongbin">
<title></title>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>


<script language="JavaScript" type="text/JavaScript"> 
var months = new Array("一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月");
var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var days = new Array("日","一", "二", "三", "四", "五", "六");
var today;
var xmlhttp;
//var isFeaste="<%=isFeaste%>";
var isFeaste="";
document.writeln("<div id='Calendar'></div>");

function createXmlHttp(){
	 if(window.XmlHttpRequest){
        xmlhttp=new XMLHttpRequest();
   }else{
       xmlhttp= new ActiveXObject("Microsoft.XMLHTTP");
   }
}
function init(){
	isFeaste="<%=isFeaste%>";
	createXmlHttp();
	 newCalendar();
}
function getDays(month, year)
{
    if (1 == month)
        return ((0 == year % 4) && (0 != (year % 100))) || (0 == year % 400) ? 29 : 28;
    else
        return daysInMonth[month];
}

function getToday()
{
    //得到今天的年,月,日
    this.now = new Date();
    this.year = this.now.getFullYear();
    this.month = this.now.getMonth();
    this.day = this.now.getDate();
}

function getStringDay(str)
{
    //得到输入框的年,月,日
    var str=str.split("-")

    this.now = new Date(parseFloat(str[0]),parseFloat(str[1])-1,parseFloat(str[2]));
    this.year = this.now.getFullYear();
    this.month = this.now.getMonth();
    this.day = this.now.getDate();
}
function newstr(){
	
}
function newCalendar() {
	var personID="<%=personID%>";
	//createXmlHttp();
    var parseYear = parseInt(document.all.Year.options[document.all.Year.selectedIndex].value);
    var parseMonth=parseInt(document.all.Month.options[document.all.Month.selectedIndex].value);
    var newCal = new Date(parseYear, document.all.Month.selectedIndex, 1);
    var day = -1;
    var startDay = newCal.getDay();
    var daily = 0;

    if ((today.year == newCal.getFullYear()) &&(today.month == newCal.getMonth()))
        day = today.day;
    var tableCal = document.all.calendar;
    var intDaysInMonth =getDays(newCal.getMonth(), newCal.getFullYear());
    var parseMonth1=(parseMonth+1);
    xmlhttp.onreadystatechange=getresultback;
    xmlhttp.open("GET","/pages/attence/getFeast4.jsp?yearvalue="+parseYear+"&monthvalue="+parseMonth+"&personID="+personID,
    	    true);
    xmlhttp.send(null);
    //alert("你将要查看的是【"+parseYear+"年度"+parseMonth+"月份】倒班情况");
    for (var intWeek = 1; intWeek < tableCal.rows.length;intWeek++)
        for (var intDay = 0;intDay < tableCal.rows[intWeek].cells.length;intDay++)
        {
            var cell = tableCal.rows[intWeek].cells[intDay];
            if ((intDay == startDay) && (0 == daily))
                daily = 1;
            if(day==daily) //今天，调用今天的Class
            {
                cell.style.background='#bbccdd';
                //cell.style.color='#FFFFFF';
                //cell.style.fontWeight='bold';
            }else if(intDay==6) //周六
                cell.style.color='green';
            else if (intDay==0) //周日
                cell.style.color='red'    
              //var ymd=new Array("2010-02-01","2010-02-17","2010-02-28","2010-12-17");
            //var ymdValue=new Array("2010-02-01","2010-02-17","2010-02-28","2010-12-17");


             var ymd=new Array();
             var ymdValue=new Array();
             var ymdValues=new Array();
             var feasts1="";
             var feasts=isFeaste.split(",");
             for(var m=0;m<feasts.length;m++){
            	 feasts1=feasts[m];
            	 var feasts2=feasts1.split(":");
                 ymd.push(feasts2[0]);
                 ymdValue.push(feasts2[1]);
                 ymdValues.push(feasts2[2]);
             }
            var isfeast=false;
            if ((daily > 0) && (daily <= intDaysInMonth))
            {
                 var ymdValue1="";
                 var ymdValue2="";
                 for(var i=0;i<ymd.length;i++){
                 if(parseYear+"-0"+parseMonth+"-"+daily==ymd[i]){ 
                	 isfeast=true; 
                	 ymdValue1=ymdValue[i];
                	 ymdValue2=ymdValues[i];
                 	break;  
                }else if(parseYear+"-0"+parseMonth+"-0"+daily==ymd[i]){
                	isfeast=true;
                	ymdValue1=ymdValue[i];
                	ymdValue2=ymdValues[i]; 
                	break;
                 }else if(parseYear+"-"+parseMonth+"-0"+daily==ymd[i]){
                    	isfeast=true; 
                    	ymdValue1=ymdValue[i];
                    	ymdValue2=ymdValues[i];
                    	break;
                 }else if(parseYear+"-"+parseMonth+"-"+daily==ymd[i]){
                 	isfeast=true; 
                 	ymdValue1=ymdValue[i];
                 	ymdValue2=ymdValues[i];
                	break;
                }else{
                    	isfeast=false;    
               }
              }
                  if(isfeast){
                	  cell.innerHTML ="<div style='font-size: 20px;'><b>"+daily+"</b></div>";
                	  if(ymdValue2=="公休日"){
                        cell.innerHTML+="<div>"+ymdValue1+"</div>"; 
                	  }else if(ymdValue2=="节假日"){
                        cell.innerHTML+="<div>"+ymdValue1+"</div>"; 
                	  }else if(ymdValue2=="休息"){
                        cell.innerHTML+="<div>"+ymdValue1+"</div>"; 
                	  }else{
                		  cell.innerHTML+="<div>"+ymdValue1+"</div>"; 
                	  }
                      }
                  else{
                	cell.innerHTML ="<div style='font-size: 28px;'><b>"+daily+"</b></div>";
                    }                                                     
                daily++;
            }
            else
                cell.innerText = "";
        }
}

function GetDate(name)
{
  window.showModalDialog("/pages/attence/groupCalendarEdit1.jsp?name="+name, null, "dialogWidth:400px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:no;");

}
function ClearCalendar(){
    window.returnValue="";
    self.close();
}
function HiddenCalendar()
{
    //关闭选择窗口
    document.all.Calendar.style.visibility='hidden';
}

function ShowCalendar(InputBox)
{
    var x,y,intLoop,intWeeks,intDays;
    var DivContent;
    var year,month,day;
//    var o=eval("document.all."+InputBox);
    var thisyear; //真正的今年年份

    thisyear=new getToday();
    thisyear=thisyear.year;

//    today = o.value;
    today = InputBox;

    if(isDate(today))
        today = new getStringDay(today);
    else
        today = new getToday();

    //显示的位置
//    x=o.offsetLeft;
//    y=o.offsetTop;
//    while(o=o.offsetParent)
//    {
//        x+=o.offsetLeft;
//        y+=o.offsetTop;
//    }
    document.all.Calendar.style.left=37;
    //document.all.Calendar.style.top=0;
    document.all.Calendar.style.visibility="visible";
    //下面开始输出日历表格(border-color:#9DBAF7)
    DivContent="<table align='center' width=700 height=580 border='0' cellpadding='2' cellspacing='3'>"; 
    DivContent+="<tr><td>";
    DivContent+="<table width=700 height=300 border='0' cellspacing='0'>"; 
    
    DivContent+="<tr align='center'   style='background-color: #bbccdd'>";

    DivContent+="<td>";

    //年
    DivContent+="公元<select name='Year' id='Year' onChange='init()' style='font-family:Verdana; font-size:15px'>";
    for (intLoop = thisyear - 80; intLoop < (thisyear + 20); intLoop++)
        DivContent+="<option value= " + intLoop + " " + (today.year == intLoop ? "Selected" : "") + ">" + intLoop + "</option>";
    DivContent+="</select>年";

    //月
    DivContent+="<select name='Month' id='Month' onChange='init()' style='font-family:Verdana; font-size:15px'>";
    for (intLoop = 0; intLoop < months.length; intLoop++)
        DivContent+="<option value= " + (intLoop + 1) + " " + (today.month == intLoop ? "Selected" : "") + ">" + months[intLoop] + "</option>";
    DivContent+="</select>月";
    //DivContent+="<td style='border-bottom:1px solid #0066FF; background-color:#ffffff; font-weight:bold; font-size:15px; padding-top:2px; color:#4477FF; cursor:hand' align='center' title='取消返回' onclick='javascript:ClearCalendar()'>取消返回</td>";
    DivContent+="</tr>";

    DivContent+="<tr><td align='center' colspan='2'>";
    DivContent+="<table id='calendar' border='0' width='100%' class='table02'>";

    //星期
    DivContent+="<tr width=100>";
    for (intLoop = 0; intLoop < days.length; intLoop++)
        DivContent+="<td align='center' class='td_middle'>" + days[intLoop] + "</td>";
    DivContent+="</tr>";

    //天
    for (intWeeks = 0; intWeeks < 6; intWeeks++)
    {
        DivContent+="<tr  width=100 height=79>";
        for (intDays = 0; intDays < days.length; intDays++)
            DivContent+="<td  width=100 height=79  class='PS_CSS' align='center'></td>";
        DivContent+="</tr>";
    }

    DivContent+="</table></td></tr></table></td><td>";
    DivContent+="<table width=100 height=580 align='center'>";
    DivContent+="<tr><td></td></tr>";
    DivContent+="<tr><td></td></tr>";
    DivContent+="<tr><td></td></tr>";
    DivContent+="<tr><td></td>";
    DivContent+="<td height=30>";
    DivContent+="<br><br><br><br>";
    DivContent+="<br><br></td></tr>";
    DivContent+="<tr><td>&nbsp;&nbsp;</td></tr>";
    DivContent+="</table></td></tr></table>";
    document.all.Calendar.innerHTML=DivContent;
    newCalendar();
}

function isDate(dateStr)
{
    var datePat = /^(\d{4})(\-)(\d{1,2})(\-)(\d{1,2})$/;
    var matchArray = dateStr.match(datePat);
    if (matchArray == null) return false;
    var month = matchArray[3];
    var day = matchArray[5];
    var year = matchArray[1];
    if (month < 1 || month > 12) return false;
    if (day < 1 || day > 31) return false;
    if ((month==4 || month==6 || month==9 || month==11) && day==31) return false;
    if (month == 2)
    {
        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
        if (day > 29 || (day==29 && !isleap)) return false;
    }
    return true;
}
function getresultback(){
	 if(xmlhttp.readyState==4){
		 isFeaste=xmlhttp.responseText;
		 newCalendar();
	}
}
	
</script>
<style type="text/css">
<!--
td,input {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
}
-->
</style>
</head>

<body style="overflow:auto;" onload="init()">
<script>
ShowCalendar('<%=CommonFuns.filterNull(request.getParameter("date"))%>');
</script>
</body>
</html>