<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.train.pojo.bo.CourceWareTypeBO" %>
<%@ page import="com.hr319wg.rpt.ucc.IRptInfoUCC" %>
<%@ page import="com.hr319wg.rpt.pojo.bo.RptClassBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");       
    System.out.println(superId);
    // 上级
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    IRptInfoUCC rc=null;
    try {
        rc = (IRptInfoUCC) SysContext.getBean("rpt_infoucc");
        list = rc.getRptClassBOSS(superId);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<itemKeySet>");
            RptClassBO o = (RptClassBO) list.get(i);
            if (o != null) {
                try {
                    List li=rc.getRptClassBOSS(o.getRptcode());
                    if (li != null && li.size()>0) {
                        childnum = "1";
                    } else {
                        childnum = "0";                                 
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }
                out.println("<key>" + o.getRptcode() + "</key>");
                out.println("<name>" + o.getRptDesc() + "</name>");
                out.println("<id>" + o.getRptcode() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKeySet>");
        }
    }
    out.println("</tree>");
%>