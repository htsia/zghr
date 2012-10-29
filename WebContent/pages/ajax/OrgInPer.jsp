<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
%>
<%

    String superId = request.getParameter("superId");
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    ArrayList list = null;
    PersonBO[] listPer = null;
    UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");

    if (!"".equals(rootId) && !"undefined".equals(rootId)) {
        String[] ids = rootId.split(",");
        if (ids != null && ids.length > 0) {
            list = new ArrayList();
            for (int i = 0; i < ids.length; i++) {
                OrgBO o = SysCacheTool.findOrgById(ids[i]);
                if (o != null)
                    list.add(o);
            }
        }
    } else if ("1".equals(rightFlag)) {
        OrgBO[] os = (OrgBO[]) api.getTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
        if (os != null && os.length > 0) {
            //System.out.println(os.length);
            list = new ArrayList();
            for (int i = 0; i < os.length; i++)
                list.add(os[i]);
        }
    } else {
        list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
        try {
            StringBuffer sql = new StringBuffer();            
            sql.append(" and p.deptId = '").append(superId).append("'");
            IPersonUCC ucc = (IPersonUCC) SysContext.getBean("emp_personUCC");
            User user = (User) session.getAttribute(Constants.USER_INFO);
            String sqlP = api.getScaleConditionByType(user, "p.deptTreeId", "p.sysCadreCode", "p.personType","A", false,false);
            sql.append(" and").append(sqlP);
            listPer = ucc.queryPerson(sql.toString());
        } catch (Exception e) {

        }
    }
    OrgBO org = SysCacheTool.findOrgById(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<org>");
            OrgBO o = (OrgBO) list.get(i);
            if (o != null) {
                ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, o.getOrgId());
                int count = 0;
                try {
                    StringBuffer sql = new StringBuffer();
                    sql.append(" and p.deptId = '").append(o.getOrgId()).append("'");
                    IPersonUCC ucc = (IPersonUCC) SysContext.getBean("emp_personUCC");
                    User user = (User) session.getAttribute(Constants.USER_INFO);
                    String sqlP = api.getScaleConditionByType(user, "p.deptTreeId", "p.sysCadreCode", "p.personType","A", false,false);
                    sql.append(" and").append(sqlP);
                    count = ucc.queryPersonCount(sql.toString());
                } catch (Exception e) {

                }
                if (list1 != null && list1.size() > 0 || count > 0) {
                    childnum = "1";
                } else {
                    childnum = "0";
                    icon = "file";
                }
                String cancel = o.getOrgCancel();
                if (cancel == null || cancel.equals("")) {
                    cancel = "0";
                } else if (Constants.YES.equals(cancel)) {
                    cancel = "1";
                } else {
                    cancel = "0";
                }
                out.println("<key>" + o.getTreeId() + "</key>");
                out.println("<name>" + o.getName() + "</name>");
                out.println("<id>" + o.getOrgId() + "</id>");
                out.println("<cancel>" + cancel + "</cancel>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");

            }
            out.println("</org>");
        }
    }
    if (listPer != null) {
        for (int i = 0; i < listPer.length; i++) {
            icon = "per";
            out.println("<org>");
            PersonBO o = (PersonBO) listPer[i];
            if (o != null) {
                childnum = "0";
                String cancel = o.getPersonCancel();
                if (cancel == null || cancel.equals("")) {
                    cancel = "0";
                } else if (Constants.YES.equals(cancel)) {
                    cancel = "1";
                } else {
                    cancel = "0";
                }
                out.println("<key>" + o.getPersonId() + "</key>");
                out.println("<name>" + o.getName() + "</name>");
                out.println("<id>" + o.getDeptId() + "</id>");
                out.println("<cancel>" + cancel + "</cancel>");
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