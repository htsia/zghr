<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
          function checkForm(){
              if(!checkValidate(document.all('form1:tatalScore'), '总分', 'i','',0)){
                  return false;
              }else if(document.all('form1:tempName').value==""){
                  alert("模版名称不能为空");
                  return false;
              }else{
                  return true;
              }

          }
   </script>
  <x:saveState value="#{xys_360TempBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xys_360TempBB.initTemp}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 绩效管理 ->360模版设置"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="模版名称"></h:outputText>
               <h:inputText id="tempName" value="#{xys_360TempBB.tempBo.tempName}"/>

               <h:outputText value="总分"></h:outputText>
               <h:inputText id="tatalScore" value="#{xys_360TempBB.tempBo.tatalScore}"></h:inputText>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{xys_360TempBB.saveTemp}" onclick="return checkForm();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>