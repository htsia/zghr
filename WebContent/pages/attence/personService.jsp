<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<x:saveState value="#{person_serviceBB}" />
<h:inputHidden value="#{person_serviceBB.pageInit}" />
<f:verbatim>
	<br>
	<table width="98%" align="center">
		<tr align="center">
			<td></f:verbatim> <h:outputText value="姓名：[#{person_serviceBB.personName}]"></h:outputText>
			<f:verbatim></td>
			<td></f:verbatim> <h:outputText value="所在班组：[#{person_serviceBB.groupName}]"></h:outputText>
			<f:verbatim></td>
		</tr>
	</table>
</f:verbatim>


<center>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center" valign="top">
		<%
			String flag = (String) session.getAttribute("flag");
			String groupno = (String) session.getAttribute("groupno");
			String userid = (String) session.getAttribute("userid");
			if ("100".equals(flag)) {
		%> <jsp:include page="showCalenda.jsp">
			<jsp:param name="personID" value="<%=userid %>" />
		</jsp:include> <%
 	} else {
 %> <jsp:include page="showCalenda.jsp">
			<jsp:param name="personID" value="<%=userid %>" />
		</jsp:include> <%
 	}
 %>
		</td>
	</tr>
</table>
</center>
