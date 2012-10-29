<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.train.pojo.bo.CourceWareTypeBO" %>
<%@ page import="com.hr319wg.attence.ucc.IAttenceSetUCC" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassGroupBO" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    String superId = request.getParameter("superId");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String orgid = user.getOrgId();
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    IAttenceSetUCC rc=null;
    try {
        rc = (IAttenceSetUCC) SysContext.getBean("att_setUCC");
        list = rc.getAllAttClassGroupBOType(orgid);
    }
    catch (Exception e) {

    }
    // ·µ»Ø½á¹û
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<GroupType>");

            AttClassGroupBO o = (AttClassGroupBO) list.get(i);
            if (o != null) {
                    childnum = "0";
                out.println("<key>" + o.getGroupNo() + "</key>");
                out.println("<name>" + o.getGroupName()+ "</name>");
                out.println("<id>" + o.getGroupNo() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</GroupType>");
        }
    }
    out.println("</tree>");
%>
