<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

    String typeId = request.getParameter("typeId");
    String personId = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("fk"));
    String setId = request.getParameter("setId");

    if (typeId == null || "".equals(typeId)){
        typeId = (String) session.getAttribute("doc_B_typeId");
        setId = (String) session.getAttribute("doc_B_setId");
    }
    session.setAttribute("doc_B_setId", setId);
    session.setAttribute("doc_B_typeId", typeId);
    session.setAttribute("doc_B_personId", personId);
%>
 <c:verbatim><jsp:include page="OrgInfoSet.jsp"/></c:verbatim>
<%
    setId=(String)session.getAttribute("doc_B_setId");
    if (setId != null) {
        InfoSetBO bo = SysCacheTool.findInfoSet(setId);
        if ("B001".equals(setId)) {
%>
    <jsp:include page="OrgBasicInfo.jsp"/>
<%
        } else if (InfoSetBO.RS_TYPE_MANY.equals(bo.getSet_rsType())) {
%>
            <jsp:include page="OrgInfoDetailList.jsp">
                <jsp:param name="setId" value="<%=setId%>"/>
                <jsp:param name="flag" value="2"/>
            </jsp:include>
<%
         } else {
%>
    <jsp:include page="OrgInfoDetail.jsp">
        <jsp:param name="setId" value="<%=setId%>"/>
        <jsp:param name="flag" value="2"/>
    </jsp:include>
<%
        }
   }
%>
