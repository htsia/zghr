<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
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

<x:saveState value="#{wage_unitBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_unitBB.pageInit}"/>
    <h:inputHidden value="#{wage_unitBB.unit.unitId}" id="unitId"/>
    <h:inputHidden value="#{wage_unitBB.unit.superId}" id="superId"/>
    <h:panelGrid width="100%" align="center">
        <h:panelGroup>
            <h:outputText escape="false" value="<strong>上级薪酬单位：</strong>#{wage_unitBB.unitName}"/>

            <h:panelGrid columns="2" align="right" cellspacing="2">
                <h:commandButton styleClass="button01" value="新建发薪单位" action="#{wage_unitBB.create}"
                                 rendered="#{wage_unitBB.operRight}"/>
                <h:commandButton styleClass="button01" value="删除发薪单位"
                                 action="#{wage_unitBB.delete}" rendered="#{wage_unitBB.operRight}"
                                 onclick="return confirmDel();"/>
            </h:panelGrid>
        </h:panelGroup>

        <h:dataTable value="#{wage_unitBB.unitList}" var="list" width="100%"  id="dateList"
                     headerClass="td_top" styleClass="table03"
                     columnClasses="td_middle_center,td_middle,td_middle,td_middle_center,td_middle_center,td_middle_center">
            <h:column rendered="#{wage_unitBB.operRight}">
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
                <c:facet name="header"><h:outputText value="发薪单位"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="是否管理机构"/></c:facet>
                <h:outputText value="#{list.manageFlag}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton id="bnt" styleClass="button01" action="#{wage_unitBB.find}" value="修改"
                                 rendered="#{wage_unitBB.operRight}">
                    <x:updateActionListener property="#{wage_unitBB.unit.unitId}" value="#{list.unitId}"/>
                </h:commandButton>
                 <h:commandButton id="btnAdd" styleClass="button01" action="#{wage_unitBB.addPerson}" value="加入人员"
                                 rendered="#{wage_unitBB.operRight}">
                    <x:updateActionListener property="#{wage_unitBB.unit.unitId}" value="#{list.unitId}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>

<c:verbatim>
    <script type="text/javascript">
        if (document.all('form1:pageInit').value == "refreshTreeadd") {
            parent.tree.location = '/pages/wage/unit/UnitTree.jsp?unitId=' + form1.all("form1:unitId").value;
        } else if (document.all('form1:pageInit').value == "refreshTreedel") {
            parent.tree.location = '/pages/wage/unit/UnitTree.jsp?unitId=' + form1.all("form1:superId").value;
        }
        setDataTableOver("form1:dateList");
    </script>
</c:verbatim>
