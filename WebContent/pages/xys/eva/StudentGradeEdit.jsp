<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function chkData(){
             if(!checkValidate(form1.all('form1:score'), '第一学期', 'f','',0)){
                return false;
             }else if(!checkValidate(form1.all('form1:score2'), '第二学期', 'f','',0)){
                 return false;
             }else if(document.all("form1:personCode").value==null||document.all("form1:personCode").value==""){
            	 alert("员工编号不能为空");
            	 return false;
             }else{
                return true;
             }

       }
   </script>
  <x:saveState value="#{regStrudentGradeBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{regStrudentGradeBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="planId" value="#{regStrudentGradeBB.planId}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 绩效管理 ->录入学生评价"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           	  <h:outputText value="员工编号"/>
           	  <h:inputText id="personCode" value="#{regStrudentGradeBB.scoreBo.personCode}" />
              <h:outputText value="第一学期"/>
              <h:inputText id="score" value="#{regStrudentGradeBB.scoreBo.score}" />
               <h:outputText value="第二学期"/>
              <h:inputText id="score2" value="#{regStrudentGradeBB.scoreBo.score2}" />
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{regStrudentGradeBB.saveScore}" onclick="return chkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>