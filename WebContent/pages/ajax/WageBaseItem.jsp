<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="java.util.ArrayList" %>
<%
    //  取得薪资中可以关联修改的项目
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String setId = request.getParameter("setId");
    ArrayList list=null;
    String setName = "";
    list = SysCacheTool.queryInfoItemBySetId(setId);
    setName = SysCacheTool.findInfoSet(setId).getSetName();

    String icon = "";
    String childnum = "0";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null&&list.size()>0) {
        int size=list.size();
        for (int i = 0; i < size; i++) {
            icon = "book_open";
            InfoItemBO item = (InfoItemBO) list.get(i);
            if (   "1".equals(item.getModiInWage())
                    && InfoItemBO.STATUS_OPEN.equals(item.getItemStatus())) {
                out.println("<item>");
                out.println("<itemId>" +item.getItemId() + "</itemId>");
                out.println("<name>" + item.getItemName() + "</name>");
                out.println("<setId>" + item.getSetId() + "</setId>");
                out.println("<setName>" + setName+"</setName>");
                out.println("<datatype>" + item.getItemDataType() + "</datatype>");
                out.println("<codeSetId>" + item.getItemCodeSet() + "</codeSetId>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
                out.println("</item>");
            }
        }
    }

    out.println("<supertree>");
    out.println("<setid>" + setId + "</setid>");
    out.println("</supertree>");
    out.println("</tree>");
%>