<%@page import="com.hr319wg.user.pojo.bo.OperateBO"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="com.hr319wg.user.service.UserManageService" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.user.pojo.bo.SelfOperateBO" %>
<%@ page import="java.util.Hashtable" %>

<%@ include file="../../include/taglib.jsp" %>
<%
   response.setHeader("progma", "no-cache");
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 97;
			document.body.scroll="no";
            document.getElementById("main").style.height = "" + mainHeight + "px";
            document.getElementById("tree").style.height = "" + (mainHeight-20) + "px";
        }
        mmenucolor = '<%=Constants.MENU_COLOR%>';
        mfontcolor='<%=Constants.MENU_FONT_COLOR%>';
        mmenuoutbordercolor='<%=Constants.MENU_OUT_BORDER_COLOR%>';
        mmenuinbordercolor='<%=Constants.MENU_IN_BORDER_COLOR%>';
        mmenuoutcolor = '<%=Constants.MENU_OUT_COLOR%>';
        mmenuincolor = '<%=Constants.MENU_IN_COLOR%>';
        mmenuovercolor = '<%=Constants.MENU_OVER_COLOR%>';
        mmidoutcolor = '<%=Constants.MENUID_OUT_COLOR%>';
        mmidincolor ='<%=Constants.MENUID_IN_COLOR%>';

        // 关联操作
        function LinkOper(url){
            document.main.location.href = url;
        }
        function refreshFun(url){
            $("iframe[name=main]").attr("src",url);
        }
    </script>
</c:verbatim>

<%@ include file="/pages/include/menu.jsp" %>

<%
    User user = (User) session.getAttribute(Constants.USER_INFO);
    UserManageService us = (UserManageService) SysContext.getBean("user_userManageService");
    Hashtable hashMenus = us.getSelfFunction(SelfOperateBO.ZJLZZ_MODULEID, user);
    menu = (MenuObj) hashMenus.get(SelfOperateBO.ZJLZZ_MODULEID);
    String moduleId = request.getParameter("moduleId");
    if (moduleId == null || "".equals(moduleId)) {
        moduleId = (String) session.getAttribute("selfModuleId");
    }
    if (moduleId == null || "".equals(moduleId)) {
        moduleId = "0401";
    }
    session.setAttribute("selfModuleId", moduleId);
    
    String superID = request.getParameter("superID");
    String operID = request.getParameter("operID");
    session.setAttribute("superID", superID);
    session.setAttribute("operID", operID);
    
    url = request.getParameter("url");
    if (url == null || "".equals(url)) {
        SelfOperateBO sb=us.getSelfOperateBO("0401");
        url = sb.getUrl();
    }
	OperateBO defaultUrl = us.getOperateBO("5025");
%>

<h:form id="form1">
    <h:commandButton id="gotoSys" action="#{user_loginBB.gotoSys}" value="业务" style="display:none"></h:commandButton>
    <c:verbatim>
        <table width="100%" border="0" cellpadding="0" height="70" cellspacing="0" background="/images/maininterface/hd_top2.jpg" >
        <tr>
            <td width="30" >&nbsp;</td>
            <td width="40" ><img src="/images/maininterface/logo.jpg" align="left" alt="" height="58" valign="top"></td>
            <td  width="50" align="center">
                <!--修改开始1 -->
				<!-- <span style="font-size:30px; color:#ffffff; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px;"><%=Constants.TITLE_NAME%></span> -->
				<img src="/images/maininterface/title_name.png"/>
				<!--修改结束1 -->
           </td>
            <td align="right" >
                <font color="white"><%=user.getName()%>，您好！ 欢迎登录<% out.println(Constants.LEAD_SYSTEM_NAME);%><br>上次登录：<%=user.getLastLoginTime()%>这是您今天第<%=user.getTodayTimes()%>次登录本系统</font>
            </td>
       </tr>
      </table>
    </c:verbatim>

     <c:verbatim>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" background="/images/maininterface/hd_top_menu.jpg" style="overflow:hidden;">
  <tr>
    <td height="31">
            <table  border="0" cellspacing="0" cellpadding="0">
            <tr>
                <%
                    List childMenu=menu.getMenus();
                    MenuObj selectMenu=null;
                    boolean select=false;
                    for(int i=0;i<childMenu.size();i++){
                        MenuObj cMenu=(MenuObj)childMenu.get(i);
                        if("业务处理".equals(cMenu.getName())){
                      	  continue;
                        }
                        if (cMenu.getOperateId().equals(moduleId)){
                           selectMenu=cMenu;
                           select=true;
                        }
                        else{
                           select=false; 
                        }
                        String className=select?"maintabactive":"maintabinactive";
						if(i != 0){
							out.println("<td width=11 align=\"middle\"><img src=\"/images/maininterface/top_menu_sp.jpg\" /></td>");
						}else{
							out.println("<td width=11></td>");
						}                    
						String width = null;						
                        if (cMenu.getName().length()<=2){
                            width = "50";
                        }
                        else if (cMenu.getName().length()<=4){
							width = "65";
                        }
                        else{
							width = "95";
                        }
                        String operName = "";
						if("个人服务".equals(cMenu.getName())){
							operName="员工信息";
						}else{
							operName=cMenu.getName();
						}
						out.println("<td align=\"center\" id=\""+cMenu.getOperateId()+"_TD\" class="+className+" width="+width+">");
                        out.println("<a href=\"/hqlead/HQOrganMain2.jsf?moduleId="+cMenu.getOperateId()+"\">"+operName+"</a>");
                        out.println("<td  width=11>");                        
                        out.println("</td>");
                    }
                %>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td align="center" id="_TD" class="<%="".equals(moduleId)?"maintabactive":"maintabinactive" %>" width="65">
                	<a href="/hqlead/HQOrganMain2.jsf?moduleId=ywsqmgr&superID=5200,">业务申请</a>
                </td>
                <td width=11></td>
                
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td align="center" id="_TD" class="<%="".equals(moduleId)?"maintabactive":"maintabinactive" %>" width="65">
                	<a href="/hqlead/HQOrganMain2.jsf?moduleId=ywspmgr&superID=5203,">业务审批</a>
                </td>
                <td width=11></td>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td align="center" id="_TD" class="<%="".equals(moduleId)?"maintabactive":"maintabinactive" %>" width="65">
                	<a href="/hqlead/HQOrganMain2.jsf?moduleId=kqglmgr&superID=0560,">考勤管理</a>
                </td>
                <td width=11></td>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td align="center" id="_TD" class="<%="".equals(moduleId)?"maintabactive":"maintabinactive" %>" width="65">
                	<a href="/hqlead/HQOrganMain2.jsf?moduleId=jxglmgr&superID=5020,">绩效管理</a>
                </td>
                <td width=11></td>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td align="center" id="_TD" class="<%="".equals(moduleId)?"maintabactive":"maintabinactive" %>" width="65">
                	<a href="/hqlead/HQOrganMain2.jsf?moduleId=xcglmgr&superID=3798,3799,0642,">薪酬管理</a>
                </td>
            </tr>
        </table>
    </td>

    <td height="22" width="180" align="right">
      <table width="95%" border="0" cellpadding="0" cellspacing="5">
      <tr>
          <td><img src="/images/maininterface/menu/password.gif" width="13" height="13"></td>
          <td><a href="javascript:doModifyPassword();">修改用户密码</a></td>
          <td width="13"><img src="/images/maininterface/menu/exit.gif" width="13" height="13"></td>
          <td><a href="/pages/LogOff.jsp">退出</a></td>
      </tr>
    </table>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
      <%if (!"0401".equals(moduleId)){%>

            <td id="showTree" align="left" width=200>
                 <input  type="text" id="name" style="width:100px">
                 <input value="查询" class="button01" onclick="doQuery();" type="button">
                 <input value="浏览" class="button01" onclick="doNavigate();" type="button">
                 <br>
                 <iframe name="tree" height="400"  style="height:100%;width:100%" src="/pages/ShowSelfOperateTree.jsp"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
            </td>
      <%
          }
      %>

      <td align="center" valign="top">
        <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
            src="<%
                    if (selectMenu!=null){
                        if (selectMenu.getMenus()==null || selectMenu.getMenus().size()==0) {
                            out.println(selectMenu.getUrl());
                        }
                        else{
                        	if(defaultUrl!=null){
                        		out.print(defaultUrl.getUrl());
                        	}
                        }
                    }
            %>" >
        </iframe>
        </td>
  </tr>
</table>
</c:verbatim>
 </h:form>
    <script language="javascript">
    function doQuery(){
        var name=document.all('name').value;
        if (name==""){
            alert('请输入姓名、姓名简拼或员工编号!');
            return false;
        }
        var url="/lead/PersonInfoList.jsf?superId=<%=Constants.ORG_BENBU%>&&queryMode=true&filter=(p.name like '%"+name+"%' or p.shortName like '%"+name+"%' or p.personCode like '%"+name+"%')";
        $("iframe[name=main]").attr("src",url);
    }
    function doNavigate(){
        document.main.location.href='/lead/chart/OrgChartIndex.jsf';
    }
</script>