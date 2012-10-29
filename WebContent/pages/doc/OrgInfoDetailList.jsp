<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String type = CommonFuns.filterNull(request.getParameter("type"));
    String isEdit = "true";
    if ("1".equals(type)) {
        isEdit = "false";
    }
%>
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


<h:form id="form1">
    <h:inputHidden value="#{org_orgEditBB.table}"/>
    <h:commandButton id="addMany" action="#{org_orgEditBB.addMany}" style="display:none"/>
    <h:commandButton id="updateMany" action="#{org_orgEditBB.updateMany}" style="display:none"/>
    <h:commandButton id="delMany" action="#{org_orgEditBB.delMany}" style="display:none"/>
    <c:verbatim>
    <table height=95% width=98% align="center">
     <tr><td valign="top">
        <jsp:include page="/pages/common/activepage/ActiveDetailList.jsp">
            <jsp:param name="hasOperSign" value="false"/>
            <jsp:param name="isCheckRight" value="true"/>
            <jsp:param name="hasFuncBnt" value="false"/>
            <jsp:param name="showExcel" value="true"/>
        </jsp:include>
     </td></tr>
     </table>
        
    </c:verbatim>
</h:form>
