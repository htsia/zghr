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
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 97;
            $("iframe[name=main]").height(mainHeight);
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
        
    </script>
</c:verbatim>

<%@ include file="/pages/include/menu.jsp" %>
<%
    User user = (User) session.getAttribute(Constants.USER_INFO);
    UserManageService us = (UserManageService) SysContext.getBean("user_userManageService");
    System.out.print(us);
    Hashtable hashMenus = us.getSelfFunction(SelfOperateBO.JGJLZZ_MODULEID, user);
    menu = (MenuObj) hashMenus.get(SelfOperateBO.JGJLZZ_MODULEID);

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
            <td align="right" >
                <font color="white"><%=user.getName()%>，您好！ 欢迎登录<% out.println(Constants.SYSTEM_NAME+Constants.CHILD_SYSTEM_NAME);%><br>上次登录：<%=user.getLastLoginTime()%>这是您今天第<%=user.getTodayTimes()%>次登录本系统</font>
            </td>
       </tr>
      </table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="22" bgcolor="#2074C5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td bgcolor="#2074C5" width="<%if(menu!=null) if(menu.getMenus()!=null) out.print(menu.getMenus().size()*25);%>"><script type="text/javascript" language="JavaScript1.2">
                        <%
                           if(menu != null)
                           {
                                subMenuCount=0;
                                LoadChildMenu(menu,"",out,true);
                                out.println("showMenu()");
                           }
                        %>
                    </script></td>
            </tr>
        </table>
    </td>
      <td height="22" bgcolor="#2074C5">
</c:verbatim>
          <h:outputText rendered="#{user_loginBB.haveMultiRole}" escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<font color=white>您有多个身份，请选择：</font>"></h:outputText>
          <h:selectOneMenu rendered="#{user_loginBB.haveMultiRole}" value="#{user_loginBB.curRole}">
                <c:selectItems value="#{user_loginBB.roleList}"></c:selectItems>
          </h:selectOneMenu>
          <h:commandButton styleClass="button01" value="切换" rendered="#{user_loginBB.haveMultiRole}" action="#{user_loginBB.changeRole}"></h:commandButton>
<c:verbatim>
      </td>
   
    <td height="22" width="180" align="right" bgcolor=red>
      <table width="95%" border="0" cellpadding="0" cellspacing="5">
      <tr>
          <td><img src="../images/maininterface/icon_h.gif" width="13" height="13"></td>
          <td><a href="javascript:doModifyPassword();"><%if ("1".equals(Constants.MODIPASS_SUPPORT)) out.print(LanguageSupport.getResource("COMM-0003","修改密码"));%></a></td>
          <td width="13"><img src="../images/maininterface/icon_e.gif" width="13" height="13"></td>
          <td><a href="/pages/LogOff.jsp" class="a01">退出</a></td>
      </tr>
    </table>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td align="center">
        <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                src="<%=url%>" >
        </iframe>
        </td>
  </tr>
</table>
</c:verbatim>    
 </h:form>
