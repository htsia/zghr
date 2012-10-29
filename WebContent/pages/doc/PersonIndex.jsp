<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ include file="../include/taglib.jsp" %>
    
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

    String personId = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("fk"));
    String setId = request.getParameter("setId");
    String typeId = request.getParameter("typeId");

    if ((typeId == null || "".equals(typeId)) ) {
        typeId = (String) session.getAttribute("doc_A_typeId");
        setId = (String) session.getAttribute("doc_A_setId");
    }

    session.setAttribute("doc_A_setId", setId);
    session.setAttribute("doc_A_typeId", typeId);
    session.setAttribute("doc_A_personId", personId);
%>
<c:verbatim>
<table width="98%" align="center" height="98%">
<tr><td height=8>
 <jsp:include page="PersonInfoSet.jsp"/>
</td></tr>

<tr><td>
</c:verbatim>
<%
    setId=(String)session.getAttribute("doc_A_setId");
    if (setId != null) {
        InfoSetBO bo = SysCacheTool.findInfoSet(setId);
        if ("A001".equals(setId)) {
%>
    <c:verbatim><jsp:include page="PersonBasicInfo.jsp"/></c:verbatim>
<%
    }else if (InfoSetBO.RS_TYPE_MANY.equals(bo.getSet_rsType())) {
%>
<c:verbatim>
<jsp:include page="PersonInfoDetailList.jsp">
    <jsp:param name="setId" value="<%=setId%>"/>
    <jsp:param name="flag" value="2"/>
</jsp:include>
</c:verbatim>
<%
} else {
%>
<c:verbatim>
<jsp:include page="PersonInfoDetail.jsp">
    <jsp:param name="setId" value="<%=setId%>"/>
    <jsp:param name="flag" value="2"/>
</jsp:include>
</c:verbatim>
<%
        }
    }
%>
<c:verbatim>
</td></tr>
</table>
</c:verbatim>