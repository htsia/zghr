<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function confirmDel() {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm('确定要删除吗？'))
                    return true;
            }
            return false;
        }
    </script>

<x:saveState value="#{lead_unitBB}"/>
<h:inputHidden id="pageInit" value="#{lead_unitBB.pageInit}"/>
<h:form id="form1">
    <h:inputHidden value="#{lead_unitBB.unit.unitId}" id="unitId"/>
    <h:inputHidden value="#{lead_unitBB.unit.superId}" id="superId"/>
    <h:panelGrid width="100%" align="center">
        <h:outputText value="当前单位：#{lead_unitBB.unitName}"/>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="新建单位" action="#{lead_unitBB.create}"
                             rendered="#{lead_unitBB.operRight}"/>
            <h:commandButton styleClass="button01" value="删除单位"
                             action="#{lead_unitBB.delete}" rendered="#{lead_unitBB.operRight}"
                             onclick="return confirmDel();"/>
        </h:panelGrid>

        <h:dataTable value="#{lead_unitBB.unitList}" var="list" width="100%"
                     headerClass="td_top" styleClass="table03"  id="dateList"
                     columnClasses="td_middle_center,td_middle,td_middle,td_middle_center,td_middle_center,td_middle_center">
            <h:column rendered="#{lead_unitBB.operRight}">
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll"
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>全选
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem"
                    value="</c:verbatim><h:outputText value="#{list.unitId}"/><c:verbatim>">
            </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="单位"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="显示顺序"/></c:facet>
                <h:outputText value="#{list.order}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton id="bnt" styleClass="button01" action="#{lead_unitBB.find}" value="修改"
                                 rendered="#{lead_unitBB.operRight}">
                    <x:updateActionListener property="#{lead_unitBB.unit.unitId}" value="#{list.unitId}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
<c:verbatim>
    <script type="text/javascript">
        if (document.all('pageInit').value == "refreshTreeadd") {
            parent.tree.location = '/lead/UnitTree.jsf?unitId=' + form1.all("form1:unitId").value;
        } else if (document.all('pageInit').value == "refreshTreedel") {
            parent.tree.location = '/lead/UnitTree.jsf?unitId=' + form1.all("form1:superId").value;
        }

       setDataTableOver("form1:dateList");
    </script>
</c:verbatim>
