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
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function confirmDel(str) {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm(str))
                    return true;
            }
            return false;
        }
    </script>
</head>

<body>
<x:saveState value="#{wage_fbstandardBB}"/>
<h:inputHidden value="#{wage_fbstandardBB.pageInit}"/>
<h:form id="form1">
    <h:inputHidden id="unitId" value="#{wage_fbstandardBB.standard.unitId}"/>
    <h:panelGrid width="95%" align="center">
        <h:panelGrid columns="2" width="100%">
            <h:outputText value="机构名称：#{wage_fbstandardBB.unitName}"/>
            <h:panelGrid align="right" columns="4" cellspacing="2">
                <h:commandButton styleClass="button01" value="新建标准表" rendered="#{wage_fbstandardBB.operRight}"
                                 action="#{wage_fbstandardBB.step1_create}"/>
                <%--<h:commandButton styleClass="button01" value="发布为公共标准" rendered="#{wage_fbstandardBB.issueRight}"--%>
                                 <!--action="#{wage_fbstandardBB.issueStandard}"-->
                                 <!--onclick="return confirmDel('确定要发布吗?');"/>-->
                <%--<h:commandButton styleClass="button01" value="撤销公共标准" rendered="#{wage_fbstandardBB.issueRight}"--%>
                                 <!--action="#{wage_fbstandardBB.banStandard}"-->
                                 <!--onclick="return confirmDel('确定要撤销吗?');"/>-->
                <h:commandButton styleClass="button01" value="删除标准表" rendered="#{wage_fbstandardBB.operRight}"
                                 action="#{wage_fbstandardBB.delete}"
                                 onclick="return confirmDel('确定要删除吗?');"/>
            </h:panelGrid>
        </h:panelGrid>
        <h:dataTable value="#{wage_fbstandardBB.stdList}" var="list"
                     headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     styleClass="table03" width="100%">
            <h:column rendered="#{wage_fbstandardBB.operRight}">
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selectItem)">
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem" </c:verbatim ><c:verbatim ><h:outputText value="#{list[1]}"/></c:verbatim>
                    <c:verbatim > value="</c:verbatim><h:outputText value="#{list[0].stdId}"/><c:verbatim>">
            </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="编号"/></c:facet>
                <h:outputText value="#{list[0].number}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="执行时间"/></c:facet>
                <h:outputText value="#{list[0].runDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="名称"/></c:facet>
                <h:outputText value="#{list[0].name}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list[0].desc}"/>
            </h:column>
            <%--<h:column>--%>
                <%--<c:facet name="header"><h:outputText value="是否公共标准"/></c:facet>--%>
                <%--<h:outputText value="#{list[0].publicFlag}"/>--%>
            <%--</h:column>--%>
            <h:column>
                <c:facet name="header"><h:outputText value="更新时间"/></c:facet>
                <h:outputText value="#{list[0].createDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton styleClass="button01" action="#{wage_fbstandardBB.view}" value="查看">
                    <x:updateActionListener property="#{wage_fbstandardBB.standard.stdId}" value="#{list[0].stdId}"/>
                </h:commandButton>
                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" action="#{wage_fbstandardBB.step1_setItem}" value="修改"
                                 rendered="#{list[2]}">
                    <x:updateActionListener property="#{wage_fbstandardBB.standard.stdId}" value="#{list[0].stdId}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
</body>
</html>