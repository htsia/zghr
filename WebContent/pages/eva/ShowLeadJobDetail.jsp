<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

    <script type="text/javascript">
	    function doSetScore(id,arr) {
	        window.showModalDialog("/eva/ShowJobContent.jsf?seq="+id+"&array="+arr, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
			return true;
	         }
	    function doChangeScore(i,itemId) {
	        window.showModalDialog("/eva/modifySelfJobDetail.jsf?num="+i+"&itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:no;");
	        document.all('form1:refresh').click();
			return true;
	         }
	    function doAddScore() {
            var itemId =document.all("form1:itemId").value ;
           window.showModalDialog("/eva/addSelfJobDetail.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:no;");
			return true;
             }
        function saveScore(){
			var score = document.getElementsByTagName("input");
			var str="";
			for(var i=0;i<score.length;i++){
				if(score[i].type=="text"){
					if(score[i].value==null||score[i].value==""){
						score[i].value = 0;
					}
					str += score[i].id+":"+score[i].value + ",";
			    }
			}
			document.all('form1:saveStr').value=str;
		    return true;
        }
        function getHistory() {
            var itemId =document.all("form1:itemId").value ;
           	window.showModalDialog("/eva/jobEstimateLog.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
			return true;
        }
    </script>
    
<x:saveState value="#{eva_showSelfJobDetailBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_showSelfJobDetailBB.pageLeadInit}"/>
    <h:inputHidden id="itemId" value="#{eva_showSelfJobDetailBB.itemID}"/>
	<h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{eva_showSelfJobDetailBB.queryPlanList}"></h:commandButton>
	<c:verbatim>
		<table width="100%">
			<tr>
				<td>
				</c:verbatim>
					<h:panelGrid align="left" columns="2">
    					<h:outputText value="当前状态："></h:outputText>
    					<h:outputText value="#{eva_showSelfJobDetailBB.statusDes}"/>
    				</h:panelGrid>
				<c:verbatim>
				</td>
				<td align="right">
				</c:verbatim>
					<h:commandButton value="增加" styleClass="button01" onclick="return doAddScore();" rendered="#{eva_showSelfJobDetailBB.jobBo.status=='1' or eva_showSelfJobDetailBB.jobBo.status=='4' or eva_showSelfJobDetailBB.jobBo.status=='0'}"></h:commandButton>
				   	<h:outputText value=" "></h:outputText>
				   	<h:commandButton value="职责审批批准" styleClass="button01" action="#{eva_showSelfJobDetailBB.audit}" rendered="#{eva_showSelfJobDetailBB.status=='1'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='1'}"></h:outputText>
        			<h:commandButton value="职责审批不批准" styleClass="button01" action="#{eva_showSelfJobDetailBB.audit2}" rendered="#{eva_showSelfJobDetailBB.status=='1'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='1'}"></h:outputText>
        			<h:commandButton value="同意修改" styleClass="button01" action="#{eva_showSelfJobDetailBB.modify}" rendered="#{eva_showSelfJobDetailBB.status=='3'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='3'}"></h:outputText>
        			<h:commandButton value="不同意修改" styleClass="button01" action="#{eva_showSelfJobDetailBB.modifyNO}" rendered="#{eva_showSelfJobDetailBB.status=='3'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='3'}"></h:outputText>
        			<h:commandButton value="同意修改工作内容" styleClass="button01" action="#{eva_showSelfJobDetailBB.modifyContentOK}" rendered="#{eva_showSelfJobDetailBB.status=='5'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='2'}"></h:outputText>
        			<h:commandButton value="不同意修改工作内容" styleClass="button01" action="#{eva_showSelfJobDetailBB.modifyContentNo}" rendered="#{eva_showSelfJobDetailBB.status=='5'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='2'}"></h:outputText>
        			<h:commandButton value="过程" styleClass="button01" onclick="return getHistory();"></h:commandButton>
        			<h:outputText value=" "></h:outputText>
        			<h:commandButton styleClass="button01" value="打分" onclick="return saveScore();" action="#{eva_showSelfJobDetailBB.saveScore}" rendered="#{eva_showSelfJobDetailBB.status=='7'}"></h:commandButton>
				    <h:inputHidden id="saveStr" value="#{eva_showSelfJobDetailBB.saveStr}"></h:inputHidden>
				    <c:verbatim>
				</td>
			</tr>
		</table>
		<table class="table03" align="center" id="dateList" >
			<tr>
				<td class='locked_top' valign='middle' align='center'>履行责任</td>
				<td class='locked_top' valign='middle' align='center'>工作任务</td>
				<td class='locked_top' valign='middle' align='center'>时间比重</td>
				<td class='locked_top' valign='middle' align='center'>考核要点</td>
				<td class='locked_top' valign='middle' align='center'>下属自评情况</td>
				<td class='locked_top' valign='middle' align='center'>考核打分</td>
				<td class='locked_top' valign='middle' align='center'>操作</td>
			</tr>
			<%
				
				for(int i=1;i<=10;i++){
					if(request.getAttribute("tasklist"+i)!=null){
					String[] array = (String[])request.getAttribute("tasklist"+i);//从request中取出数组进行强制转换
					String arr = array[0];
					String itemId = (String)session.getAttribute("itemId");
					request.getSession().removeAttribute("array"+i);
					request.getSession().setAttribute("array"+i,array);
					out.print("<tr>");
					for(int j = 1;j < array.length;j++){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						if(array[j]!=null){
							out.print(array[j]);
						}else{
							out.print(CommonFuns.filterNull(array[j]));
						}
						out.print("</td>");
						}
					if(request.getAttribute("content"+i)!=null){
					List content = (List)request.getAttribute("content"+i);
					EvaJobContentBO jcb;
					//显示个人自助考核打分
					out.print("<td valign='middle' class='td_middle_left' align='center'>");
					out.print("<table>");
					for(int k=0;k<content.size();k++){
						jcb = (EvaJobContentBO)content.get(k);
					out.print("<tr>");
					out.print("<td>");
					if(jcb.getContent()==null){
						jcb.setContent(CommonFuns.filterNull(jcb.getContent()));
					}
					out.print(jcb.getContent());
					out.print("</td>");
					out.print("<td>");
					if(jcb.getSelfScore()==null||"".equals(jcb.getSelfScore())){
						jcb.setSelfScore("0");
					}
					out.print(jcb.getSelfScore()+"分");
					out.print("</td>");
					out.print("<td>");
					if(jcb.getResult()==null){
						jcb.setResult(CommonFuns.filterNull(jcb.getResult()));
					}
					out.print(jcb.getResult());
					out.print("</td>");
					out.print("</tr>");
					}
					out.print("</table>");
					out.print("</td>");
					//显示具体工作内容及领导考核打分
					out.print("<td valign='middle' class='td_middle_left' align='center'>");
					out.print("<table>");
					for(int k=0;k<content.size();k++){
						jcb = (EvaJobContentBO)content.get(k);
					out.print("<tr>");
					out.print("<td>");
					if(jcb.getLeadScore()==null||"".equals(jcb.getLeadScore())){
						jcb.setLeadScore("0");
					}
					if("7".equals((String)session.getAttribute("status"))){
						out.print("<input id = '"+jcb.getTaskID()+"' class='input' type='text' value='"+jcb.getLeadScore()+"'/>");
					}else{
						out.print("<input id = '"+jcb.getTaskID()+"' class='input' type='text' value='"+jcb.getLeadScore()+"' readonly='true'/>");
					}
					out.print("</td>");
					out.print("</tr>");
					}
					out.print("</table>");
					out.print("</td>");
					}else{
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("</td>");
					}
					if("0".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("1".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\">");
						out.print("</td>");
					}
					
					if("2".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					
					if("3".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("4".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\">");
						out.print("</td>");
					}
					if("5".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("6".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改内容\" onclick=\"doSetScore('"+itemId+"','"+arr+"');\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("7".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("8".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					out.print("</tr>");
					}
				}
			%>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("dateList");
</script>