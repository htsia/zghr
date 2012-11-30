<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.user.ucc.IUserManageUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>

<%@ include file="./include/taglib.jsp" %>
<%
   response.setHeader("progma", "no-cache");
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
<title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript" language="javascript" src="/js/check.js"></script>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        with (window) onload = onresize = function(){
            var mainHeight = document.body.clientHeight - 95;
            $("iframe[name=main]").height(mainHeight);
        }
        if ("1"=="<%=Constants.BUSI_MENU_CONFIG%>"){
            mmenucolor = '<%=Constants.MENU_COLOR%>';
            mfontcolor='<%=Constants.MENU_FONT_COLOR%>';
            mmenuoutbordercolor='<%=Constants.MENU_OUT_BORDER_COLOR%>';
            mmenuinbordercolor='<%=Constants.MENU_IN_BORDER_COLOR%>';
            mmenuoutcolor = '<%=Constants.MENU_OUT_COLOR%>';
            mmenuincolor = '<%=Constants.MENU_IN_COLOR%>';
            mmenuovercolor = '<%=Constants.MENU_OVER_COLOR%>';
            mmidoutcolor = '<%=Constants.MENUID_OUT_COLOR%>';
            mmidincolor ='<%=Constants.MENUID_IN_COLOR%>';
        }
    </script>
</head>
<body>
    <%@ include file="./include/menu.jsp" %>

<%
  User user =  (User) session.getAttribute(Constants.USER_INFO);
   MenuObj menu=new  MenuObj();
  if(user!=null){
      IUserManageUCC rc = (IUserManageUCC) SysContext.getBean("user_userManageUccImpl");
      menu=rc.getJZMenu(user);
      url =  request.getParameter("url");
      if (url!=null) {
          url=url.replaceAll("~~","\\&");
      }
   }
%>
<form>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <tr>
         <td width=260 height=62 background="/images/maininterface/logo.jpg"></td>
         <td width=450 align="left" height=62 background="../images/maininterface/toptitle.gif">
             <span style="font-size:30px; color:#000000; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px; width:450px;"><%=Constants.TITLE_NAME%></span>
         </td>
         <td background="../images/maininterface/toptitle_extend.gif" align="right">
             <%=user.getName()%>，您好！ 欢迎登录<% out.println(Constants.SYSTEM_NAME);%><br><a href="/system/QueryOwnLog.jsf" target="_blank">上次登录：<%=user.getLastLoginTime()%>这是您今天第<%=user.getTodayTimes()%>次登录本系统</a>
         </td>
        </tr>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="22" bgcolor="#2074C5">
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="5"   nowrap></td>
              <td bgcolor="#2074C5" width="<%if(menu!=null) if(menu.getMenus()!=null) out.print(menu.getMenus().size()*25);%>">
                  <script type="text/javascript" language="JavaScript1.2">
                        <%                           if(menu != null){

                                subMenuCount=0;
                                LoadChildMenu(menu,"",out,true);
                                out.println("showMenu();");
                           }
                        %>
                    </script>
               </td>
            </tr>
        </table>
    </td>

    <td height="22" width="180" align="right" bgcolor=red>
      <table width="95%" border="0" cellpadding="0" cellspacing="5">
      <tr>
          <td width="13"><img src="../images/maininterface/icon_h.gif" width="13" height="13"></td>
          <td><a href="javascript:doModifyPassword();">个人设置</a></td>

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
        <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"  src="
        <%
                OperateBO obo;
                String funid="2121";
                if(url!=null && !url.equals("")) {
                   out.print(url);
                } else {
                   IUserManageUCC ic=(IUserManageUCC)SysContext.getBean("user_userManageUccImpl");
                   List list = ic.queryUserOperate(user.getUserId());
                   boolean has=false;
                   if (list!=null){
                       for(int i=0;i<list.size();i++){
                           obo =(OperateBO)list.get(i);
                           if (obo.getOperateId().equals(funid)){
                             has=true;
                             out.print(obo.getUrl());
                             break;
                           }
                       }
                       //  如果没有则取第一个
                       if (!has){
                               for(int i=0;i<list.size();i++){
                               obo =(OperateBO)list.get(i);
                               if (obo.getModuleID()!=null && obo.getModuleID().equals(moduleId) && obo.getUrl()!=null && !obo.getUrl().equals("")){
                                 out.print(obo.getUrl());
                                 break;
                               }
                           }
                       }
                   }
                }
        %>
        " >
        </iframe>
        </td>
  </tr>
</table>
 </form>

</body>
</html>
