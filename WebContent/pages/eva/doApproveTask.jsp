<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
    
     <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
        <script language="javascript" src="/js/commonFuns.js"></script>
        <script language="javascript" src="/js/editor2.js"></script>
        <script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>
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
<c:verbatim><base target='_self'></c:verbatim>
<x:saveState value="#{evaLeadtaskEstimateBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{evaLeadtaskEstimateBB.initApprove}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="绩效管理 -> 任务考核报批"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
    	<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
    		<h:outputText value="审批"/>
    		<h:selectOneMenu id="status" value="#{evaLeadtaskEstimateBB.auditResult}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="0" itemLabel="不同意"/>
            </h:selectOneMenu>
    		<h:outputText value="审批内容"/>
            <h:inputTextarea value="#{evaLeadtaskEstimateBB.content}" rows="5" cols="80"/>
    	</h:panelGrid>
   	</h:panelGrid>
   	 <c:verbatim>
 <table width="100%"><tr><td align="right">
 </c:verbatim>   	
    		<h:commandButton styleClass="button01" value="审批" action="#{evaLeadtaskEstimateBB.doApproval}"
                             onclick="return forCheck();"/>
<c:verbatim>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table>
</c:verbatim>
</h:form>
