<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXys360TempUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.Xys360TempLibBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    IXys360TempUCC rc=null;
    try {
        rc = (IXys360TempUCC) SysContext.getBean("xys360TempUCC");
        list = rc.getXys360TempLibBO(superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<itemKeySet>");

            Xys360TempLibBO o = (Xys360TempLibBO) list.get(i);
            if (o != null) {
                try {
                    List li=rc.getXys360TempLibBO(o.getTempLibId());
                    if (li != null && li.size()>0) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }
                out.println("<key>" + o.getTempLibId() + "</key>");
                out.println("<name>" + o.getTempLibName() + "</name>");
                out.println("<id>" + o.getTempLibId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKeySet>");
        }
    }
    out.println("</tree>");
%>