<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
     function doCheck(){
         if (document.all("form1:text5code").value==''){
             alert("��ѡ���ų�����");
             return false;
         }

         if (document.all("form1:typeID").value==''){
             alert("������ģ��");
             return false;
         }
         return true;
     }
</script>
<x:saveState value="#{sys_workexcludeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{sys_workexcludeBB.pageInit}"></h:inputHidden>
    <h:panelGrid align="center" width="98%">
      <h:panelGrid columns="2" align="right" cellspacing="2">
          <h:commandButton styleClass="button01" value="����" action="#{sys_workexcludeBB.save}"
                           onclick="return doCheck();"/>
          <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
      </h:panelGrid>

      <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
          <h:outputText value="����"/>
          <h:selectOneMenu id="typeID" value="#{sys_workexcludeBB.wb.typeID}">
              <c:selectItems value="#{sys_workexcludeBB.typeList}"></c:selectItems>
          </h:selectOneMenu>

          <h:outputText value="�ų���λ"></h:outputText>
          <h:panelGroup>
              <h:inputTextarea id="text5"
                            value="#{sys_workexcludeBB.wb.orgname}" cols="40" rows="8"
                            readonly="true" />
              <h:inputHidden id="text5code"	value="#{sys_workexcludeBB.wb.orguid}" />
              <h:commandButton
                            type="button" styleClass="button_select"
                            onclick="PopUpMutilOnlyOrgTwoControl('form1:text5code','form1:text5','1','')" />
          </h:panelGroup>
      </h:panelGrid>
    </h:panelGrid>
</h:form>
