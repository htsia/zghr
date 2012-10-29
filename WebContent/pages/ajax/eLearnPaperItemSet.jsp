<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.scorm.paperLibService" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.PaperItemSetBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // �ϼ�

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    paperLibService rc = null;
    try {
        rc = (paperLibService) SysContext.getBean("eLearn_paperservice");
        list = rc.getChildPaperItemSet(superId);
    }
    catch (Exception e) {

    }
    // ���ؽ��
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<PaperItemSet>");

            PaperItemSetBO o = (PaperItemSetBO) list.get(i);
            childnum = "0";
            out.println("<key>" + o.getSetID() + "</key>");
            out.println("<name>" + o.getSetName() + "[�ܷ֣�" + CommonFuns.filterNull(o.getTotalscore()) + " ��Ŀ����:" + CommonFuns.filterNull(o.getQuestioncount()) + "]</name>");
            out.println("<id>" + o.getSetID() + "</id>");
            out.println("<icon>" + icon + "</icon>");
            out.println("<childnum>" + childnum + "</childnum>");
            out.println("</PaperItemSet>");
        }
    }
    out.println("</tree>");
%>