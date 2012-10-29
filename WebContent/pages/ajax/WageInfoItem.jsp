<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="java.util.ArrayList" %>
<%
    //  ȡ��н����Ŀ
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String setId = request.getParameter("setId");
    ArrayList list=null;
    String setName = "";
    if (setId.equals("A815PREV")) {
       list = SysCacheTool.queryInfoItemBySetId("A815");
       setName = SysCacheTool.findInfoSet("A815").getSetName()+"(��������)";
    }
    else if(setId.equals("A815")) {
        list = SysCacheTool.queryInfoItemBySetId(setId);

        // ͬʱ���Ӳ���н����Ϣ
        ArrayList list2=SysCacheTool.queryInfoItemBySetId("B732");
        for(int i=0;i<list2.size();i++){
            list.add(list2.get(i));
        }
        // ͬʱ���ӻ���н����Ϣ
        list2=SysCacheTool.queryInfoItemBySetId("B026");
        for(int i=0;i<list2.size();i++){
            list.add(list2.get(i));
        }
        // ͬʱ���Ӹ�λн����Ϣ
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
        // ����������
        SysCacheTool.sortInfoItemByName(list);
        int size=list.size();
        for (int i = 0; i < size; i++) {
            icon = "file";
            InfoItemBO item = (InfoItemBO) list.get(i);
            if (!"1".equals(item.getItemStatus())){  // ����
                continue;
            }
            // ���˵��ַ��ֶ�
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
                    ) {   // �����Ƿ�ǰ��¼
            	
                out.println("<item>");
                    
                if (setId.equals("A815PREV")) {
                    out.println("<itemId>" +item.getItemId() + "PREV</itemId>");
                }
                else{
                    out.println("<itemId>" +item.getItemId() + "</itemId>");
                }

                if (item.getSetId().equals("B732")){ // A815���ܹҽ�B732
                    out.println("<name>н�ʲ�����Ϣ-" + item.getItemName() + "</name>");
                }
                else if (item.getSetId().equals("B026")){ // A815���ܹҽ�B026
                    out.println("<name>������Ϣ-" + item.getItemName() + "</name>");
                }
                else if (item.getSetId().equals("C018")){ // A815���ܹҽ�C018
                    out.println("<name>��λ��Ϣ-" + item.getItemName() + "</name>");
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

                if (item.getSetId().equals("B732")){ // A815���ܹҽ�B732
                    out.println("<setName>" +"����н�ʷ�����Ϣ�Ӽ�" +"</setName>");
                }
                else if (item.getSetId().equals("B026")){ // A815���ܹҽ�B026
                    out.println("<setName>" +"����н�ʷ�����Ϣ�Ӽ�" +"</setName>");
                }
                else if (item.getSetId().equals("C018")){ // A815���ܹҽ�C018
                    out.println("<setName>" +"��λн����Ϣ�Ӽ�" +"</setName>");
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