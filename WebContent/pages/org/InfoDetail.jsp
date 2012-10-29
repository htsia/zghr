<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires","Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
  <head><title> </title></head>
  <body>
  <c:view>
     <h:form id="form1">
         <h:inputHidden />
       <jsp:include page="/pages/common/activepage/ActiveDetail.jsp" >
        <jsp:param name="isEdit" value="true" />
       </jsp:include>
     </h:form>
  </c:view>
  </body>
</html>