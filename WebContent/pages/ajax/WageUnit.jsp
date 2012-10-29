<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageUnitBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.user.pojo.bo.RoleInfoBO" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    ArrayList list = new ArrayList();

    UserAPI userapi = (UserAPI) SysContext.getBean("user_pmsAPI");

    if ("-1".equals(superId)) {
        if (RoleInfoBO.ORGTYPE_OWN.equals(user.getprocessUnit())) {   // 本单位只需显示自己
            PersonBO person = SysCacheTool.findPersonById(user.getUserId());
            WageUnitBO unit = SysCacheTool.findWageUnit(person.getGongZiGX());
            list.add(unit);
        } else {
            OrgBO[] os = (OrgBO[]) userapi.getTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
            if (os != null && os.length > 0) {
                for (int i = 0; i < os.length; i++) {
                    WageUnitBO wagebo=SysCacheTool.findWageUnit(os[i].getOrgId());
                    if (wagebo!=null){
                        list.add(wagebo);
                    }
                }
            }
        }
    } else {
        list = SysCacheTool.querySubObject(SysCache.OBJ_WAGEUNIT, null, superId);
    }
    WageUnitBO org = SysCacheTool.findWageUnit(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            WageUnitBO o = (WageUnitBO) list.get(i);
            // 权限判断
            if (userapi.checkOrgTreeId(user,SysCacheTool.findOrgById(o.getUnitId()),"1")==1) continue;
            icon = "hfiles";
            out.println("<org>");
            if (o != null) {
                if (SysCache.wageUnitSubStrMap.containsKey(o.getUnitId())) {
                    childnum = "1";
                } else {
                    childnum = "0";
                    icon = "file";
                }
                out.println("<key>" + o.getTreeId() + "</key>");
                out.println("<name>" + o.getName() + "</name>");
                out.println("<id>" + o.getUnitId() + "</id>");
                out.println("<treeId>" + o.getTreeId() + "</treeId>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</org>");
        }

    }
    if (org != null) {
        out.println("<supertree>");
        out.println("<treeid>" + org.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }
    out.println("</tree>");
%>