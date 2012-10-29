<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.train.ucc.impl.eLearnUCCImpl" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.eLearnDirBO" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.elearnCourseBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    List courseList = null;
    eLearnUCCImpl rc = null;
    try {
        rc = (eLearnUCCImpl) SysContext.getBean("eLearn_learnucc");
        list = rc.getAllChildType(superId);
        courseList = rc.getCourceList(superId);
    }
    catch (Exception e) {

    }

    // 返回目录结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<eLearnDirAndCourse>");

            eLearnDirBO o = (eLearnDirBO) list.get(i);
            if (o != null) {
                childnum = "0";
                try {
                    if (rc.haveTypeChild(o.getTypeID())) {
                        childnum = "1";
                    }
                    if (rc.getCourceList(o.getTypeID()).size()>0){
                         childnum = "1";
                    }
                }
                catch (Exception e) {

                }

                out.println("<key>" + o.getTypeID() + "</key>");
                out.println("<name>" + o.getTypeName() + "</name>");
                out.println("<id>" + o.getTypeID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</eLearnDirAndCourse>");
        }
    }
    // 课程
    if (courseList != null) {
        for (int i = 0; i < courseList.size(); i++) {
            icon = "dept";
            out.println("<eLearnDirAndCourse>");

            elearnCourseBO o = (elearnCourseBO) courseList.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getCourseID() + "</key>");
                out.println("<name>" + o.getCourseName() + "</name>");
                out.println("<id>" + o.getCourseID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</eLearnDirAndCourse>");
        }
    }

    out.println("</tree>");
%>