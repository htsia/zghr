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
        function doAddScore() {
           var masterId =document.all("form1:masterId").value ;
           window.showModalDialog("/eva/addSelfTaskDetail.jsf?masterId="+masterId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
		   return true;
        }
        function doChangeTask(itemId) {
            window.showModalDialog("/eva/modSelfTaskDetail.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
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
        function doApproval(id,arr) {
            var masterId =document.all("form1:masterId").value ;
            window.showModalDialog("/eva/doApproveTask.jsf?masterId="+masterId, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
   		   return true;
         }
        function getHistory() {
            var masterId =document.all("form1:masterId").value ;
           	window.showModalDialog("/eva/taskEstimateLog.jsf?masterId="+masterId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
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
    </script>
<x:saveState value="#{evaLeadtaskEstimateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{evaLeadtaskEstimateBB.initEdit}"/>
    <h:inputHidden id="masterId" value="#{evaLeadtaskEstimateBB.masterId}"/>
    <h:inputHidden id="itemId" value=""/>
    <h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{evaLeadtaskEstimateBB.queryEstimateList}"></h:commandButton>
    <h:commandButton id="deletebutton" value="删除" style="display:none;"  action="#{evaLeadtaskEstimateBB.deleteContent}"></h:commandButton>
    
    <h:panelGrid columns="1" align="center" width="98%">
    <h:panelGroup>
				<h:panelGrid align="left">
					<h:outputText value="当前状态:#{evaLeadtaskEstimateBB.master.statusDes}"/>
				</h:panelGrid>
				<h:panelGrid align="right">
				<h:panelGroup>
					<h:commandButton value="增加" styleClass="button01" onclick="return doAddScore();" rendered="#{evaLeadtaskEstimateBB.master.status!='2' && evaLeadtaskEstimateBB.master.status!='3'}"></h:commandButton>
					<h:outputText value=" " rendered="#{evaLeadtaskEstimateBB.master.status!='2' && evaLeadtaskEstimateBB.master.status!='3'}"></h:outputText>
					<h:commandButton value="审批" styleClass="button01"  onclick="return doApproval();" rendered="#{evaLeadtaskEstimateBB.master.status=='1'}"></h:commandButton>
					<h:outputText value=" " rendered="#{evaLeadtaskEstimateBB.master.status=='1'}"></h:outputText>
					<h:commandButton value="同意修改" styleClass="button01"  action="#{evaLeadtaskEstimateBB.modOk}" rendered="#{evaLeadtaskEstimateBB.master.status=='3'}"></h:commandButton>
					<h:outputText value=" " rendered="#{evaLeadtaskEstimateBB.master.status=='3'}"></h:outputText>
					<h:commandButton value="不同意修改" styleClass="button01"  action="#{evaLeadtaskEstimateBB.modNo}" rendered="#{evaLeadtaskEstimateBB.master.status=='3'}"></h:commandButton>
					<h:outputText value=" " rendered="#{evaLeadtaskEstimateBB.master.status=='3'}"></h:outputText>
					<h:commandButton styleClass="button01" value="打分" onclick="return saveScore();" action="#{evaLeadtaskEstimateBB.saveScore}" rendered="#{evaLeadtaskEstimateBB.master.status=='2'}"></h:commandButton>
					<h:inputHidden id="saveStr" value="#{eva_showSelfJobDetailBB.saveStr}"></h:inputHidden>
					<h:outputText value=" " rendered="#{evaLeadtaskEstimateBB.master.status=='2'}"></h:outputText>
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
				<td class='locked_top' valign='middle' align='center'>完成情况</td>
				<td class='locked_top' valign='middle' align='center'>自评分</td>
				<td class='locked_top' valign='middle' align='center'>权重</td>
				<td class='locked_top' valign='middle' align='center'>打分</td>
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
						out.print(CommonFuns.filterNull(taskbo.getProcess()));
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(CommonFuns.filterNull(taskbo.getSelfScore()));
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(taskbo.getPurview()+"%");
						out.print("</td>");
						String status=(String)session.getAttribute("status");
						if(!"2".equals(status)){
							out.print("<td valign='middle' class='td_middle_left' align='center'>");
							out.print("</td>");
						}else{
							out.print("<td valign='middle' class='td_middle_left' align='center'>");
							out.print("<input id = '"+taskbo.getItemId()+"' class='input' type='text' value='"+CommonFuns.filterNull(taskbo.getScore())+"'/>");
							out.print("</td>");
						}
						
						if(!"2".equals(status) && !"3".equals(status)){
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