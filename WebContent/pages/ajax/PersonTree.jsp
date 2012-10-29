<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="java.util.*" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    String cancelFlag = CommonFuns.filterNull(request.getParameter("cancelFlag"));
    ArrayList list = null;

    if (!"".equals(rootId) && !"undefined".equals(rootId) && !"null".equals(rootId)) {
        if ("-1".equals(superId)) {
            String[] ids = rootId.split(",");
            if (ids != null && ids.length > 0) {
                list = new ArrayList();
                for (int i = 0; i < ids.length; i++) {
                    OrgBO o = SysCacheTool.findOrgById(ids[i]);
                    if (o != null)
                        list.add(o);
                }
            }
        } else {
            list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
        }
    } else if ("1".equals(rightFlag)) {
        try {
            UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
            if ("-1".equals(superId)) {
                OrgBO[] os = (OrgBO[]) api.getTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
                if (os != null && os.length > 0) {
                    list = new ArrayList();
                    for (int i = 0; i < os.length; i++)
                        list.add(os[i]);
                }
            } else {
                list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
                //过滤排除机构
                for (int i = 0; i < list.size(); i++) {
                    OrgBO o = (OrgBO) list.get(i);
                    if (api.checkOrgTreeId((User) session.getAttribute(Constants.USER_INFO), o, "0") == 1) {
                        list.remove(i);
                        i--;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("PmsAPI异常:" + e);
        }
    } else {
        list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
    }

    if ("-1".equals(superId)) {
        if (list != null && list.size() > 1) {
            TreeMap tree = new TreeMap();
            for (int i = 0; i < list.size(); i++) {
                OrgBO org = (OrgBO) list.get(i);
                tree.put(org.getTreeId(), org);
            }
            Iterator it = tree.values().iterator();
            if (it.hasNext()) {
                OrgBO prevOrg = (OrgBO) it.next();
                while (it.hasNext()) {
                    if (it.hasNext()) {
                        OrgBO posOrg = (OrgBO) it.next();
                        if (posOrg.getTreeId().startsWith(prevOrg.getTreeId())) {
                            it.remove();
                        } else {
                            prevOrg = posOrg;
                        }
                    }
                }
            }
            if (tree.size() != 0) {
                list = new ArrayList(tree.values());
            }
        }
    }   

    OrgBO org = SysCacheTool.findOrgById(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            OrgBO o = (OrgBO) list.get(i);
            if (!"1".equals(cancelFlag) && Constants.YES.equals(o.getOrgCancel()))//如果cancelFlag 为空或undefined则过滤掉"已撤消结构(即org.orgCancel = yes);如果给值且值为1,则显示全部机构
                continue;
            childnum = "1";
            icon = "folder";

            //判断下级是否有节点,并且如果不显示撤消机构 则判下级是否都是撤消机构
            if (o != null) {
                String cancel = o.getOrgCancel();
                if (Constants.YES.equals(cancel))
                    continue;
                out.println("<org>");
                out.println("<key>" + o.getTreeId() + "</key>");
                out.println("<name>" + o.getName() + "</name>");
                out.println("<id>" + o.getOrgId() + "</id>");
                out.println("<cancel>" + cancel + "</cancel>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
                out.println("</org>");
            }
        }
    }

    if (org != null) {
        out.println("<supertree>");
        out.println("<treeid>" + org.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }

    //根据superId查人。需要考虑系统管理干部
    String addSql = CommonFuns.filterNull(request.getParameter("filterSQL"));
    addSql = addSql.replaceAll("\\|", " ");
    StringBuffer condi = new StringBuffer();
    if (CommonFuns.filterNull(addSql).length() > 0)
        condi.append(" and (").append(addSql).append(")");
    condi.append(" and p.deptId='").append(superId).append("'");

    String sysCadreField = "p.sysCadreCode";
    String sysPerTypeField = "p.personType";
    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user != null) {
        Hashtable ht = (Hashtable) CommonFuns.filterNull(Hashtable.class, user.getPmsQueryCode());
        List pmsSysCardreCode = (List) ht.get(Constants.SYS_TEAM_CODEID);
        List pmsPerTypeCode = (List) ht.get(Constants.SYS_PERSONTYPE_CODEID);
        //监测系统管理干部权限
        sysCadreField = CommonFuns.filterNull(sysCadreField);
        if (!sysCadreField.equals("")) {   //如果不为空,查询则与人员相关,此时需监测系统管理干部条件限制
            condi.append(" and (").append(sysCadreField).append("  is null ");  //先把 系统管理干部字段为null值得查出来

            for (int i = 0; i < pmsSysCardreCode.size(); i++) {
                CodeItemBO bo1 = (CodeItemBO) pmsSysCardreCode.get(i);
                if (bo1 != null) {
                    condi.append(" or ").append(sysCadreField).append(" = '").append(bo1.getItemId()).append("' ");

                }
            }
            condi.append(")");
        }

        if (!sysPerTypeField.equals("")) {   //如果不为空,查询则与人员相关,此时需检测员工类别代码条件限制
            if (pmsPerTypeCode.size() > 0) {
                StringBuffer codeCond = new StringBuffer();
                for (int i = 0; i < pmsPerTypeCode.size(); i++) {
                    if (i != 0) {
                        codeCond.append(" or ");
                    }
                    CodeItemBO item = (CodeItemBO) pmsPerTypeCode.get(i);
                    codeCond.append(sysPerTypeField)
                            .append(" = '")
                            .append(item.getItemId())
                            .append("' ");
                }
                condi.append(" and (").append(codeCond).append(") ");
            } else {
                condi.append(" and (1=2) ");
            }
        }
        IPersonUCC ucc = (IPersonUCC) SysContext.getBean("emp_personUCC");
        PersonBO[] persons = ucc.queryAllPerson(condi.toString() + " order by p.sort,p.postLevel,p.sysTime");

        if (persons != null) {
            for (int i = 0; i < persons.length; i++) {
                PersonBO p = persons[i];
                out.println("<person>");
                out.println("<id>" + p.getPersonId() + "</id>");
                out.println("<name>" + p.getName() + "</name>");
                out.println("<sex>" + p.getSex() + "</sex>");
                out.println("</person>");
            }
        }
    }
    out.println("</tree>");
%>