<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <script type="text/javascript">
    	function chkData(){
             if (document.all('form1:setId').value==""||document.all('form1:FieldId').value==""||document.all('form1:tagEnd').value==""||document.all('form1:tagBegin').value==""){
                alert("�ֶβ���Ϊ��!");
                return false;
             }
         }
       
      </script>
  
  <x:saveState value="#{resumeImportTemBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{resumeImportTemBB.inintItem}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ƹ���� -> ����ģ�涨��"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��Ӧ����"></h:outputText>
               <h:selectOneMenu id="setId" value="#{resumeImportTemBB.tempItembo.setId}" onchange="submit();" valueChangeListener="#{resumeImportTemBB.changeSet}">
               		<c:selectItems value="#{resumeImportTemBB.setIdList}"/>
               </h:selectOneMenu>
               <h:outputText value="��Ӧ�ֶ�"></h:outputText>
               <h:selectOneMenu id="fieldId" value="#{resumeImportTemBB.tempItembo.fieldId}">
               		<c:selectItems value="#{resumeImportTemBB.setItemList}"/>
               </h:selectOneMenu>
               <h:outputText value="������ʼ"></h:outputText>
               <h:inputText  id="tagBegin" value="#{resumeImportTemBB.tempItembo.tagBegin}"></h:inputText>
               <h:outputText value="��������"></h:outputText>
               <h:inputText  id="tagEnd" value="#{resumeImportTemBB.tempItembo.tagEnd}"></h:inputText>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" styleClass="button01"  action="#{resumeImportTemBB.saveItem}" onclick="return chkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
