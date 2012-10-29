<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.eva.ucc.IEvaKeyItemUCC" %>
<%@ page import="com.hr319wg.eva.pojo.bo.TemplateItemSetBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    IEvaKeyItemUCC rc = null;
    try {
        rc = (IEvaKeyItemUCC) SysContext.getBean("eva_keyitemucc");
        list = rc.getAllChildItemSet(superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<tempLateItemSet>");

            TemplateItemSetBO o = (TemplateItemSetBO) list.get(i);
            if (o != null) {
                try {
                    List li = rc.getAllChildItemSet(o.getSetID());
                    if (li != null && li.size() > 0) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }
                out.println("<key>" + o.getSetID() + "</key>");
                out.println("<name>" + o.getSetName() + "</name>");
                out.println("<id>" + o.getSetID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</tempLateItemSet>");
        }
    }
    out.println("</tree>");
%>