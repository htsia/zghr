<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXys360KeyUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.Xys360KeyLibBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    IXys360KeyUCC rc=null;
    try {
        rc = (IXys360KeyUCC) SysContext.getBean("xys360KeyUCC");
        list = rc.getXys360KeyLibBO(superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<itemKeySet>");

            Xys360KeyLibBO o = (Xys360KeyLibBO) list.get(i);
            if (o != null) {
                try {
                    List li=rc.getXys360KeyLibBO(o.getLibId());
                    if (li != null && li.size()>0) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }
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