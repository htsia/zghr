<%@page import="com.hr319wg.custom.util.CommonUtil"%>
<%@page import="com.hr319wg.user.pojo.bo.OperateBO"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.service.UserManageService" %>
<%@ page import="com.hr319wg.user.pojo.bo.SelfOperateBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
   response.setHeader("progma", "no-cache");
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
	<script src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 100;
            $("iframe[name=main]").height(mainHeight);
            $("iframe[name=tree]").height(mainHeight);
        }
        // 关联操作
        function LinkOper(url){
            document.main.location.href = url;
        }
        function refreshFun(url){
            $("iframe[name=main]").attr("src",url);
        }
    </script>
<body scroll="no">
</c:verbatim>

<%@ include file="/pages/include/menu.jsp" %>

<%
    User user = (User) session.getAttribute(Constants.USER_INFO);
    Hashtable hashMenus = null;
    UserManageService us = (UserManageService) SysContext.getBean("user_userManageService");
    hashMenus = us.getSelfFunction(SelfOperateBO.YGZZ_MODULEID, user);
    menu = (MenuObj) hashMenus.get(SelfOperateBO.YGZZ_MODULEID);
    
    String moduleId = request.getParameter("moduleId");
    if (moduleId == null || "".equals(moduleId)) {
        moduleId = "0101";
    }
    if (moduleId == null || "".equals(moduleId)) {
        moduleId = (String) session.getAttribute("selfModuleId");
    }
    
    session.setAttribute("selfModuleId", moduleId);
    String moduleOperID = request.getParameter("moduleOperID");
    String subfolder1 = request.getParameter("subfolder");
    String bylevel1 = request.getParameter("bylevel");
    session.setAttribute("moduleOperID", moduleOperID); 
    session.setAttribute("subfolder", subfolder1); 
    session.setAttribute("bylevel", bylevel1); 
    
    Object approtype=session.getAttribute("approtype");
    if(approtype!=null){
    	moduleId="KQGL";
	    session.setAttribute("selfModuleId", "KQGL");
	    session.setAttribute("moduleOperID", "0500"); 
	    session.setAttribute("subfolder", "1"); 
	    session.setAttribute("bylevel", null); 
    }
    
    url = request.getParameter("url");
    if (url == null || "".equals(url)) {
        SelfOperateBO sb = us.getSelfOperateBO("0101");
        if (sb==null || "0".equals(sb.getisUse())){
            sb = us.getSelfOperateBO("1001");
        }
        url = sb.getUrl();
    }
%>


<h:form id="form1">
    <h:commandButton id="gotoSys" action="#{user_loginBB.gotoSys}" value="业务" style="display:none"></h:commandButton>
    <c:verbatim>
        <table width="100%" border="0" cellpadding="0" height="70" cellspacing="0" background="/images/maininterface/hd_top2.jpg" >
        <tr>
            <td width="30" >&nbsp;</td>
            <td width="40" ><img src="/<%=CommonUtil.getSYS_INTERFACE()[1]%>" align="left" alt="" height="58" valign="top"></td>
            <td  width="500" align="center">
                <!--修改开始1 -->
				<!-- <span style="font-size:30px; color:#ffffff; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px;"><%=Constants.TITLE_NAME%></span> -->
				<!-- <img src="/images/maininterface/title_name.png"/> -->
				<!--修改结束1 -->
           </td>
           <td align="right" >&nbsp;</td>
       </tr>
      </table>

      <table width="100%" border="0" cellspacing="0" cellpadding="0" background="/images/maininterface/hd_top_menu.jpg">
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
								out.println("<a href=\"/self/SelfMain2.jsf?moduleId="+cMenu.getOperateId()+"\">"+operName+"</a>");
								out.println("<td  width=11>");                        
								out.println("</td>");

                          }
                      %>
                      <%
                          List<OperateBO> moduleList = CommonUtil.getAllModulesInSelf();
                      	  if(moduleId!=null){
                      		  for(OperateBO bo : moduleList){
                      			  String moduleID=bo.getModuleID();
                      			  String subfolder="1";
                      			  String bylevel=null;                      			  
					              if("JXGL".equals(moduleID) || "XCGL".equals(moduleID)){
					            	  subfolder="0";
					              }
					              if("JXGL".equals(moduleID)){
					            	  bylevel="1";
					              }
                      			  %>
                      			  	<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
					                <td align="center" id="_TD" class="<%="".equals(moduleId)?"maintabactive":"maintabinactive" %>" width="65">
					                	<a href="/self/SelfMain2.jsf?moduleOperID=<%=bo.getOperateId()%>&moduleId=<%=moduleID%>&subfolder=<%=subfolder%>&bylevel=<%=bylevel%>"><%=bo.getOperateName() %></a>
					                </td>
					                <td width=11></td>
                      			  <%
                      		  }
                      	  }
                      %>
                  </tr>
              </table>
          </td>

          <td height="22" width="200" align="right">
            <table width="100%" border="0" cellpadding="0" cellspacing="5">
            <tr>
                <td><img src="/images/maininterface/menu/exchange.gif" width="13" height="13"></td>
                <td><a href="javascript:document.all('form1:gotoSys').click()">HR系统</a></td>
                <td><img src="/images/maininterface/menu/password.gif" width="13" height="13"></td>
                <td><a href="javascript:doModifyPassword();"><%if ("1".equals(Constants.MODIPASS_SUPPORT)) out.print(LanguageSupport.getResource("COMM-0003","修改密码"));%></a></td>
                <td width="13"><img src="/images/maininterface/menu/exit.gif" width="13" height="13"></td>
                <td><a href="/pages/LogOff.jsp">退出</a></td>
            </tr>
          </table>
          </td>
        </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="height:100%">
        <tr>
            <%if (!"0101".equals(moduleId) && !"0102".equals(moduleId)){%>      
            <td id="showTree" align="left" width=200 valign="top">
                 <iframe name="tree" height="400"  frameborder="no" border="0" marginwidth="0" marginheight="0"  scrolling="auto" style="height:100%;width:100%;" src="/pages/ShowSelfOperateTree.jsp?Root=YGZZ"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
            </td>
            <%}%>
            <td align="center" valign="top">
              <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%" height="100%"
                  src="<%
                          if (selectMenu!=null){
                              if (selectMenu.getMenus()==null || selectMenu.getMenus().size()==0) {
                                  out.println(selectMenu.getUrl());
                              }
                              else{
                                  MenuObj me=(MenuObj)selectMenu.getMenus().get(0);
                                  out.println(me.getUrl());
                              }
                          }
                  %>" >
              </iframe>
              </td>
        </tr>
      </table>
</body>
</c:verbatim>
 </h:form>
