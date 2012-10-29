<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function forView(form, id, type) {
        window.showModalDialog("/insurace/annuity/showDetail.jsf?PersonID=" + id, "", "dialogWidth:800px; dialogHeight:500px; center:center; status:0;resizable:yes");
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
    <h:inputHidden value="#{annu_queryBB.pageInit}"></h:inputHidden>
    <c:verbatim>
    <table align="center" height=100% width=95%>
        <tr><td height=8>
    </c:verbatim>
            <h:outputText value="选择月份"></h:outputText>
            <h:inputText readonly="true" value="#{annu_queryBB.month}" id="month"></h:inputText>
            <h:commandButton styleClass="button_date" type="button" onclick='changeDate();'></h:commandButton>
            <h:outputText value="      "></h:outputText>

            <h:outputText value="选择机构"></h:outputText>
            <h:inputText readonly="true"  id="orgID"></h:inputText>
            <h:inputHidden value="#{annu_queryBB.orgID}" id="orgName"></h:inputHidden>
            <h:commandButton styleClass="button_org" type="button" onclick='changeOrg();'></h:commandButton>
            <h:outputText value="      "></h:outputText>

            <h:outputText value="输入姓名或简拼"></h:outputText>
            <h:inputText value="#{annu_queryBB.name}"></h:inputText>
            <h:commandButton styleClass="button01" id="query" value="查询" action="#{annu_queryBB.doQuery}"></h:commandButton>
            <h:commandButton onclick="doExport();" value="导出" styleClass="button01"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
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