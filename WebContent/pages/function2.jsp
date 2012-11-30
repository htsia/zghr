<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.user.ucc.IUserManageUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

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
    <style type="text/css">
    .menu{
	width:147px;
	height:auto;
	position:absolute;
	z-index:10000;
	top:105px;
	right:0px;
}
.menu_1{ width:132px; height:auto; float:left; background:url(/images/maininterface/hd_mn_2.gif) center center repeat-y; padding:0 5px 0 10px; font-size:12px; color:#000000;
}
.menu_1 ul{ padding:0 ; margin:0; float:left; width:132px; float:left; height:auto;
}
.menu_1 ul li{ list-style:none; width:112px; height:24px; float:left; line-height:24px; padding:0 0 0 20px; border-bottom:1px dashed #99BDE6; cursor:hand;
}
.menu_2{ width:147px; height:auto; float:left; 
}
.btu{ width:14px; height:275px; position:absolute;
	z-index:20000;
	top:105px;
	right:0px;
}	
}
</style>
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

        // 关联操作
        function LinkOper(url){
            document.main.location.href = url;
        }
    </script>
   <script type="text/javascript">
   	function showMenu1(){
   	  document.getElementById("btu").style.visibility="hidden";
   	  document.getElementById("menu1").style.visibility="visible";
   	}
   	function hidenMenu1(){
   	 	document.getElementById("menu1").style.visibility="hidden";
    	document.getElementById("btu").style.visibility="visible";
   	}
   	function showMenu2(){
     	  document.getElementById("btu").style.visibility="hidden";
     	  document.getElementById("menu1").style.visibility="visible";
     }
    function hidenMenu2(){
     	document.getElementById("menu1").style.visibility="hidden";
      	document.getElementById("btu").style.visibility="visible";
    }
//     //document.oncontextmenu=function(e){return false;}   
   </script>

</head>
<body>
    <%@ include file="./include/menu.jsp" %>

<%
  User user =  (User) session.getAttribute(Constants.USER_INFO);
  if(user!=null){
      hashMenus = user.getPmsMenus();
      moduleId = request.getParameter("moduleid");
      if (moduleId==null || "".equals(moduleId)){
           moduleId=OperateBO.PERMODULEID;
      }
      menu =(MenuObj) hashMenus.get(moduleId);
      url =  request.getParameter("url");
      if (url!=null) {
          url=url.replaceAll("~~","\\&");
      }
      lang=user.getLoginLang();
   }
%>
<form>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>
            <jsp:include page="/pages/Top2.jsp">
                <jsp:param name="init" value="true"/>
            </jsp:include>
        </td>
      </tr>
     </table> 

    <table width="100%" border="0" cellpadding="0" cellspacing="0" background="/images/maininterface/hd_nav_unsel.gif">
      <tr>
        <td width="20" height="30">&nbsp;</td>
        <td class="F02"></td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
                <tr>
                  <td width="<%if(menu!=null) if(menu.getMenus()!=null) out.print(menu.getMenus().size()*25);%>">
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
            </table></td>
        <td align="right" class="F02"></td>
        <td width="14" class="F02"></td>
      </tr>
    </table>
  
    <div class="btu" style="visibility:visible;" id="btu" ><img src="/images/maininterface/hd_mn_4.gif" onmouseover="showMenu1()" onmouseout="hidenMenu1()"/></div>
    <div class="menu" style="visibility:hidden;" id="menu1" onmouseover="showMenu2()" onmouseout="hidenMenu2()">
       <div class="menu_2"><img src="/images/maininterface/hd_mn_1.gif" width="147"  align="top" /></div>
       <div class="menu_1">
    <ul>
     <%
              if(hashMenus != null && hashMenus.get(OperateBO.ORGMODULEID)!=null && !OperateBO.ORGMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/position.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.ORGMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.ORGMODULEID,lang)+"</a></li>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.POSTMODULEID)!=null && !OperateBO.POSTMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/role.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.POSTMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.POSTMODULEID,lang)+"</a></li>");
              }
             if(hashMenus != null && hashMenus.get(OperateBO.PARTYMODULEID)!=null && !OperateBO.PARTYMODULEID.equals(moduleId)){
                 out.println("<li><img width='13' height='13' src='/images/maininterface/menu/party.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.PARTYMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.PARTYMODULEID,lang)+"</a></li>");
             }
              if(hashMenus != null && hashMenus.get(OperateBO.PERMODULEID)!=null && !OperateBO.PERMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/AddPerson.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.PERMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.PERMODULEID,lang)+"</a></li>");
              }
             if(hashMenus != null && hashMenus.get(OperateBO.CHANGEMODULEID)!=null && !OperateBO.CHANGEMODULEID.equals(moduleId)){
                 out.println("<li><img width='13' height='13' src='/images/maininterface/menu/form.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.CHANGEMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.CHANGEMODULEID,lang)+"</a></li>");
             }
         if(hashMenus != null && hashMenus.get(OperateBO.LABORMODULEID)!=null && !OperateBO.LABORMODULEID.equals(moduleId)){
             out.println("<li><img width='13' height='13' src='/images/maininterface/menu/cup.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.LABORMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.LABORMODULEID,lang)+"</a></li>");
         }

              if(hashMenus != null && hashMenus.get(OperateBO.ATTMODULEID)!=null && !OperateBO.ATTMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/remind.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.ATTMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.ATTMODULEID,lang)+"</a></li>");
              }
             if(hashMenus != null && hashMenus.get(OperateBO.TITLEMODULEID)!=null && !OperateBO.TITLEMODULEID.equals(moduleId)){
                 out.println("<li><img width='13' height='13' src='/images/maininterface/menu/zhicheng.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.TITLEMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.TITLEMODULEID,lang)+"</a></li>");
             }
              if(hashMenus != null && hashMenus.get(OperateBO.WAGEMODULEID)!=null && !OperateBO.WAGEMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/wage.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.WAGEMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.WAGEMODULEID,lang)+"</a></li>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.INSURMODULEID)!=null && !OperateBO.INSURMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/InfoManage.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.INSURMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.INSURMODULEID,lang)+"</a></li>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.CONTMODULEID)!=null && !OperateBO.CONTMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/log.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.CONTMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.CONTMODULEID,lang)+"</a></li>");
              }
               if(hashMenus != null && hashMenus.get(OperateBO.EVAMODULEID)!=null && !OperateBO.EVAMODULEID.equals(moduleId)){
                    out.println("<li><img width='13' height='13' src='/images/maininterface/menu/orgchart.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.EVAMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.EVAMODULEID,lang)+"</a></li>");
                }
                if(hashMenus != null && hashMenus.get(OperateBO.TRAINMODULEID)!=null && !OperateBO.TRAINMODULEID.equals(moduleId)){
                     out.println("<li><img width='13' height='13' src='/images/maininterface/menu/status.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.TRAINMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.TRAINMODULEID,lang)+"</a></li>");
                 }
                if(hashMenus != null && hashMenus.get(OperateBO.RECUMODULEID)!=null && !OperateBO.RECUMODULEID.equals(moduleId)){
                     out.println("<li><img width='13' height='13' src='/images/maininterface/menu/EditPerson.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.RECUMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.RECUMODULEID,lang)+"</a></li>");
                 }
              if(hashMenus != null && hashMenus.get(OperateBO.QUERYMODULEID)!=null && !OperateBO.QUERYMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/query.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.QUERYMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.QUERYMODULEID,lang)+"</a></li>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.RPTMODULEID)!=null && !OperateBO.RPTMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/operate.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.RPTMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.RPTMODULEID,lang)+"</a></li>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.RUNMODULEID)!=null && !OperateBO.RUNMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/exchange.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.RUNMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.RUNMODULEID,lang)+"</a></li>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.SYSMODULEID)!=null && !OperateBO.SYSMODULEID.equals(moduleId)){
                  out.println("<li><img width='13' height='13' src='/images/maininterface/menu/config.gif'><a  href='/pages/function2.jsp?moduleid="+OperateBO.SYSMODULEID+"'>"+LanguageSupport.translateObjectName(CodeUtil.TYPE_MODULEID,OperateBO.SYSMODULEID,lang)+"</a></li>");
              }
            %>
    </ul>
    </div>
       <div class="menu_2"><img src="/images/maininterface/hd_mn_3.gif" width="147" height="33" align="top" /></div>
    </div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td align="center">
            <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                    src="<%
                    String funid="";
                    if (moduleId.equals(OperateBO.ORGMODULEID)){
                        // 0103	机构信息维护
                        funid="0112";
                    }  else if (moduleId.equals(OperateBO.PERMODULEID)){
                        // 0311	信息维护
                        funid="0320";
                    }  else if (moduleId.equals(OperateBO.POSTMODULEID)){
                        // 0217	岗位维护
                        funid="0201";
                    }  else if (moduleId.equals(OperateBO.CONTMODULEID)){
                        // 合同信息
                        funid="0426";
                        OperateBO oo=SysCacheTool.findOperate("0406");
                        if (oo!=null && "1".equals(oo.getisUse())){
                            funid="0406";
                        }
                    }  else if (moduleId.equals(OperateBO.WAGEMODULEID)){
                        // 0648	薪资项目录入与计算
                        funid="0601";
                    }  else if (moduleId.equals(OperateBO.INSURMODULEID)){
                        //1411	数据处理
                        funid="1409";
                    }  else if (moduleId.equals(OperateBO.QUERYMODULEID)){
                        //1055	人员查询
                        funid="1055";
                    }  else if (moduleId.equals(OperateBO.RPTMODULEID)){
                        // 0721	报表生成
                        funid="0721";
                        OperateBO oo=SysCacheTool.findOperate("0701");
                        if (oo!=null && "1".equals(oo.getisUse())){
                            funid="0701";
                        }
                    }  else if (moduleId.equals(OperateBO.RUNMODULEID)){
                        //0930	日志查看
                        funid="0894";
                    }  else if (moduleId.equals(OperateBO.SYSMODULEID)){
                        //0905	指标管理
                        funid="0905";
                        OperateBO oo=SysCacheTool.findOperate("0915");
                        if (oo!=null && "1".equals(oo.getisUse())){
                            funid="0915";
                        }
                    }  else if (moduleId.equals(OperateBO.EVAMODULEID)){
                        funid="1514";
                            OperateBO oo=SysCacheTool.findOperate("1505");
                            if (oo!=null && "1".equals(oo.getisUse())){
                                funid="1505";
                            }
                    }
                    else if (moduleId.equals(OperateBO.TRAINMODULEID)){
                        funid="1842";
                        OperateBO oo=SysCacheTool.findOperate("1808");
                        if (oo!=null && "1".equals(oo.getisUse())){
                            funid="1808";
                        }
                    }
                    else if (moduleId.equals(OperateBO.ATTMODULEID)){
                        funid="0523";
                            OperateBO oo=SysCacheTool.findOperate("0511");
                            if (oo!=null && "1".equals(oo.getisUse())){
                                funid="0511";
                            }
                    }
                    else if (moduleId.equals(OperateBO.PARTYMODULEID)){
                        funid="2121";
                    }
                    else if (moduleId.equals(OperateBO.LABORMODULEID)){
                        funid="3711";
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
    document.body.scroll="no";
    if (document.all('form1:gotoSelf')==null || document.all('form1:gotoSelf')==undefined){
        document.all('selfButton').style.display="none";
     }
</script>
</body>
</html>
