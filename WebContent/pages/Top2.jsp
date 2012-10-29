<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%
    User curuser = (User) session.getAttribute(Constants.USER_INFO);
    String curlan=curuser.getLoginLang();
%>

<table width="100%" border="0" cellpadding="0" cellspacing="0" background="/images/maininterface/hd_top.jpg" style="backgroud:#1F93B8">
<tr>
    <td width="40" height="58">&nbsp;</td>
    <td width="40" height="58"><img src="/images/maininterface/logo.jpg" align="left" alt="" height="58" valign="top"></td>
    <td  width="60%" align="center">
        <span style="font-size:30px; color:#ffffff; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px;"><%=LanguageSupport.getParaValue("TITLE_NAME",curlan)%></span>
   </td>
    <td  align="right" >
         <table height="58" width="100" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td valign="top" width="81"><a href="/MainInterface/Main2.jsf"><img src="<%=LanguageSupport.getImg("/images/maininterface/","hd_home.jpg",curlan)%>"   border="0" ></a></td>
            <td valign="top" id="selfButton" width="69">
               <a onclick="javascript:document.all('form1:gotoSelf').click();" style="cursor:hand"> <img src="<%=LanguageSupport.getImg("/images/maininterface/","hd_member.jpg",curlan)%>" ></a>
            </td>
            <td valign="top" width="69"><a href="../pages/LogOff.jsp" class="a01"><img src="<%=LanguageSupport.getImg("/images/maininterface/","hd_exit.jpg",curlan)%>" alt=""  border="0"></a></td>
          </tr>
        </table>
    </td>
   </tr>
  </table>

