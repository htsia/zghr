<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title></title>
    <base target="_self">
        <script type="text/javascript">
            function viewWage(id){
                var url="/wage/relation/ViewWage.jsf?personID="+id;
                window.showModalDialog(url, null, "dialogWidth:750px; dialogHeight:550px;center:center;resizable:no;status:no;");
                return false;
            }
            function seleEndDate(){
                PopUpCalendarDlg_OnlyMonth('form1:endDate');
                var index=0;
                while(true){
                    if (document.all('form1:data_' + index + ':costEndDate')!=null){
                        document.all('form1:data_' + index + ':costEndDate').value=document.all('form1:endDate').value;
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
                obj = 'form1:data_' + index + ':costEndDate';
                debugger;
                PopUpCalendarDlg_OnlyMonth(obj);
            }
        </script>
</head>

<body>
<x:saveState value="#{wage_salaryRelationBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_salaryRelationBB.pageInit}"/>
    <h:inputHidden id="flag" value="1"/>

    <h:panelGrid width="98%"  align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                    cellspacing="0">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="����н���ϵת��"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" align="center" styleClass="table03" columnClasses="td_form01,td_form02,td_form01,td_form02" columns="4">
        <h:outputText value="����"/>
        <h:outputText value="#{wage_salaryRelationBB.salaryrelation.persName}"/>

        <h:outputText value="������λ"/>
        <h:inputText readonly="true" id="fromUnit" code="" dict="yes" dict_num="OU" alt="������λ|0|s"
                     value="#{wage_salaryRelationBB.salaryrelation.fromUnit}"/>
        <h:outputText value="���뵥λ"/>
        <h:panelGroup>
            <h:inputText readonly="true" id="toUnit" code="" dict="yes" dict_num="OU" alt="���뵥λ|0|s"
                         value="#{wage_salaryRelationBB.salaryrelation.toUnit}"/>
        </h:panelGroup>

        <h:outputText value="ԭ��λ��󷢷��·�"/>
        <h:panelGroup>
            <h:inputText id="endDate" alt="ԭ��λ��󷢷��·�|1|s" readonly="true" value="#{wage_salaryRelationBB.salaryrelation.payEndDate}"/>
            <h:commandButton type="button" styleClass="button_date"  onclick="seleEndDate();"/>
        </h:panelGroup>
        <h:outputText value="�µ�λ�״η����·�"/>
        <h:panelGroup>
            <h:inputText id="startDate" alt="�µ�λ�״η����·�|1|s" readonly="true" value="#{wage_salaryRelationBB.salaryrelation.payStartDate}"/>
            <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDlg_OnlyMonth('form1:startDate')"/>
        </h:panelGroup>
        <h:outputText value="��ע"/>
        <h:inputTextarea rows="1" cols="50" value="#{wage_salaryRelationBB.salaryrelation.remark}"/>
    </h:panelGrid>
    <f:verbatim><br></f:verbatim>
    <x:dataTable styleClass="table03" rowIndexVar="index"    id="data"
                 rowClasses="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 align="center"
                 width="80%" value="#{wage_salaryRelationBB.salaryrelationvos}" var="list">
        <h:column>
            <f:facet name="header"><h:outputText value="ת����Ŀ" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.transferItem}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="�Ƿ�ת��" styleClass="td03"/></f:facet>
            <h:selectOneRadio id="radio" value="#{list.radioValue}">
                <f:selectItem itemValue="00901" itemLabel="��"/>
                <f:selectItem itemValue="00900" itemLabel="��"/>
            </h:selectOneRadio>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="��Ϣ" styleClass="td03"/></f:facet>
            <h:outputText rendered="#{list.itemId!='A795701'}" value="#{list.basicNum}"/>
            <h:commandButton type="button" styleClass="button01" value="�鿴" onclick="viewWage('#{wage_salaryRelationBB.personchangevo.personId}');" rendered="#{list.itemId=='A795701'}"></h:commandButton>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="�ɷѽ���ʱ��" styleClass="td03"/></f:facet>
            <h:inputText disabled="#{list.flag}" alt="�ɷѽ���ʱ��|1|s" id="costEndDate"
                         value="#{list.costEndDate}"/>
            <h:commandButton type="button" disabled="#{list.flag}" styleClass="button_date" onclick="seleDate('#{index}');"/>
        </h:column>

    </x:dataTable>
    <f:verbatim><br></f:verbatim>
    <h:panelGrid align="right" cellpadding="2" cellspacing="2" columns="1">
        <h:panelGroup>
            <h:commandButton styleClass="button01" value="����"
                             onclick="if(forsubmit(document.form1))return true;else return false;"
                             action="#{wage_salaryRelationBB.savePerson}"/>
            <h:commandButton type="button" styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
</body>
<script type="text/javascript">
    interpret(form1);
</script>
</html>
