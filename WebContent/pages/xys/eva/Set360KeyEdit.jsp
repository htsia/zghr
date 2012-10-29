<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">

   </script>
  <x:saveState value="#{xys_360KeyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xys_360KeyBB.initKey}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 绩效管理 ->KPI指标设置"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="指标名称"></h:outputText>
               <h:inputText value="#{xys_360KeyBB.keyBo.keyName}"/>
               <h:outputText value="指标类型"></h:outputText>
               <h:selectOneMenu value="#{xys_360KeyBB.keyBo.keyType}">
                   <c:selectItem itemLabel="能力" itemValue="1"/>
                   <c:selectItem itemLabel="态度" itemValue="2"/>
               </h:selectOneMenu>
               <h:outputText value="指标说明"></h:outputText>
               <h:inputTextarea value="#{xys_360KeyBB.keyBo.keyDesc}" rows="10" cols="80"></h:inputTextarea>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{xys_360KeyBB.saveKey}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>