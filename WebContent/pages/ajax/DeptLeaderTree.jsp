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
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
%>
<%

    String superId = request.getParameter("superId");
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    String cancelFlag = CommonFuns.filterNull(request.getParameter("cancelFlag"));
    String leaderFlag = CommonFuns.filterNull(request.getParameter("leaderFlag"));
    ArrayList list = null;
    String leaderDeptId="";
    User bo=(User) session.getAttribute(Constants.USER_INFO);
    

    OrgBO tbo=null;
    if(bo!=null){
      
		List deptLst = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, bo.getOrgId());
	    
	    if(deptLst!=null && deptLst.size()>0){
	    	for(int i=0;i<deptLst.size();i++){
	    		OrgBO tObo=(OrgBO)deptLst.get(i);
	    		if(tObo.getTreeId().endsWith("001")){
	    			//list=new ArrayList();
	    			//list.add(tObo);
	    			tbo=tObo;
	    			leaderDeptId=tObo.getOrgId();
	    			break;
	    		}
	    	}
	    }
    
		if(superId==null || "-1".equals(superId)){
			if(tbo!=null)
				list=new ArrayList();
				list.add(tbo);
	    }else{
	    	if(superId!=null&&tbo!=null){
	    		OrgBO superorgbo=SysCacheTool.findOrgById(superId);
	    		if(superId.equals(tbo.getOrgId())||superorgbo.getSuperId().equals(tbo.getOrgId())){
			    	list=SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
			    }
		    	
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
    addSql = addSql.replaceAll("\\|"," ");
    StringBuffer condi = new StringBuffer();
    if (addSql!=null && CommonFuns.filterNull(addSql).length() > 0)
        condi.append(" and (").append(addSql).append(")");
    condi.append(" and p.deptId='").append(superId).append("'");

    String sysCadreField = "p.sysCadreCode";
    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user != null) {

        Hashtable ht = (Hashtable) CommonFuns.filterNull(Hashtable.class, user.getPmsQueryCode());
        List pmsSysCardreCode = (List) ht.get(Constants.SYS_TEAM_CODEID);

        //���ϵͳ����ɲ�Ȩ��
        sysCadreField = CommonFuns.filterNull(sysCadreField);
        pmsSysCardreCode = (List) CommonFuns.filterNull(List.class, pmsSysCardreCode);
        if (!sysCadreField.equals("")) {   //�����Ϊ��,��ѯ������Ա���,��ʱ����ϵͳ����ɲ���������
            condi.append(" and (").append(sysCadreField).append("  is null ");  //�Ȱ� ϵͳ����ɲ��ֶ�Ϊnullֵ�ò����

            for (int i = 0; i < pmsSysCardreCode.size(); i++){
                CodeItemBO bo1 = (CodeItemBO) pmsSysCardreCode.get(i);
                if (bo1 != null) {
                    condi.append(" or ").append(sysCadreField).append(" = '").append(bo1.getItemId()).append("' ");
					}
				}
            condi.append(")");
        }
        IPersonUCC ucc = (IPersonUCC) SysContext.getBean("emp_personUCC");
        PersonBO[] persons = ucc.queryAllPerson(condi.toString() + " order by p.sort");

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