<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{sys_forumEditBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{sys_forumEditBB.answerInit}"></h:inputHidden>
	<h:panelGrid>
		  <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1114","回复内容 ")%>:
           </f:verbatim>
		<h:inputTextarea value="#{sys_forumEditBB.uabo.ansContent}" readonly="true" rows="20" cols="70"></h:inputTextarea>
		 <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1329","回复日期 ")%>:
         </f:verbatim>
		<h:outputText value="#{sys_forumEditBB.uabo.ansTime}"></h:outputText>
	</h:panelGrid>
</h:form>