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
            <h:outputText value="办理薪酬关系转移"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" align="center" styleClass="table03" columnClasses="td_form01,td_form02,td_form01,td_form02" columns="4">
        <h:outputText value="姓名"/>
        <h:outputText value="#{wage_salaryRelationBB.salaryrelation.persName}"/>

        <h:outputText value="调出单位"/>
        <h:inputText readonly="true" id="fromUnit" code="" dict="yes" dict_num="OU" alt="调出单位|0|s"
                     value="#{wage_salaryRelationBB.salaryrelation.fromUnit}"/>
        <h:outputText value="调入单位"/>
        <h:panelGroup>
            <h:inputText readonly="true" id="toUnit" code="" dict="yes" dict_num="OU" alt="调入单位|0|s"
                         value="#{wage_salaryRelationBB.salaryrelation.toUnit}"/>
        </h:panelGroup>

        <h:outputText value="原单位最后发放月份"/>
        <h:panelGroup>
            <h:inputText id="endDate" alt="原单位最后发放月份|1|s" readonly="true" value="#{wage_salaryRelationBB.salaryrelation.payEndDate}"/>
            <h:commandButton type="button" styleClass="button_date"  onclick="seleEndDate();"/>
        </h:panelGroup>
        <h:outputText value="新单位首次发放月份"/>
        <h:panelGroup>
            <h:inputText id="startDate" alt="新单位首次发放月份|1|s" readonly="true" value="#{wage_salaryRelationBB.salaryrelation.payStartDate}"/>
            <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDlg_OnlyMonth('form1:startDate')"/>
        </h:panelGroup>
        <h:outputText value="备注"/>
        <h:inputTextarea rows="1" cols="50" value="#{wage_salaryRelationBB.salaryrelation.remark}"/>
    </h:panelGrid>
    <f:verbatim><br></f:verbatim>
    <x:dataTable styleClass="table03" rowIndexVar="index"    id="data"
                 rowClasses="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 align="center"
                 width="80%" value="#{wage_salaryRelationBB.salaryrelationvos}" var="list">
        <h:column>
            <f:facet name="header"><h:outputText value="转移项目" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.transferItem}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="是否转移" styleClass="td03"/></f:facet>
            <h:selectOneRadio id="radio" value="#{list.radioValue}">
                <f:selectItem itemValue="00901" itemLabel="是"/>
                <f:selectItem itemValue="00900" itemLabel="否"/>
            </h:selectOneRadio>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="信息" styleClass="td03"/></f:facet>
            <h:outputText rendered="#{list.itemId!='A795701'}" value="#{list.basicNum}"/>
            <h:commandButton type="button" styleClass="button01" value="查看" onclick="viewWage('#{wage_salaryRelationBB.personchangevo.personId}');" rendered="#{list.itemId=='A795701'}"></h:commandButton>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="缴费截至时间" styleClass="td03"/></f:facet>
            <h:inputText disabled="#{list.flag}" alt="缴费截至时间|1|s" id="costEndDate"
                         value="#{list.costEndDate}"/>
            <h:commandButton type="button" disabled="#{list.flag}" styleClass="button_date" onclick="seleDate('#{index}');"/>
        </h:column>

    </x:dataTable>
    <f:verbatim><br></f:verbatim>
    <h:panelGrid align="right" cellpadding="2" cellspacing="2" columns="1">
        <h:panelGroup>
            <h:commandButton styleClass="button01" value="保存"
                             onclick="if(forsubmit(document.form1))return true;else return false;"
                             action="#{wage_salaryRelationBB.savePerson}"/>
            <h:commandButton type="button" styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
</body>
<script type="text/javascript">
    interpret(form1);
</script>
</html>
