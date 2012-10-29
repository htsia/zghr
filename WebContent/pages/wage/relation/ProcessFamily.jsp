<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title></title>
    <base target="_self">
        <script type="text/javascript">
            function seleEndDate(){
                PopUpCalendarDlg_OnlyMonth('form1:endDate');
                var index=0;
                while(true){
                    if (document.all('form1:_id22_' + index + ':costEndDate')!=null){
                        document.all('form1:_id22_' + index + ':costEndDate').value=document.all('form1:endDate').value;
                    }
                    else break;
                    index+=1;
                }
            }
            function forPerson() {
                fPopUpPerDlg("form1:name");
                document.all("form1:name").value = document.all("form1:name").code;
                form1.all("form1:findP").click();
            }
            function seleDate(index) {
                obj = 'form1:_id22_' + index + ':costEndDate';
                PopUpCalendarDlg_OnlyMonth(obj);
            }
        </script>
</head>

<body>
<x:saveState value="#{emp_followfamilyBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_followfamilyBB.pageInit}"/>
    <h:inputHidden id="flag" value="1"/>

    <h:panelGrid width="98%"  align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                    cellspacing="0">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="������Ǩ�˿�"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>
    <h:panelGrid width="95%" align="center" styleClass="table03" columnClasses="td_form01,td_form02,td_form01,td_form02" columns="4">
        <h:outputText value="����ʱ��"/>
        <h:outputText value="#{emp_followfamilyBB.personchangevo.applyDate}"/>

        <h:outputText value="����"/>
        <h:outputText value="#{emp_followfamilyBB.personchangevo.name}"/>

        <h:outputText value="������λ"/>
        <h:inputText readonly="true" id="fromUnit" code="" dict="yes" dict_num="OU" alt="������λ|0|s"
                     value="#{emp_followfamilyBB.personchangevo.fromOrgName}"/>
        <h:outputText value="���뵥λ"/>
        <h:inputText readonly="true" id="toUnit" code="" dict="yes" dict_num="OU" alt="���뵥λ|0|s"
                        value="#{emp_followfamilyBB.personchangevo.toOrgName}"/>
   </h:panelGrid>
    <br>
    <x:dataTable styleClass="table03" rowIndexVar="index"
                headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 align="center"
                 width="80%" value="#{emp_followfamilyBB.familyList}" var="list">
        <h:column>
            <f:facet name="header"><h:outputText value="�Ƿ���Ǩ" styleClass="td03"/></f:facet>
            <h:selectBooleanCheckbox value="#{list.isFollow}"></h:selectBooleanCheckbox>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="����" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="�Ա�" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.sex}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="��������" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.birthDay}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="��ϵ" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.relation}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="��ס��" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.address}"/>
        </h:column>

    </x:dataTable>
    <br>

    <h:panelGrid align="right" cellpadding="2" cellspacing="2" columns="1">
        <h:panelGroup>
            <h:commandButton styleClass="button01" value="����"
                             onclick="if(forsubmit(document.form1))return true;else return false;"
                             action="#{emp_followfamilyBB.savePerson}"/>
            <h:commandButton type="button" styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGroup>
    </h:panelGrid>

</h:form>
</body>
<script type="text/javascript">
    interpret(form1);
</script>
</html>
