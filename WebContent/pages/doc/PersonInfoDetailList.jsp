<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script type="text/javascript">
        function forAdd(form, type) {
            form.flag.value = type;
            document.all("form1:addMany").click();
            return true;
        }
        function forEdit(form, type) {
            form.flag.value = type;
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
                document.all("form1:updateMany").click();
                return true;
            }
        }
        function forDel(form, type) {
            form.flag.value = type;
            if (checkMutilSelect(form.chk)) {
                if (confirm("确认删除？")) {
                    forsubmit(form);
                    document.all("form1:delMany").click();
                    return true;
                }
            } else {
                alert("请选择需要删除的记录！")
            }
            return false;
        }
        function forExport() {
            windowOpen("/pages/common/ExportToExcel.jsp?sessionKey=<%=Constants.OBJECT_DETAIL%>", "");
        }
    </script>

<x:saveState value="#{emp_personEditBB}"/>
<h:inputHidden value="#{emp_personEditBB.table}"/>
<h:form id="form1">
    <h:commandButton id="addMany" action="#{emp_personEditBB.addMany}" style="display:none"/>
    <h:commandButton id="updateMany" action="#{emp_personEditBB.updateMany}" style="display:none"/>
    <h:commandButton id="delMany" action="#{emp_personEditBB.delMany}" style="display:none"/>
    <c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveDetailList.jsp">
        <jsp:param name="hasOperSign" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="hasFuncBnt" value="false"/>
        <jsp:param name="showExcel" value="true"/>
    </jsp:include>
    </c:verbatim>
</h:form>
