<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@page import="com.hr319wg.common.web.SysContext" %>
<%@page import="com.hr319wg.xys.workflow.service.ActivitiToolsService" %> 
<%@page import="java.util.*" %> 
<%@page import="org.activiti.engine.impl.pvm.process.ActivityImpl" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{attLeaveApplyBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{attLeaveApplyBB.initLog}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
           <td class="td_title"><img src="/images/tips.gif">
                             考勤管理 ->查看审批流程
           </td>          
        </tr>
        </table>
        <table height=100% width=100% align="center">
       <tr><td height="60%">
       <%
       	   String distanceId=(String)session.getAttribute("distanceId");
       %>
        <iframe id="main" frameborder="0" width=100% height=100% scrolling="no" src="/pages/xys/workflow/showProcessImg.jsp?processInstanceId=<%=distanceId%>"></iframe>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	<h:outputText value="当前审批人列表"/>
    <x:dataTable value="#{attLeaveApplyBB.currApproverList}" var="list1" align="center" id="currApproveList" rowIndexVar="index1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index1+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list1.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
            <h:outputText value="#{list1.personSeq}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="二级部门"/></c:facet>
            <h:outputText value="#{list1.secondDeptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
            <h:outputText value="#{list1.deptName}"/>
        </h:column>
    </x:dataTable>
    <c:verbatim><br/></c:verbatim>
    <h:outputText value="审批记录列表"/>
    <x:dataTable value="#{attLeaveApplyBB.logList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="审批人"/></c:facet>
            <h:outputText value="#{list.personId}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="审批时间"/></c:facet>
            <h:outputText value="#{list.auditTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="审批结果"/></c:facet>
            <h:selectOneMenu value="#{list.auditResult}" disabled="true">
            	<c:selectItem itemLabel="通过" itemValue="1"/>
		     	<c:selectItem itemLabel="退回" itemValue="0"/>
            </h:selectOneMenu>
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="审批意见"/></c:facet>
            <h:outputText value="#{list.auditxplan}"/>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
   setDataTableOver("form1:currApproveList");
</script>
