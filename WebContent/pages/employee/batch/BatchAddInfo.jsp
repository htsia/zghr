<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forsave(form1){
            if(forsubmit(document.forms(0))){
                document.all("form1:save").click();
            }
        }
        function forBack(form1){
            parent.window.close();
        }
    </script>

    <h:form id="form1">
        <h:inputHidden value="#{emp_BatchPersonAddBB.pageInit}"/>
        <h:commandButton id="save" onclick="return true" action="#{emp_BatchPersonAddBB.saveAdd}" style="display:none"/>
        <c:verbatim><jsp:include page="ActiveBatchDetail.jsp" /></c:verbatim>
    </h:form>
