<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.scorm.questLibService" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.QuestionLiBBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    questLibService rc = null;
    try {
        rc = (questLibService) SysContext.getBean("eLearn_libservice");
        list = rc.getChildLib(superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<QuestionLib>");

            QuestionLiBBO o = (QuestionLiBBO) list.get(i);
            if (o != null) {
                try {
                    List li = rc.getChildLib(o.getLibID());
                    if (li != null && li.size() > 0) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }
                out.println("<key>" + o.getLibID() + "</key>");
                out.println("<name>" + o.getLibName() + "</name>");
                out.println("<id>" + o.getLibID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</QuestionLib>");
        }
    }
    out.println("</tree>");
%>