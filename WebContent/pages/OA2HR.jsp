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
            var mainHeight = document.body.clientHeight - 5;
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


<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor=<%=Constants.BGCOLOR%>>
  <tr>
    <td class="F02"></td>
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
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
        </table>

        </td>
    <td align="right" class="F02"></td>
    <td width="14" class="F02"></td>
  </tr>
</table>
  
 <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td align="center">
        <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
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


</body>
</html>
