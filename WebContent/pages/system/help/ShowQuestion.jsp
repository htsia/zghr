<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
</script>
<x:saveState value="#{sys_forumEditBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{sys_forumEditBB.showInit}"></h:inputHidden>
	<h:panelGrid align="center" width="99%">
	     <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1319","问题")%>:
         </f:verbatim>
		 <h:inputTextarea readonly="true" value="#{sys_forumEditBB.uqbo.subject}" rows="20" cols="70"></h:inputTextarea>
	     <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1120","发布时间")%>:
         </f:verbatim>
		 <h:outputText value="#{sys_forumEditBB.uqbo.submitTime}"></h:outputText>
	</h:panelGrid>
</h:form>