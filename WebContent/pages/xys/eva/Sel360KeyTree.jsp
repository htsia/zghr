<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXys360KeyUCC" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.Xys360KeyLibBO" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.Xys360KeyBO" %>


<%

    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级
    String keyType=request.getParameter("keyType");
    System.out.println(superId+"===================="+keyType);
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    List list2 = null;
    IXys360KeyUCC rc = null;
    try {
        rc = (IXys360KeyUCC) SysContext.getBean("xys360KeyUCC");
        list = rc.getXys360KeyLibBO(superId);  // 子目录
        list2 = rc.getXys360KeyBOByLibAndType(superId,keyType);   // 指标
    }
    catch (Exception e) {

    }

    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<itemKey>");

            Xys360KeyLibBO o = (Xys360KeyLibBO) list.get(i);
            if (o != null) {
                try {
                    List li = rc.getXys360KeyLibBO(o.getLibId());
                    List li2 = rc.getXys360KeyBOByLibAndType(o.getLibId(),keyType);
                    if ((li != null && li.size() > 0) || (li2 != null && li2.size() > 0)) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }
                out.println("<key>" + o.getLibId() + "</key>");
                out.println("<name>" + o.getLibName() + "</name>");
                out.println("<id>" + o.getLibId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKey>");
        }
    }
    if (list2 != null) {
        for (int i = 0; i < list2.size(); i++) {
            icon = "dept";
            out.println("<itemKey>");

            Xys360KeyBO o = (Xys360KeyBO) list2.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getKeyId() + "</key>");
                out.println("<name>" + o.getKeyName() + "</name>");
                out.println("<id>" + o.getKeyId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKey>");
        }
    }

    out.println("</tree>");
%>