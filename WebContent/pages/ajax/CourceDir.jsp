<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.train.ucc.impl.CourceWareUCCImpl" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.train.pojo.bo.CourceWareTypeBO" %>
<%@ page import="com.hr319wg.train.ucc.IeLearnUCC" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    IeLearnUCC rc = (IeLearnUCC) SysContext.getBean("eLearn_learnucc");
    try {
        list = rc.getAllChildType(superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<courceDir>");

            CourceWareTypeBO o = (CourceWareTypeBO) list.get(i);
            if (o != null) {
                try {
                    if (rc != null && rc.haveTypeChild(o.getTypeID())) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }

                out.println("<key>" + o.getTypeID() + "</key>");
                out.println("<name>" + o.getTypeName() + "</name>");
                out.println("<id>" + o.getTypeID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</courceDir>");
        }
    }
    out.println("</tree>");
%>