<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    String desktop="";
    if ("true".equals(request.getParameter("DeskTop"))){
        desktop="true";
    }
%>
<script type="text/javascript">
    function forView(id) {
        windowOpen("<%=Constants.LEAD_SHOW_PERSONURL%>?DeskTop=<%=desktop%>&fk="+id, "aa", "", "1000", "600", "auto","10","1","yes");
    }
</script>
<h:form>
     <h:inputHidden value="#{qry_querySettingBB.initShowResult}"/>
   <c:verbatim>
    <jsp:include page="/pages/common/activepage/PhotoList.jsp">
        <jsp:param name="init" value="true"/>
    </jsp:include>
    </c:verbatim>
</h:form>
