<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.lead.pojo.bo.LeadOrgBO" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");
    ArrayList list = SysCacheTool.querySubObject(SysCache.OBJ_LEADUNIT, null, superId);
    String filter = request.getParameter("filter");
    if (filter != null && !"".equals(filter)) {
        int flen = filter.length();
        for (int i = 0; i < list.size();) {
            LeadOrgBO unit = (LeadOrgBO) list.get(i);
            String treeId = unit.getTreeId();
            int len = treeId.length();
            if ((flen > len && treeId.startsWith(filter.substring(0, len)))
                    || (flen <= len && treeId.startsWith(filter))) {
                list.set(i, unit);
                i++;
            } else {
                list.remove(i);
            }
        }
    }
    LeadOrgBO org = SysCacheTool.findLeadUnit(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "database";
            out.println("<org>");
            LeadOrgBO o = (LeadOrgBO) list.get(i);
            if (o != null) {
                if (SysCache.wageUnitSubStrMap.containsKey(o.getUnitId())) {
                    childnum = "1";
                } else {
                    childnum = "0";
                    icon = "file";
                }
                out.println("<key>" + o.getTreeId() + "</key>");
                out.println("<name>" + o.getName() + "</name>");
                out.println("<id>" + o.getUnitId() + "</id>");
                out.println("<treeId>" + o.getTreeId() + "</treeId>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</org>");
        }
    }
    if (org != null) {
        out.println("<supertree>");
        out.println("<treeid>" + org.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }
    out.println("</tree>");
%>