<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>

<%
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
	            	}else{
		            	var dscroe=parseFloat(score);
		            	if(dscroe>resultHi||dscroe<resultLow){
		            		alert("请在打分区间["+resultLow+"-"+resultHi+"]内打分");
		            		document.getElementById("socre_"+itemId).value="";
		            		document.getElementById("socre_"+itemId).focus();
		            	}
	            	}
            	}
            }
        }
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
</script>
<x:saveState value="#{dept_KpiAuditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{dept_KpiAuditBB.initInput}"></h:inputHidden>
     <h:inputHidden value="#{dept_KpiAuditBB.objId}"></h:inputHidden>
    <h:commandButton id="savebutton" value="保存" style="display:none;" action="#{dept_KpiAuditBB.saveScore2}"></h:commandButton>
    <c:verbatim>
   <table width=98% align="center" >
   	  <tr><td colspan="2" height="10"></td></tr>
   	   <%
       String objId =(String)session.getAttribute("objId");
   	   XysKpiDeptSbjBO sbj=(XysKpiDeptSbjBO)session.getAttribute("sbj");
   	   XysKpiDeptObjBO obj=null;
   	   IXysKpiDeptUCC ucc = null;
       try {
           ucc = (IXysKpiDeptUCC) SysContext.getBean("xysKpiDeptUCC");
           obj=ucc.findXysKpiDeptObjBOById(objId);
       }
       catch (Exception e) {
		   e.printStackTrace();
       }
       OrgBO org=SysCacheTool.findOrgById(obj.getDeptId());
       
   %>
       <tr>
           <td align="center" width="60%">
               <span style="font-size:18px;font-weight:bold;" ><%=org.getName()%>KPI考核</span>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
           
       </tr>

       <tr><td height=8>
       </td></tr>

       <tr><td width="60%" valign="top" align="center">
           <table class="table02"  align="center" width="100%">
               <%
                   List libList=ucc.getXysKpiObjLibBOByObjId(objId);//一级指标列表
                   if(libList!=null&&libList.size()>0){
                	   out.println("<tr>");
                	   out.println("<td class='td_middle'>指标名称</td>");
                	   out.println("<td class='td_middle'>指标内容和工作计划</td>");
                	   out.println("<td class='td_middle'>权重</td>");
                	   out.println("<td class='td_middle'>目标值</td>");
                	   out.println("<td class='td_middle'>评分标准</td>");
                	   out.println("<td class='td_middle'>数据来源</td>");
                	   out.println("<td class='td_middle'>实际完成情况</td>");
                	   out.println("<td class='td_middle'>分数</td>");
                	   out.println("</tr>");
	                   for (int i = 0; i < libList.size(); i++) {
	                	   XysKpiObjLibBO lib = (XysKpiObjLibBO) libList.get(i);
	                        List items = ucc.getXysKpiObjKeyBOByLibId(lib.getObjLibId());
	                        int count = items.size() > 0 ? items.size() : 1;
	                        out.println("<tr>");
	                        out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(count) + "'>");
	                        out.println(lib.getObjLibName());
	                        out.println("</td>");
	                        if (items != null && items.size() > 0) {
	                            XysKpiObjKeyBO itembo = (XysKpiObjKeyBO) items.get(0);
	                            XysKpiDeptObjScoreBO score=ucc.findEqualsXysKpiDeptObjScoreBO(sbj.getSbjId(), itembo.getObjKeyId());
	                            out.println("<td class='td_middle_left'>");
	                            out.println(itembo.getKeyName());
	                            out.println("</td>");
	                            out.println("<td class='td_middle_left'>");
	                            out.println(itembo.getWeight()  + "%");
	                            out.println("</td>");
	                            out.println("<td class='td_middle_left' >");
	                            out.println(CommonFuns.filterNull(itembo.getAimValue()));
	                            out.println("</td>");
	                            out.println("<td class='td_middle_left' >");
	                            out.println(CommonFuns.filterNull(itembo.getGradeStd()));
	                            out.println("</td>");
	                            out.println("<td class='td_middle_left'>");
	                            out.println(CommonFuns.filterNull(itembo.getDataSource()));
	                            out.println("</td>");
	                            out.println("<td class='td_middle_left'>");
	                            out.println(CommonFuns.filterNull(itembo.getExecution()));
	                            out.println("</td>");
	                            out.println("<td class='td_middle_left'>");
	                            out.println("<input size='5' id='socre_"+itembo.getObjKeyId()+"' value='"+CommonFuns.filterNull(score.getScore())+"' name='"+itembo.getObjKeyId()+"' type='text' class='input' readonly='true'>");
	                            out.println("</td>");
	                            out.println("</tr>");
	                            for (int j = 1; j < items.size(); j++) {
	                                itembo = (XysKpiObjKeyBO) items.get(j);
	                                score=ucc.findEqualsXysKpiDeptObjScoreBO(sbj.getSbjId(), itembo.getObjKeyId());
	                                out.println("<tr>");
	                                out.println("<td class='td_middle_left'>");
	                                out.println(itembo.getKeyName());
	                                out.println("</td>");
	                                out.println("<td class='td_middle_left'>");
	                                out.println( itembo.getWeight() + "%");
	                                out.println("</td>");
	                                out.println("<td class='td_middle_left'>");
		                            out.println(CommonFuns.filterNull(itembo.getAimValue()));
		                            out.println("</td>");
		                            out.println("<td class='td_middle_left'>");
		                            out.println(CommonFuns.filterNull(itembo.getGradeStd()));
		                            out.println("</td>");
		                            out.println("<td class='td_middle_left'>");
		                            out.println(CommonFuns.filterNull(itembo.getDataSource()));
		                            out.println("</td>");
		                            out.println("<td class='td_middle_left'>");
		                            out.println(CommonFuns.filterNull(itembo.getExecution()));
		                            out.println("</td>");
	                                out.println("<td class='td_middle_left'>");
	                                out.println("<input size='5' id='socre_"+itembo.getObjKeyId()+"' name='"+itembo.getObjKeyId()+"' value='"+CommonFuns.filterNull(score.getScore())+"' type='text' class='input' readonly='true'>");
	                                out.println("</td>");
	                                out.println("</tr>");
	                            }
	                        } else {
	                            out.println("</tr>");
	                        }
	                   }
                   }
               %>
           </table>
       </td>
       </tr>
       <tr><td height=8 align="right">
       <input type="button" class="button01" value="重新计算" onclick="checkAllInput()"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       </td></tr>
   </table>
    </c:verbatim>
</h:form>  

