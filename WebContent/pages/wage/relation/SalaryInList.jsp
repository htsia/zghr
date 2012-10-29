<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</head>
<script language="javascript">
    function checkIds(persId) {
        if (checkMutilSelect(persId)) {
            if (confirm('确定要删除所选人员吗？'))
            {
                return true;
            } else {
                return false;
            }
        } else {
            alert("请选择人员！")
            return false;
        }
    }
</script>

<body>
<x:saveState value="#{wage_salaryRelationBB}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 薪酬管理 ->  转入薪酬关系"/>
        </h:panelGroup>
    </h:panelGrid>
<h:inputHidden value="#{wage_salaryRelationBB.pageInit}"/>
<h:form id="form1">
    <h:panelGrid columns="1" width="95%" align="center">
        <h:outputText value="发薪单位：#{wage_salaryRelationBB.unitName}"/>
    </h:panelGrid>
    <f:verbatim><br></f:verbatim>
    <h:panelGrid align="center" width="95%" columns="2">
        <h:panelGrid columns="11" cellspacing="2">
            <h:outputText value="姓名"/>
            <h:inputText id="name"  size="10" value="#{wage_salaryRelationBB.personName}"/>
            <h:outputText value="开始时间"/>
            <h:inputText id="sDate"  size="10" value="#{wage_salaryRelationBB.startDate}"/>
            <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:sDate')"/>
            <h:outputText value="结束时间"/>
            <h:inputText id="eDate"  size="10" value="#{wage_salaryRelationBB.endDate}"/>
            <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:eDate')"/>
            <h:outputText value="状态"/>
            <h:selectOneMenu value="#{wage_salaryRelationBB.status}">
                <f:selectItem itemValue="" itemLabel=""/>
                <f:selectItem itemValue="1" itemLabel="等待确认"/>
                <f:selectItem itemValue="2" itemLabel="办理完成"/>
                <f:selectItem itemValue="3" itemLabel="退回"/>
            </h:selectOneMenu>

            <h:commandButton id="findIn" styleClass="button01" value="查询"
                             action="#{wage_salaryRelationBB.findInPerson}"/>
        </h:panelGrid>
        <h:panelGrid columns="1" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="导出到Excel"
                             action="#{wage_salaryRelationBB.exportInToExcel}"/>
        </h:panelGrid>
         </h:panelGrid>
        <h:panelGrid align="center" width="100%" >
        <h:dataTable width="95%" align="center"
                     styleClass="table03" headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     value="#{wage_salaryRelationBB.relationpersoninvos}" var="list">
            <h:column>
                <f:facet name="header"><h:outputText value="员工编号" /></f:facet>
                <h:outputText value="#{list.persCode}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="姓名" /></f:facet>
                <h:outputText value="#{list.persName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="调出时间" /></f:facet>
                <h:outputText value="#{list.date}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="行政职务" /></f:facet>
                <h:outputText value="#{list.duty}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="调入单位" /></f:facet>
                <h:outputText value="#{list.toUnitName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="调出单位" /></f:facet>
                <h:outputText value="#{list.fromUnitName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="状态" /></f:facet>
                <h:outputText value="#{list.status}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="操作" /></f:facet>
                <h:commandButton id="link" styleClass="button01" value="查看"
                                 action="#{wage_salaryRelationBB.viewInPerson}">
                    <x:updateActionListener property="#{wage_salaryRelationBB.salaryrelation.persId}"
                                            value="#{list.persId}"/>
                    <x:updateActionListener property="#{wage_salaryRelationBB.salaryrelation.fromUnit}"
                                            value="#{list.fromUnit}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
        <f:verbatim escape="false">
            <hrdc:pageTag submitMethod="form1.all(\"form1:findIn\").click()"/>
        </f:verbatim>
        </h:panelGrid>

</h:form>
</body>
</html>
