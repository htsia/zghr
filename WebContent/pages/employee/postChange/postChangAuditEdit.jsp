<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function checkData(){
		return forsubmit(document.forms(0));
	}
</script>	
<x:saveState value="#{emppostChangeAuditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emppostChangeAuditBB.initEidt}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{emppostChangeAuditBB.changeId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height="10%">
            <td class="td_title">
     </c:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value="#{emppostChangeAuditBB.opername}"/>
      <c:verbatim>
           </td>
        </tr>
        <tr height=30>
            <td valign="top">
		</c:verbatim>
    	    <h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
    	    	  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2423", "原部门 ")%>
			</f:verbatim>
    	    	<h:panelGroup>
	    	    	<h:inputText styleClass="input" id="oldDept" value="#{emppostChangeAuditBB.postChangBo.oldDept}" dict="yes" dict_num="OU"  code=""
	                            readonly="true"    alt="调入部门|1|s|50||"/>
                </h:panelGroup>
                  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2422", "原岗位 ")%>
			</f:verbatim>
    	    	<h:panelGroup>
    	    		<h:inputText styleClass="input" id="oldPost" value="#{emppostChangeAuditBB.postChangBo.oldPost}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="新岗位|1|s|50||"/>
    	    	</h:panelGroup>
    	    	  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2025", "原职务 ")%>
			</f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="oldJob" value="#{emppostChangeAuditBB.postChangBo.oldJob}" dict="yes" dict_num="#{emppostChangeAuditBB.job}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
    	    	</h:panelGroup>
    	    	  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2421", "新部门 ")%>
			</f:verbatim>
    	    	<h:panelGroup>
	    	    	<h:inputText styleClass="input" id="newDept" value="#{emppostChangeAuditBB.postChangBo.newDept}" dict="yes" dict_num="OU"  code=""
	                            readonly="true"    alt="调入部门|1|s|50||"/>
                </h:panelGroup>
                  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2020", "新岗位 ")%>
			</f:verbatim>
    	    	<h:panelGroup>
    	    		<h:inputText styleClass="input" id="newPost" value="#{emppostChangeAuditBB.postChangBo.newPost}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="新岗位|1|s|50||"/>
    	    	</h:panelGroup>
    	    	  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2026", "新职务 ")%>
			</f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="newJob" value="#{emppostChangeAuditBB.postChangBo.newJob}" dict="yes" dict_num="#{emppostChangeAuditBB.job}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
    	    	</h:panelGroup>
    	    </h:panelGrid>
            <c:verbatim><br></c:verbatim>
            <h:outputText value="#{emppostChangeAuditBB.title1352}" rendered="#{emppostChangeAuditBB.postChangBo.auditResult=='0' ||emppostChangeAuditBB.postChangBo.auditResult=='1'||emppostChangeAuditBB.postChangBo.auditResult=='2'}"></h:outputText>
			<h:panelGrid rendered="#{emppostChangeAuditBB.postChangBo.auditResult=='0' ||emppostChangeAuditBB.postChangBo.auditResult=='1'||emppostChangeAuditBB.postChangBo.auditResult=='2'}" width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
	    	 <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2023", "审批意见 ")%>
			</f:verbatim>
	    	   
	            <h:selectOneMenu id="status" disabled="#{!emppostChangeAuditBB.postChangBo.edit}" value="#{emppostChangeAuditBB.postChangBo.auditResult}">
	                <c:selectItem itemValue="1" itemLabel="同意"/>
	                <c:selectItem itemValue="2" itemLabel="不同意"/>
	            </h:selectOneMenu>
	
	             <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2182", "原因")%>
			</f:verbatim>
	            <h:inputTextarea value="#{emppostChangeAuditBB.postChangBo.auditOption}" readonly="#{!emppostChangeAuditBB.postChangBo.edit}" rows="3" cols="60"/>
	
	             <f:verbatim>
				<%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
			</f:verbatim>
	            <h:commandButton rendered="#{emppostChangeAuditBB.postChangBo.edit}" styleClass="button01" value="审批" action="#{emppostChangeAuditBB.audit}" onclick="checkData()"/>
	    	</h:panelGrid>

            <c:verbatim><br></c:verbatim>
            <h:outputText value="#{emppostChangeAuditBB.title1353}" rendered="#{emppostChangeAuditBB.postChangBo.auditResult1=='0' ||emppostChangeAuditBB.postChangBo.auditResult1=='1'||emppostChangeAuditBB.postChangBo.auditResult1=='2'}"></h:outputText>
            <h:panelGrid rendered="#{emppostChangeAuditBB.postChangBo.auditResult1=='0' ||emppostChangeAuditBB.postChangBo.auditResult1=='1'||emppostChangeAuditBB.postChangBo.auditResult1=='2'}" width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
             <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2023", "审批意见 ")%>
            </f:verbatim>

                <h:selectOneMenu id="status1" disabled="#{!emppostChangeAuditBB.postChangBo.edit1}" value="#{emppostChangeAuditBB.postChangBo.auditResult1}">
                    <c:selectItem itemValue="1" itemLabel="同意"/>
                    <c:selectItem itemValue="2" itemLabel="不同意"/>
                </h:selectOneMenu>

                 <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2182", "原因")%>
            </f:verbatim>
                <h:inputTextarea value="#{emppostChangeAuditBB.postChangBo.auditOption1}" readonly="#{!emppostChangeAuditBB.postChangBo.edit1}" rows="3" cols="60"/>

                 <f:verbatim>
                <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
            </f:verbatim>
                <h:commandButton rendered="#{emppostChangeAuditBB.postChangBo.edit1}" styleClass="button01" value="审批" action="#{emppostChangeAuditBB.audit1}" onclick="checkData()"/>
            </h:panelGrid>

            <c:verbatim><br></c:verbatim>
            <h:outputText value="#{emppostChangeAuditBB.title1354}" rendered="#{emppostChangeAuditBB.postChangBo.auditResult2=='0' ||emppostChangeAuditBB.postChangBo.auditResult2=='1'||emppostChangeAuditBB.postChangBo.auditResult2=='2'}"></h:outputText>
            <h:panelGrid rendered="#{emppostChangeAuditBB.postChangBo.auditResult2=='0' ||emppostChangeAuditBB.postChangBo.auditResult2=='1'||emppostChangeAuditBB.postChangBo.auditResult2=='2'}" width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
             <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2023", "审批意见 ")%>
            </f:verbatim>

                <h:selectOneMenu id="status2" disabled="#{!emppostChangeAuditBB.postChangBo.edit2}" value="#{emppostChangeAuditBB.postChangBo.auditResult2}">
                    <c:selectItem itemValue="1" itemLabel="同意"/>
                    <c:selectItem itemValue="2" itemLabel="不同意"/>
                </h:selectOneMenu>

                 <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2182", "原因")%>
            </f:verbatim>
                <h:inputTextarea value="#{emppostChangeAuditBB.postChangBo.auditOption2}" readonly="#{!emppostChangeAuditBB.postChangBo.edit2}" rows="3" cols="60"/>

                 <f:verbatim>
                <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
            </f:verbatim>
                <h:commandButton rendered="#{emppostChangeAuditBB.postChangBo.edit2}" styleClass="button01" value="审批" action="#{emppostChangeAuditBB.audit2}" onclick="checkData()"/>
            </h:panelGrid>

            <c:verbatim><br></c:verbatim>
            <h:outputText value="#{emppostChangeAuditBB.title1377}" rendered="#{emppostChangeAuditBB.postChangBo.auditResult3=='0' ||emppostChangeAuditBB.postChangBo.auditResult3=='1'||emppostChangeAuditBB.postChangBo.auditResult3=='2'}"></h:outputText>
            <h:panelGrid rendered="#{emppostChangeAuditBB.postChangBo.auditResult3=='0' ||emppostChangeAuditBB.postChangBo.auditResult3=='1'||emppostChangeAuditBB.postChangBo.auditResult3=='2'}" width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
             <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2023", "审批意见 ")%>
            </f:verbatim>

                <h:selectOneMenu id="status3" disabled="#{!emppostChangeAuditBB.postChangBo.edit3}" value="#{emppostChangeAuditBB.postChangBo.auditResult3}">
                    <c:selectItem itemValue="1" itemLabel="同意"/>
                    <c:selectItem itemValue="2" itemLabel="不同意"/>
                </h:selectOneMenu>

                 <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2182", "原因")%>
            </f:verbatim>
                <h:inputTextarea value="#{emppostChangeAuditBB.postChangBo.auditOption3}" readonly="#{!emppostChangeAuditBB.postChangBo.edit3}" rows="3" cols="60"/>

                 <f:verbatim>
                <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
            </f:verbatim>
                <h:commandButton rendered="#{emppostChangeAuditBB.postChangBo.edit3}" styleClass="button01" value="审批" action="#{emppostChangeAuditBB.audit3}" onclick="checkData()"/>
            </h:panelGrid>

            <c:verbatim><br></c:verbatim>
            <h:outputText value="#{emppostChangeAuditBB.title1378}" rendered="#{emppostChangeAuditBB.postChangBo.auditResult4=='0' ||emppostChangeAuditBB.postChangBo.auditResult4=='1'||emppostChangeAuditBB.postChangBo.auditResult4=='2'}"></h:outputText>
            <h:panelGrid rendered="#{emppostChangeAuditBB.postChangBo.auditResult4=='0' ||emppostChangeAuditBB.postChangBo.auditResult4=='1'||emppostChangeAuditBB.postChangBo.auditResult4=='2'}" width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
             <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2023", "审批意见 ")%>
            </f:verbatim>

                <h:selectOneMenu id="status4" disabled="#{!emppostChangeAuditBB.postChangBo.edit4}" value="#{emppostChangeAuditBB.postChangBo.auditResult4}">
                    <c:selectItem itemValue="1" itemLabel="同意"/>
                    <c:selectItem itemValue="2" itemLabel="不同意"/>
                </h:selectOneMenu>

                 <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2182", "原因")%>
            </f:verbatim>
                <h:inputTextarea value="#{emppostChangeAuditBB.postChangBo.auditOption4}" readonly="#{!emppostChangeAuditBB.postChangBo.edit4}" rows="3" cols="60"/>

                 <f:verbatim>
                <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
            </f:verbatim>
                <h:commandButton rendered="#{emppostChangeAuditBB.postChangBo.edit4}" styleClass="button01" value="审批" action="#{emppostChangeAuditBB.audit4}" onclick="checkData()"/>
            </h:panelGrid>

            <c:verbatim><br></c:verbatim>
            <h:outputText value="#{emppostChangeAuditBB.title1379}" rendered="#{emppostChangeAuditBB.postChangBo.auditResult5=='0' ||emppostChangeAuditBB.postChangBo.auditResult5=='1'||emppostChangeAuditBB.postChangBo.auditResult5=='2'}"></h:outputText>
            <h:panelGrid rendered="#{emppostChangeAuditBB.postChangBo.auditResult5=='0' ||emppostChangeAuditBB.postChangBo.auditResult5=='1'||emppostChangeAuditBB.postChangBo.auditResult5=='2'}" width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
             <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2023", "审批意见 ")%>
            </f:verbatim>

                <h:selectOneMenu id="status5" disabled="#{!emppostChangeAuditBB.postChangBo.edit5}" value="#{emppostChangeAuditBB.postChangBo.auditResult5}">
                    <c:selectItem itemValue="1" itemLabel="同意"/>
                    <c:selectItem itemValue="2postChangList" itemLabel="不同意"/>
                </h:selectOneMenu>

                 <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2182", "原因")%>
            </f:verbatim>
                <h:inputTextarea value="#{emppostChangeAuditBB.postChangBo.auditOption5}" readonly="#{!emppostChangeAuditBB.postChangBo.edit5}" rows="3" cols="60"/>

                 <f:verbatim>
                <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
            </f:verbatim>
                <h:commandButton rendered="#{emppostChangeAuditBB.postChangBo.edit5}" styleClass="button01" value="审批" action="#{emppostChangeAuditBB.audit5}" onclick="checkData()"/>
            </h:panelGrid>

    <c:verbatim>
			</td>
        </tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
