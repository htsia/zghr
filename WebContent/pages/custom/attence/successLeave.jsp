<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{attRestApplyBB}" />
<x:saveState value="#{attOutApplyBB}" />
<x:saveState value="#{attOvertimeApplyBB}" />
<x:saveState value="#{attLeaveApplyBB}" />
<h:form id="form1">
<h:inputHidden id="rest" value="#{attRestApplyBB.toRest}"/>
<h:inputHidden id="out" value="#{attOutApplyBB.toOut}"/>
<h:inputHidden id="overtime" value="#{attOvertimeApplyBB.toOvertime}"/>
<h:inputHidden id="leave" value="#{attLeaveApplyBB.toLeave}"/>
</h:form>
  
<script type="text/javascript">
    if(document.all("form1:out").value==1){
    	window.location.href="/custom/attence/attOutQuery.jsf?inself=1";
    }else if(document.all("form1:leave").value==1){
    	window.location.href="/custom/attence/attLeaveQuery.jsf?inself=1";
    }else if(document.all("form1:rest").value==1){
    	window.location.href="/custom/attence/attRestQuery.jsf?inself=1";
    }else if(document.all("form1:overtime").value==1){
    	window.location.href="/custom/attence/attOvertimeQuery.jsf?inself=1";
    }else{
    	alert("Ò³Ãæ²»¶Ô");
    }	
    
</script>
