<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function chkData(){
    	   if(!checkValidate(document.all('form1:count'), '������Ŀ/����', 'i')){
               return false;
            }else{
                return true;
            }
       }
   </script>
  <x:saveState value="#{xys_SpreadMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xys_SpreadMgrBB.initItemEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ч���� ->���˼ƻ�����"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="�ȼ�����"/>
               <h:inputText id="gradeName" value="#{xys_SpreadMgrBB.itemBo.gradeName}" />
               <h:outputText value="��������"/>
               <h:selectOneMenu value="#{xys_SpreadMgrBB.itemBo.ctrType}">
               		<c:selectItem itemLabel="��Ŀ" itemValue="1"/>
            		<c:selectItem itemLabel="����" itemValue="2"/>
               </h:selectOneMenu>
               <h:outputText value="������Ŀ/����"/>
               <h:inputText id="count" value="#{xys_SpreadMgrBB.itemBo.ctrCount}" />
               <h:outputText value="�л��ȼ�"/>
               <h:selectOneMenu value="#{xys_SpreadMgrBB.itemBo.chgGradeItem}">
               		<c:selectItems value="#{xys_SpreadMgrBB.gradeList}"/>
               </h:selectOneMenu>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01"  action="#{xys_SpreadMgrBB.saveItem}" onclick="return chkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>