<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function queryPersonNotInSet(){
            var unitId = form1.all("form1:unitId").value;
            var arg = "&unitId=" + unitId;
            window.open("/wage/set/PersonNotInSetQuery.jsf?act=qryPersNotInSet&" + arg, "��ѯδ����������Ա", "left=10,top=50,height=600,width=1000,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
        }
        function confirmDel() {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm('ȷ��Ҫɾ����������ɾ�����������׵Ĺ�ʽ���Ա������н���'))
                    return true;
            }
            return false;
        }
        function doOpenInputPower(setId){
            window.showModalDialog("/attence/SetInputPower.jsf?setID=" + setId, "", "dialogWidth:500px; dialogHeight:400px; status:0;");
            return false;
        }

    </script>
</head>

<body>
<x:saveState value="#{wage_setBB}"/>
<x:saveState value="#{wage_setItemBB}"/>
<x:saveState value="#{wage_setPersonBB}"/>
<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{wage_setBB.pageInit}"/>
    <h:inputHidden id="unitId" value="#{wage_setBB.wageset.unitId}"/>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid align="center" columns="2" width="100%">
            <h:outputText value="��н��λ��#{wage_setBB.unitName}"/>
        </h:panelGrid>

        <h:dataTable value="#{wage_setBB.setlist}" var="list"
                     headerClass="td_top"  width="100%"
                     styleClass="table03"  columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle_center,td_middle_center">
            <h:column rendered="#{wage_setBB.operRight}">
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll"
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>ȫѡ
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem"
                    value="</c:verbatim><h:outputText value="#{list.setId}"/><c:verbatim>">
            </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���ױ��"/></c:facet>
                <h:outputText value="#{list.setId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��������"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:panelGrid align="center" columns="1" cellspacing="2">
                    <h:panelGroup>
                        <h:commandButton  styleClass="button01" value="����Ȩ������" rendered="#{wage_setBB.canModifyDepPower}" onclick="return doOpenInputPower('#{list.setId}');" />
                    </h:panelGroup>
                    <h:outputText value="û��Ȩ��" rendered="#{!wage_setBB.operRight}"/>
                </h:panelGrid>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
</body>
</html>