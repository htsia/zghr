<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.api.UserAPI"%>
<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="com.hr319wg.user.pojo.bo.RoleInfoBO"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageUnitBO"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String type = request.getParameter("type");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String title = "";
    String url = "";
    if (user == null) {
        response.sendRedirect("/pages/overtime.jsp");
    } else {
        String userId = user.getUserId();
        String unitId = SysCacheTool.findPersonById(userId).getGongZiGX();
        
    	List list = new ArrayList();
    	UserAPI userapi = (UserAPI) SysContext.getBean("user_pmsAPI");
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
    	WageUnitBO org = SysCacheTool.findWageUnit("-1");
        List unitList = new ArrayList();
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                WageUnitBO o = (WageUnitBO) list.get(i);
                // 权限判断
                if (userapi.checkOrgTreeId(user,SysCacheTool.findOrgById(o.getUnitId()),"1")==1) continue;
                if (o != null) {
                	unitId=o.getUnitId();
                	break;
                }
            }
        }
    	
    	
        WageUnitBO unit=SysCacheTool.findWageUnit(unitId);
        if(unit==null) {
            out.println("<script language='javascript'>alert('错误：用户没有发薪单位')</script>");
            return;
        }
        if (unitId == null || unitId.trim().length() == 0) return;
        if ("standard".equals(type)) {
            title = "标准表设置";
            url = "/wage/base/StandardList.jsf?act=list&unitId=" + unitId;
        } else if ("formula".equals(type)) {
            title = "公式设置";
            url = "/wage/base/FormulaList.jsf?act=list&unitId=" + unitId;
        } else if ("set".equals(type)) {
            title = "账套管理";
            url = "/wage/set/SetList.jsf?act=list&unitId=" + unitId;
        } else if ("gross".equals(type)) {
            title = "工资计划";
            url = "/wage/gross/GrossView.jsf?act=list&unitId=" + unitId;
        } else if ("unit".equals(type)) {
            title = "发薪单位设置";
            String superId = SysCacheTool.findWageUnit(unitId).getSuperId();
            url = "/wage/unit/UnitList.jsf?act=list&superId=" + superId;
        } else if ("person".equals(type)) {
            title = "薪资基础信息维护";
            url = "/wage/base/PersonInfoQry.jsf?act=init&unitId=" + unitId;
        }
    }
%>

    <script type="text/javascript" language="javascript">
        var type = "<%=type%>";
        function refreshList(unitId, childNum) {
            if ("unit" == type) {
                document.list.location = "/wage/unit/UnitList.jsf?act=list&superId=" + unitId;
            } else if ("standard" == type) {
                    document.list.location = "/wage/base/StandardList.jsf?act=list&unitId=" + unitId;
            } else if ("formula" == type) {
                    document.list.location = "/wage/base/FormulaList.jsf?act=list&unitId=" + unitId;
            } else if ("set" == type) {
                    document.list.location = "/wage/set/SetList.jsf?act=list&unitId=" + unitId;
            } else if ("gross" == type) {
                document.list.location = "/wage/gross/GrossView.jsf?act=list&unitId=" + unitId;
            } else if ("person" == type) {
                if (childNum == 0)
                    document.list.location = "/wage/base/PersonInfoQry.jsf?act=init&unitId=" + unitId;
            }            
        }
         with (window) onload = onresize = function(){
            var mainHeight = document.body.clientHeight - 40;
            $("iframe[name=tree]").height(mainHeight);
            document.getElementById("list").style.height = "" + mainHeight + "px";
            document.getElementById("mainTable").style.height = "" + mainHeight + "px";
        }
    </script>

<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title"><img src="/images/tips.gif"><%=title%></td>
    </tr>
</table>


<table width="100%" id="mainTable" height="98%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" valign="top" class="explorer" id="showTree" width="250">
             <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"     src="/pages/wage/unit/UnitTree.jsp">
             </iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
         </td>

        <td align="center" valign="top" class="explorer">
              <iframe name="list" frameborder="0"   scrolling="auto" width="100%"     src="<%=url%>"></iframe>
        </td>
    </tr>
</table>
