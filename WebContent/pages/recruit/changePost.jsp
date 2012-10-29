<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
 
   <x:saveState value="#{recu_resumeInfoBB}" />
  <h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{recu_resumeInfoBB.initChangePost}"></h:inputHidden>
       <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 简历浏览-> 调整岗位" rendered="#{recu_resumeInfoBB.postMode=='0'}"/>
              <h:outputText value=" 简历浏览-> 调整岗位类型" rendered="#{recu_resumeInfoBB.postMode=='1'}"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="姓名"></h:outputText>
               <h:inputText id="materiallName" value="#{recu_resumeInfoBB.detailbo.personName}"></h:inputText>
				
               <h:outputText value="岗位" rendered="#{recu_resumeInfoBB.postMode=='0'}"></h:outputText>
               <h:outputText value="岗位类型" rendered="#{recu_resumeInfoBB.postMode=='1'}"></h:outputText>
               <h:selectOneMenu value="#{recu_resumeInfoBB.detailbo.itemId}">
					<c:selectItems value="#{recu_resumeInfoBB.itemList}" />
				</h:selectOneMenu>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" action="#{recu_resumeInfoBB.changePost}" styleClass="button01"/>
           </h:panelGrid>
           
           </h:panelGrid>
  </h:form>

