<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="java.util.ArrayList" %>
<%
    //  取得薪资项目
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String setId = request.getParameter("setId");
    ArrayList list=null;
    String setName = "";
    if (setId.equals("A815PREV")) {
       list = SysCacheTool.queryInfoItemBySetId("A815");
       setName = SysCacheTool.findInfoSet("A815").getSetName()+"(上月数据)";
    }
    else if(setId.equals("A815")) {
        list = SysCacheTool.queryInfoItemBySetId(setId);

        // 同时附加部门薪资信息
        ArrayList list2=SysCacheTool.queryInfoItemBySetId("B732");
        for(int i=0;i<list2.size();i++){
            list.add(list2.get(i));
        }
        // 同时附加机构薪资信息
        list2=SysCacheTool.queryInfoItemBySetId("B026");
        for(int i=0;i<list2.size();i++){
            list.add(list2.get(i));
        }
        // 同时附加岗位薪资信息
        list2=SysCacheTool.queryInfoItemBySetId("C018");
        for(int i=0;i<list2.size();i++){
            list.add(list2.get(i));
        }

        setName = SysCacheTool.findInfoSet(setId).getSetName();
    }
    else {
        list = SysCacheTool.queryInfoItemBySetId(setId);
        setName = SysCacheTool.findInfoSet(setId).getSetName();
    }

    String icon = "";
    String childnum = "0";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");

    if (list != null&&list.size()>0) {
        // 按名称排序
        SysCacheTool.sortInfoItemByName(list);
        int size=list.size();
        for (int i = 0; i < size; i++) {
            icon = "file";
            InfoItemBO item = (InfoItemBO) list.get(i);
            if (!"1".equals(item.getItemStatus())){  // 禁用
                continue;
            }
            // 过滤掉字符字段
            if ((InfoItemBO.DATA_TYPE_COMPUTE.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_INT.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_CODE.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_WAGEDEPT.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_DATE.equals(item.getItemDataType())
                    || InfoItemBO.DATA_TYPE_DATE6.equals(item.getItemDataType()))
                    && InfoItemBO.STATUS_OPEN.equals(item.getItemStatus())
                    && !item.getItemId().equals(item.getSetId()+"000")
                    && !"ID".equals(item.getItemId())
                    && !"SUBID".equals(item.getItemId())
                    ) {   // 过滤是否当前记录
            	
                out.println("<item>");
                    
                if (setId.equals("A815PREV")) {
                    out.println("<itemId>" +item.getItemId() + "PREV</itemId>");
                }
                else{
                    out.println("<itemId>" +item.getItemId() + "</itemId>");
                }

                if (item.getSetId().equals("B732")){ // A815可能挂接B732
                    out.println("<name>薪资部门信息-" + item.getItemName() + "</name>");
                }
                else if (item.getSetId().equals("B026")){ // A815可能挂接B026
                    out.println("<name>机构信息-" + item.getItemName() + "</name>");
                }
                else if (item.getSetId().equals("C018")){ // A815可能挂接C018
                    out.println("<name>岗位信息-" + item.getItemName() + "</name>");
                }
                else{
                    out.println("<name>" + item.getItemName() + "</name>");
                }

                if (setId.equals("A815PREV")) {
                   out.println("<setId>" + setId + "</setId>");
                }
                else{
                   out.println("<setId>" + item.getSetId() + "</setId>");
                }

                if (item.getSetId().equals("B732")){ // A815可能挂接B732
                    out.println("<setName>" +"部门薪资发放信息子集" +"</setName>");
                }
                else if (item.getSetId().equals("B026")){ // A815可能挂接B026
                    out.println("<setName>" +"机构薪资发放信息子集" +"</setName>");
                }
                else if (item.getSetId().equals("C018")){ // A815可能挂接C018
                    out.println("<setName>" +"岗位薪酬信息子集" +"</setName>");
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