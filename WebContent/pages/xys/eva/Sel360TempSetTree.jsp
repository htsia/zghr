<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXys360TempUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.Xys360TempSetBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String tempId = request.getParameter("tempId");                           // 上级
    System.out.println("tempId2="+tempId);
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    IXys360TempUCC rc=null;
    try {
        rc = (IXys360TempUCC) SysContext.getBean("xys360TempUCC");
        list = rc.getXys360TempSetBOByTempId(tempId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<itemKeySet>");

            Xys360TempSetBO o = (Xys360TempSetBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getSetId() + "</key>");
                out.println("<name>" + o.getSetName() + "</name>");
                out.println("<id>" + o.getSetId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKeySet>");
        }
    }
    out.println("</tree>");
%>