<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.XysKpiObjLibBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String objId = request.getParameter("objId");                           // 上级
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    IXysKpiDeptUCC rc=null;
    try {
        rc = (IXysKpiDeptUCC) SysContext.getBean("xysKpiDeptUCC");
        list = rc.getXysKpiObjLibBOByObjId(objId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<itemKeySet>");

            XysKpiObjLibBO o = (XysKpiObjLibBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getObjLibId() + "</key>");
                out.println("<name>" + o.getObjLibName() + "</name>");
                out.println("<id>" + o.getObjLibId()+ "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKeySet>");
        }
    }
    out.println("</tree>");
%>