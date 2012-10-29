<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>多头发放人员授权</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language="javascript">
        function checkIds(persId) {
            if (checkMutilSelect(persId)) {
                if (confirm('确定要撤销所选人员的授权吗？'))
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
</head>

<body>
<x:saveState value="#{wage_manyHeadPutoutBB}"/>
<h:inputHidden value="#{wage_manyHeadPutoutBB.pageInit}"/>
<h:panelGrid width="98%" align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                cellspacing="0">
    <h:outputText value="   多头发放关系设置"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid columns="1" width="95%" align="center">
    <h:outputText value="发薪单位：#{wage_manyHeadPutoutBB.unitName}"/>
    <%
   // <h:multlink value="1" paneLable="多头发放关系授权,查看多头发放人员"
                //   paneLink="ManyHeadPersonSetup.jsf,ViewManyHeadPerson.jsf"
                 //  align="left" width="50%"/>
                   %>
</h:panelGrid>

<h:form id="form1">
    <h:panelGrid width="95%" align="center" >
        <%--<h:panelGrid align="left" columns="9" cellspacing="2">--%>
            <%--<h:outputText value="姓名"/>--%>
            <%--<h:inputText id="name" size="10" value="#{wage_manyHeadPutoutBB.personName}"/>--%>
            <%--<h:outputText value="开始时间"/>--%>
            <%--<h:inputText id="sDate" size="10" value="#{wage_manyHeadPutoutBB.startDate}"/>--%>
            <%--<h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:sDate')"/>--%>
            <%--<h:outputText value="结束时间"/>--%>
            <%--<h:inputText id="eDate" size="10" value="#{wage_manyHeadPutoutBB.endDate}"/>--%>
            <%--<h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:eDate')"/>--%>
            <%--<h:commandButton id="find" styleClass="button01" value="查询"--%>
                             <%--action="#{wage_manyHeadPutoutBB.findOutPerson}"/>--%>
        <%--</h:panelGrid>--%>
        <h:panelGrid align="right" cellpadding="2" cellspacing="0" columns="3">
            <h:commandButton type="button" styleClass="button01" value="增加人员"
                             onclick="location='AddManyHeadPerson.jsf'"/>
            <h:commandButton styleClass="button01" value="撤销授权"
                             onclick="if(checkIds(document.form1.awardId)){return true;}else return false;"
                             action="#{wage_manyHeadPutoutBB.deletePerson}"/>
            <h:commandButton styleClass="button01" value="导出到Excel"
                             action="#{wage_manyHeadPutoutBB.exportOutToExcel}"/>
        </h:panelGrid>
        <h:dataTable width="100%"  align="center"
                     styleClass="table03"  headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     value="#{wage_manyHeadPutoutBB.manyHeadPutoutVos}" var="list" >
            <h:column>
                <f:facet name="header">
                    <f:verbatim escape="false">
                        <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.awardId)"/>
                    </f:verbatim>
                </f:facet>
                <f:verbatim escape="false"><input type="checkbox" </f:verbatim>
                <h:outputText value="#{list.flag}"/><f:verbatim> name="awardId" value="</f:verbatim>
                <h:outputText value="#{list.awardId}"/><f:verbatim>"></f:verbatim>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="员工编号" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="姓名" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="工作单位" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.workPlace}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="所在部门" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="被授权单位" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.destDeptName}"/>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
</body>
</html>