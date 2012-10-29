<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
       function auditHeader(id,taskId) {
           window.showModalDialog("/xys/attence/leave_audit_header_edit.jsf?leaveId="+id+"&taskId="+taskId, null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.5+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       function auditDean(id,taskId) {
           window.showModalDialog("/xys/attence/leave_audit_dean_edit.jsf?leaveId="+id+"&taskId="+taskId, null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.5+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       function auditMaster(id,taskId) {
           window.showModalDialog("/xys/attence/leave_audit_master_edit.jsf?leaveId="+id+"&taskId="+taskId, null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.5+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       function auditHr(id,taskId) {
           window.showModalDialog("/xys/attence/leave_audit_hr_edit.jsf?leaveId="+id+"&taskId="+taskId, null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.5+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       function showFlow(id){
    	   window.showModalDialog("/xys/attence/leave_log.jsf?leaveId="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return true;
       }
    </script>

<x:saveState value="#{xysLeaveAuditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xysLeaveAuditBB.initHeader}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
           <td class="td_title"><img src="/images/tips.gif">
                             考勤管理 -></c:verbatim><<h:outputText value="#{xysLeaveAuditBB.opeateName}"></h:outputText><c:verbatim>
           </td>
        </tr>
    </table>
       <br/>
       <table height=100% width=100% align="center">
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xysLeaveAuditBB.leaveList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="申请人"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="请假类型"/></c:facet>
            <h:selectOneMenu value="#{list.leaveType}" disabled="true">
            	<c:selectItems value="#{xysLeaveAuditBB.leaveTypeList}"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="请假时间"/></c:facet>
            <h:outputText value="#{list.applyDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="申请时间"/></c:facet>
            <h:outputText value="#{list.applyTiem}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="原因"/></c:facet>
            <h:outputText value="#{list.reason}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        
       
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="审批" onclick="return auditHeader('#{list.leaveId}','#{list.taskId}');" styleClass="button01" rendered="#{xysLeaveAuditBB.opeateId=='5202'}"></h:commandButton>
            <h:commandButton value="审批" onclick="return auditDean('#{list.leaveId}','#{list.taskId}');" styleClass="button01" rendered="#{xysLeaveAuditBB.opeateId=='5203'}"></h:commandButton>
            <h:commandButton value="审批" onclick="return auditMaster('#{list.leaveId}','#{list.taskId}');" styleClass="button01" rendered="#{xysLeaveAuditBB.opeateId=='5204'}"></h:commandButton>
            <h:commandButton value="审批" onclick="return auditHr('#{list.leaveId}','#{list.taskId}');" styleClass="button01" rendered="#{xysLeaveAuditBB.opeateId=='5209'}"></h:commandButton>
            <h:commandButton value="查看流程" onclick="showFlow('#{list.leaveId}')" styleClass="button01"></h:commandButton>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
