<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script language="javascript">
        function forCurrent(form){
            if (!checkMutilSelect(form.chk)) {
                alert("请选择!");
            } else {
                var chk = form.chk;
                var size = chk.length;
                if (size == null) {
                    if (chk.checked) {
                        form.pk.value = chk.value;
                    }
                } else {
                    for (var i = 0; i < size; i++) {
                        if (chk[i].checked) {
                            form.pk.value = chk[i].value;
                            break;
                        }
                    }
                }
                forsubmit(form);
                document.all("form1:current").click();
                return true;
            }
        }

        function forAdd() {
            document.all("form1:new").click();
        }
        function forEdit(form) {
            if (!checkMutilSelect(form.chk)) {
                alert("请选择!");
            } else {
                var chk = form.chk;
                var size = chk.length;
                if (size == null) {
                    if (chk.checked) {
                        form.pk.value = chk.value;
                    }
                } else {
                    for (var i = 0; i < size; i++) {
                        if (chk[i].checked) {
                            form.pk.value = chk[i].value;
                            break;
                        }
                    }
                }
                document.all("form1:mod").click();
            }
        }
        function forDel(form) {
            if (checkMutilSelect(form.chk)) {
                if (confirm("确认删除？")) {
                    document.all("form1:del").click();
                }
            } else {
                alert("请选择需要删除的记录！")
            }
        }
        function forExport(){
            window.open('/pages/common/ExportToExcel.jsp?sessionKey=DetailInfo')
        }
    </script>

<x:saveState value="#{wage_persMgrBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_persMgrBB.pageInit}"/>
    <h:commandButton action="#{wage_persMgrBB.createPersSetInfo}" style="display:none" id="new"/>
    <h:commandButton action="#{wage_persMgrBB.findPersSetInfo}" style="display:none" id="mod"/>
    <h:commandButton action="#{wage_persMgrBB.deletePersSetInfo}" style="display:none" id="del"/>
    <h:commandButton id="current" action="#{wage_persMgrBB.setCurrent}" style="display:none"/>
    <c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveDetailList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasFuncBnt" value="true"/>
        <jsp:param name="isScroll" value="true"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="tableId" value="DetailInfo"/>
    </jsp:include>
    </c:verbatim>
</h:form>
