<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

    <script type="text/javascript">
    	var str="";
        function doSetScore(id,arr) {
            window.showModalDialog("/eva/ShowJobContent.jsf?seq="+id+"&array="+arr, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
            document.all('form1:refresh').click();
			return true;
        }
        function doApproval(id,arr) {
           var masterId =document.all("form1:masterId").value ;
           window.showModalDialog("/eva/approveTask.jsf?masterId="+masterId, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
  		   return true;
        }
        function doAddScore() {
           var masterId =document.all("form1:masterId").value ;
           window.showModalDialog("/eva/addSelfTaskDetail.jsf?masterId="+masterId, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
		   return true;
        }
        function doChangeTask(itemId) {
            window.showModalDialog("/eva/modSelfTaskDetail.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
            document.all('form1:refresh').click();
			return true;
        }
        function showLine(itemId) {
            window.showModalDialog("/eva/SelfTaskDetailQuery.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
            document.all('form1:refresh').click();
			return true;
        }
        function showProcess(itemId) {
            window.showModalDialog("/eva/taskProcessMgr.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
            document.all('form1:refresh').click();
			return true;
        }
        
        function deleteLine(itemId){
        	document.all("form1:itemId").value=itemId;
        	document.all("form1:deletebutton").click();
        	return true;
        }
        function getHistory() {
            var masterId =document.all("form1:masterId").value ;
           	window.showModalDialog("/eva/taskEstimateLog.jsf?masterId="+masterId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
			return true;
        }
    </script>
<x:saveState value="#{selfTaskEstimateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{selfTaskEstimateBB.initEdit}"/>
    <h:inputHidden id="masterId" value="#{selfTaskEstimateBB.masterId}"/>
    <h:inputHidden id="itemId" value=""/>
    <h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{selfTaskEstimateBB.queryEstimateList}"></h:commandButton>
    <h:commandButton id="deletebutton" value="删除" style="display:none;"  action="#{selfTaskEstimateBB.deleteContent}"></h:commandButton>
	<h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 自助任务考核"/>
        </h:panelGroup>
    </h:panelGrid>
    
    <h:panelGrid columns="1" align="center" width="98%">
    <h:panelGroup>
				<h:panelGrid align="left">
					<h:outputText value="当前状态:#{selfTaskEstimateBB.master.statusDes}"/>
				</h:panelGrid>
				<h:panelGrid align="right">
				<h:panelGroup>
					<h:commandButton value="增加" styleClass="button01" onclick="return doAddScore();" rendered="#{selfTaskEstimateBB.master.status=='0' or selfTaskEstimateBB.master.status=='4'}"></h:commandButton>
					<h:commandButton value="报批" styleClass="button01" onclick="return doApproval();" rendered="#{selfTaskEstimateBB.master.status=='0' or selfTaskEstimateBB.master.status=='4'}"></h:commandButton>
					<h:commandButton value="申请修改" styleClass="button01"  action="#{selfTaskEstimateBB.doModify}" rendered="#{selfTaskEstimateBB.master.status=='2'}"></h:commandButton>
					<h:commandButton value="过程" styleClass="button01" onclick="return getHistory();"></h:commandButton>
				</h:panelGroup>
				</h:panelGrid> 
				</h:panelGroup>
		<c:verbatim>
		<table class="table02" align="center" id="dateList">
			<tr>
				<td class='locked_top' valign='middle' align='center'>序号</td>
				<td class='locked_top' valign='middle' align='center'>工作任务</td>
				<td class='locked_top' valign='middle' align='center'>工作计划</td>
				<td class='locked_top' valign='middle' align='center'>衡量标准</td>
				<td class='locked_top' valign='middle' align='center'>时间</td>
				<td class='locked_top' valign='middle' align='center'>自评分</td>
				<td class='locked_top' valign='middle' align='center'>权重</td>
				<td class='locked_top' valign='middle' align='center'>操作</td>
			</tr>
			<%
				List rsultlist=(ArrayList)session.getAttribute("resultList");
				if(rsultlist!=null&&rsultlist.size()>0){
					for(int i=0;i<rsultlist.size();i++){
						EvaTaskEstimateBO taskbo=(EvaTaskEstimateBO)rsultlist.get(i);
						out.print("<tr>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(taskbo.getSeq());
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(taskbo.getTaskContent());
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(taskbo.getTaskPlan());
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(taskbo.getTaskStandard());
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(taskbo.getTaskDate());
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(CommonFuns.filterNull(taskbo.getSelfScore()));
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(taskbo.getPurview()+"%");
						out.print("</td>");
						String status=(String)session.getAttribute("status");
						if("0".equals(status) || "4".equals(status)){
							out.print("<td valign='middle' class='td_middle_left' align='center'>");
							out.print("<input type=\"button\" class=\"button01\" value=\"过程管理\" onclick=\"showProcess('"+taskbo.getItemId()+"');\">");
							out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeTask('"+taskbo.getItemId()+"');\">");
							out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+taskbo.getItemId()+"');\">");
							out.print("<input type=\"button\" class=\"button01\" value=\"查看详情\" onclick=\"showLine('"+taskbo.getItemId()+"');\">");
							out.print("</td>");
						}else{
							out.print("<td valign='middle' class='td_middle_left' align='center'>");
							out.print("<input type=\"button\" class=\"button01\" value=\"过程管理\" onclick=\"showProcess('"+taskbo.getItemId()+"');\">");
							out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeTask('"+taskbo.getItemId()+"');\" disabled=\"true\">");
							out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+taskbo.getItemId()+"');\" disabled=\"true\">");
							out.print("<input type=\"button\" class=\"button01\" value=\"查看详情\" onclick=\"showLine('"+taskbo.getItemId()+"');\">");
							out.print("</td>");
						}
						out.print("</tr>");
						}
					}
			%>
		</table>
	</c:verbatim>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("dateList");
</script>