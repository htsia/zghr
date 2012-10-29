<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String type = CommonFuns.filterNull(request.getParameter("type"));
    String isEdit = "true";
    if("1".equals(type)){
         isEdit = "false";
    }
    String isCheckRight=CommonFuns.filterNull(request.getParameter("isCheckRight"));
    if ("".equals(isCheckRight)){
        isCheckRight="true";
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
            exportToExcel('<%=Constants.OBJECT_DETAIL%>');
        }
        function forCurrent(form){
            if (!checkMutilSelect(form.chk)) {
                alert("请选择!");
            } else {
                var chk = form.chk;
                var size = chk.length;
                if (size == null) {
                    if (chk.checked) {
                        form.curID.value = chk.value;
                    }
                } else {
                    for (var i = 0; i < size; i++) {
                        if (chk[i].checked) {
                            form.curID.value = chk[i].value;
                            break;
                        }
                    }
                }
                forsubmit(form);
                document.all("form1:current").click();
                return true;
            }
        }
   </script>

    <x:saveState value="#{emp_personEditBB}" />
    <h:form id="form1">
        <c:verbatim>
        <input type="hidden" name="isCheckRight" value="<%=isCheckRight%>">
        </c:verbatim>
        <h:inputHidden value="#{emp_personEditBB.table}"/>
        <h:commandButton id="addMany" action="#{emp_personEditBB.addMany}" style="display:none"/>
        <h:commandButton id="updateMany" action="#{emp_personEditBB.updateMany}" style="display:none"/>
        <h:commandButton id="delMany" action="#{emp_personEditBB.delMany}" style="display:none"/>
        <h:commandButton id="current" action="#{emp_personEditBB.setCurrent}" style="display:none"/>
<c:verbatim>
        <jsp:include page="../../common/activepage/ActiveDetailList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="isCheckRight" value="<%=isCheckRight%>"/>
            <jsp:param name="isScroll" value="true"/>
            <jsp:param name="hasFuncBnt" value="<%=isEdit%>"/>
        </jsp:include>
</c:verbatim>
    </h:form>
