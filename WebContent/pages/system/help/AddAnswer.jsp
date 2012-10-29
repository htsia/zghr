<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{sys_forumEditBB}"/>
	<h:form id="BulletinEditForm">
	<h:inputHidden value="#{sys_forumEditBB.formID}"></h:inputHidden>
    <h:panelGrid columns="1" columnClasses="td_title" width="100%" align="center"  border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif"></h:graphicImage>
			  <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1316","回复管理 ")%> -> 
                  <%=LanguageSupport.getResource("XTGL-1317","回复编辑 ")%>  
             </f:verbatim>
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="99%" align="left">
		<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02">
		     <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1306","回复 ")%> : 
             </f:verbatim>
			<h:inputTextarea value="#{sys_forumEditBB.uabo.ansContent}" cols="73" rows="8"></h:inputTextarea>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:panelGroup>
				<h:commandButton value="保存" styleClass="button01" action="#{sys_forumEditBB.saveAnswer}"></h:commandButton>
				<h:commandButton value="取消" type="button" styleClass="button01" onclick="window.close();"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
	</h:form>


