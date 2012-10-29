<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language="javascript">
        function checkIds(persId) {
            if (checkMutilSelect(persId)) {
                if (confirm('确定要删除所选计划吗？'))
                {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择计划！")
                return false;
            }
        }
        function checkIds1(persId) {
            if (checkMutilSelect(persId)) {
                    return true;
            } else {
                alert("请选择计划！")
                return false;
            }
        }
    </script>

</head>

<h:inputHidden value="#{wage_grossBB.pageInit}"/>
<x:saveState value="#{wage_grossBB}"/>
<h:form id="form1">
    <h:commandButton style="display:none;" id="query" action="#{wage_grossBB.queryGross}"/>
    <h:panelGrid width="100%" align="center"  columns="2" styleClass="td_page">
        <h:panelGroup>
            <h:outputText value="选择年度："/>
            <h:selectOneMenu id="year" value="#{wage_grossBB.year}"
                             onchange="submit()" valueChangeListener="#{wage_grossBB.queryGrossByYear}">
                <f:selectItems value="#{wage_grossBB.years}"/>
            </h:selectOneMenu>
        </h:panelGroup>
        <h:panelGrid columns="4" cellspacing="2">
        <h:commandButton value="新增计划" styleClass="button01" onclick="return true;"
                             action="#{wage_grossBB.addPlan}"  rendered="#{wage_grossBB.operRight}"/>
        <%--<h:commandButton value="调整计划" styleClass="button01"--%>
                <%--onclick="if(checkIds1(document.form1.subId)){return true;}else return false;"--%>
                             <%--action="#{wage_grossBB.adjustPlan}" rendered="#{wage_grossBB.operRight}"/>--%>
        <h:commandButton value="调整计划" styleClass="button01"
                             action="#{wage_grossBB.adjustPlan}" rendered="#{wage_grossBB.operRight}"/>
        <h:commandButton value="删除计划" styleClass="button01"
                             onclick="if(checkIds(document.form1.subId)){return true;}else return false;"
                             action="#{wage_grossBB.deleteGross}" rendered="#{wage_grossBB.operRight}"/>
        <h:commandButton value="导出到Excel" styleClass="button01" action="#{wage_grossBB.exportToExcel}"/>
        </h:panelGrid>
    </h:panelGrid>
    <f:verbatim><br><div id="datatable"></f:verbatim>
    <h:dataTable width="150%" styleClass="table03" headerClass="td_top" align="center"
                 columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle"
                 value="#{wage_grossBB.grossVos}" var="list" >
        <h:column rendered="#{wage_grossBB.operRight}">
            <f:facet name="header">
                <f:verbatim escape="false">
                    <input type="checkbox" name="chkAll"
                           onclick="selectAll(document.form1.chkAll,document.form1.subId)"/>
                </f:verbatim>
            </f:facet>
            <f:verbatim escape="false"><input type="checkbox" name="subId" </f:verbatim>
                <h:outputText value="#{list.flag}"/><f:verbatim>
                value="</f:verbatim><h:outputText value="#{list.subId}"/><f:verbatim>"></f:verbatim>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText  value="发薪单位" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.unitName}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="年度" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.year}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="年初应付工资余额" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.NCYFGZYE}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="当年工资计划总量" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.DNJHZL}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="预留次年发放工资" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.YLCNFFGZ}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="年度内可用工资总量" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.KYGZZL}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="已用工资总量" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.YYGZZL}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="使用进度(%)" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.useProgress}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="当年可用余额" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.DNKYGZYE}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="多头发放调整项" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.adjustItem}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="备注" styleClass="td03"/></f:facet>
            <h:outputText escape="false"  value="#{list.remark}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="操作" styleClass="td03"/></f:facet>
            <%--<h:panelGrid columns="2" cellspacing="2">--%>
                <%--<h:commandButton id="link" styleClass="button01" value="计划调整" action="#{wage_grossBB.adjustPlan}" rendered="#{wage_grossBB.operRight}">--%>
                    <%--<x:updateActionListener property="#{wage_grossBB.grossVo.subId}" value="#{list.subId}" />--%>
                <%--</h:commandButton>--%>
                <h:commandButton id="view" style="#{list.flag}" styleClass="button01" value="查看发放明细"
                                 onclick="javascript:windowOpen('GrossDetailView.jsf?unitId=#{list.unitId}&year=#{list.year}&act=detail','','resizable=yes,','900','370','','200','50');return false;">
                </h:commandButton>
            <%--</h:panelGrid>--%>
        </h:column>
    </h:dataTable>
    <f:verbatim></div></f:verbatim>
</h:form>
</html>