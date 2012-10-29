<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.user.pojo.bo.RoleInfoBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // �ϼ�
    String onlyOrg=request.getParameter("onlyOrg");                           // �ϼ�
    ArrayList list = new ArrayList();

    User user = (User) (session.getAttribute(Constants.USER_INFO));

    if ("-1".equals(superId)) {  // ��ʾ��
        if (user.isUnitLeader()){
             if (RoleInfoBO.ORGTYPE_ALL.equals(user.getprocessUnit())){    // �ܾ���
                  OrgBO org=SysCacheTool.findOrgById(Constants.ORG_BENBU);
                  list.add(org);
             }
             else{                                                          // ��֧�ܾ���
                 OrgBO org=SysCacheTool.findOrgById(user.getOrgId());
                 list.add(org);
             }
        }
        else if (user.isDeptLeader()){   // ���ž���
            OrgBO org=SysCacheTool.findOrgById(user.getDeptId());
            list.add(org);
        }
    } else {
        list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);// ȫ��
    }

    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");

    OrgBO org=SysCacheTool.findOrgById(superId);
    // ���ؽ��
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            OrgBO o = (OrgBO) list.get(i);
            if ("true".equals(onlyOrg) && !OrgBO.UNITTYPE.equals(o.getorgType()) && !OrgBO.VIRTUALTYPE.equals(o.getorgType())) {      // ���˲���
                continue;
            }

            childnum = "0";
            out.println("<org>");

            //�ж��¼��Ƿ��нڵ�,�����������ʾ�������� �����¼��Ƿ��ǳ�������
            if (o != null) {
                ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, o.getOrgId());
                if ("true".equals(onlyOrg)){
                    for(int k=0;k<list1.size();k++){
                        OrgBO oo=(OrgBO)list1.get(k);
                        if (OrgBO.UNITTYPE.equals(oo.getorgType()) || OrgBO.VIRTUALTYPE.equals(oo.getorgType())){
                           childnum = "1"; 
                           break;
                        }
                    }
                }
                else{
                    if (list1 != null && list1.size() > 0) {
                         childnum = "1";
                    }
                }
                String cancel = o.getOrgCancel();
                if (cancel == null || cancel.equals("")) {
                    cancel = "0";
                } else if (Constants.YES.equals(cancel)) {
                    cancel = "1";
                } else {
                    cancel = "0";
                }
                if (OrgBO.UNITTYPE.equals(o.getorgType())) {
                    icon = "org";
                } else if (OrgBO.DEPTTYPE.equals(o.getorgType())) {
                    icon = "dept";
                } else if (OrgBO.GROUPTYPE.equals(o.getorgType())) {
                    icon = "group";
                } else if (OrgBO.VIRTUALTYPE.equals(o.getorgType())) {
                    icon = "virtual";
                } else {
                    icon = "folder";
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

    if (org != null) {
        out.println("<supertree>");
        out.println("<treeid>" + org.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }

    out.println("</tree>");
%>