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
            $("iframe[name=main]").height(mainHeight);
            $("iframe[name=tree]").height(mainHeight);
        }

        // ��������
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
    Hashtable hashMenus = us.getSelfFunction(SelfOperateBO.JGJLZZ_MODULEID, user);
    menu = (MenuObj) hashMenus.get(SelfOperateBO.JGJLZZ_MODULEID);
    String moduleId = request.getParameter("moduleId");
    if (moduleId == null || "".equals(moduleId)) {
        moduleId = (String) session.getAttribute("selfModuleId");
    }
    if (moduleId == null || "".equals(moduleId)) {
        moduleId = "0301";
    }
    session.setAttribute("selfModuleId", moduleId);

    url = request.getParameter("url");
    if (url == null || "".equals(url)) {
        SelfOperateBO sb =us.getSelfOperateBO("0301");
        url = sb.getUrl();
    }
%>
<h:form id="form1">
    <h:commandButton id="gotoSys" action="#{user_loginBB.gotoSys}" value="ҵ��" style="display:none"></h:commandButton>
    <c:verbatim>
        <table width="100%" border="0" cellpadding="0" height="70" cellspacing="0" background="/images/maininterface/hd_top2.jpg" >
        <tr>
            <td width="30" >&nbsp;</td>
            <td width="40" ><img src="/images/maininterface/logo.jpg" align="left" alt="" height="58" valign="top"></td>
            <td  width="50" align="center">
                <!--�޸Ŀ�ʼ1 -->
				<!-- <span style="font-size:30px; color:#ffffff; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px;"><%=Constants.TITLE_NAME%></span> -->
				<img src="/images/maininterface/title_name.png"/>
				<!--�޸Ľ���1 -->
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
								out.println("<td align=\"center\" id=\""+cMenu.getOperateId()+"_TD\" class="+className+" width="+width+">");
								out.println("<a href=\"/lead/OrganMain2.jsf?moduleId="+cMenu.getOperateId()+"\">"+cMenu.getName()+"</a>");
								out.println("<td  width=11>");                        
								out.println("</td>");
                            }
                        %>
                    </tr>
                </table>
            </td>

            <td height="22" width="200" align="right">
              <table width="100%" border="0" cellpadding="0" cellspacing="5">
              <tr>
                  <td><img src="/images/maininterface/menu/password.gif" width="13" height="13"></td>
                  <td><a href="javascript:doModifyPassword();"><%if ("1".equals(Constants.MODIPASS_SUPPORT)) out.print(LanguageSupport.getResource("COMM-0003","�޸�����"));%></a></td>
                  <td width="13"><img src="/images/maininterface/menu/exit.gif" width="13" height="13"></td>
                  <td><a href="/pages/LogOff.jsp">�˳�</a></td>
              </tr>
            </table>
            </td>
          </tr>
        </table>

        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          <tr>
              <%if (!"0301".equals(moduleId)){%>
              <td id="showTree" align="left" width=200>
                         <iframe name="tree" height="400"  style="height:100%;width:100%" src="/pages/ShowSelfOperateTree.jsp?Root=JGJLZZ"></iframe>
                    </td>
                    <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
                    </td>
              <%}%>
              <td align="center" valign="top">
                <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
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
    
    </c:verbatim>
 </h:form>
