<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<script type="text/javascript">
    function forsave(form) {
       document.all("form1:saveOne").click();
    }
    function forBack(form){
        window.close();
    }
</script>


<x:saveState value="#{emp_PersonCountBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_PersonCountBB.initModi}"/>
    <h:commandLink id="saveOne" action="#{emp_PersonCountBB.saveOne}" style="display:none"/>
    <c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveDetail.jsp">
        <jsp:param name="isEdit" value="true"/>
    </jsp:include>
    </c:verbatim>
</h:form>

