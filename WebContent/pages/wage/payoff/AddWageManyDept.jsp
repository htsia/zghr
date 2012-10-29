<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

      
      <script type="text/javascript">
          function doSearch(){
              if (document.all("form1:nameStr").value==null || document.all("form1:nameStr").value==""){
                  alert("��¼���ѯ����");
                  return false;
              }
              return true;
          }
          function doSave(){
             if (document.all("form1:personID").value==null || document.all("form1:personID").value==""){
                 alert("��ѡ����Ա��");
                 return false;
             }
              if (document.all("form1:wageDept").value==null || document.all("form1:wageDept").value==""){
                  alert("��ѡ��ڶ����ţ�");
                  return false;
              }
              return true;
          }
      </script>

  <x:saveState value="#{wage_manydepteditBB}" />
  <h:form id="form1">
      <h:inputHidden value="#{wage_manydepteditBB.pageInit}"/>
      <h:inputHidden id="setId" value="#{wage_manydepteditBB.setId}"/>
      <h:inputHidden id="dateId" value="#{wage_manydeptBB.dateId}"></h:inputHidden>
      <h:panelGrid columns="2" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:outputText value="��������:" />
              <h:inputText  id="nameStr" value="#{wage_manydepteditBB.nameStr}" style="width:140px"/>
              <h:commandButton value="��ѯ" styleClass="button01" id="addMany" onclick="return doSearch();" action="#{wage_manydepteditBB.addMany}" />
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="2"  width="98%" align="center">
          <h:panelGroup>
              <h:outputText value="��ѡ��"></h:outputText>
              <h:selectOneMenu id="personID" value="#{wage_manydepteditBB.personID}">
                  <c:selectItems value="#{wage_manydepteditBB.personList}"></c:selectItems>
              </h:selectOneMenu>
              <h:commandButton value="��ʼ¼��" styleClass="button01" action="#{wage_manydepteditBB.changePerson}" />
          </h:panelGroup>

          <h:panelGrid columns="1" align="right">
            <h:commandButton value="����" styleClass="button01" id="save" onclick="return doSave();" action="#{wage_manydepteditBB.save}" />
          </h:panelGrid>
      </h:panelGrid>

      <h:panelGrid columns="2" width="98%" align="center" columnClasses="td_form01,td_form02">
           <h:outputText value="Ա�����"/>
           <h:outputText value="#{wage_manydepteditBB.personCode}"/>

           <h:outputText value="Ա������"/>
           <h:outputText value="#{wage_manydepteditBB.personName}"/>

           <h:outputText value="н�ʲ���1"/>
           <h:outputText value="#{wage_manydepteditBB.wageDept1}"/>

           <h:outputText  value="н�ʲ���2"/>
           <h:panelGroup>
               <h:inputText id="wageDept" value="#{wage_manydepteditBB.wageDept2}" readonly="true"/>
               <c:verbatim>
                 <input type='button' class='button_select' onclick="PopUpWageDeptDlg('form1:wageDept',document.all('form1:SetId').value)"/>
               </c:verbatim>
           </h:panelGroup>

           <h:outputText value="�����Ƿ���ͬ������" />
           <h:selectOneMenu value="#{wage_manydepteditBB.lastMonth}">
               <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
               <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
           </h:selectOneMenu>
      </h:panelGrid>
  </h:form>
