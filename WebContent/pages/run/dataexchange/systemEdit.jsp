<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
    
     
      <script type="text/javascript">
          
      </script>
 


  <x:saveState value="#{regSystemMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{regSystemMgrBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ���ݽ���ƽ̨ -> ϵͳ�Ǽ�"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="ϵͳ����"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.sysName}"></h:inputText>
			
               <h:outputText value="ϵͳ����"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.sysPass}"></h:inputText>

               <h:outputText value="���ݿ����"></h:outputText>
               <h:selectOneMenu  value="#{regSystemMgrBB.systembo.dbType}">
               		<c:selectItem itemLabel="SQLSERVER2000" itemValue="01"/>
               		<c:selectItem itemLabel="SQLSERVER2005" itemValue="02"/>
               		<c:selectItem itemLabel="ORACLE" itemValue="05"/>
               		<c:selectItem itemLabel="MYSQL" itemValue="10"/>
               </h:selectOneMenu>

               <h:outputText value="���ݿ������"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.dbHost}"></h:inputText>

               <h:outputText value="�˿�"></h:outputText>
               <h:inputText   value="#{regSystemMgrBB.systembo.dbPort}"></h:inputText>
               
               <h:outputText value="���ݿ�����"></h:outputText>
               <h:inputText   value="#{regSystemMgrBB.systembo.dbName}"></h:inputText>
               
               <h:outputText value="���ݿ��û�"></h:outputText>
               <h:inputText   value="#{regSystemMgrBB.systembo.dbUser}"></h:inputText>
               
               <h:outputText value="���ݿ�����"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.dbPass}"></h:inputText>
               
               <h:outputText value="��ƷͶ�ݵ�ַ"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.postAdd}"></h:inputText>
               
                <h:outputText value="��¼�û�"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.loginUser}"></h:inputText>
               
               <h:outputText value="��¼����"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.loginPass}"></h:inputText>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01"  action="#{regSystemMgrBB.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
