<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.eva.ucc.IEvaKeyItemUCC" %>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaKeyItemSetBO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaKeyItemBO" %>

<%
    User user = (User) session.getAttribute(Constants.USER_INFO);
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级

    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    List list2 = null;
    TrainAPI api = null;
    IEvaKeyItemUCC rc = null;
    try {
        rc = (IEvaKeyItemUCC) SysContext.getBean("eva_keyitemucc");
        list = rc.getAllChildType(superId);  // 子目录
        list2 = rc.getKeyItemList(superId, user.getOrgId());   // 指标
    }
    catch (Exception e) {

    }

    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<itemKey>");

            EvaKeyItemSetBO o = (EvaKeyItemSetBO) list.get(i);
            if (o != null) {
                try {
                    List li = rc.getAllChildType(o.getSetID());
                    List li2 = rc.getKeyItemList(o.getSetID(),user.getOrgId());
                    if ((li != null && li.size() > 0) || (li2 != null && li2.size() > 0)) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                    }
                }
                catch (Exception e) {
                    childnum = "0";
                }
                out.println("<key>" + o.getSetID() + "</key>");
                out.println("<name>" + o.getSetName() + "</name>");
                out.println("<id>" + o.getSetID() + "</id>");
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

            EvaKeyItemBO o = (EvaKeyItemBO) list2.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getItemID() + "</key>");
                out.println("<name>" + o.getItemName() + "</name>");
                out.println("<id>" + o.getItemID() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</itemKey>");
        }
    }

    out.println("</tree>");
%>