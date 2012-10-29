<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.api.ActivePageAPI"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user == null) {
        response.sendRedirect("/pages/overtime.htm");
    } 
    ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
    String sql = "select orguid from b001 where b001002=-1"; 
    String orguid = api.queryForString(sql);    
    out.print("<script>location.href='/insurace/RateSetList.jsf?superId="+orguid+"'</script>");
%>


