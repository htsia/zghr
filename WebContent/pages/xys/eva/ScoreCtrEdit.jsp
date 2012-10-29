<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function chkData(){
    	   if(!checkValidate(document.all('form1:count'), '控制人数', 'i')){
               return false;
            }else{
                return true;
            }
       }
   </script>
  <x:saveState value="#{xys_scoreCtrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xys_scoreCtrBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 绩效管理 ->考核计划管理"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="等级名称"/>
               <h:inputText id="gradeName" value="#{xys_scoreCtrBB.ctrBo.gradeName}" />
               <h:outputText value="控制比例"/>
               <h:inputText id="count" value="#{xys_scoreCtrBB.ctrBo.count}" />
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{xys_scoreCtrBB.saveCtr}" onclick="return chkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>