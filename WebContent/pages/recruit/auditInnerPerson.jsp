<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{innerRecuResultBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{innerRecuResultBB.initDeail}"></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td colspan=2 height=8>
        </td></tr>

        <tr><td height=8 align="left">
    </c:verbatim>
            <h:outputText value="应聘人员:#{innerRecuResultBB.personName}"></h:outputText>
            <h:outputText value="   "></h:outputText>
    <c:verbatim>
        </td>
        <td height=8 align="right">
    </c:verbatim>
      	<h:commandButton value="同意" styleClass="button01"  action="#{innerRecuResultBB.tongyi}"></h:commandButton>
      	<h:outputText value=" "></h:outputText>
        <h:commandButton value="不同意" styleClass="button01"  action="#{innerRecuResultBB.butongyi}"></h:commandButton>
    <c:verbatim>
        </td></tr>
<%
	String personId=(String)session.getAttribute("personId");
%>
        <tr><td colspan=2 height=100%>
            <iframe id="main" width=100% height=100% src="<%=Constants.LEAD_SHOW_PERSONURL%>?fk=<%=personId%>"></iframe>
           
        </td></tr>
        
        </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>
