<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language="javascript">
        function checkIds(persId) {
            if (checkMutilSelect(persId)) {
                if (confirm('ȷ��Ҫɾ����ѡ�ƻ���'))
                {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("��ѡ��ƻ���")
                return false;
            }
        }
        function checkIds1(persId) {
            if (checkMutilSelect(persId)) {
                    return true;
            } else {
                alert("��ѡ��ƻ���")
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
            <h:outputText value="ѡ����ȣ�"/>
            <h:selectOneMenu id="year" value="#{wage_grossBB.year}"
                             onchange="submit()" valueChangeListener="#{wage_grossBB.queryGrossByYear}">
                <f:selectItems value="#{wage_grossBB.years}"/>
            </h:selectOneMenu>
        </h:panelGroup>
        <h:panelGrid columns="4" cellspacing="2">
        <h:commandButton value="�����ƻ�" styleClass="button01" onclick="return true;"
                             action="#{wage_grossBB.addPlan}"  rendered="#{wage_grossBB.operRight}"/>
        <%--<h:commandButton value="�����ƻ�" styleClass="button01"--%>
                <%--onclick="if(checkIds1(document.form1.subId)){return true;}else return false;"--%>
                             <%--action="#{wage_grossBB.adjustPlan}" rendered="#{wage_grossBB.operRight}"/>--%>
        <h:commandButton value="�����ƻ�" styleClass="button01"
                             action="#{wage_grossBB.adjustPlan}" rendered="#{wage_grossBB.operRight}"/>
        <h:commandButton value="ɾ���ƻ�" styleClass="button01"
                             onclick="if(checkIds(document.form1.subId)){return true;}else return false;"
                             action="#{wage_grossBB.deleteGross}" rendered="#{wage_grossBB.operRight}"/>
        <h:commandButton value="������Excel" styleClass="button01" action="#{wage_grossBB.exportToExcel}"/>
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
            <f:facet name="header"><h:outputText  value="��н��λ" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.unitName}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="���" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.year}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="���Ӧ���������" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.NCYFGZYE}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="���깤�ʼƻ�����" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.DNJHZL}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="Ԥ�����귢�Ź���" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.YLCNFFGZ}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="����ڿ��ù�������" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.KYGZZL}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="���ù�������" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.YYGZZL}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="ʹ�ý���(%)" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.useProgress}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="����������" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.DNKYGZYE}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="��ͷ���ŵ�����" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.adjustItem}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="��ע" styleClass="td03"/></f:facet>
            <h:outputText escape="false"  value="#{list.remark}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="����" styleClass="td03"/></f:facet>
            <%--<h:panelGrid columns="2" cellspacing="2">--%>
                <%--<h:commandButton id="link" styleClass="button01" value="�ƻ�����" action="#{wage_grossBB.adjustPlan}" rendered="#{wage_grossBB.operRight}">--%>
                    <%--<x:updateActionListener property="#{wage_grossBB.grossVo.subId}" value="#{list.subId}" />--%>
                <%--</h:commandButton>--%>
                <h:commandButton id="view" style="#{list.flag}" styleClass="button01" value="�鿴������ϸ"
                                 onclick="javascript:windowOpen('GrossDetailView.jsf?unitId=#{list.unitId}&year=#{list.year}&act=detail','','resizable=yes,','900','370','','200','50');return false;">
                </h:commandButton>
            <%--</h:panelGrid>--%>
        </h:column>
    </h:dataTable>
    <f:verbatim></div></f:verbatim>
</h:form>
</html>