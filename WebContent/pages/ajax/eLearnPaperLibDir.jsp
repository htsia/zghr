<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.scorm.questLibService" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.QuestionLiBBO" %>
<%@ page import="com.hr319wg.scorm.paperLibService" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.PaperLiBBO" %>

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
    paperLibService rc = null;
    try {
        rc = (paperLibService) SysContext.getBean("eLearn_paperservice");
        list = rc.getChildPaperLib(superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<PaperLib>");

            PaperLiBBO o = (PaperLiBBO) list.get(i);
            if (o != null) {
                try {
                    List li = rc.getChildPaperLib(o.getLibID());
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
            out.println("</PaperLib>");
        }
    }
    out.println("</tree>");
%>