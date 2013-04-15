<%@page import="com.hr319wg.custom.util.ComparatorWageUnitBO"%>
<%@page import="java.util.Collections"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageUnitBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.user.pojo.bo.RoleInfoBO" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String superId = request.getParameter("id");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    ArrayList list = new ArrayList();

    UserAPI userapi = (UserAPI) SysContext.getBean("user_pmsAPI");

    if ("-1".equals(superId)) {
        if (RoleInfoBO.ORGTYPE_OWN.equals(user.getprocessUnit())) {   // 本单位只需显示自己
            PersonBO person = SysCacheTool.findPersonById(user.getUserId());
            WageUnitBO unit = SysCacheTool.findWageUnit(person.getGongZiGX());
            list.add(unit);
        } else {
            OrgBO[] os = (OrgBO[]) userapi.getTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
            if (os != null && os.length > 0) {
                for (int i = 0; i < os.length; i++) {
                    WageUnitBO wagebo=SysCacheTool.findWageUnit(os[i].getOrgId());
                    if (wagebo!=null){
                        list.add(wagebo);
                    }
                }
            }
        }
    } else {
        list = SysCacheTool.querySubObject(SysCache.OBJ_WAGEUNIT, null, superId);
    }
    if(list!=null){
    	Collections.sort(list, new ComparatorWageUnitBO());
    }
    WageUnitBO org = SysCacheTool.findWageUnit(superId);
    String childnum = "";
    List unitList = new ArrayList();
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            WageUnitBO o = (WageUnitBO) list.get(i);
            // 权限判断
            if (userapi.checkOrgTreeId(user,SysCacheTool.findOrgById(o.getUnitId()),"1")==1) continue;
            if (o != null) {
                if (SysCache.wageUnitSubStrMap.containsKey(o.getUnitId())) {
                    childnum = "1";
                } else {
                    childnum = "0";
                }
                if("1".equals(childnum)){
	                unitList.add("{id:'"+o.getUnitId()+"',name:'"+o.getName()+"',pId:'"+o.getSuperId()+"',childNum:'"+childnum+"',open:true,isParent:true,iconOpen:'/images/tree_images/hfiles.gif',iconClose:'/images/tree_images/hfiles.gif'}");
                }else{
                	unitList.add("{id:'"+o.getUnitId()+"',name:'"+o.getName()+"',pId:'"+o.getSuperId()+"',childNum:'"+childnum+"',icon:'/images/tree_images/hfile.gif'}");
                }
            }
        }
    }
    out.print(JSONArray.fromObject(unitList));
%>