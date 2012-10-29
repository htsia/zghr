<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</head>

<body>
<x:saveState value="#{wage_unitBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_unitBB.unit.treeId}" id="treeId"/>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid align="center" styleClass="table03" width="95%" columns="2" columnClasses="td_form01,td_form02">
        <h:outputText value="上级发薪单位"/>
        <h:panelGrid cellspacing="2" columns="2">
            <h:inputText id="superId" value="#{wage_unitBB.unit.superId}" size="40"
                         code="" dict="yes" dict_num="WAGE" readonly="true" alt="上级发薪单位|0"/>
        </h:panelGrid>

        <h:outputText value="发薪单位"/>
        <h:panelGrid cellspacing="2" columns="2">
            <h:inputText id="unitId" value="#{wage_unitBB.unit.unitId}" size="40"
                         code="" dict="yes" dict_num="OU" readonly="true" alt="发薪单位|0"/>
            <h:commandButton type="button" styleClass="button_select" id="bntorg" onclick="PopUpOrgDlg('form1:unitId','1',document.forms(0).all('form1:superId').code)"/>
        </h:panelGrid>

        <h:outputText value="描述"/>
        <h:inputText id="desc" value="#{wage_unitBB.unit.desc}" size="60"/>

        <h:outputText value="显示顺序"/>
        <h:inputText id="order" value="#{wage_unitBB.unit.order}" alt="显示顺序|0|i|3|0"/>

        <h:outputText value="是否管理机构"/>
        <h:selectOneRadio value="#{wage_unitBB.unit.manageFlag}" id="manageFlag" alt="是否管理机构|0">
            <c:selectItem itemValue="00901" itemLabel="是"/>
            <c:selectItem itemValue="00900" itemLabel="否"/>
        </h:selectOneRadio>
    </h:panelGrid>

    <c:verbatim><br></c:verbatim>

    <h:panelGrid columns="2" cellspacing="2" align="center">
        <h:commandButton styleClass="button01" value="保存" action="#{wage_unitBB.save}"
                         onclick="return forsubmit(document.forms(0))"/>
        <h:commandButton styleClass="button01" value="取消返回" action="#{wage_unitBB.list}"
                         onclick="return pageCodeExchange(document.forms(0))">
            <x:updateActionListener property="#{wage_unitBB.pageInit}" value=""/>
        </h:commandButton>
    </h:panelGrid>
</h:form>
<c:verbatim escape="false">
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
        if(form1.all("form1:unitId").value!=null&&form1.all("form1:unitId").value!=""){
            form1.all("form1:bntorg").style.display="none";
        }
    </script>
</c:verbatim>
</body>
</html>