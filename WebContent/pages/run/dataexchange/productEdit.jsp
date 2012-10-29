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
              <h:outputText value=" 数据交换平台 -> 产品登记"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="产品名称"></h:outputText>
               <h:inputText  value="#{regProductMgrBB.productebo.proName}"></h:inputText>
               <h:outputText value="产品类型"></h:outputText>
               <h:selectOneMenu  value="#{regProductMgrBB.productebo.proType}" onchange="submit();" valueChangeListener="#{regProductMgrBB.changeType}">
               		<c:selectItem itemValue="1" itemLabel="数据包"/>
               		<c:selectItem itemValue="2" itemLabel="SQL"/>
               		<c:selectItem itemValue="3" itemLabel="定时查询"/>
               </h:selectOneMenu>
               <h:outputText value="SQL模式源系统" rendered="#{regProductMgrBB.productebo.proType=='2'}"></h:outputText>
               <h:selectOneMenu  value="#{regProductMgrBB.productebo.sqlSource}" rendered="#{regProductMgrBB.productebo.proType=='2'}">
               		<c:selectItems value="#{regProductMgrBB.systemList}"/>
               </h:selectOneMenu>
               <h:outputText value="通知消费者信息"></h:outputText>
               <h:inputTextarea value="#{regProductMgrBB.productebo.sendMsg}" rows="3" cols="50">
               </h:inputTextarea>
               <h:outputText value="提取表数据语句" rendered="#{regProductMgrBB.productebo.proType=='2'}"></h:outputText>
               <h:inputTextarea value="#{regProductMgrBB.productebo.proSql}" rows="3" cols="50" rendered="#{regProductMgrBB.productebo.proType=='2'}">
               </h:inputTextarea>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{regProductMgrBB.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
