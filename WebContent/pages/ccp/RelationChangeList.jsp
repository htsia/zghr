<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>
<html>
<head>
    <title>党组织关系转移</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <f:verbatim>
        <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    </f:verbatim>
</head>

<body>
<%--<x:saveState value="#{ccp_transEditBB.partyRelation.flowId}"/>--%>
<x:saveState value="#{ccp_transListBB}"/>
<h:form id="form1">
<h:inputHidden id="queryType" value="1"/>
<h:inputHidden id="transcateType" value="4"/>
<h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" styleClass="td_title">
    <h:outputText value=" "/>
    <h:outputText value=" 换开介绍信 ->查询历史"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid width="95%" border="0" align="center" cellpadding="0" cellspacing="0" columns="2">
    <h:panelGroup>
        <h:outputText value="姓名："/>
        <h:inputText id="personName" value="#{ccp_transListBB.personName}" size="20" styleClass="input"/>
        <h:outputText value=" "/>
        <h:outputText value="操作日期："/>
        <h:inputText id="leaveSDate" value="#{ccp_transListBB.leaveSDate}" size="12" styleClass="input"/>
        <h:commandButton value="" styleClass="button_date" onclick="PopUpCalendarDialog('form1:leaveSDate');return false;"/>
        <h:outputText value=" "/>
        <h:outputText value="至"/>
        <h:outputText value=" "/>
        <h:inputText id="leaveEDate" value="#{ccp_transListBB.leaveEDate}" size="12" styleClass="input"/>
        <h:commandButton value="" styleClass="button_date" onclick="PopUpCalendarDialog('form1:leaveEDate');return false;"/>
        <h:outputText value=" "/>
        <h:commandButton id="qry" value=" 查询 " styleClass="button01" action="#{ccp_transListBB.queryHistory}"/>
        <h:outputText value=" "/>
        <h:commandButton value=" 返回 " styleClass="button01" action="edit"/>
    </h:panelGroup>
    <%--<h:panelGrid border="0" align="right" columns="1">--%>
        <%--<h:panelGroup>--%>
            <%--<h:outputText value=" "/>--%>
            <%--<h:commandButton value=" 删除 " styleClass="button01"--%>
                             <%--onclick="javascript:if(confirm('确定要删除记录吗？')){return true} else return false;"--%>
                             <%--action="#{ccp_transListBB.deletePartyRelation}"/>--%>
        <%--</h:panelGroup>--%>
    <%--</h:panelGrid>--%>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:dataTable width="95%" value="#{ccp_transListBB.relationvo}" var="list"
             headerClass="td_top" rowClasses="td_middle" styleClass="table03" border="1" align="center">
    <%--<h:column>--%>
        <%--<f:facet name="header"><f:verbatim escape="false">--%>
            <!--<input type="checkbox" name="chkAll"-->
                   <%--onclick="selectAll(document.form1.chkAll,document.form1.flowId)"/></f:verbatim>--%>
        <%--</f:facet>--%>
        <%--<f:verbatim escape="false"><div align="center"><input type="checkbox" name="flowId"--%>
            <%--value="</f:verbatim>--%>
        <%--<h:outputText value="#{list.flowId}"/><f:verbatim>"></div></f:verbatim>--%>
    <%--</h:column>--%>
    <h:column>
        <f:facet name="header"><h:outputText value="查询编号"/></f:facet>
        <h:outputText value="#{list.qryId}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="姓名"/></f:facet>
        <h:outputText value="#{list.personName}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="性别"/></f:facet>
        <h:outputText value="#{list.personGender}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="出生日期"/></f:facet>
        <h:outputText value="#{list.personBirthday}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="政治面貌"/></f:facet>
        <h:outputText value="#{list.partyFigure}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="原所在党组织"/></f:facet>
        <h:outputText value="#{list.sendByUnit}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="转往党组织"/></f:facet>
        <h:outputText value="#{list.sendUnit}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="操作时间"/></f:facet>
        <h:outputText value="#{list.transcateDate}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="操作人"/></f:facet>
        <h:outputText value="#{list.transcatePerson}"/>
    </h:column>

</h:dataTable>
<h:panelGrid width="95%" align="center" columns="1" >
    <f:verbatim escape="false">
        <hrdc:pageTag submitMethod="form.all(\"form1:qry\").click()" buttonStyle="button01"/>
    </f:verbatim>
</h:panelGrid>
</h:form>
</body>
</html>