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
                //�����ų�����
                for (int i = 0; i < list.size(); i++) {
                    OrgBO o = (OrgBO) list.get(i);
                    if (api.checkOrgTreeId((User) session.getAttribute(Constants.USER_INFO), o, "0") == 1) {
                        list.remove(i);
                        i--;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("PmsAPI�쳣:" + e);
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
            if (!"1".equals(cancelFlag) && Constants.YES.equals(o.getOrgCancel()))//���cancelFlag Ϊ�ջ�undefined����˵�"�ѳ����ṹ(��org.orgCancel = yes);�����ֵ��ֵΪ1,����ʾȫ������
                continue;
            childnum = "1";
            icon = "folder";

            //�ж��¼��Ƿ��нڵ�,�����������ʾ�������� �����¼��Ƿ��ǳ�������
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

    //����superId���ˡ���Ҫ����ϵͳ����ɲ�
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
        //���ϵͳ����ɲ�Ȩ��
        sysCadreField = CommonFuns.filterNull(sysCadreField);
        if (!sysCadreField.equals("")) {   //�����Ϊ��,��ѯ������Ա���,��ʱ����ϵͳ����ɲ���������
            condi.append(" and (").append(sysCadreField).append("  is null ");  //�Ȱ� ϵͳ����ɲ��ֶ�Ϊnullֵ�ò����

            for (int i = 0; i < pmsSysCardreCode.size(); i++) {
                CodeItemBO bo1 = (CodeItemBO) pmsSysCardreCode.get(i);
                if (bo1 != null) {
                    condi.append(" or ").append(sysCadreField).append(" = '").append(bo1.getItemId()).append("' ");

                }
            }
            condi.append(")");
        }

        if (!sysPerTypeField.equals("")) {   //�����Ϊ��,��ѯ������Ա���,��ʱ����Ա����������������
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