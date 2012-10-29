<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleApplyItemScoreBO" %>
<%@ page import="com.hr319wg.title.ucc.impl.EmpTitleApplyUcc" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String itemId =(String)session.getAttribute("itemId");// 上级
    User user=(User)session.getAttribute(Constants.USER_INFO);
    String orgid=user.getOrgId();
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    EmpTitleApplyUcc rc = null;
    try {
        rc = (EmpTitleApplyUcc) SysContext.getBean("empTitleApplayUcc");
        list = rc.getAllEmpTitleApplyItemScoreBOByItemId(itemId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<Powers>");

            EmpTitleApplyItemScoreBO o = (EmpTitleApplyItemScoreBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getScoreId()+ "</key>");
                out.println("<name>" + o.getItemName()+"</name>");
                out.println("<id>" + o.getScoreId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</Powers>");
        }
    }
    out.println("</tree>");
%>