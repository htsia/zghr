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
            document.getElementById("main").style.height = "" + mainHeight + "px";
            document.getElementById("tree").style.height = "" + mainHeight + "px";
        }

        // 关联操作
        function LinkOper(url){
            document.main.location.href = url;
        }
        function refreshFun(url){
            document.main.location.href=url;
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
    <h:commandButton id="gotoSys" action="#{user_loginBB.gotoSys}" value="业务" style="display:none"></h:commandButton>
    <c:verbatim>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" background="/images/maininterface/hd_top.jpg" style="backgroud:#1F93B8">
        <tr>
            <td width="40" height="58">&nbsp;</td>
            <td width="40" height="58"><img src="/images/maininterface/logo.jpg" align="left" alt="" height="58" valign="top"></td>
            <td  width="50%" align="center">
                <span style="font-size:30px; color:#ffffff; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px; width:380px;"><%=Constants.TITLE_NAME%></span>
           </td>
           <td align="right" >&nbsp;</td>
       </tr>
      </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="20" bgcolor="#2693B4">
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
                                out.println("<td width=1></td>");
                                out.println("<td  width=11>");
                                if (select){
                                    out.println("<img  align=\"texttop\" src=\"/images/maininterface/corner_s_left.jpg\"/>");
                                }
                                else{
                                    out.println("<img  align=\"texttop\" src=\"/images/maininterface/corner_left.jpg\"/>");
                                }
                                out.println("</td>");
                                if (cMenu.getName().length()<=2){
                                    out.println("<td id=\""+cMenu.getOperateId()+"_TD\" class="+className+" width=50>");
                                }
                                else if (cMenu.getName().length()<=4){
                                    out.println("<td id=\""+cMenu.getOperateId()+"_TD\" class="+className+" width=65>");
                                }
                                else{
                                    out.println("<td id=\""+cMenu.getOperateId()+"_TD\" class="+className+" width=95>");
                                }
                                out.println("<a href=\"/lead/OrganMain2.jsf?moduleId="+cMenu.getOperateId()+"\"><img width=\"13\" height=\"13\" src=\""+cMenu.getWebIcon()+"\"   style=\"border:0;vertical-align:middle\"><font color=\""+Constants.TAB_FONT_COLOR+"\">"+cMenu.getName()+"</font></a>");
                                out.println("<td  width=11>");
                                if (select){
                                    out.println("<img id=\""+cMenu.getOperateId()+"_TD\" align=\"texttop\" src=\"/images/maininterface/corner_s_right.jpg\"/>");
                                }
                                else{
                                    out.println("<img id=\""+cMenu.getOperateId()+"_TD\" align=\"texttop\" src=\"/images/maininterface/corner_right.jpg\"/>");
                                }
                                out.println("<td>");
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

        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          <tr>
              <%if (!"0301".equals(moduleId)){%>
              <td id="showTree" align="left" width=200>
                         <iframe name="tree" height="100%"  style="height:100%;width:100%" src="/pages/ShowSelfOperateTree.jsp?Root=JGJLZZ"></iframe>
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
