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
              <h:outputText value=" 数据交换平台 -> 系统登记"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="系统名称"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.sysName}"></h:inputText>
			
               <h:outputText value="系统密码"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.sysPass}"></h:inputText>

               <h:outputText value="数据库类别"></h:outputText>
               <h:selectOneMenu  value="#{regSystemMgrBB.systembo.dbType}">
               		<c:selectItem itemLabel="SQLSERVER2000" itemValue="01"/>
               		<c:selectItem itemLabel="SQLSERVER2005" itemValue="02"/>
               		<c:selectItem itemLabel="ORACLE" itemValue="05"/>
               		<c:selectItem itemLabel="MYSQL" itemValue="10"/>
               </h:selectOneMenu>

               <h:outputText value="数据库服务器"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.dbHost}"></h:inputText>

               <h:outputText value="端口"></h:outputText>
               <h:inputText   value="#{regSystemMgrBB.systembo.dbPort}"></h:inputText>
               
               <h:outputText value="数据库名称"></h:outputText>
               <h:inputText   value="#{regSystemMgrBB.systembo.dbName}"></h:inputText>
               
               <h:outputText value="数据库用户"></h:outputText>
               <h:inputText   value="#{regSystemMgrBB.systembo.dbUser}"></h:inputText>
               
               <h:outputText value="数据库密码"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.dbPass}"></h:inputText>
               
               <h:outputText value="产品投递地址"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.postAdd}"></h:inputText>
               
                <h:outputText value="登录用户"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.loginUser}"></h:inputText>
               
               <h:outputText value="登录密码"></h:outputText>
               <h:inputText  value="#{regSystemMgrBB.systembo.loginPass}"></h:inputText>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{regSystemMgrBB.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
