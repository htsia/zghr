<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<head>
    <title>多头发放关系设置</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language=javascript src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language=javascript src="<%=request.getContextPath()%>/js/checkAll.js"></script>
</head>

<body>
<h:inputHidden value="#{wage_manyHeadPutoutBB.pageInit}"/>
<h:panelGrid width="98%" align="center"  columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                cellspacing="0">
    <h:outputText value="   多头发放关系设置"/>
</h:panelGrid>
<h:panelGrid columns="1" width="98%" align="center">
        <h:outputText value="发薪单位：#{wage_manyHeadPutoutBB.unitName}"/>
    </h:panelGrid>
<x:saveState value="#{wage_manyHeadPutoutBB}"/>
<h:form id="form1">

    <h:panelGrid width="60%" align="center" styleClass="table03" columns="2" columnClasses="td_form01,td_form02">
        <h:outputText value="姓名"/>
        <h:panelGroup>
            <h:inputText alt="姓名|0|s" readonly="true" id="name" code="" dict="yes" dict_num="PE"
                         value="#{wage_manyHeadPutoutBB.manyHeadPutout.persId}"/>
            <h:outputText value=" "/>
            <h:commandButton type="button" styleClass="button01" value="选择人员"
                             onclick="fPopUpPerDlg('form1:name',null,#{wage_manyHeadPutoutBB.unitId});"/>
        </h:panelGroup>

        <h:outputText value="被授权单位"/>
        <h:panelGroup>
            <h:inputText id="destUnit"  readonly="true" code="" dict="yes" dict_num="OU" alt="被授权单位|0|s"   size="40"
                         value="#{wage_manyHeadPutoutBB.manyHeadPutout.destUnit}"/>
            <h:outputText value=" "/>
            <h:commandButton type="button" styleClass="button01" value="选择单位"
                             onclick="fPopUpWageUnitDlg('form1:destUnit','false')"/>
        </h:panelGroup>
    </h:panelGrid>
    <f:verbatim><br></f:verbatim>
    <h:panelGrid align="center" cellpadding="0" cellspacing="2" columns="2">
        <h:commandButton styleClass="button01" value="保存"
                         onclick="if(forsubmit(document.form1))return true;else return false;"
                         action="#{wage_manyHeadPutoutBB.savePerson}"/>
        <h:commandButton type="button" styleClass="button01" value="取消"
                         onclick="location='ManyHeadPersonSetup.jsf'"/>
    </h:panelGrid>
</h:form>
</body>
<script type="text/javascript">
    interpret(form1);
</script>
</html>
