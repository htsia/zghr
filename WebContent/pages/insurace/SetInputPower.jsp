<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title>������Ŀ</title>
    <script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/insurace/InsInputPowerEdit.jsf?personID="+document.all("form1:personID").value+"&setID="+document.all("form1:setId").value, null, "dialogWidth:330px; dialogHeight:260px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>
</head>

<body>
<x:saveState value="#{ins_inputBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{ins_inputBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{ins_inputBB.setID}"/>

    <h:panelGrid columns="1" cellspacing="2" width="98%"  align="center" >
        <h:panelGrid columns="2">
            <h:panelGroup>
                <h:outputText value="н�����ף�#{ins_inputBB.setName}"/>
                <c:verbatim>&nbsp;&nbsp;</c:verbatim>

                <h:outputText value="��ѡ���û�"></h:outputText>
                <h:selectOneMenu id="personID" value="#{ins_inputBB.personID}" onchange="submit()" valueChangeListener="#{ins_inputBB.changePerson}">
                    <c:selectItems value="#{ins_inputBB.ins_personList}"></c:selectItems>
                </h:selectOneMenu>
            </h:panelGroup>

            <h:panelGrid align="right">
                   <h:commandButton value="����" styleClass="button01" onclick="doAdd()"></h:commandButton>
            </h:panelGrid>
        </h:panelGrid>

        <h:dataTable value="#{ins_inputBB.insPowerList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="100%" >
        <h:column>
            <c:facet name="header"><h:outputText value="��Ȩ����Ŀ����"/></c:facet>
            <h:outputText value="#{list.itemName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="ɾ��" action="#{ins_inputBB.delete}"   styleClass="button01" onclick="return confirm('ȷ��ɾ����')">
                <x:updateActionListener property="#{ins_inputBB.wbo.powerID}" value="#{list.powerID}"></x:updateActionListener>
            </h:commandButton>
        </h:column>
    </h:dataTable>
        <h:outputText escape="false" value="<font color=red>ע��:������ʱ�����ȫ����Ŀ��Ȩ��</font>"></h:outputText>
    </h:panelGrid>

</h:form>
</body>
</html>