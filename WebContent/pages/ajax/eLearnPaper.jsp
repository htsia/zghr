<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.scorm.paperLibService" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.PaperLiBBO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.eLearnPaperBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    User user = (User) session.getAttribute(Constants.USER_INFO);

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    paperLibService rc = null;
    try {
        rc = (paperLibService) SysContext.getBean("eLearn_paperservice");
        list = rc.getAllUsePaper(user.getOrgId());
    }
    catch (Exception e) {

    }
    // ·µ»Ø½á¹û
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<Paper>");
            eLearnPaperBO o = (eLearnPaperBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getPaperID() + "</key>");
                out.println("<name>" + o.getName() + "</name>");
                out.println("<id>" + o.getPaperID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</Paper>");
        }
    }
    out.println("</tree>");
%>