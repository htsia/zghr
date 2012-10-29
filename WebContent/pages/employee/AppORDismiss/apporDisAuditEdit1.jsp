<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function checkData(){
		return forsubmit(document.forms(0))
	}
</script>	
<x:saveState value="#{empApporDisAuditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{empApporDisAuditBB.initEidt}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{empApporDisAuditBB.changeId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height="10%">
            <td class="td_title"><img src="/images/tips.gif"> 
              <%=LanguageSupport.getResource( "RYGL-0300", "人员管理")%>->
              <%=LanguageSupport.getResource( "RYGL-2022", "转岗审批")%>
             </td>
        </tr>
        <tr height=30>
            <td valign="top">
		</c:verbatim>
		<h:panelGrid width="100%" columns="1">
			<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
	    	 <f:verbatim>
	    	  <%=LanguageSupport.getResource( "RYGL-2023", "审批意见")%>
	    	 </f:verbatim>
	            <h:selectOneMenu id="status" value="#{empApporDisAuditBB.empapporDisbo.auditResult}">
	                <c:selectItem itemValue="1" itemLabel="同意"/>
	                <c:selectItem itemValue="0" itemLabel="不同意"/>
	            </h:selectOneMenu>
	
	           <f:verbatim>
	    	        <%=LanguageSupport.getResource( "RYGL-2024", "原因")%>
	    	   </f:verbatim>
	            <h:inputTextarea value="#{empApporDisAuditBB.empapporDisbo.auditOption}" rows="3" cols="60"/>
	
	             <f:verbatim>
	    	        <%=LanguageSupport.getResource( "YXGL-1026", "操作")%>
	    	   </f:verbatim>
	            <h:commandButton styleClass="button01" value="审批" action="#{empApporDisAuditBB.audit}" onclick="checkData()"/>
	    	</h:panelGrid>
    	    <h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
    	    	<h:outputText value="原职务"/>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="oldJob" value="#{empApporDisAuditBB.empapporDisbo.oldJob}" dict="yes" dict_num="#{empApporDisAuditBB.job}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
    	    	</h:panelGroup>
    	    	<h:outputText value="新职务"/>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="newJob" value="#{empApporDisAuditBB.empapporDisbo.newJob}" dict="yes" dict_num="#{empApporDisAuditBB.job}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
    	    	</h:panelGroup>
    	    </h:panelGrid>
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
