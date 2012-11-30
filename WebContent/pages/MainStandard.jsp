<%@page import="com.hr319wg.custom.util.CommonUtil"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.user.ucc.IUserManageUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="./include/taglib.jsp" %>
<c:verbatim>
<script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    
<script language="javascript">
    with (window) onload = onresize = function(){
        var mainHeight = document.body.clientHeight - 120;
        $("iframe[name=main]").height(mainHeight);
        $("iframe[name=tree]").height(mainHeight);
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
    function refreshFun(url){
    	$("iframe[name=main]").attr("src",url);
    }
    function refreshMain(){
         window.location="/MainInterface/MainStandard.jsf?moduleId=HOMEPAGE";
    }
</script>
<body scroll="no">
</c:verbatim>

<%
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String moduleId = request.getParameter("moduleId");
    String funUrl = request.getParameter("funUrl");
    if (moduleId == null || "".equals(moduleId)) {
        moduleId = (String) session.getAttribute("moduleId");
    }
    if (moduleId == null || "".equals(moduleId)) {
        moduleId = "HOMEPAGE";
    }
    session.setAttribute("moduleId", moduleId);
    Hashtable hashMenus = user.getPmsMenus();
%>

<h:form id="form1">
<f:verbatim>
      <table width="100%" border="0" cellpadding="0" height="70" cellspacing="0"  background="/images/maininterface/hd_top2.jpg">
        <tr>
            <td width="10" >&nbsp;</td>
            <td width="40">
                <img src="/<%=CommonUtil.getSYS_INTERFACE()[1]%>" />
            </td>
            <td align="right" valign="top">
                 <table height="58" width="100" border="0" cellspacing="0" cellpadding="0" style="margin-top:1px;">
                  <tr>
                    <td valign="top" width="81"><a href="/MainInterface/MainStandard.jsf?moduleId=HOMEPAGE"><img src="<%=LanguageSupport.getImg("/images/maininterface/","hd_home.jpg")%>"   border="0" ></a></td>
                    <td valign="top" width="69">
                    </f:verbatim>
                          <h:commandButton id="gotoSelf" action="#{user_loginBB.gotoSelf}" value="自助" style="display:none" />
                    <f:verbatim>
                    <a onclick="javascript:document.all('form1:gotoSelf').click();" style="cursor:hand"> <img src="<%=LanguageSupport.getImg("/images/maininterface/","hd_member.jpg")%>" ></a>
                    </td>
                    <td valign="top" width="69"><a href="../pages/LogOff.jsp" class="a01"><img src="<%=LanguageSupport.getImg("/images/maininterface/","hd_exit.jpg")%>" alt=""  border="0"></a></td>
                  </tr>
                </table>
            </td>
           </tr>
        </table>

        <table border="0" width="100%" cellpadding="0" height="31" cellspacing="0"  background="/images/maininterface/hd_top_menu.jpg">
            <tr height=31>
                <td width=2></td>
                <%
                    String width="65";
                    String title="";
                    int len;
                    if(hashMenus != null && hashMenus.get(OperateBO.ORGMODULEID) != null){
                        title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.ORGMODULEID);
                        len=title.getBytes().length;
                        if (len<8){
                            width="40";
                        }
                        else{
                            width="65";
                        }
                %>
                <td width=10></td>
                <td id="JGGL_TD" class="maintabinactive" width=<%=width%> align="center">
                   <a href="/MainInterface/MainStandard.jsf?moduleId=JGGL"><div class="top_menu_title"><%=title%></div></a>
                <%}%>

                <%if(hashMenus != null && hashMenus.get(OperateBO.POSTMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.POSTMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                %>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td id="GWGL_TD" class="maintabinactive" width=<%=width%> align="center">
                   <a href="/MainInterface/MainStandard.jsf?moduleId=GWGL"><div class="top_menu_title"><%=title%></div></a>
                 <%}%>
                 <%if(hashMenus != null && hashMenus.get(OperateBO.PERMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.PERMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                 %>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td id="RYGL_TD" class="maintabinactive" width=<%=width%> align="center">
                   <a href="/MainInterface/MainStandard.jsf?moduleId=RYGL"><div class="top_menu_title"><%=title%></div></a>
                <%}%>
                <%if(hashMenus != null && hashMenus.get(OperateBO.CHANGEMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.CHANGEMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                %>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td id="RYDP_TD" class="maintabinactive" width=<%=width%> align="center">
                   <a href="/MainInterface/MainStandard.jsf?moduleId=RYDP"><div class="top_menu_title"><%=title%></div></a>
                <%}%>
                <%if(hashMenus != null && hashMenus.get(OperateBO.WAGEMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.WAGEMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                %>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td id="XCGL_TD" class="maintabinactive" width=<%=width%> align="center">
                   <a href="/MainInterface/MainStandard.jsf?moduleId=XCGL"><div class="top_menu_title"><%=title%></div></a>
                <%}%>

                <%if(hashMenus != null && hashMenus.get(OperateBO.INSURMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.INSURMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                %>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td id="BXGL_TD" class="maintabinactive" width=<%=width%> align="center">
                   <a href="/MainInterface/MainStandard.jsf?moduleId=BXGL"><div class="top_menu_title"><%=title%></div></a>
                <%}%>

                    <%if(hashMenus != null && hashMenus.get(OperateBO.TITLEMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.TITLEMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                    %>
                    <td id="ZCPS_TD" class="maintabinactive" width=<%=width%> align="center">
                       <a href="/MainInterface/MainStandard.jsf?moduleId=ZCPS"><div class="top_menu_title"><%=title%></div></a>
                    <%}%>
                    <%if(hashMenus != null && hashMenus.get(OperateBO.CONTMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.CONTMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                    %>
					<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                    <td id="HTGL_TD" class="maintabinactive" width=<%=width%> align="center">
                       <a href="/MainInterface/MainStandard.jsf?moduleId=HTGL"><div class="top_menu_title"><%=title%></div></a>
                    <%}%>
                    <%if(hashMenus != null && hashMenus.get(OperateBO.ATTMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.ATTMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                    %>
					<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                    <td id="KQGL_TD" class="maintabinactive" width=<%=width%> align="center">
                       <a href="/MainInterface/MainStandard.jsf?moduleId=KQGL"><div class="top_menu_title"><%=title%></div></a>
                    <%}%>
                <%if(hashMenus != null && hashMenus.get(OperateBO.RECUMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.RECUMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                %>
                <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td id="ZPGL_TD" class="maintabinactive" width=<%=width%> align="center">
                   <a href="/MainInterface/MainStandard.jsf?moduleId=ZPGL"><div class="top_menu_title"><%=title%></div></a>
                <%}%>
                 <%if(hashMenus != null && hashMenus.get(OperateBO.EVAMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.EVAMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                 %>
                 <td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                <td id="JXGL_TD" class="maintabinactive" width=<%=width%> align="center">
                   <a href="/MainInterface/MainStandard.jsf?moduleId=JXGL"><div class="top_menu_title"><%=title%></div></a>
                </td>
                <%}%>
                <%if(hashMenus != null && hashMenus.get(OperateBO.TRAINMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.TRAINMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                %>
				<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                    <td id="PXGL_TD" class="maintabinactive" width=<%=width%> align="center">
                       <a href="/MainInterface/MainStandard.jsf?moduleId=PXGL"><div class="top_menu_title"><%=title%></div></a>
                <%}%>
               <%if(hashMenus != null && hashMenus.get(OperateBO.LEARNMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.LEARNMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                   %>
					<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                    <td id="ZXXX_TD" class="maintabinactive" width=<%=width%> align="center">
                       <a href="/MainInterface/MainStandard.jsf?moduleId=ZXXX"><div class="top_menu_title"><%=title%></div></a>
                <%}%>
                <%if(hashMenus != null && hashMenus.get(OperateBO.MONITORMODULEID) != null){
                    title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.MONITORMODULEID);
                    len=title.getBytes().length;
                    if (len<8){
                        width="40";
                    }
                    else{
                        width="65";
                    }
                %>
				<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                    <td id="MKZF_TD" class="maintabinactive" width=<%=width%> align="center">
                       <a  href="/MainInterface/MainStandard.jsf?moduleId=MKZF"><div class="top_menu_title"><%=title%></div></a>
                    <td>
                 <%}%>

                         <%if(hashMenus != null && hashMenus.get(OperateBO.RPTMODULEID) != null){
                        title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.RPTMODULEID);
                        len=title.getBytes().length;
                        if (len<8){
                            width="40";
                        }
                        else{
                            width="65";
                        }
                         %>
						<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                         <td id="BBGL_TD" class="maintabinactive" width=<%=width%> align="center">
                            <a href="/MainInterface/MainStandard.jsf?moduleId=BBGL"><div class="top_menu_title"><%=title%></div></a>
                         <%}%>

                         <%if(hashMenus != null && hashMenus.get(OperateBO.QUERYMODULEID) != null){
                            title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.QUERYMODULEID);
                            len=title.getBytes().length;
                            if (len<8){
                                width="40";
                            }
                            else{
                                width="65";
                            }
                         %>
						<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                         <td id="CXGL_TD" class="maintabinactive" width=<%=width%> align="center">
                            <a href="/MainInterface/MainStandard.jsf?moduleId=CXGL"><div class="top_menu_title"><%=title%></div></a>
                         <%}%>

                    <%if(hashMenus != null && hashMenus.get(OperateBO.RUNMODULEID) != null){
                            title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.RUNMODULEID);
                            len=title.getBytes().length;
                            if (len<8){
                                width="40";
                            }
                            else{
                                width="65";
                            }
                    %>
					<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                    <td id="YXGL_TD" class="maintabinactive" width=<%=width%> align="center">
                       <a href="/MainInterface/MainStandard.jsf?moduleId=YXGL"><div class="top_menu_title"><%=title%></div></a>
                    <%}%>
                    <%if(hashMenus != null && hashMenus.get(OperateBO.SYSMODULEID) != null){
                            title=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.SYSMODULEID);
                            len=title.getBytes().length;
                            if (len<8){
                                width="40";
                            }
                            else{
                                width="65";
                            }
                    %>
					<td width=11 align="middle"><img src="/images/maininterface/top_menu_sp.jpg" /></td>
                    <td id="XTGL_TD" class="maintabinactive" width=<%=width%> align="center">
                       <a href="/MainInterface/MainStandard.jsf?moduleId=XTGL"><div class="top_menu_title"><%=title%></div></a>
                    <td>
                    <%}%>
                <td>&nbsp;</td>
           </tr>
          </table>
            
        <table width="100%" height="500" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
              <tr>
                <%if (!"HOMEPAGE".equals(moduleId)){%>
                      <td id="showTree" align="left" width="200" valign="top">
                            <iframe name="tree" height="400"  frameborder="no" border="0" marginwidth="0" marginheight="0" style="height:100%;width:100%;border:10px" src="/pages/ShowOperateTree.jsp"></iframe>
                      </td>
                      <td width="10" class="ctrlbar" valign="middle">
                          <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
                      </td>
                <%
                    }
                %>

                <td align="right" valign="top">
                    <iframe name="main" height="100%"  frameborder="0"  height=400 scrolling="no" width="100%" src="<%
                if ("HOMEPAGE".equals(moduleId)){
                     out.print("/MainInterface/FirstPage.jsf");
                }
                else if (funUrl!=null && !"".equals(funUrl)){
                    out.print(funUrl);
                }
                else{
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
                    }  else if (moduleId.equals(OperateBO.RUNMODULEID)){
                        //0930	日志查看
                        funid="0894";
                    }  else if (moduleId.equals(OperateBO.SYSMODULEID)){
						//0905	指标管理
						//funid="0905";
						//0915	导航图
                        funid="0915";
                    }  else if (moduleId.equals(OperateBO.EVAMODULEID)){
                        funid="1514";
                    }
                    else if (moduleId.equals(OperateBO.TRAINMODULEID)){
                        funid="1842";
                    }
                    else if (moduleId.equals(OperateBO.ATTMODULEID)){
                        funid="0523";
                    }
                    else if (moduleId.equals(OperateBO.PARTYMODULEID)){
                        funid="2121";
                    }
                    else if (moduleId.equals(OperateBO.LABORMODULEID)){
                        funid="3711";
                    }
                       OperateBO obo;
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
                %>">  </iframe>
                </td>
              </tr>
            <tr bgcolor="#2096BA">
              <td height="30px" nowrap colspan="3" valign="top" align="right"><%=Constants.COPY_RIGHT%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            </tr>

        </table>
</body>
</f:verbatim>
</h:form>
<script language="javascript">
   document.all("<%=moduleId%>"+ "_TD").className="maintabactive";
</script>
