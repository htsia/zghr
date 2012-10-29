<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{self_QuestionEditBB}"/>
	<h:form id="BulletinEditForm">
       <h:inputHidden value="#{self_QuestionEditBB.pageInit}"></h:inputHidden>
       <h:inputHidden value="#{self_QuestionEditBB.fomID}"></h:inputHidden>
       <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                 <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1306","回复")%> 
                 </f:verbatim>
           </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>

        <h:panelGrid border="1" columns="2" align="center" cellspacing="2"    cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
             <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1307","署名方式")%> 
             </f:verbatim>
            <h:selectOneMenu value="#{self_QuestionEditBB.nameStyle}">
                <c:selectItem itemValue="0" itemLabel="登陆名"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="真实姓名"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="匿名"></c:selectItem>
            </h:selectOneMenu>

            <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1105","标题")%> 
             </f:verbatim>
			<h:inputText id="text1" styleClass="input" value="#{self_QuestionEditBB.fqbo.subject}" size="80" maxlength="50"/>

		   <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1111","内容")%> 
            </f:verbatim>
			<h:inputTextarea id="textarea" rows="15" cols="80"	value="#{self_QuestionEditBB.fqbo.content}"/>
		</h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>

        <h:panelGrid border="0" columns="2" cellpadding="8" align="right">
			<h:commandButton value="保存" action="#{self_QuestionEditBB.saveNewAnswer}" styleClass="button01" />
			<h:commandButton value="返回" type="button" onclick="window.close();" styleClass="button01" />
		</h:panelGrid>
	</h:form>


