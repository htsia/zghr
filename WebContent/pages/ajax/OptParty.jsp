<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.ccp.pojo.bo.PartyBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.ccp.util.CcpTools" %>
<%@ page import="com.hr319wg.ccp.util.CcpConstants" %>
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
    String partyType = CommonFuns.filterNull(request.getParameter("paType"));
    ArrayList list = null;
    if (!"".equals(rootId) && !"undefined".equals(rootId) && !"null".equals(rootId)) {
        if ("-1".equals(superId)) {
            String[] ids = rootId.split(",");
            if (ids != null && ids.length > 0) {
                list = new ArrayList();
                for (int i = 0; i < ids.length; i++) {
                    PartyBO o = SysCacheTool.findParty(ids[i]);
                    if (o != null)
                        list.add(o);
                }
            }
        } else {
            list = SysCacheTool.querySubObject(SysCache.OBJ_PARTY, null, superId);
        }
    } else if ("1".equals(rightFlag) && "".equals(rootId)) {
        try {
            UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
            if ("-1".equals(superId)) {
                PartyBO[] os = (PartyBO[]) api.getOptTreeRoot("1", (User) session.getAttribute(Constants.USER_INFO));
                if (os != null && os.length > 0) {
                    list = new ArrayList();
                    for (int i = 0; i < os.length; i++)
                        list.add(os[i]);
                }
            } else {
                list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
                //过滤排除机构
                for (int i = 0; i < list.size(); i++) {
                    PartyBO o = (PartyBO) list.get(i);
                    if (api.checkPartyTreeId((User) session.getAttribute(Constants.USER_INFO), o.getTreeId(), "0") == 1)
                    {
                        list.remove(i);
                        i--;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("PmsApi:"+e);
        }
    } else {
        list = SysCacheTool.querySubObject(SysCache.OBJ_PARTY, null, superId);
    }

     //add by wb  on 2006-12-05
    if ("-1".equals(superId)) {
        if (list != null && list.size() > 1) {
            TreeMap tree = new TreeMap();
            for (int i = 0; i < list.size(); i++) {
                PartyBO org = (PartyBO) list.get(i);
                tree.put(org.getTreeId(), org);
            }
            Iterator it = tree.values().iterator();
            if (it.hasNext()) {
                PartyBO prevOrg = (PartyBO) it.next();
                while (it.hasNext()) {
                    if (it.hasNext()) {
                        PartyBO posOrg = (PartyBO) it.next();
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
    /////////////////
    //wangbing add filter dismiss party
    list = CcpTools.filterParty(list, partyType);
    //wangbing add end

    PartyBO party = SysCacheTool.findParty(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<party>");
            PartyBO o = (PartyBO) list.get(i);
            if (o != null) {
                ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_PARTY, null, o.getPartyId());
                String canceldate = "";
                if (partyType.equals("1")) {//wangbing add filter party
                    if (list1 != null && list1.size() > 0) {
                        for (int n = 0; n < list1.size(); n++) {
                            PartyBO bo = (PartyBO) list1.get(n);
                            canceldate = CommonFuns.filterNull(bo.getPartyCancelDate()).trim();
                            if (canceldate.equals("")) {
                                childnum = "1";
                                break;
                            } else {
                                childnum = "0";
                                icon = "file";
                            }
                        }
                    } else {
                        childnum = "0";
                        icon = "file";
                    }
                    canceldate = o.getPartyName();
                } else if (partyType.equals("3")) {//wangbing add filter party
                    if (list1 != null && list1.size() > 0) {
                        for (int n = 0; n < list1.size(); n++) {
                            PartyBO bo = (PartyBO) list1.get(n);
                            canceldate = CommonFuns.filterNull(bo.getPartyCancelDate()).trim();
                            String pType = CommonFuns.filterNull(bo.getPartyType()).trim();
                            if (canceldate.equals("") && (pType.equals(CcpConstants.PARTYTYPE_COMM) || pType.equals(CcpConstants.PARTYTYPE_ORGAN)))
                            {
                                childnum = "1";
                                break;
                            } else {
                                childnum = "0";
                                icon = "file";
                            }
                        }
                    } else {
                        childnum = "0";
                        icon = "file";
                    }
                    canceldate = o.getPartyName();
                } else {
                    if (list1 != null && list1.size() > 0) {
                        childnum = "1";
                    } else {
                        childnum = "0";
                        icon = "file";
                    }
                    canceldate = CommonFuns.filterNull(o.getPartyCancelDate()).trim();
                    if (canceldate.equals("")) {
                        canceldate = o.getPartyName();
                    } else {
                        canceldate = o.getPartyName() + "(已撤销)";
                    }
                }
                out.println("<key>" + o.getTreeId() + "</key>");
                out.println("<name>" + canceldate + "</name>");
                out.println("<id>" + o.getPartyId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</party>");
        }
    }

    if (party != null) {
        out.println("<supertree>");
        out.println("<treeid>" + party.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }

    out.println("</tree>");

%>