<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<html>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
      <script type="text/javascript">
          function forsave(form){
             document.all("form1:save").click(); 
          }
          function forBack(form){
             window.close();
          }
      </script>

  <x:saveState value="#{emp_ConPostEditBB}" />
  <h:form id="form1">
      <h:inputHidden id="cancelInit" value="#{emp_ConPostEditBB.cancelInit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
                  <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2260","Ա������")%>->
                   <%=LanguageSupport.getResource("RYGL-2287","ȡ����ְ")%>
               </f:verbatim>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="center">
          <h:panelGrid align="right">
              <h:panelGroup>
                  <h:commandButton value="ȡ����ְ1" styleClass="button01" rendered="#{emp_ConPostEditBB.cancelvo.conOrguid1!=\"\"}" action="#{emp_ConPostEditBB.Cancel1}" ></h:commandButton>
                  <h:commandButton value="ȡ����ְ2" styleClass="button01" rendered="#{emp_ConPostEditBB.cancelvo.conOrguid2!=\"\"}" action="#{emp_ConPostEditBB.Cancel2}" ></h:commandButton>
                  <h:commandButton value="����" type="button" onclick="window.close();" styleClass="button01"></h:commandButton>
              </h:panelGroup>
          </h:panelGrid>

           <h:panelGrid columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
               <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1042","Ա�����")%>
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cancelvo.personCode}"></h:outputText>
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2136","Ա������")%>
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cancelvo.personName}"></h:outputText>

               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2284","����λ")%>
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cancelvo.mainOrgName}"></h:outputText>
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2286","������")%>
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cancelvo.mainDeptName}"></h:outputText>

               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2288","��ְ��λ")%>1
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cancelvo.conOrguid1Name}"></h:outputText>
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2285","��ְ����")%>1
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cancelvo.conDeptid1Name}"></h:outputText>

               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2288","��ְ��λ")%>2
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cancelvo.conOrguid2Name}"></h:outputText>
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2285","��ְ����")%>2
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cancelvo.conDeptid2Name}"></h:outputText>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
