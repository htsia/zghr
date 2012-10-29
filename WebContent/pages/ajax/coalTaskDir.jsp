<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.coalsafe.pojo.bo.CoalAmerceStandardDirBO" %>
<%@ page import="com.hr319wg.coalsafe.ucc.impl.CoalSafeMgrUcc" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                          // 上级

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    CoalSafeMgrUcc rc=null;
    try {
        rc = (CoalSafeMgrUcc) SysContext.getBean("coalsafeMgrUcc");
        
        if(superId!=null&&!superId.equals("")){
        	list = rc.getAllCoalAmerceStandardDirBOBySuperId(superId);
        }else{
        	list = rc.getAllRootCoalAmerceStandardDirBO();
        }
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<itemKeySet>");

            CoalAmerceStandardDirBO o = (CoalAmerceStandardDirBO) list.get(i);
            if (o != null) {
            	try {
            		List li=rc.getAllCoalAmerceStandardDirBOBySuperId(o.getDirId());
                    if (li != null && li.size()>0) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }
                out.println("<key>" + o.getDirId() + "</key>");
                out.println("<name>" + o.getDirName() + "</name>");
                out.println("<id>" + o.getDirId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKeySet>");
        }
    }
    out.println("</tree>");
%>