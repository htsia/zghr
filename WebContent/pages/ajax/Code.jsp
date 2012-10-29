<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");
    String setId = request.getParameter("setId");
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    ArrayList list = null;
    if("".equals(rootId)){
      list = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, setId, superId);
    }else{
         String[] ids = rootId.split(",");
        if(ids != null && ids.length >0){
            list = new ArrayList();
            for(int i=0;i<ids.length;i++){
                CodeItemBO o =SysCacheTool.findCodeItem(setId,ids[i]);
                if(o != null)
                    list.add(o);
            }
        }
    }
    CodeItemBO code = SysCacheTool.findCodeItem(setId, superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "database";
            CodeItemBO o = (CodeItemBO) list.get(i);
            if ("0".equals(o.getItemStatus())) continue;  // ½ûÓÃ
            out.println("<code>");
            if (o != null) {
                ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, setId, o.getItemId());
                if (list1 != null && list1.size() > 0) {
                    childnum = "1";
                } else {
                    childnum = "0";
                    icon = "file";
                }
                out.println("<key>" + o.getTreeId() + "</key>");
                out.println("<name>" + o.getItemName() + "</name>");
                out.println("<id>" + o.getItemId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</code>");
        }
    }

    if (code != null) {
        out.println("<supertree>");
        out.println("<treeid>" + code.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }

    out.println("</tree>");
%>