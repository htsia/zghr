<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>

<x:saveState value="#{studentAudit_ListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{studentAudit_ListBB.initAudit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 培训管理 -> 培训班审批"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

  <h:panelGrid align="center" width="98%" columns="1">
  		<h:panelGrid columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
       				<h:outputText value="姓名" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.personName}" readonly="true"/>
					<h:outputText value="性别" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.personSex}" readonly="true"/>
					<h:outputText value="所报班级" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.className}" readonly="true"/>
					<h:outputText value="报名时间" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.signTime}" readonly="true"/>
					<h:outputText value="所属部门" />
					<h:inputText value="#{studentAudit_ListBB.studentbo.personDept}" readonly="true"/>
					<h:outputText value="审批意见"/>
		            <h:selectOneMenu id="status" value="#{studentAudit_ListBB.studentbo.status}">
		                <c:selectItem itemValue="1" itemLabel="审批通过"/>
		                <c:selectItem itemValue="2" itemLabel="审批不通过"/>
		            </h:selectOneMenu>
		            <h:outputText value="操作"/>
		            <h:commandButton styleClass="button01" value="审批" action="#{studentAudit_ListBB.audit}"
		                             onclick="return forCheck();" />
         </h:panelGrid>
        
		</h:panelGrid>
</h:form>
