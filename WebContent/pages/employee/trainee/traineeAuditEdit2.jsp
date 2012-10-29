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
		return forsubmit(document.forms(0))
	}
</script>	
<x:saveState value="#{empTraineeAuditMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{empTraineeAuditMgrBB.initEidt}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{empTraineeAuditMgrBB.personId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height="10%">
            <td class="td_title"><img src="/images/tips.gif"> 
              <%=LanguageSupport.getResource("RYGL-2123", "人员调配")%>->
               <%=LanguageSupport.getResource("RYGL-2505", "实习转正审批")%> 
            </td>
        </tr>
        <tr height=30>
            <td valign="top">
		</c:verbatim>
		<h:panelGrid width="100%" columns="1">
			<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
	    	  <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2023", "审批意见")%>       
	    	    </f:verbatim>
	            <h:selectOneMenu id="status" value="#{empTraineeAuditMgrBB.changBo.auditResult1}">
	                <c:selectItem itemValue="1" itemLabel="同意"/>
	                <c:selectItem itemValue="0" itemLabel="不同意"/>
	            </h:selectOneMenu>
	
	              <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2024", "原因")%>       
	    	    </f:verbatim>
	            <h:inputTextarea value="#{empTraineeAuditMgrBB.changBo.auditOption1}" rows="3" cols="60"/>
	
	              <f:verbatim>
	    	     <%=LanguageSupport.getResource("YXGL-1026", "操作")%>       
	    	    </f:verbatim>
	            <h:commandButton styleClass="button01" value="审批" action="#{empTraineeAuditMgrBB.audit1}" onclick="checkData()"/>
	    	</h:panelGrid>
    	    <h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
    	    	   <f:verbatim>
	    	     <%=LanguageSupport.getResource("XTGL-1055", "当前人员类别")%>       
	    	    </f:verbatim>
    	    	<h:panelGroup>
	    	    	 <h:inputText styleClass="input" id="OA001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empTraineeAuditMgrBB.changBo.curType}"
                     alt="员工类别|0|s|50||"/>
                </h:panelGroup>
    	    	<f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2220", "转正后人员类别")%>       
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="NA001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empTraineeAuditMgrBB.changBo.passType}"
                     alt="员工类别|0|s|50||"/>
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
