<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXysKpiKeyUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.XysKpiKeyLibBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String postId = request.getParameter("postId");                           // 上级
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    IXysKpiKeyUCC rc=null;
    try {
        rc = (IXysKpiKeyUCC) SysContext.getBean("xysKpiKeyUCC");
        list = rc.getXysKpiKeyLibBOByPostId(postId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<itemKeySet>");

            XysKpiKeyLibBO o = (XysKpiKeyLibBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getLibId() + "</key>");
                out.println("<name>" + o.getLibName() + "</name>");
                out.println("<id>" + o.getLibId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKeySet>");
        }
    }
    out.println("</tree>");
%>