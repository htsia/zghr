<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleTempDirBO" %>
<%@ page import="com.hr319wg.title.ucc.impl.TitleContentSetUCC" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId =(String)session.getAttribute("templateId");// 上级
    User user=(User)session.getAttribute(Constants.USER_INFO);
    String orgid=user.getOrgId();
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    TitleContentSetUCC rc = null;
    try {
        rc = (TitleContentSetUCC) SysContext.getBean("titleContentSetUcc");
        list = rc.getAllEmpTitleTempDirBO(superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<Powers>");

            EmpTitleTempDirBO o = (EmpTitleTempDirBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getDirId()+ "</key>");
                out.println("<name>" + o.getDirName() +"(总分："+o.getTotalScore()+")"+ "</name>");
                out.println("<id>" + o.getDirId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</Powers>");
        }
    }
    out.println("</tree>");
%>