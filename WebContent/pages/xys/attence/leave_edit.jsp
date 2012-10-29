<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
  
  
  <x:saveState value="#{xysLeaveApplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xysLeaveApplyBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 考勤管理 ->请假申请"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             <h:outputText value="申请人"/>
             <h:outputText value="#{xysLeaveApplyBB.personName}"/>
            <h:outputText value="请假类型"/>
            <h:selectOneMenu value="#{xysLeaveApplyBB.leaveBo.leaveType}">
            	<c:selectItems value="#{xysLeaveApplyBB.leaveTypeList}"/>
            </h:selectOneMenu>
            <h:outputText value="开始时间"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="beginTime" value="#{xysLeaveApplyBB.leaveBo.beginTime}"
                             readonly="true" alt="开始日期|0|d|50||"/>
                <c:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </c:verbatim>
            </h:panelGroup>

            <h:outputText value="结束时间"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endTime" value="#{xysLeaveApplyBB.leaveBo.endTime}"
                             readonly="true" alt="结束日期|0|d|50||"/>
                <c:verbatim>
                <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </c:verbatim>
            </h:panelGroup>
            <h:outputText value="请假时间"/>
            <h:inputText value="#{xysLeaveApplyBB.leaveBo.applyDays}"></h:inputText>
           </h:panelGrid>
		   <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="请假原因"/>
             <h:inputTextarea cols="60" rows="5" value="#{xysLeaveApplyBB.leaveBo.reason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{xysLeaveApplyBB.saveLeave}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>