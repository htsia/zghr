<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forClearZero() {
            var field = form1.all('form1:inputField');
            if (checkMutilSelect(field)) {
                if (confirm("ȷ��������ݣ�")) {
                    return true;
                }else{
                    return false;
                }
            } else {
                alert("��ѡ�������");
                return false
            }
        }
    </script>

<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setInputBB.pageInit}"/>
    <h:panelGrid columns="2" width="90%" styleClass="table03" align="center" columnClasses="td_top,td_top">
        <h:outputText value="��н��λ:#{wage_setInputBB.unitName}"/>
        <h:outputText value="��������:#{wage_setInputBB.setName}"/>
        <h:outputText value="ѡ����Ҫ��յ������"/>
        <h:selectManyCheckbox value="#{wage_setInputBB.inputField}" layout="pageDirection" id="inputField">
            <c:selectItems value="#{wage_setInputBB.inputList}"/>
        </h:selectManyCheckbox>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="2" cellspacing="2" align="right">
        <h:commandButton styleClass="button01" value="�������"
                         action="#{wage_setInputBB.clearZero}" onclick="return forClearZero();"/>
        <h:commandButton styleClass="button01" value="ȡ��" type="button"
                         onclick="window.close()"/>
    </h:panelGrid>
</h:form>
