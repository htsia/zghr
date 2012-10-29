<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>�鿴��ͷ������Ա</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</head>
<body>
<x:saveState value="#{wage_manyHeadPutoutBB}"/>
<h:inputHidden value="#{wage_manyHeadPutoutBB.pageInit}"/>
<h:panelGrid width="98%" align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                cellspacing="0">
    <h:outputText value="   ��ͷ���Ź�ϵ����"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid columns="1" width="95%" align="center">
    <h:outputText value="��н��λ��#{wage_manyHeadPutoutBB.unitName}"/>
   <%
 //  <h:multlink value="2" paneLable="��ͷ���Ź�ϵ��Ȩ,�鿴��ͷ������Ա"
           //        paneLink="ManyHeadPersonSetup.jsf,ViewManyHeadPerson.jsf"
             //      align="left" width="50%"/>
                   %>
</h:panelGrid>
<%--<f:verbatim><br></f:verbatim>--%>
<h:form>
<h:panelGrid width="95%" align="center">
    <h:panelGrid align="right" cellpadding="2" cellspacing="0" columns="1">
        <h:commandButton styleClass="button01" value="������Excel" action="#{wage_manyHeadPutoutBB.exportInToExcel}"/>
    </h:panelGrid>
    <h:dataTable styleClass="table03" headerClass="td_top"
                 columnClasses="td_middle_center,td_middle_center,td_middle_center"
                 width="100%" align="center"
                 value="#{wage_manyHeadPutoutBB.manyHeadVos}" var="list">
        <h:column>
            <f:facet name="header"><h:outputText value="Ա�����"/></f:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="����"/></f:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="��Ȩ��λ"/></f:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
    </h:dataTable>
</h:panelGrid>
</h:form>
</body>
</html>