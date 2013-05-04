<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="java.util.Collections"%>
<%@page import="net.sf.json.JSONArray"%>
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
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.emp.ucc.teamManagerUcc" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.emp.pojo.bo.EmpTeamInfoBo" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String superId = request.getParameter("id");                           // �ϼ�
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));     // Ȩ�޷�ʽ  //   0-��ʹ�� 1-ʹ�ò�ѯȨ�޹���,2-ʹ��ά��Ȩ�޹���
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));           // ���ڵ�
    String cancelFlag = CommonFuns.filterNull(request.getParameter("cancelFlag"));   // �Ƿ���ʾ��������
    String showGroup = CommonFuns.filterNull(request.getParameter("showGroup"));    //   �Ƿ���ʾ����
    String onlyOrg = CommonFuns.filterNull(request.getParameter("onlyOrg"));          //  ֻ��ʾ����
    String showTeam = CommonFuns.filterNull(request.getParameter("showTeam"));          // ��ʾ�Ŷ�
    String secDeptTreeId = CommonFuns.filterNull(request.getParameter("secDeptTreeId"));          // ����������id
    List<OrgBO> list = null;
    User user = (User) (session.getAttribute(Constants.USER_INFO));
    teamManagerUcc teamucc = (teamManagerUcc) SysContext.getBean("teamucc");
    if (!"".equals(rootId) && !"undefined".equals(rootId) && !"null".equals(rootId)) {
        if ("-1".equals(superId)) {   // ���ָ�����ײ����
            String[] ids = rootId.split(",");
            if (ids != null && ids.length > 0) {
                list = new ArrayList();
                for (int i = 0; i < ids.length; i++) {
                    OrgBO o = SysCacheTool.findOrgById(ids[i]);
                    if (o != null) list.add(o);
                }
            }
        } else {
            list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);// ȫ��
        }
    } else if ("1".equals(rightFlag)) { //��ѯ��Χ
        try {
            UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
            if ("-1".equals(superId)) {
                OrgBO[] os = (OrgBO[]) api.getTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
                if (os != null && os.length > 0) {
                    list = new ArrayList();
                    for (int i = 0; i < os.length; i++) {
                    	list.add(SysCacheTool.findOrgById(os[i].getOrgId()));
                    }
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
            System.out.println("PmsApi:" + e);
        }
    } else if ("2".equals(rightFlag)) { //ά����Χ
        try {
            UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
            if ("-1".equals(superId)) {
                OrgBO[] os = (OrgBO[]) api.getOptTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
                if (os != null && os.length > 0) {
                    list = new ArrayList();
                    for (int i = 0; i < os.length; i++){
                        list.add(SysCacheTool.findOrgById(os[i].getOrgId()));
                    }
                }
            } else {
                list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
                //�����ų�����
                for (int i = 0; i < list.size(); i++) {
                    OrgBO o = (OrgBO) list.get(i);
                    if (api.checkOrgTreeId((User) session.getAttribute(Constants.USER_INFO), o, "1") == 1) {
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

//     if ("-1".equals(superId)) {
//         if (list != null && list.size() > 1) {
//             TreeMap tree = new TreeMap();
//             for (int i = 0; i < list.size(); i++) {
//                 OrgBO org = (OrgBO) list.get(i);
//                 tree.put(org.getOrgId(), org);
//             }
//             Iterator it = tree.values().iterator();
//             if (it.hasNext()) {
//                 OrgBO prevOrg = (OrgBO) it.next();
//                 while (it.hasNext()) {
//                     OrgBO posOrg = (OrgBO) it.next();
//                     if (posOrg.getOrgId().startsWith(prevOrg.getOrgId())) {
//                         it.remove();
//                     } else {
//                         prevOrg = posOrg;
//                     }
//                 }
//             }
//             if (tree.size() != 0) {
//                 list = new ArrayList(tree.values());
//             }
//         }
//     }
    String childnum = null;
    List orgList = new ArrayList();
    // ���ؽ��
    if (list != null) {
    	List secOrgList=new ArrayList();
    	List<CodeItemBO> secList=SysCacheTool.queryCodeItemBySetId("3053");
    	for(OrgBO org : list){
    		for(CodeItemBO code : secList){
    			if("-1".equals(org.getSuperId()) || code.getItemId().equals("3053"+org.getOrgId())){
    				secOrgList.add(org);
    				break;
    			}
    		}
    	}
    	
	    Collections.sort(secOrgList);
        for (int i = 0; i < secOrgList.size(); i++) {
            OrgBO o = (OrgBO) secOrgList.get(i);
            if(o.getOrgId().length()>6 && secDeptTreeId!=null && !"".equals(secDeptTreeId) && !"null".equals(secDeptTreeId) && !o.getOrgId().startsWith(secDeptTreeId)){
				continue;
			}
            if (!"1".equals(cancelFlag) && Constants.YES.equals(o.getOrgCancel()))//���cancelFlag Ϊ�ջ�undefined����˵�"�ѳ����ṹ(��org.orgCancel = yes);�����ֵ��ֵΪ1,����ʾȫ������
                continue;
            if (!"1".equals(showGroup) && OrgBO.GROUPTYPE.equals(o.getorgType())) {  // ���˵�����
                continue;
            }
            if ("1".equals(onlyOrg) && !OrgBO.UNITTYPE.equals(o.getorgType()) && !OrgBO.VIRTUALTYPE.equals(o.getorgType())) {      // ���˲���
                continue;
            }
            childnum = "0";

            //�ж��¼��Ƿ��нڵ�,�����������ʾ�������� �����¼��Ƿ��ǳ�������
            if (o != null) {
                ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, o.getOrgId()); // ȡ�������¼�
                if (list1 != null && list1.size() > 0) {
                    try {
                        for (int j = 0; j < list1.size(); j++) {
                            OrgBO o1 = (OrgBO) list1.get(j);
                            if (!"1".equals(showGroup) && OrgBO.GROUPTYPE.equals(o1.getorgType())) continue;   // ���˵�����
                            if ("1".equals(onlyOrg) && !OrgBO.UNITTYPE.equals(o1.getorgType()) && !OrgBO.VIRTUALTYPE.equals(o1.getorgType())) {      // ���˲���
                                continue;
                            }
                            if ( !"0".equals(rightFlag)){
                                if (user.isBusinessUser() || user.isSysOper()) {    // ҵ���û�����Ȩ��
                                    // û��Ȩ��
                                    UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
                                    if (api.checkOrgTreeId((User) session.getAttribute(Constants.USER_INFO), o1, "1") == 1)
                                        continue;
                                }
                            }

                            if ("1".equals(cancelFlag)) {
                                childnum = "1";
                                break;
                            } else if (!Constants.YES.equals(o1.getOrgCancel())) {
                                childnum = "1";
                                break;
                            }
                        }
                    }
                    catch (Exception e) {

                    }
                }
                if ("1".equals(showTeam)) { // ��ʾ�Ŷ�
                    List teamlist = teamucc.getAllEmpTeamInfoBo(o.getOrgId());
                    if (teamlist!=null && teamlist.size()>0) {
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
				String name=o.getName()+("1".equals(cancel)?"(�ѳ���)":"");
				if("089110".equals(o.getorgType())){
					if("1".equals(childnum)){
						orgList.add("{id:'"+o.getOrgId()+"',name:'"+name+"',pId:'"+o.getSuperId()+"',isParent:true,iconOpen:'/images/tree_images/org.gif',iconClose:'/images/tree_images/org.gif'}");
					}else{
						orgList.add("{id:'"+o.getOrgId()+"',name:'"+name+"',pId:'"+o.getSuperId()+"',isParent:true,iconOpen:'/images/tree_images/org.gif',iconClose:'/images/tree_images/org.gif'}");
					}
				}else{
					if("1".equals(childnum)){
						orgList.add("{id:'"+o.getOrgId()+"',name:'"+name+"',pId:'"+o.getSuperId()+"',isParent:true,icon:'/images/tree_images/dept.gif'}");
					}else{
						orgList.add("{id:'"+o.getOrgId()+"',name:'"+name+"',pId:'"+o.getSuperId()+"',icon:'/images/tree_images/dept.gif'}");					
					}
				}
            }
        }
        if ("1".equals(showTeam)) { // ��ʾ�Ŷ�
            List teamlist = teamucc.getAllEmpTeamInfoBo(superId);
            if (teamlist != null) {
                for (int j = 0; j < teamlist.size(); j++) {
                    EmpTeamInfoBo em=(EmpTeamInfoBo)teamlist.get(j);
                    orgList.add("{id:'"+em.getTeamId()+"',name:'"+em.getTeamName()+"',pId:'"+em.getTeamId()+"',icon:'/images/tree_images/dept.gif'}");
                }
            }
        }
    }
//     System.out.println(orgList);
    out.print(JSONArray.fromObject(orgList));
%>