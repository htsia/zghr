<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
    function forCheck(){
        if(document.all("form1:setName").value == ""){
                alert("�������ֲ���Ϊ��!");
                document.all("form1:setName").focus();
                return false;
               }
        else{
            return true ;
            }
        }
</script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{RptSetBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{RptSetBB.editRptSetInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="��������"></h:outputText>
            <h:panelGroup>
                <h:inputText  id="setName"  value="#{RptSetBB.repSetBO.setName}" />
            </h:panelGroup>
            
          <h:outputText value="ʹ�����"/>
	      <h:panelGroup>
            	<h:selectOneRadio id="isUse" value="#{RptSetBB.repSetBO.isUse}">
					<f:selectItem itemLabel="��" itemValue="1" />
					<f:selectItem itemLabel="��" itemValue="0" />
				</h:selectOneRadio>
			</h:panelGroup>

            <h:outputText value="��������"/>
             <h:panelGroup>
                <h:selectOneRadio value="#{RptSetBB.repSetBO.achivesType}" >
                    <f:selectItem itemValue="4" itemLabel="�ܱ�" />
                    <f:selectItem itemValue="0" itemLabel="�±�" />
                    <f:selectItem itemValue="1" itemLabel="����" />
                    <f:selectItem itemValue="2" itemLabel="���걨" />
                    <f:selectItem itemValue="3" itemLabel="�걨" />
                </h:selectOneRadio>
            </h:panelGroup>

	    <h:outputText value="�Ƿ�������"/>
	     <h:panelGroup>
            <h:selectOneRadio value="#{RptSetBB.repSetBO.isFlow}" >
				<f:selectItem itemValue="1" itemLabel="��" />
				<f:selectItem itemValue="0" itemLabel="��" />
			</h:selectOneRadio>
        </h:panelGroup>
        
          <h:outputText value="���ܹ�ϵ"/>
	      <h:panelGroup>
                <h:inputText id="groupName" readonly="true" value="#{RptSetBB.repSetBO.groupName}" styleClass="input" />
                <h:inputHidden id="groupId" value="#{RptSetBB.repSetBO.groupId}"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpItemRptSetControl(document.all('form1:groupId'),document.all('form1:groupName'))"/>
		  </h:panelGroup>
        
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{RptSetBB.saveOrUpdateRptSetBO}"
                             onclick="return forCheck();"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
