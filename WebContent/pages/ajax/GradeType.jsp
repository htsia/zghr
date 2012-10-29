<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.train.pojo.bo.CourceWareTypeBO" %>
<%@ page import="com.hr319wg.eva.ucc.impl.EvaGradeUCC" %>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaGradeBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    try {
        EvaGradeUCC rc = (EvaGradeUCC) SysContext.getBean("eva_gradeUCC");
        list = rc.getAllGrade();
    }
    catch (Exception e) {

    }
    // ·µ»Ø½á¹û
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<GradeType>");

            EvaGradeBO o = (EvaGradeBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getGradeID() + "</key>");
                out.println("<name>" + o.getGradeName() + "</name>");
                out.println("<id>" + o.getGradeID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</GradeType>");
        }
    }
    out.println("</tree>");
%>