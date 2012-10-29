<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>住房补贴二次计算</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
</head>

<body>
<script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language=javascript src="<%=request.getContextPath()%>/js/check.js"></script>
<script language=javascript src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<SCRIPT language=JavaScript type=text/JavaScript>
    function checkForm() {
        if (document.getElementById("form1:planName").value == null || document.getElementById("form1:planName").value == "") {
            alert("请输入计划名称")
            return false;
        } else
            return true;
    }
    function checkIds(deptId) {
        if (checkMutilSelect(deptId)) {
            if (confirm('确定要移除部门吗？'))
            {
                return true;
            } else {
                return false;
            }
        } else {
            alert("请选择部门！")
            return false;
        }
    }
    function forSave(){
        document.forms(0).flag.value="save";
        return forsubmit(document.forms(0));
    }
</SCRIPT>
<br>
<h:form id="form1">
    <x:saveState value="#{wage_fbcomputeBB}"/>
    <h:inputHidden value="#{wage_fbcomputeBB.pageInit}"/>
    <input type="hidden" name="flag" value="<%=request.getParameter("flag")%>"/>
    <h:panelGrid border="0" align="center" width="95%">
        <h:panelGrid border="0" align="left" cellspacing="2" columns="2">
            <h:outputText value="机构名称：#{wage_fbcomputeBB.unitName}"/>
            <%--<h:outputText value="记录数：#{wage_fbcomputeBB.recNum}"/>--%>
        </h:panelGrid>

        <h:panelGrid border="0" align="right" cellspacing="2" columns="7">
            <h:commandButton styleClass="button01" value="数据抽取" action="#{wage_fbcomputeBB.importData}"/>
            <h:commandButton styleClass="button01" value="计算起步时间" onclick="return checkBatchDo('chk');" action="#{wage_fbcomputeBB.computeDate}"/>
            <h:commandButton styleClass="button01" value="保存数据"
                             onclick="javascript:return forSave();"
                             action="#{wage_fbcomputeBB.saveData}">
            </h:commandButton>
            <h:commandButton styleClass="button01" value="导入计算结果" onclick="if(checkBatchDo('chk')){return confirm('若有手动调整的数据请先保存\n确定要导入计算结果吗?');}else{return false;}" action="#{wage_fbcomputeBB.setResultData}"/>
            <h:commandButton styleClass="button01" value="导出到Excel"
                             onclick="return true;"
                             action="#{wage_fbcomputeBB.importToExcel}"/>
            <h:commandButton styleClass="button01" value=" 删除 " action="#{wage_fbcomputeBB.deleteBatch}" onclick="return checkBatchDelete('chk');" />
            <h:commandButton  styleClass="button01" id="qry" value=" 查询 " action="#{wage_fbcomputeBB.queryPers}"  onclick="submit();"/>
        </h:panelGrid>
    </h:panelGrid>
    <center>
    <hrdc:pageTag submitMethod="form1.all(\"form1:qry\").onclick()"/>
    </center>
    <h:panelGrid align="center" width="95%">
        <h:dataTable styleClass="table03" headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     align="center" width="100%"
                     value="#{wage_fbcomputeBB.computeBOs}" var="list" >
            <h:column>
                <f:facet name="header">
                       <f:verbatim escape="false">
                        <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.chk)"/>
                        </f:verbatim>
                </f:facet>
                <f:verbatim escape="false">
                    <input type="checkbox" name="chk" value="</f:verbatim>
                    <h:outputText value="#{list.persId}"/>
                    <f:verbatim>"></f:verbatim>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="姓名" /></f:facet>
                <h:outputText value="#{list.persName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="所在部门" /></f:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="标准表编号" /></f:facet>
                <h:outputText value="#{list.standardId}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="补偿服务起点时间" /></f:facet>
                <h:inputText value="#{list.workYear}" alt="补偿服务起点时间|0|d6" size="16"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="享受住房待遇职级" /></f:facet>
                <h:outputText value="#{list.startPostName}" />
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="职务" /></f:facet>
                <h:outputText value="#{list.dutyName}" />
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="职等" /></f:facet>
                <h:outputText value="#{list.postLevelName}" />
            </h:column>
            <%--<h:column>--%>
                <%--<f:facet name="header"><h:outputText value="专业技术" /></f:facet>--%>
                <%--<h:inputText value="#{list.technology}"/>--%>
            <%--</h:column>--%>
            <h:column>
                <f:facet name="header"><h:outputText value="起步时间" /></f:facet>
                <h:inputText value="#{list.startDate}" alt="起步时间|1|d6" size="16"/>
            </h:column>
           <%-- <h:column>
                <f:facet name="header"><h:outputText value="操作" /></f:facet>
                <h:commandButton id="del" styleClass="button01" value="删除" onclick="return confirm('确定要删除吗?')" action="#{wage_fbcomputeBB.deleteData}">
                    <x:updateActionListener property="#{wage_fbcomputeBB.persId}" value="#{list.persId}"/>
                </h:commandButton>
            </h:column>--%>
        </h:dataTable>
    </h:panelGrid>
</h:form>
</body>
</html>
