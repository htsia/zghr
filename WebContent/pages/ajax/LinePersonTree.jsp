<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.ArrayList" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
%>
<%

    String superId = request.getParameter("superId");
    ArrayList list = null;


    list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);

    OrgBO org = SysCacheTool.findOrgById(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            OrgBO o = (OrgBO) list.get(i);
            if (Constants.YES.equals(o.getOrgCancel()))//���cancelFlag Ϊ�ջ�undefined����˵�"�ѳ����ṹ(��org.orgCancel = yes);�����ֵ��ֵΪ1,����ʾȫ������
                continue;
            childnum = "1";
            icon = "folder";

            //�ж��¼��Ƿ��нڵ�,�����������ʾ�������� �����¼��Ƿ��ǳ�������
            if (o != null) {
                String cancel = o.getOrgCancel();
                if (Constants.YES.equals(cancel))
                    continue;
                //System.out.println(oa.getTreeId());
                if (o.getTreeId().length() == 3 || o.getTreeId().startsWith("001651")) {
                    if (o.getTreeId().length() > 12)
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
    }

    if (org != null) {
        out.println("<supertree>");
        out.println("<treeid>" + org.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }

    //����superId���ˡ���Ҫ����ϵͳ����ɲ�
    String addSql = CommonFuns.filterNull(request.getParameter("filterSQL"));
    addSql = addSql.replaceAll("\\|", " ");

    if(org != null && org.getTreeId().length() ==12){
        if(addSql.length() > 0)
            addSql = " and (" + addSql + ") and p.deptTreeId like '" + org.getTreeId() + "%'";
        else
            addSql = " and p.deptTreeId like '" + org.getTreeId() + "%'";


        IPersonUCC ucc = (IPersonUCC) SysContext.getBean("emp_personUCC");
        PersonBO[] persons = ucc.queryAllPerson(addSql + " order by p.sort");

        if (persons != null) {
            for (int i = 0; i < persons.length; i++) {
                PersonBO p = persons[i];
                out.println("<person>");
                out.println("<id>" + p.getPersonId() + "</id>");
                out.println("<name>" + p.getName() + "</name>");
                out.println("</person>");
            }
        }
    }

    out.println("</tree>");


%>