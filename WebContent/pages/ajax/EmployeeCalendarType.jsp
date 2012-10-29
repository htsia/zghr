<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.train.pojo.bo.CourceWareTypeBO" %>
<%@ page import="com.hr319wg.attence.ucc.IworkCalenderUCC" %>
<%@ page import="com.hr319wg.attence.ucc.IAttenceSetUCC" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.attence.pojo.vo.AttClassGroupVO" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    String superId = request.getParameter("superId");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String personID=user.getUserId();    
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    IAttenceSetUCC  rcss=null;
    IworkCalenderUCC rc=null;
    try {
    	rcss = (IAttenceSetUCC) SysContext.getBean("att_setUCC");
        rc = (IworkCalenderUCC) SysContext.getBean("att_workCalenderUCC");
        AttClassGroupVO vo=rcss.findAttClassGroupVObyId(personID);
        String orgid=vo.getPostId();
        list = rc.getEmployeeCalendar(orgid);
    }
    catch (Exception e) {

    }
    // ·µ»Ø½á¹û
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<EmployeeCalendarType>");

            PersonBO o = (PersonBO) list.get(i);
            if (o != null) {
                    childnum = "0";
                out.println("<key>" + o.getPersonId() + "</key>");
                out.println("<name>" + o.getName()+ "</name>");
                out.println("<id>" + o.getPersonId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</EmployeeCalendarType>");
        }
    }
    out.println("</tree>");
%>
