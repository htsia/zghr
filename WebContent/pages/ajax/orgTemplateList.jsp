<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgTemplateBO" %>
<%@ page import="com.hr319wg.org.ucc.impl.OrgTemplateUCC" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");// 上级
    User user=(User)session.getAttribute(Constants.USER_INFO);
    String orgid=user.getOrgId();
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    OrgTemplateUCC rc = null;
    try {
        rc = (OrgTemplateUCC) SysContext.getBean("orgtemplateucc");
        list = rc.getAllOrgTemplateBO();
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<template>");

            OrgTemplateBO o = (OrgTemplateBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getTemplateId()+ "</key>");
                out.println("<name>" + o.getTemplateName() + "</name>");
                out.println("<id>" + o.getTemplateId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</template>");
        }
    }
    out.println("</tree>");
%>