<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{xysLeaveApplyBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xysLeaveApplyBB.initLog}"></h:inputHidden>
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
        <iframe id="main" width=100% height=100% src="/pages/xys/workflow/showProcessImg.jsp?processInstanceId=<%=distanceId%>"></iframe>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{xysLeaveApplyBB.logList}" var="list" align="center" id="dateList" rowIndexVar="index"
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
</script>
