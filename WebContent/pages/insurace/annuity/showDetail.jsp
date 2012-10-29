<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function forView(form, id, type) {
        alert(id);
    }
    function changeDate(){
        PopUpCalendarDlg_OnlyMonth("form1:month");
        document.all('form1:query').click();
    }
    function changeOrg(){
        fPopUpOrgDlg2('form1:orgName','form1:orgID',2)
        document.all('form1:query').click();
    }

</script>
<x:saveState value="#{annu_queryBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{annu_queryBB.showdetail}"></h:inputHidden>
    <c:verbatim>
    <table align="center" height=100% width=98%>
        <tr><td height=8 align="right">
    </c:verbatim>
            <h:outputText value="ÐÕÃû£º#{annu_queryBB.personName}"></h:outputText>
    <c:verbatim>
        </td></tr>

        <tr><td height=8 align="right">
    </c:verbatim>
            <h:commandButton onclick="doExport2();" value="µ¼³ö" styleClass="button01"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="true"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
            <jsp:param name="rowFuncName" value="forView"/>
            <jsp:param name="isRow" value="true"/>
            <jsp:param name="keyName" value="ID"/>
        </jsp:include>
        </td></tr>
    </table>
    </c:verbatim>
</h:form>