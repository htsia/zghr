<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.user.pojo.bo.RoleInfoBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");
    String cancelFlag = CommonFuns.filterNull(request.getParameter("cancelFlag"));
    List list = new ArrayList();

    User bo = (User) session.getAttribute(Constants.USER_INFO);
    PersonBO personbo = SysCacheTool.findPersonById(bo.getUserId());

    //当superId＝－1时显示根节点。
    if (superId == null || "".equals(superId) || "-1".equals(superId)) {
        OrgBO orgbo = SysCacheTool.findOrgById(personbo.getDeptId());
        if (RoleInfoBO.ORGTYPE_SUPER_DEPT.equals(bo.getprocessUnit())) {  // 管理上级部门
            OrgBO superdept = SysCacheTool.findOrgById(orgbo.getSuperId());
            if (OrgBO.DEPTTYPE.equals(superdept.getorgType())) {
                list.add(superdept);
            } else {
                list.add(orgbo);
            }
        } else {
            list.add(orgbo);
        }
    }

    if (superId != null && !"".equals(superId) && !"-1".equals(superId)) {
        List sublist = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
        list.addAll(sublist);
    }

    if (superId != null && !"".equals(superId) && !"-1".equals(superId)) {
        IPersonUCC ucc = (IPersonUCC) SysContext.getBean("emp_personUCC");
        OrgBO org = SysCacheTool.findOrgById(superId);

        String condi = " and p.deptId = '" + org.getOrgId() + "' ";
        String filter = request.getParameter("filterSQL");
        if (CommonFuns.filterNull(filter).length() > 0) {
            condi += " and (" + filter + ")";
        }

        PersonBO[] persons = ucc.queryAllPerson(condi + " order by p.sort");
        if (persons != null) {
            for (int i = 0; i < persons.length; i++) {
                list.add(persons[i]);
            }
        }
    }

    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    int count = list.size();
    if (superId != null && !"".equals(superId) && !"-1".equals(superId)) {
        OrgBO o = SysCacheTool.findOrgById(superId);
        out.println("<supertree>");
        out.println("<treeid>" + o.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }

    for (int i = 0; i < count; i++) {
        if (list.get(i) instanceof OrgBO) {
            OrgBO o = (OrgBO) list.get(i);
            if (Constants.YES.equals(o.getOrgCancel()))
                continue;//撤消机构不在
            out.println("<org>");
            out.println("<key>" + o.getTreeId() + "</key>");
            out.println("<name>" + o.getName() + "</name>");
            out.println("<id>" + o.getOrgId() + "</id>");
            out.println("<cancel>0</cancel>");
            out.println("<icon>folder</icon>");
            out.println("<childnum>1</childnum>");
            out.println("</org>");
        }

        if (list.get(i) instanceof PersonBO) {
            PersonBO p = (PersonBO) list.get(i);
            out.println("<person>");
            out.println("<id>" + p.getPersonId() + "</id>");
            if (p.getPostId() != null && !"".equals(p.getPostId())) {
                out.println("<name>" + p.getName() + "(" + CodeUtil.interpertCode(CodeUtil.TYPE_POST,p.getPostId()) + ") </name > ");
            } else {
                out.println("<name>" + p.getName() + "</name>");
            }
            out.println("<sex>" + CommonFuns.filterNull(p.getSex()) + "</sex>");
            out.println("</person>");
        }
    }
    out.println("</tree>");
%>