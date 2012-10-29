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
            document.getElementById("main").style.height = "" + mainHeight + "px";
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
  if(user!=null){
      hashMenus = user.getPmsMenus();
      moduleId = request.getParameter("moduleid");
      menu =(MenuObj) hashMenus.get(moduleId);
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
              <td width="10"   nowrap></td>
              <td bgcolor="#2074C5" width="<%if(menu!=null) if(menu.getMenus()!=null) out.print(menu.getMenus().size()*25);%>">
                  <script type="text/javascript" language="JavaScript1.2">
                        <%
                           if(menu != null){
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
          <td width="13"><img src="../images/maininterface/icon_r.gif" width="13" height="13"></td>
          <td><a onmouseover='Enter_Lable()'  onmouseout='Exit_Lable()'  class="a01">功能模块</a></td>

          <td width="13"><img src="../images/maininterface/icon_h.gif" width="13" height="13"></td>
          <td><a href="/MainInterface/Main.jsf" class="a01">首页</a></td>

          <td width="13"><img src="../images/maininterface/icon_e.gif" width="13" height="13"></td>
         <td><a href="/pages/LogOff.jsp" class="a01">退出</a></td>
      </tr>
    </table>
    </td>
  </tr>
</table>

  <div id='ModuleShow' onmouseout='Exit_Div()' onmouseover='Enter_Div()' style='BORDER-RIGHT:black 1px solid;BORDER-TOP:black 1px solid;BORDER-LEFT:black 1px solid;BORDER-BOTTOM:black 1px solid;Z-INDEX:180;TABLE-LAYOUT: fixed; FONT-SIZE: 9pt;BACKGROUND-COLOR: #f0f8ff;LEFT:"+divleft+"px;TOP:85px;POSITION: absolute;VISIBILITY:hidden;Width:120px;HEIGHT:350px;'>
    <table>
        <%
          if(hashMenus != null && hashMenus.get(OperateBO.ORGMODULEID)!=null && !OperateBO.ORGMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.ORGMODULEID+"'> <font size='2pt' color='blue'>机构管理</font></a> </td>");
              out.println("</tr>");
          }

          if(hashMenus != null && hashMenus.get(OperateBO.POSTMODULEID)!=null && !OperateBO.POSTMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.POSTMODULEID+"'> <font size='2pt' color='blue'>岗位管理</font></a> </td>");
              out.println("</tr>");
          }

          if(hashMenus != null && hashMenus.get(OperateBO.PERMODULEID)!=null && !OperateBO.PERMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.PERMODULEID+"'> <font size='2pt' color='blue'>人员管理</font></a> </td>");
              out.println("</tr>");
          }
          if(hashMenus != null && hashMenus.get(OperateBO.ATTMODULEID)!=null && !OperateBO.ATTMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.ATTMODULEID+"'> <font size='2pt' color='blue'>考勤管理</font></a> </td>");
              out.println("</tr>");
          }
          if(hashMenus != null && hashMenus.get(OperateBO.WAGEMODULEID)!=null && !OperateBO.WAGEMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.WAGEMODULEID+"'> <font size='2pt' color='blue'>薪资管理</font></a> </td>");
              out.println("</tr>");
          }

          if(hashMenus != null && hashMenus.get(OperateBO.INSURMODULEID)!=null && !OperateBO.INSURMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.INSURMODULEID+"'> <font size='2pt' color='blue'>保险管理</font></a> </td>");
              out.println("</tr>");
          }

          if(hashMenus != null && hashMenus.get(OperateBO.CONTMODULEID)!=null && !OperateBO.CONTMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.CONTMODULEID+"'> <font size='2pt' color='blue'>合同管理</font></a> </td>");
              out.println("</tr>");
          }
           if(hashMenus != null && hashMenus.get(OperateBO.EVAMODULEID)!=null && !OperateBO.EVAMODULEID.equals(moduleId)){
                out.println("<tr>");
                out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.EVAMODULEID+"'> <font size='2pt' color='blue'>绩效管理</font></a> </td>");
                out.println("</tr>");
            }
            if(hashMenus != null && hashMenus.get(OperateBO.TRAINMODULEID)!=null && !OperateBO.TRAINMODULEID.equals(moduleId)){
                 out.println("<tr>");
                 out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.TRAINMODULEID+"'> <font size='2pt' color='blue'>培训管理</font></a> </td>");
                 out.println("</tr>");
             }
            if(hashMenus != null && hashMenus.get(OperateBO.TESTMODULEID)!=null && !OperateBO.TESTMODULEID.equals(moduleId)){
                 out.println("<tr>");
                 out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.TESTMODULEID+"'> <font size='2pt' color='blue'>考试管理</font></a> </td>");
                 out.println("</tr>");
             }
            if(hashMenus != null && hashMenus.get(OperateBO.MONITORMODULEID)!=null && !OperateBO.MONITORMODULEID.equals(moduleId)){
                 out.println("<tr>");
                 out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.MONITORMODULEID+"'> <font size='2pt' color='blue'>监督执法</font></a> </td>");
                 out.println("</tr>");
             }

            if(hashMenus != null && hashMenus.get(OperateBO.RECUMODULEID)!=null && !OperateBO.RECUMODULEID.equals(moduleId)){
                 out.println("<tr>");
                 out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.RECUMODULEID+"'> <font size='2pt' color='blue'>招聘管理</font></a> </td>");
                 out.println("</tr>");
             }

          if(hashMenus != null && hashMenus.get(OperateBO.QUERYMODULEID)!=null && !OperateBO.QUERYMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.QUERYMODULEID+"'> <font size='2pt' color='blue'>查询管理</font></a> </td>");
              out.println("</tr>");
          }

          if(hashMenus != null && hashMenus.get(OperateBO.RPTMODULEID)!=null && !OperateBO.RPTMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.RPTMODULEID+"'> <font size='2pt' color='blue'>报表管理</font></a> </td>");
              out.println("</tr>");
          }

          if(hashMenus != null && hashMenus.get(OperateBO.RUNMODULEID)!=null && !OperateBO.RUNMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.RUNMODULEID+"'> <font size='2pt' color='blue'>运行管理</font></a> </td>");
              out.println("</tr>");
          }

          if(hashMenus != null && hashMenus.get(OperateBO.SYSMODULEID)!=null && !OperateBO.SYSMODULEID.equals(moduleId)){
              out.println("<tr>");
              out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.SYSMODULEID+"'> <font size='2pt' color='blue'>系统管理</font></a> </td>");
              out.println("</tr>");
          }
        %>
        </table>
  </div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td align="center">
        <iframe name="main" frameborder="0"  scrolling="auto" width="100%"
                src="<%
                String funid="";
                if (moduleId.equals(OperateBO.ORGMODULEID)){
                    // 0103	机构信息维护
                    funid="0103";
                }  else if (moduleId.equals(OperateBO.PERMODULEID)){
                    // 0311	信息维护
                    funid="0311";
                }  else if (moduleId.equals(OperateBO.POSTMODULEID)){
                    // 0217	岗位维护
                    funid="0217";
                }  else if (moduleId.equals(OperateBO.CONTMODULEID)){
                    // 合同信息
                    funid="0426";
                }  else if (moduleId.equals(OperateBO.WAGEMODULEID)){
                    // 0648	薪资项目录入与计算
                    funid="0648";
                }  else if (moduleId.equals(OperateBO.INSURMODULEID)){
                    //1411	数据处理
                    funid="1411";
                }  else if (moduleId.equals(OperateBO.QUERYMODULEID)){
                    //1055	人员查询
                    funid="1055";
                }  else if (moduleId.equals(OperateBO.RPTMODULEID)){
                    // 0721	报表生成
                    funid="0721";
                }  else if (moduleId.equals(OperateBO.RUNMODULEID)){
                    //0930	日志查看
                    funid="0894";
                }  else if (moduleId.equals(OperateBO.SYSMODULEID)){
                    //0905	指标管理
                    funid="0905";
                }  else if (moduleId.equals(OperateBO.EVAMODULEID)){
                    funid="1514";
                }
                else if (moduleId.equals(OperateBO.TRAINMODULEID)){
                    funid="1842";
                }
                else if (moduleId.equals(OperateBO.ATTMODULEID)){
                    funid="0523";
                }

                OperateBO obo;
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
                %>" >
        </iframe>
        </td>
  </tr>
</table>
 </form>

<script language="javascript">
    var divleft=document.body.clientWidth*0.86;
    document.all('ModuleShow').style.left=divleft;
    document.body.scroll="no";
</script>
</body>
</html>
