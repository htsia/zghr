<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
    
     
      <script type="text/javascript">
          
      </script>
 


  <x:saveState value="#{regProductMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{regProductMgrBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ���ݽ���ƽ̨ -> ��Ʒ�Ǽ�"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��Ʒ����"></h:outputText>
               <h:inputText  value="#{regProductMgrBB.productebo.proName}"></h:inputText>
               <h:outputText value="��Ʒ����"></h:outputText>
               <h:selectOneMenu  value="#{regProductMgrBB.productebo.proType}" onchange="submit();" valueChangeListener="#{regProductMgrBB.changeType}">
               		<c:selectItem itemValue="1" itemLabel="���ݰ�"/>
               		<c:selectItem itemValue="2" itemLabel="SQL"/>
               		<c:selectItem itemValue="3" itemLabel="��ʱ��ѯ"/>
               </h:selectOneMenu>
               <h:outputText value="SQLģʽԴϵͳ" rendered="#{regProductMgrBB.productebo.proType=='2'}"></h:outputText>
               <h:selectOneMenu  value="#{regProductMgrBB.productebo.sqlSource}" rendered="#{regProductMgrBB.productebo.proType=='2'}">
               		<c:selectItems value="#{regProductMgrBB.systemList}"/>
               </h:selectOneMenu>
               <h:outputText value="֪ͨ��������Ϣ"></h:outputText>
               <h:inputTextarea value="#{regProductMgrBB.productebo.sendMsg}" rows="3" cols="50">
               </h:inputTextarea>
               <h:outputText value="��ȡ���������" rendered="#{regProductMgrBB.productebo.proType=='2'}"></h:outputText>
               <h:inputTextarea value="#{regProductMgrBB.productebo.proSql}" rows="3" cols="50" rendered="#{regProductMgrBB.productebo.proType=='2'}">
               </h:inputTextarea>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01"  action="#{regProductMgrBB.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
