<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.scorm.DataManager" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.elearnUnitBO" %>

<%
    // 课程单元
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级
    String courseID = request.getParameter("courseID");

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    DataManager rc = null;
    try {
        rc = (DataManager) SysContext.getBean("eLearn_datamanager");
        list = rc.getChildUnit(courseID, superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<eLearnCourse>");

            elearnUnitBO o = (elearnUnitBO) list.get(i);
            if (o != null) {
                try {
                    if (rc.getChildUnit(courseID, o.getUnitID()).size()>0) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }

                out.println("<key>" + o.getUnitID() + "</key>");
                out.println("<name>" + o.getUnitName().replaceAll("&","&amp;") + "</name>");
                out.println("<id>" + o.getUnitID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</eLearnCourse>");
        }
    }
    out.println("</tree>");
%>