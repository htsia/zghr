<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="java.util.ArrayList" %>
<%
    //  取得二维分析项目
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
            icon = "file";
            InfoItemBO item = (InfoItemBO) list.get(i);
            // 过滤掉字符字段
            if (    InfoItemBO.DATA_TYPE_INT.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_CODE.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())
                    && InfoItemBO.STATUS_OPEN.equals(item.getItemStatus())
                    && !item.getItemId().equals(item.getSetId()+"000")) {   // 过滤是否当前记录
                out.println("<item>");

                out.println("<itemId>" +item.getItemId() + "</itemId>");
                out.println("<name>" + item.getItemName() + "</name>");

                out.println("<setId>" + item.getSetId() + "</setId>");

                if (item.getSetId().equals("B732")){ // A815可能挂接B732
                    out.println("<setName>" +"部门薪资发放信息子集" +"</setName>");
                }
                else {
                   out.println("<setName>" + setName+"</setName>");
                }
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