<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>

<%
//人员KPI自评页面
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
  
   
   <br>
<script type="text/javascript">
	var xmlHttp;
	var itemId;
	 //创建XMLHttpRequest对象
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }
    
    function checkInputValue(pid) {
        itemId=pid;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", "/pages/xys/eva/checkInputScore.jsp?itemId=" + pid, true);
        xmlHttp.send(null);
    }
    function handleStateChange() {
        if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
            	var results = xmlHttp.responseText;
            	if(results!=null&&results!=""){
	            	var result=results.split(",");
	            	var score=document.getElementById("socre_"+itemId).value;
	            	var resultHi=parseFloat(result[0]);
	            	var resultLow=parseFloat(result[1]);
	            	var dscroe1=true;
	            	if(""==score){
	            		dscroe1=false;
	            	}else{
	            		var reg=/^\d+(\.\d+)?$/;
	            		dscroe1=reg.test(score);
	            	}
	            	if(dscroe1==false){
	            		alert("请输入数字");
	            		document.getElementById("socre_"+itemId).value="";
	            		document.getElementById("socre_"+itemId).focus();
	            		return;
	            	}else{
		            	var dscroe=parseFloat(score);
		            	if(dscroe>resultHi||dscroe<resultLow){
		            		alert("请在打分区间["+resultLow+"-"+resultHi+"]内打分");
		            		document.getElementById("socre_"+itemId).value="";
		            		document.getElementById("socre_"+itemId).focus();
		            		return;
		            	}
	            	}
	            	sumScore();
            	}
            }
        }
    }
   
    function sumScore(){
  	  var sumScore=0;
        var doms=document.getElementsByTagName('input');
        if(doms!=null&&doms.length>0){
 	        for(var i=0;i<doms.length;i++){
 		        if(doms[i].id!=null&&doms[i].id.substring(0,6)=="socre_"&&(doms[i].value!=null&&doms[i].value!="")){
 		        	sumScore += parseFloat(doms[i].value)* parseFloat(doms[i].weight)/100;
 		        }
 	        }
        }
        var div =document.getElementById('scoreSumDiv');
        div.innerHTML = Math.round(sumScore*100)/100;
  }
    
   function checkAllInput(){
       var allinput=true;
       var doms=document.getElementsByTagName('input');
       if(doms!=null&&doms.length>0){
	        for(var i=0;i<doms.length;i++){
		        if(doms[i].id!=null&&doms[i].id.substring(0,6)=="socre_"&&(doms[i].value==null||doms[i].value=="")){
		        	allinput=false;
		        }
	        }
       }
       if(allinput==true){
          document.all('form1:savebutton').click();
       }else{
           alert("请输入各指标得分！");
       }
   }
   
   sumScore();
</script>
<c:verbatim>
<style type="text/css">
    	.td_xys_top {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 12px;
			color: #333333;
			background-color: #F3F3F3;
			padding: 3px;
			border-right: 1px #4986d4 solid;
			border-bottom: 1px #4986d4 solid;
			height: 22px;
		}
		.td_xys_mid {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 12px;
			color: #333333;
			background-color: #FFFFFF;
			padding: 3px;
    		border-right: 1px #4986d4 solid;
			border-bottom: 1px #4986d4 solid;
			height: 22px;
    		text-align :left;
    		word-wrap:break-word;
		}
		.input_xys {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 12px;
			color: #323232;
			background-color: #FFFFFF;
			height: 20px;
			border: 1px solid #4986d4;
		}
	textarea
	{ 
		width:100%; 
		height:100%; 
		overflow-y:visible ;
		overflow-x:visible;
		WORD-BREAK: break-all;
		background-color:white;
		border: 0px solid #4986d4;
	} 
    </style>
   </c:verbatim>
<x:saveState value="#{self_PersonKpiGradeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{self_PersonKpiGradeBB.initInput}"></h:inputHidden>
     <h:inputHidden value="#{self_PersonKpiGradeBB.objId}"></h:inputHidden>
    <h:commandButton id="savebutton" value="保存" style="display:none;" action="#{self_PersonKpiGradeBB.saveScore}"></h:commandButton>
    <c:verbatim>
   <table width=98% align="center" >
   	  <tr><td colspan="2" height="10"></td></tr>
   	   <%
       String objId =(String)session.getAttribute("objId");
   	   XysKpiPersonObjBO obj=null;
   	   IXysKpiDeptUCC ucc = null;
   	   IXysKpiPersonUCC pucc=null;
       try {
           ucc = (IXysKpiDeptUCC) SysContext.getBean("xysKpiDeptUCC");
           pucc = (IXysKpiPersonUCC) SysContext.getBean("xysKpiPersonUCC");
           obj=pucc.findXysKpiPersonObjBOById(objId);
       }
       catch (Exception e) {
		   e.printStackTrace();
       }
       PersonBO pb=SysCacheTool.findPersonById(obj.getPersonId());
       
   %>
       <tr>
           <td align="center" width="60%">
               <span style="font-size:18px;font-weight:bold;" ><%=pb.getName()%>KPI考核</span>
            </td>
       </tr>
       <tr><td height=8>
       </td></tr>

       <tr><td width="60%" valign="top" align="center">
           <table class="table02"  align="center" width="100%"  cellspacing=0 cellpadding=0 width=100%>
               <%
                   List libList=ucc.getXysKpiObjLibBOByObjId(objId);
                   if(libList!=null&&libList.size()>0){
                	   out.println("<tr>");
                	   out.println("<td class='td_xys_top'>指标名称</td>");
                	   out.println("<td  class='td_xys_top' >指标内容和工作计划</td>");
                	   out.println("<td class='td_xys_top'>目标值</td>");
                	   out.println("<td class='td_xys_top' style='width:110px'>评分标准</td>");
                	   out.println("<td class='td_xys_top' style='width:80px'>数据来源</td>");
                	   out.println("<td class='td_xys_top' style='width:40px'>权重</td>");
                	   out.println("<td class='td_xys_top' style='width:300px'>实际完成情况</td>");
                	   out.println("<td class='td_xys_top'>自评分</td>");
                	   out.println("</tr>");
	                   for (int i = 0; i < libList.size(); i++) {
	                	   XysKpiObjLibBO lib = (XysKpiObjLibBO) libList.get(i);
	                        List items = ucc.getXysKpiObjKeyBOByLibId(lib.getObjLibId());
	                        int count = items.size() > 0 ? items.size() : 1;
	                        out.println("<tr>");
	                        out.println("<td valign='center' class='td_xys_mid' align='center' rowspan='" + String.valueOf(count) + "'>");
	                        out.println(lib.getObjLibName());
	                        out.println("</td>");
	                        if (items != null && items.size() > 0) {
	                            XysKpiObjKeyBO itembo = (XysKpiObjKeyBO) items.get(0);
	                            
	                            out.println("<td class='td_xys_mid'>");
	                            out.println(itembo.getKeyName());
	                            out.println("</td>");
	                            
	                            out.println("<td class='td_xys_mid'>");
	                            out.println(CommonFuns.filterNull(itembo.getAimValue()));
	                            out.println("</td>");
	                            
	                            out.println("<td class='td_xys_mid'>");
	                            out.println(CommonFuns.filterNull(itembo.getGradeStd()));
	                            out.println("</td>");
	                            
	                            out.println("<td class='td_xys_mid'>");
	                            out.println(CommonFuns.filterNull(itembo.getDataSource()));
	                            out.println("</td>");
	                            out.println("<td class='td_xys_mid'>");
	                            out.println(itembo.getWeight()+"%");
	                            out.println("</td>");
	                            out.println("<td class='td_xys_mid'>");
	                            out.println("<textarea style='border:#b7b3ad 1px solid;margin:0px;padding:2px;background-color:cce8cf'   name='"+itembo.getObjKeyId()+"_execution'>"+CommonFuns.filterNull(itembo.getExecution())+"</textarea>");
	                            out.println("</td>");
	                            out.println("<td class='td_xys_mid'>");
	                            out.println("<input size='5' style='background-color:cce8cf'  weight='"+itembo.getWeight()+"' id='socre_"+itembo.getObjKeyId()+"' value='"+CommonFuns.filterNull(itembo.getSelfGrade())+"' name='"+itembo.getObjKeyId()+"' type='text' class='input' onchange=\"checkInputValue('"+itembo.getObjKeyId()+"')\">");
	                            out.println("</td>");
	                            out.println("</tr>");
	                            for (int j = 1; j < items.size(); j++) {
	                                itembo = (XysKpiObjKeyBO) items.get(j);
	                                out.println("<tr>");
	                                
	                                out.println("<td class='td_xys_mid'>");
		                            out.println(itembo.getKeyName());
		                            out.println("</td>");
		                            
		                            out.println("<td class='td_xys_mid'>");
		                            out.println(CommonFuns.filterNull(itembo.getAimValue()));
		                            out.println("</td>");
		                            
		                            out.println("<td class='td_xys_mid'>");
		                            out.println(CommonFuns.filterNull(itembo.getGradeStd()));
		                            out.println("</td>");
		                            
		                            out.println("<td class='td_xys_mid'>");
		                            out.println(CommonFuns.filterNull(itembo.getDataSource()));
		                            out.println("</td>");
	                                out.println("<td class='td_xys_mid'>");
	                                out.println( itembo.getWeight() +"%");
	                                out.println("</td>");
		                            out.println("<td class='td_xys_mid'>");
		                            out.println("<textarea style='border:#b7b3ad 1px solid;margin:0px;padding:2px;background-color:cce8cf'   name='"+itembo.getObjKeyId()+"_execution'>"+CommonFuns.filterNull(itembo.getExecution())+"</textarea>");
		                            out.println("</td>");
	                                out.println("<td class='td_xys_mid'>");
	                                out.println("<input style='background-color:cce8cf'  size='5' weight='"+itembo.getWeight()+"' id='socre_"+itembo.getObjKeyId()+"' name='"+itembo.getObjKeyId()+"' value='"+CommonFuns.filterNull(itembo.getSelfGrade())+"' type='text' class='input' onchange=\"checkInputValue('"+itembo.getObjKeyId()+"')\">");
	                                out.println("</td>");
	                                out.println("</tr>");
	                            }
	                        } else {
	                            out.println("</tr>");
	                        }
	                   }
	                   out.println("<tr>");
                	   out.println("<td class='td_xys_top'  style='text-align:center' colspan='7'><b>分数加权合计</b></td>");
                	   out.println("<td class='td_xys_top'  style='align:center' ><b><div id='scoreSumDiv'></div></b></td>");
                	   out.println("</tr>");
                   }
               %>
           </table>
       </td>
       </tr>
       <tr><td height=8 align="right">
       <input type="button" class="button01" value="保存" onclick="checkAllInput()"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       </td></tr>
   </table>
    </c:verbatim>
</h:form>  

