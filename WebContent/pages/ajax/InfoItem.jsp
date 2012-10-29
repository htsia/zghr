<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.WageAPI" %>
<%@ page import="com.hr319wg.wage.ucc.IWageSetItemUCC" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageSetItemBO" %>
<%@ page import="com.hr319wg.sys.ucc.IInfoItemUCC" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
%>
<%
    String onlyWageItem = request.getParameter("onlyWageItem");   // ture a815仅仅显示本帐套项目
    String setId = request.getParameter("setId");
    String rightFlag = request.getParameter("rightFlag");
    String orderByName = request.getParameter("orderByName");
    List list = new ArrayList();

    if ("A815".equals(setId) && "true".equals(onlyWageItem)) {
        WageAPI api = (WageAPI) SysContext.getBean("wage_api");
        User user = (User) session.getAttribute(Constants.USER_INFO);
        String wageset = api.querySetByPersonID(user.getUserId());
        IWageSetItemUCC itemucc = (IWageSetItemUCC) SysContext.getBean("wage_SetItemUccImpl");
        List itemlist = null;
        if (wageset!=null && !"".equals(wageset)){
            if ("true".equals(orderByName)) {
                itemlist = itemucc.queryItemBySetIdOrderByName(wageset);
            } else {
                itemlist = itemucc.queryItemBySetId(wageset);
            }

            for (int i = 0; i < itemlist.size(); i++) {
                WageSetItemBO ibo = (WageSetItemBO) itemlist.get(i);
                list.add(SysCacheTool.findInfoItem("", ibo.getField()));
            }
        }
        else{
            list=SysCacheTool.queryInfoItemBySetId("A815");
        }
    } else {
        if ("true".equals(orderByName)) {
            try{
                IInfoItemUCC ucc=(IInfoItemUCC) SysContext.getBean("sys_infoItemUccImpl");
                InfoItemBO []ibs=ucc.queryInfoItems(setId,"p.itemName");
                for(int i=0;i<ibs.length;i++){
                   list.add(ibs[i]);
                }
            }
            catch(Exception e){

            }
        } else {
            list = SysCacheTool.queryInfoItemBySetId(setId);
        }

        if ("Y".equalsIgnoreCase(rightFlag)) {
            try {
                UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
                list = api.queryUserInfoItems((User) session.getAttribute(Constants.USER_INFO), list, CellVO.PERMISSION_READ);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    String icon = "";
    String childnum = "0";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "file";
            InfoItemBO o = (InfoItemBO) list.get(i);
            if ((!InfoItemBO.STATUS_OPEN.equals(o.getItemStatus())) && (!"B001003".equals(o.getItemId()))) continue;
            out.println("<item>");
            out.println("<key>" + o.getItemId() + "</key>");
            out.println("<name>" + o.getItemName() + "</name>");
            out.println("<id>" + o.getItemId() + "</id>");
            out.println("<datatype>" + o.getItemDataType() + "</datatype>");
            out.println("<property>" + o.getItemProperty() + "</property>");
            out.println("<code>" + o.getItemCodeSet() + "</code>");
            out.println("<icon>" + icon + "</icon>");
            out.println("<childnum>" + childnum + "</childnum>");
            out.println("</item>");
        }

    }

    out.println("<supertree>");
    out.println("<setid>" + setId + "</setid>");
    out.println("</supertree>");
    out.println("</tree>");

%>
<%!
    public List parseSpecItem(List list) {
        //System.out.println(((InfoItemBO)list.get(0)).getSetId());
        if (list != null && list.size() >= 1) {
            InfoItemBO bo = (InfoItemBO) list.get(0);
            if (bo != null) {
                if ("A001".equals(bo.getSetId())) {
                    list.add(SysCacheTool.findInfoItem("A001", "A001730"));
                    list.add(SysCacheTool.findInfoItem("A001", "A001753"));
                } else if ("B001".equals(bo.getSetId())) {
                    list.add(SysCacheTool.findInfoItem("B001", "B001730"));
                } else if ("C001".equals(bo.getSetId())) {
                    list.add(SysCacheTool.findInfoItem("C001", "C001730"));
                }
            }
        }
        return list;
    }
%>