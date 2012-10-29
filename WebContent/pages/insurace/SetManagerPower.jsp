<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <base target="_self">
    <script type="text/javascript">
        function doAdd(){
            if (document.all('form1:personID').value=="-1" || document.all('form1:personID').value=="" ){
                alert("��ѡ����Ա!");
                return false;
            }
            return true;
        }
        function setPower(ID){
            window.showModalDialog("/insurace/ModiManagePower.jsf?ID="+ID, null, "dialogWidth:300px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{ins_managerItemBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{ins_managerItemBB.pageInit}"/>
    <h:panelGrid columns="1" cellspacing="2" width="98%"  align="center" >
            <h:panelGrid columns="2" align="right">
                   <h:selectOneMenu id="personID" value="#{ins_managerItemBB.personID}">
                       <c:selectItems value="#{ins_managerItemBB.userList}"></c:selectItems>
                   </h:selectOneMenu>
                   <h:commandButton value="������Ա" styleClass="button01" action="#{ins_managerItemBB.addPerson}" onclick="return doAdd();"></h:commandButton>
            </h:panelGrid>
    </h:panelGrid>

        <h:dataTable value="#{ins_managerItemBB.insPowerList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="����Ա"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��Ȩ����Ŀ����"/></c:facet>
            <h:outputText value="#{list.itemName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�Ȩ�޶���"  styleClass="button01" onclick="return setPower('#{list.personID}')">
            </h:commandButton>
            <h:commandButton value="ֹͣ��Ȩ" action="#{ins_managerItemBB.delete}"   styleClass="button01" onclick="return confirm('ȷ��ɾ����')">
                <x:updateActionListener property="#{ins_managerItemBB.powerID}" value="#{list.powerID}"></x:updateActionListener>
            </h:commandButton>
        </h:column>
       </h:dataTable>
</h:form>
