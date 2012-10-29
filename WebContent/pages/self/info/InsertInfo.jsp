<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String flag = (String) request.getAttribute("flag");
    String setId = CommonFuns.filterNull(request.getParameter("setId"));
    String fk = CommonFuns.filterNull(request.getParameter("fk"));
    String pk = CommonFuns.filterNull(request.getParameter("pk"));
    String type = CommonFuns.filterNull(request.getParameter("type"));
    String isEdit = "true";
    if("1".equals(type)){
         isEdit = "false";
    }
%>
<script type="text/javascript">
    function forsave(form) {
        if (forsubmit(form)){
            document.all("form1:saveOne").click();
            return true;
        }
        else{
            return false;
        }
    }

    function forBack() {
        window.close();
        return true;
    }
</script>

<x:saveState value="#{self_personEditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{self_personEditBB.beginInsert}"/>
    <h:commandButton id="saveOne" style="display:none" action="#{self_personEditBB.SaveInsert}"></h:commandButton>
    <br><strong>注意：插入的数据经审批后才能入库，可以点击“查看修改数据“按钮查看数据状态</strong><br>
    <c:verbatim>
        <jsp:include page="InsertInfoInput.jsp">
            <jsp:param name="isEdit" value="<%=isEdit%>"/>
        </jsp:include>
    </c:verbatim>
</h:form>
