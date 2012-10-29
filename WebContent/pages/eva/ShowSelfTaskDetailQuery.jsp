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
            window.showModalDialog("/eva/addSelfTaskDetail.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
            document.all('form1:refresh').click();
			return true;
        }
        function deleteLine(itemId){
            alert(itemId);
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
				<h:commandButton value="过程" styleClass="button01" onclick="return getHistory();"></h:commandButton>
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
						out.print(taskbo.getSelfScore());
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print(taskbo.getPurview()+"%");
						out.print("</td>");
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