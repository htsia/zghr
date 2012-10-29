<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.train.pojo.bo.CourceWareTypeBO" %>
<%@ page import="com.hr319wg.attence.ucc.IAttenceSetUCC" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassBO" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    String superId = request.getParameter("superId");                           // 上级
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
        list = rc.getAllAttClassBOType(orgid);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
    	AttClassBO o1=new AttClassBO();
    	o1.setClassID("1");
    	o1.setClassName("休息");
    	list.add(o1);
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<GroupType>");

            AttClassBO o = (AttClassBO) list.get(i);
            
            if (o != null) {
                    childnum = "0";
                out.println("<key>" + o.getClassID() + "</key>");
                out.println("<name>" + o.getClassName()+ "</name>");
                out.println("<id>" + o.getClassID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</GroupType>");
        }
    }
    out.println("</tree>");
%>
