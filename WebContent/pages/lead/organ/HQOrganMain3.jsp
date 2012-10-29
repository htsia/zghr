<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="com.hr319wg.user.service.UserManageService" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.user.pojo.bo.SelfOperateBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.user.pojo.bo.DeskTopOperateBO" %>

<%@ include file="../../include/taglib.jsp" %>
<%
   response.setHeader("progma", "no-cache");
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 120;
            document.getElementById("main").style.height = "" + mainHeight + "px";
            document.getElementById("tree").style.height = "" + (mainHeight-30) + "px";
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
            document.main.location.href=url;
        }
        function goSys(){
            document.all('form1:gotoSys').click();
        }
    </script>
</c:verbatim>

<%@ include file="/pages/include/menu.jsp" %>

<%
    User user =  (User) session.getAttribute(Constants.USER_INFO);
    UserManageService us = (UserManageService) SysContext.getBean("user_userManageService");
    
    String url = request.getParameter("url");
    if (url == null || "".equals(url)) {
        DeskTopOperateBO sb = us.getDeskTopOperateBO("0401");
        url = sb.getUrl();
    }
%>

<h:form id="form1">
    <h:commandButton id="gotoSys" action="#{user_loginBB.gotoSys}" value="业务" style="display:none"></h:commandButton>
    <c:verbatim>
        <table width="100%" border="0" cellpadding="0" height="72" cellspacing="0" background="/images/maininterface/hd_top3.jpg" >
        <tr>
            <td width="30" >&nbsp;</td>
            <td width="40" ><img src="/images/maininterface/logo.jpg" align="left" alt="" height="58" valign="top"></td>
            <td  width="40%" align="left">
                <span style="font-size:30px; color:#ffffff; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px;"><%=Constants.TITLE_NAME%></span>
           </td>
            <td align="right" >
                <font color="white"><%=user.getName()%>，您好！ 欢迎登录<% out.println(Constants.SYSTEM_NAME+Constants.LEAD_SYSTEM_NAME);%><br>上次登录：<%=user.getLastLoginTime()%>今天第<%=user.getTodayTimes()%>次登录本系统</font>
            </td>
       </tr>
      </table>
    </c:verbatim>

     <c:verbatim>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td height="22"  align="right" bgcolor="#2693B4"> &nbsp
      </td>

      <td height="22"  align="right" bgcolor="#2693B4">
          <table width="280" border="0" cellpadding="0" cellspacing="5">
          <tr>
              <td>&nbsp;</td>
              <td>
                  <img src="/images/maininterface/icon_r.gif" width="13" height="13"><a href='javascript:goSys();'>HR系统</a>
              </td>
              <td id="modipass">
                  <img src="/images/maininterface/icon_h.gif" width="13" height="13">
                  <a href="javascript:doModifyPassword();"><%=LanguageSupport.getResource("COMM-0003","修改密码")%></a>
              </td>
              <script type="text/javascript">
                  <%
                      if (!"1".equals(Constants.MODIPASS_SUPPORT)){
                         out.println("document.all('modipass').style.display='none';");
                      }
                  %>
              </script>
              <td>
                  <img src="/images/maininterface/icon_e.gif" width="13" height="13">
                  <a href="/pages/LogOff.jsp" class="a01">退出</a>
              </td>
          </tr>
        </table>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
            <td id="showTree" align="left" width=200>
                  <table width=100%>
                  <tr><td height=8>
</c:verbatim>
                      <h:inputText id="name" style="width:80px"></h:inputText>
                      <h:commandButton value="查询" styleClass="button01" onclick="doQuery();" type="button"></h:commandButton>
                      <h:commandButton value="浏览" styleClass="button01" onclick="doNavigate();" type="button"></h:commandButton>
<c:verbatim>    
                  </td></tr>

                  <tr><td>
                      <iframe name="tree" style="height:100%;width:100%" src="/pages/ShowDTOperateTree.jsp"></iframe>
                  </td></tr>
                  </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
            </td>

          <td align="center" valign="top">
            <iframe name="main" frameborder="0"  scrolling="auto" width="100%"   src="<%=url%>" >
            </iframe>
          </td>
  </tr>
</table>
</c:verbatim>
 </h:form>
    <script language="javascript">
    function doQuery(){
        var name=document.all('form1:name').value;
        if (name==""){
            alert('请输入姓名、姓名简拼或员工编号!');
            return false;
        }
        var url="/desktop/PersonInfoList.jsf?superId=<%=Constants.ORG_BENBU%>&&queryMode=true&filter=(p.name like '%"+name+"%' or p.shortName like '%"+name+"%' or p.personCode like '%"+name+"%')";
        document.main.location.href=url;
    }
    function doNavigate(){
        document.main.location.href='/lead/chart/OrgChartIndex.jsf';
    }
</script>