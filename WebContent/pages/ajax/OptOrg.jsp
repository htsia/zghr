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
<%@ page import="java.util.TreeMap"%>
<%@ page import="java.util.Iterator"%>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
%>
<%

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
                OrgBO[] os = (OrgBO[]) api.getOptTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
                if (os != null && os.length > 0) {
                    //System.out.println(os.length);
                    list = new ArrayList();
                    for (int i = 0; i < os.length; i++)
                        list.add(os[i]);
                }
            } else {
                list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
                //System.out.println("suborg count" + list.size());
                //过滤排除机构
                for (int i = 0; i < list.size(); i++) {
                    OrgBO o = (OrgBO) list.get(i);
                    //System.out.println("check" + i);
                    if (api.checkOrgTreeId((User) session.getAttribute(Constants.USER_INFO), o, "1") == 1) {
                        list.remove(i);
                        i--;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("PmsApi:"+e);
        }
    } else {
        list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
    }

    //add by wb  on 2006-12-5
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
    //////////////////////////////////////
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
            childnum = "0";
            icon = "folder";
            out.println("<org>");
            //判断下级是否有节点,并且如果不显示撤消机构 则判下级是否都是撤消机构
            if (o != null) {
                ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, o.getOrgId());
                if (list1 != null && list1.size() > 0) {
                    if ("1".equals(cancelFlag)) {
                        childnum = "1";
                    } else {
                        for (int j = 0; j < list1.size(); j++) {
                            OrgBO o1 = (OrgBO) list1.get(j);
                            if (!Constants.YES.equals(o1.getOrgCancel())) {
                                childnum = "1";
                                break;
                            }
                        }
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