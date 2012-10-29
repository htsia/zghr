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
            <h:outputText value="�������ƣ�#{wage_fbstandardBB.unitName}"/>
            <h:panelGrid align="right" columns="4" cellspacing="2">
                <h:commandButton styleClass="button01" value="�½���׼��" rendered="#{wage_fbstandardBB.operRight}"
                                 action="#{wage_fbstandardBB.step1_create}"/>
                <%--<h:commandButton styleClass="button01" value="����Ϊ������׼" rendered="#{wage_fbstandardBB.issueRight}"--%>
                                 <!--action="#{wage_fbstandardBB.issueStandard}"-->
                                 <!--onclick="return confirmDel('ȷ��Ҫ������?');"/>-->
                <%--<h:commandButton styleClass="button01" value="����������׼" rendered="#{wage_fbstandardBB.issueRight}"--%>
                                 <!--action="#{wage_fbstandardBB.banStandard}"-->
                                 <!--onclick="return confirmDel('ȷ��Ҫ������?');"/>-->
                <h:commandButton styleClass="button01" value="ɾ����׼��" rendered="#{wage_fbstandardBB.operRight}"
                                 action="#{wage_fbstandardBB.delete}"
                                 onclick="return confirmDel('ȷ��Ҫɾ����?');"/>
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
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{list[0].number}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="ִ��ʱ��"/></c:facet>
                <h:outputText value="#{list[0].runDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list[0].name}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list[0].desc}"/>
            </h:column>
            <%--<h:column>--%>
                <%--<c:facet name="header"><h:outputText value="�Ƿ񹫹���׼"/></c:facet>--%>
                <%--<h:outputText value="#{list[0].publicFlag}"/>--%>
            <%--</h:column>--%>
            <h:column>
                <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                <h:outputText value="#{list[0].createDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton styleClass="button01" action="#{wage_fbstandardBB.view}" value="�鿴">
                    <x:updateActionListener property="#{wage_fbstandardBB.standard.stdId}" value="#{list[0].stdId}"/>
                </h:commandButton>
                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" action="#{wage_fbstandardBB.step1_setItem}" value="�޸�"
                                 rendered="#{list[2]}">
                    <x:updateActionListener property="#{wage_fbstandardBB.standard.stdId}" value="#{list[0].stdId}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
</body>
</html>