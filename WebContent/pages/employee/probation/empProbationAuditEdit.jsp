<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
	
<x:saveState value="#{empprobastionaduitEditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{empprobastionaduitEditBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{empprobastionaduitEditBB.personId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height="10%">
            <td class="td_title"><img src="/images/tips.gif"> 
              <%=LanguageSupport.getResource("RYGL-0300", "人员管理")%>->
              <%=LanguageSupport.getResource("RYGL-2133", "转正审批")%>
              </td>
        </tr>
        <tr height=30>
            <td valign="top">
		</c:verbatim>
    <h:outputText value="#{empprobastionaduitEditBB.title0347}" rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult=='0' || empprobastionaduitEditBB.empprobationbo.auditResult=='1' || empprobastionaduitEditBB.empprobationbo.auditResult=='2'}"></h:outputText>
	<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03"
                   rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult=='0' || empprobastionaduitEditBB.empprobationbo.auditResult=='1' || empprobastionaduitEditBB.empprobationbo.auditResult=='2'}">
          <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2023", "审批意见")%>
    	 </f:verbatim>
            <h:selectOneMenu id="status" disabled="#{!empprobastionaduitEditBB.empprobationbo.edit}" value="#{empprobastionaduitEditBB.empprobationbo.auditResult}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="2" itemLabel="不同意"/>
            </h:selectOneMenu>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2024", "原因")%>
    	 </f:verbatim>
            <h:inputTextarea readonly="#{!empprobastionaduitEditBB.empprobationbo.edit}" value="#{empprobastionaduitEditBB.empprobationbo.auditOption}" rows="3" cols="60"/>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
    	 </f:verbatim>
            <h:commandButton rendered="#{empprobastionaduitEditBB.empprobationbo.edit}" styleClass="button01" value="审批" action="#{empprobastionaduitEditBB.audit1}"/>
    	</h:panelGrid>

           <h:outputText rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult2=='0' || empprobastionaduitEditBB.empprobationbo.auditResult2=='1' || empprobastionaduitEditBB.empprobationbo.auditResult2=='2'}" value="#{empprobastionaduitEditBB.title0348}"></h:outputText>
    <h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03"
                       rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult2=='0' || empprobastionaduitEditBB.empprobationbo.auditResult2=='1' || empprobastionaduitEditBB.empprobationbo.auditResult2=='2'}">


              <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2023", "审批意见")%>
           </f:verbatim>
                <h:selectOneMenu id="status2" disabled="#{!empprobastionaduitEditBB.empprobationbo.edit2}" value="#{empprobastionaduitEditBB.empprobationbo.auditResult2}">
                    <c:selectItem itemValue="1" itemLabel="同意"/>
                    <c:selectItem itemValue="2" itemLabel="不同意"/>
                </h:selectOneMenu>

                 <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2024", "原因")%>
           </f:verbatim>
                <h:inputTextarea readonly="#{!empprobastionaduitEditBB.empprobationbo.edit2}" value="#{empprobastionaduitEditBB.empprobationbo.auditOption2}" rows="3" cols="60"/>

                 <f:verbatim>
            <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
           </f:verbatim>
                <h:commandButton rendered="#{empprobastionaduitEditBB.empprobationbo.edit2}" styleClass="button01" value="审批" action="#{empprobastionaduitEditBB.audit2}"/>
          </h:panelGrid>

    	 <h:outputText value="#{empprobastionaduitEditBB.title0349}" rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult3=='0' || empprobastionaduitEditBB.empprobationbo.auditResult3=='1' || empprobastionaduitEditBB.empprobationbo.auditResult3=='2'}"></h:outputText>
    <h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03"
                   rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult3=='0' || empprobastionaduitEditBB.empprobationbo.auditResult3=='1' || empprobastionaduitEditBB.empprobationbo.auditResult3=='2'}">


          <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2023", "审批意见")%>
    	 </f:verbatim>
            <h:selectOneMenu id="status3" disabled="#{!empprobastionaduitEditBB.empprobationbo.edit3}" value="#{empprobastionaduitEditBB.empprobationbo.auditResult3}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="2" itemLabel="不同意"/>
            </h:selectOneMenu>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2024", "原因")%>
    	 </f:verbatim>
            <h:inputTextarea readonly="#{!empprobastionaduitEditBB.empprobationbo.edit3}" value="#{empprobastionaduitEditBB.empprobationbo.auditOption3}" rows="3" cols="60"/>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
    	 </f:verbatim>
            <h:commandButton rendered="#{empprobastionaduitEditBB.empprobationbo.edit3}" styleClass="button01" value="审批" action="#{empprobastionaduitEditBB.audit3}"/>
    	</h:panelGrid>

    <h:outputText rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult4=='0' || empprobastionaduitEditBB.empprobationbo.auditResult4=='1' || empprobastionaduitEditBB.empprobationbo.auditResult4=='2'}" value="#{empprobastionaduitEditBB.title0352}"></h:outputText>
    <h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03"
                   rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult4=='0' || empprobastionaduitEditBB.empprobationbo.auditResult4=='1' || empprobastionaduitEditBB.empprobationbo.auditResult4=='2'}">
          <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2023", "审批意见")%>
    	 </f:verbatim>
            <h:selectOneMenu id="status4" disabled="#{!empprobastionaduitEditBB.empprobationbo.edit4}" value="#{empprobastionaduitEditBB.empprobationbo.auditResult4}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="2" itemLabel="不同意"/>
            </h:selectOneMenu>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2024", "原因")%>
    	 </f:verbatim>
            <h:inputTextarea readonly="#{!empprobastionaduitEditBB.empprobationbo.edit4}" value="#{empprobastionaduitEditBB.empprobationbo.auditOption4}" rows="3" cols="60"/>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
    	 </f:verbatim>
            <h:commandButton rendered="#{empprobastionaduitEditBB.empprobationbo.edit4}" styleClass="button01" value="审批" action="#{empprobastionaduitEditBB.audit4}"/>
    	</h:panelGrid>

    	 <h:outputText value="#{empprobastionaduitEditBB.title0353}" rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult5=='0' || empprobastionaduitEditBB.empprobationbo.auditResult5=='1' || empprobastionaduitEditBB.empprobationbo.auditResult5=='2'}"></h:outputText>
    <h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03"
                   rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult5=='0' || empprobastionaduitEditBB.empprobationbo.auditResult5=='1' || empprobastionaduitEditBB.empprobationbo.auditResult5=='2'}">


          <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2023", "审批意见")%>
    	 </f:verbatim>
            <h:selectOneMenu id="status5" disabled="#{!empprobastionaduitEditBB.empprobationbo.edit5}" value="#{empprobastionaduitEditBB.empprobationbo.auditResult5}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="2" itemLabel="不同意"/>
            </h:selectOneMenu>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2024", "原因")%>
    	 </f:verbatim>
            <h:inputTextarea readonly="#{!empprobastionaduitEditBB.empprobationbo.edit5}" value="#{empprobastionaduitEditBB.empprobationbo.auditOption5}" rows="3" cols="60"/>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
    	 </f:verbatim>
            <h:commandButton rendered="#{empprobastionaduitEditBB.empprobationbo.edit5}" styleClass="button01" value="审批" action="#{empprobastionaduitEditBB.audit5}"/>
    	</h:panelGrid>
    <h:outputText value="#{empprobastionaduitEditBB.title0354}" rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult6=='0' || empprobastionaduitEditBB.empprobationbo.auditResult6=='1' || empprobastionaduitEditBB.empprobationbo.auditResult6=='2'}"></h:outputText>
    <h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03"
                   rendered="#{empprobastionaduitEditBB.empprobationbo.auditResult6=='0' || empprobastionaduitEditBB.empprobationbo.auditResult6=='1' || empprobastionaduitEditBB.empprobationbo.auditResult6=='2'}">
          <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2023", "审批意见")%>
    	 </f:verbatim>
            <h:selectOneMenu id="status6" disabled="#{!empprobastionaduitEditBB.empprobationbo.edit6}" value="#{empprobastionaduitEditBB.empprobationbo.auditResult6}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="2" itemLabel="不同意"/>
            </h:selectOneMenu>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("RYGL-2024", "原因")%>
    	 </f:verbatim>
            <h:inputTextarea readonly="#{!empprobastionaduitEditBB.empprobationbo.edit6}" value="#{empprobastionaduitEditBB.empprobationbo.auditOption6}" rows="3" cols="60"/>

             <f:verbatim>
    	  <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
    	 </f:verbatim>
            <h:commandButton rendered="#{empprobastionaduitEditBB.empprobationbo.edit6}" styleClass="button01" value="审批" action="#{empprobastionaduitEditBB.audit6}"/>
    	</h:panelGrid>

    <c:verbatim>
			</td>
        </tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
</script>
