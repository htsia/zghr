<%@ page import="com.hr319wg.eva.ucc.impl.EvaKeyItemUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.eva.ucc.IEvaScoreUCC" %>
<%@ page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
   <%
       String templateID = request.getParameter("templateID");
       if (templateID==null){
           templateID=(String)session.getAttribute("templateID");
       }
       String masterID = request.getParameter("masterID");
       if (masterID==null){
           masterID=(String)session.getAttribute("masterID");
       }

       String objectID = request.getParameter("objectID");
       if (objectID==null){
           objectID=(String)session.getAttribute("objectID");
       }

       EvaKeyItemUCC ucc = null;
       EvaTemplateBO templatebo = null;
       EvaPlanUCC  planUcc=null;
       try {
           ucc = (EvaKeyItemUCC) SysContext.getBean("eva_keyitemucc");
           planUcc=(EvaPlanUCC)SysContext.getBean("eva_planUCC");
           templatebo = ucc.findTemplateBO(templateID);
       }
       catch (Exception e) {

       }
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
        xmlHttp.open("GET", "/pages/eva/checkInputScore.jsp?itemId=" + pid, true);
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
		            		alert("请在打分区间内打分");
		            		document.getElementById("socre_"+itemId).value="";
		            		document.getElementById("socre_"+itemId).focus();
		            	}
	            	}
            	}
            }
        }
    }

    function Info(itemid){
        var url="/eva/KeyItemInfo.jsf?itemID="+itemid;
        document.all('two').src=url;
    }
    function viewAtt(id){
	  	 window.open('/pages/eva/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
	 }
   function showWork(planId,personId) {
       window.showModalDialog("/eva/workSumEdit.jsf?method=query&planID="+planId+"&sumPid="+personId, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:yes;scroll:yes;");
       return true;
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

<h:form id="form1">
    <h:inputHidden value="#{eva_scoreBB.initInput}"></h:inputHidden>
    <h:commandButton id="savebutton" value="保存" style="display:none;" action="#{eva_scoreBB.savescore1}"></h:commandButton>
    <c:verbatim>
   <table width=98% align="center" >
   	   <tr>
   	   	<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;
   	   	<span style="font-size:14px;font-weight:bold;" >
  </c:verbatim>
  		<h:outputText value="考核主体：#{eva_scoreBB.masterName}"></h:outputText>
  		<h:outputText value="  "></h:outputText>
  		<h:outputText value="考核客体：#{eva_scoreBB.objectName}"></h:outputText>
  		<h:outputText value="  "></h:outputText>
  		<h:outputText value="任务数：#{eva_scoreBB.taskDes}"></h:outputText>
   <c:verbatim>
   </span>
   	   	</td>
   	   </tr>
   	  <tr><td colspan="2" height="10"></td></tr>
       <tr>
           <td align="center" width="60%">
               <span style="font-size:18px;font-weight:bold;" ><%=templatebo.getTemplateName()%></span>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                String planId=(String)session.getAttribute("planId");
                String notShowPercent="0";
                EvaPlanBO pb=planUcc.findPlanById(planId);
            	if(pb.getNotShowPercent()!=null&&!pb.getNotShowPercent().equals("")){
            		notShowPercent=pb.getNotShowPercent();
            	}
            	String personId=(String)session.getAttribute("personId");
                    if (masterID!=null && !"".equals(masterID) && objectID!=null && !"".equals(objectID)) {
                        out.print("<input type=\"button\" class=\"button01\" value=\"保存\" onclick=\"checkAllInput()\">");
                    }
                %>
            </td>
            <td>
            </td>
       </tr>

       <tr><td height=8 colspan=2>

       </td></tr>

       <tr><td width="60%" valign="top" algin=right>
           <table class="table02"  align="center" width="100%">
               <%
                   Hashtable ht = (Hashtable)session.getAttribute("ScoreObject");
                   if (ht==null) ht=new Hashtable();
                   List root = ucc.getAllChildItemSet(templateID);
                   String value="";
                   String id="";
                   for (int i = 0; i < root.size(); i++) {
                       TemplateItemSetBO rootset = (TemplateItemSetBO) root.get(i);
                       List items = ucc.getAllChildItem(rootset.getSetID());
                       int count = items.size() > 0 ? items.size() : 1;
                       out.println("<tr>");
                       out.println("<td valign='center' class='td_middle_center' align='center' rowspan='" + String.valueOf(count) + "'>");
                       out.println(rootset.getSetName());
                       out.println("</td>");
                       if (items!=null && items.size()>0){
                           TemplateItemBO itembo = (TemplateItemBO) items.get(0);
                           EvaKeyItemBO keybo = ucc.getEvaKeyItemBO(itembo.getLinkID());
                           EvaScoreBO valuebo=(EvaScoreBO)ht.get(itembo.getItemID());
                           if (valuebo!=null){
                               value=CommonFuns.filterNull(valuebo.getScore());
                               id=valuebo.getScoreID();
                           }
                           else{
                               value="";
                               id="noitem";
                           }
                           String title="";
                           if(notShowPercent.equals("1")){
                        	   title= keybo.getItemName() + "(" + CommonFuns.filterNull(itembo.getScore()) + ")";
                           }else{
                        	   title= keybo.getItemName() + "(" + CommonFuns.filterNull(itembo.getScore()) + "%)"; 
                           }
                           out.println("<td class='td_middle_left'>");
                           out.println(title);
                           out.println("</td>");

                           if(keybo.getItemType().equals("2")){
	                           out.println("<td class='td_middle_left'>");
	                           out.println("计算型指标不用打分");
	                           out.println("</td>");
                           }else{
                        	   out.println("<td class='td_middle_left'>");
	                           out.println("<input id='socre_"+keybo.getItemID()+"' name='"+id+"' class='input' type='text' onfocus=\"Info('"+keybo.getItemID()+"')\" onchange=\"checkInputValue('"+keybo.getItemID()+"')\" value='"+value+"' style=\"behavior:url('/js/mytextbox.htc');\" >");
	                           out.println("</td>");
                           }
                           out.println("</tr>");
                           for (int j = 1; j < items.size(); j++) {
                               itembo = (TemplateItemBO) items.get(j);
                               keybo = ucc.getEvaKeyItemBO(itembo.getLinkID());
                               valuebo=(EvaScoreBO)ht.get(itembo.getItemID());
                               if (valuebo!=null){
                                   value=CommonFuns.filterNull(valuebo.getScore());
                                   id=valuebo.getScoreID();
                               }
                               else{
                                   value="";
                                   id="noitem";
                               }
                               if(notShowPercent.equals("1")){
                            	   title = keybo.getItemName() + "(" + CommonFuns.filterNull(itembo.getScore()) + ")";
                               }else{
                            	   title = keybo.getItemName() + "(" + CommonFuns.filterNull(itembo.getScore()) + "%)";
                               }
                               out.println("<tr>");
                               out.println("<td class='td_middle_left'>");
                               out.println(title);
                               out.println("</td>");
                               if(keybo.getItemType().equals("2")){
    	                           out.println("<td class='td_middle_left'>");
    	                           out.println("计算型指标不用打分");
    	                           out.println("</td>");
                               }else{
                            	   out.println("<td class='td_middle_left'>");
    	                           out.println("<input id='socre_"+keybo.getItemID()+"' name='"+id+"' class='input' type='text' onfocus=\"Info('"+keybo.getItemID()+"')\" onchange=\"checkInputValue('"+keybo.getItemID()+"')\" value='"+value+"' style=\"behavior:url('/js/mytextbox.htc');\" >");
    	                           out.println("</td>");
                               }
                               out.println("</tr>");
                           }
                       }
                       else{
                         out.println("</tr>");
                       }
                   }
               %>
           </table>
       </td>
       <td valign="top"   align="center" width="40%" rowspan="2">
       		<iframe id="two" width="100%" height="500" frameBorder=0 scrolling=no src="/eva/KeyItemInfo.jsf"></iframe>
        </td>
       </tr>
        <tr>
       	    <td valign="top" width="60%" algin=right>
       			<iframe id="one" width="100%" height="200" frameBorder=0 scrolling=no src="/eva/workSumShow.jsf?planID=<%=planId%>&sumPid=<%=personId%>"></iframe>
       			</c:verbatim>
       			<h:commandLink value="述职报告"   onclick="viewAtt('#{eva_scoreBB.attachmentId}')" rendered="#{eva_scoreBB.isHaveReport=='1'}"></h:commandLink>
       			<c:verbatim>
       		</td>
       	
       </tr>
   </table>
    </c:verbatim>
</h:form>  
<script type="text/javascript">

</script>  
