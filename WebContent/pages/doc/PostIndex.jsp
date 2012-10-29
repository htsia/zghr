<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO"%>
<%@ include file="../include/taglib.jsp" %>

<%
    String typeId = request.getParameter("typeId");
    String personId = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("postid"));
    String setId = request.getParameter("setId");
    
    if(setId == null || "".equals(setId))
		setId = (String)session.getAttribute("doc_C_setId");

	if(typeId == null || "".equals(typeId))
		typeId=(String)session.getAttribute("doc_C_typeId");

	if(null == setId)
		setId = "C001";

	session.setAttribute("doc_C_setId",setId);
    session.setAttribute("doc_C_typeId",typeId);
%>
   <c:verbatim><jsp:include page="PostInfoSet.jsp"/></c:verbatim>
   <%
    if(setId != null){
        InfoSetBO bo = SysCacheTool.findInfoSet(setId);
        if("C001".equals(setId)){
    %>
			<jsp:include page="PostNote.jsp"  />
	<%}else if(InfoSetBO.RS_TYPE_MANY.equals(bo.getSet_rsType())){
    %>
  	 <jsp:include page="PostInfoDetailList.jsp" >
	        <jsp:param name="setId" value="<%=setId%>"/>	<jsp:param name="flag" value="2"/>
	 </jsp:include>
	<%
        }else{
    %>
	 <jsp:include page="PostInfoDetail.jsp" >
    	 <jsp:param name="setId" value="<%=setId%>"/>	 <jsp:param name="flag" value="2"/>
	 </jsp:include>
	<%
        }
   }
%>

