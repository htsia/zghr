<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String SecondMainUrl = "/pages/function2.jsp";
    int menuCount=0;
    Hashtable hashMenus = user.getPmsMenus();
%>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
    <script language="javascript">
    function showsubmenu(sid){
        whichEl = eval("submenu" + sid);
        imgmenu = eval("imgmenu" + sid);
        if (whichEl.style.display == "none"){
            eval("submenu" + sid + ".style.display=\"\";");
            imgmenu.background="/images/maininterface/hd_main_47.gif";
        }
        else{
            eval("submenu" + sid + ".style.display=\"none\";");
            imgmenu.background="/images/maininterface/hd_main_48.gif";
        }
     }

      function hide(){
            A=document.getElementById('hide').style.display
            if(A=="none"){
                document.getElementById('hide').style.display="block"
                document.getElementById('frameshow').src="/images/button_1.gif";
            }
            if(A=="block"){
                document.getElementById('hide').style.display="none"
                document.getElementById('frameshow').src="/images/button_2.gif";
            }
       }
       function showDetail(id,msg){
            arg="remindid="+id+"&remindmsg="+msg;
            window.showModalDialog("/system/RemResultDetail.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function showQueryResult(qryId){
            window.showModalDialog("/pages/qry/ShowQueryResult.jsp?qryId=" + qryId, null, "dialogWidth:960px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenShortMessage(){
            window.showModalDialog("/system/ShortMessageList.jsf", null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenAdvice(){
            window.showModalDialog("/system/SenderAdvicesList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:no;");
            return false;
        }
        function doOpenForum(){
            window.showModalDialog("/system/ForumList.jsf", null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenUseForum(){
            window.showModalDialog("/system/help/ForumList.jsf", null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function downLoadSoft(){
        	window.showModalDialog("/run/DownFile.jsf", null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function LoadWorkLog(){
        	window.showModalDialog("/OA/WorkLog.jsf", null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

        // 待办事宜处理
        function LinkAction(itemID){
            document.all('form1:operID').value=itemID;
            document.all('form1:processMore').click();
        }
        // 关联操作
        function LinkOper(operID){
            document.all('form1:operID').value=operID;
            document.all('form1:processOper').click();
        }
        function refreshMain(){
             window.location="/MainInterface/Main2.jsf";
        }
    </script>
	
<h:form id="form1">
<f:verbatim>
      <input type="hidden" value="true" id="busimain">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>
         <jsp:include page="/pages/Top2.jsp">
             <jsp:param name="init" value="true"/>
         </jsp:include>

        <table width="100%" border="0" cellpadding="0" cellspacing="0" background="/images/maininterface/hd_nav_unsel.gif">
          <tr>
            <td width="20" height="30">&nbsp;</td>
            <td valign="middle"><img src="/images/maininterface/menu/web-server.gif" align="absmiddle">&nbsp;&nbsp;<% String str=LanguageSupport.getResource("MSG-0001","欢迎使用")+ LanguageSupport.getParaValue("SYSTEM_NAME")+"&nbsp;"+Constants.VERSON;out.print(str);%></td>
            <td width="20" height="30">&nbsp;</td>

             <td height="30" valign="middle">
            </f:verbatim>
                <h:outputText rendered="#{user_loginBB.haveMultiRole}" escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<font color=black>请选择身份(Please Select Role)：</font>"></h:outputText>
                <h:selectOneMenu rendered="#{user_loginBB.haveMultiRole}" value="#{user_loginBB.curRole}">
                      <c:selectItems value="#{user_loginBB.roleList}"></c:selectItems>
                </h:selectOneMenu>
                <h:outputText value=" "></h:outputText>
                <h:commandButton styleClass="button01" value="#{sys_buttonBB.btnSubmit}" rendered="#{user_loginBB.haveMultiRole}" action="#{user_loginBB.changeRole}"></h:commandButton>
                <h:commandButton id="gotoSelf" action="#{user_loginBB.gotoSelf}" value="自助" style="display:none"></h:commandButton>
            <f:verbatim>
             </td>

            <td align="right" class="F04"><a href="javascript:doModifyLanguage();"><%if ("1".equals(Constants.LANGUAGE_SUPPORT)) out.print(LanguageSupport.getResource("COMM-0002","语言设置"));%></a>&nbsp;
            <a href="javascript:doModifyPassword();"><%if ("1".equals(Constants.MODIPASS_SUPPORT)) out.print(LanguageSupport.getResource("COMM-0003","修改密码"));%></a> &nbsp;<a target="_blank" href="/system/NewsBriefMore.jsf"><%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER,"0952")%></a> </td>
            <td width="14" ></td>
          </tr>
        </table>
        </td>
    </tr>

      <tr>
        <td>
            <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
             <td width="180" align="center" valign="top" style="display:block;" id="hide">
             <table width="180" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr><td height="28"   style="background:url(/images/maininterface/hd_main_32.gif) top no-repeat;" ></td></tr>

                <tr>
                    <td height="28" style="background: url(/images/maininterface/hd_main_40.gif) top no-repeat;">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td  height="20" align="center"><font color="white"><%=LanguageSupport.getResource("MSG-0002","管理菜单")%></font></td>
                          </tr>
                        </table>
                    </td>
               </tr>

              <tr>
                <td valign="top">
                  <table width="151" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                      <td height="6"></td>
                  </tr>

                      <tr>
                        <td>
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                            <td height="23" background="/images/maininterface/hd_main_47.gif" id="imgmenu1" class="menu_title" onMouseOver="this.className='menu_title2';" onclick="showsubmenu(1)" onMouseOut="this.className='menu_title';" style="cursor:hand">
                                 <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="18%">&nbsp;</td>
                                    <td width="82%" align="left"><%=LanguageSupport.getResource("MSG-0003","基础模块")%></td>
                                  </tr>
                                </table>
                            </td>
                          </tr>

                          <tr>
                            <td background="/images/maininterface/hd_main_51.gif" id="submenu1">
                            <div class="sec_menu" >
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td>
                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <%if(hashMenus != null && hashMenus.get(OperateBO.ORGMODULEID) != null){ %>
                                  <tr>
                                    <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/position.gif" alt="" width="13" height="13" /></td>
                                    <td width="84%" height="23" align="left">
                                      <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.ORGMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.ORGMODULEID)%></a></td>
                                      </tr>
                                    </table>
                                    </td>
                                  </tr>
                                    <%  }
                                        if(hashMenus != null && hashMenus.get(OperateBO.PARTYMODULEID) != null){ %>
                                      <tr>
                                        <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/party.gif" alt="" width="13" height="13" /></td>
                                        <td width="84%" height="23" align="left">
                                          <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.PARTYMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.PARTYMODULEID)%></a></td>
                                          </tr>
                                        </table>
                                        </td>
                                      </tr>

                                <%}
                                  if(hashMenus != null && hashMenus.get(OperateBO.POSTMODULEID) != null){
                                %>
                                  <tr>
                                    <td height="23" align="center"><img src="/images/maininterface/menu/link.gif" width="13" height="13" /></td>
                                    <td height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.POSTMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.POSTMODULEID)%></a></td>
                                        </tr>
                                    </table>
                                    </td>
                                  </tr>
                                  <%}
                              if(hashMenus != null && hashMenus.get(OperateBO.PERMODULEID) != null){
                                  %>
                                  <tr>
                                    <td height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif" width="13" height="13" /></td>
                                    <td height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.PERMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.PERMODULEID)%></a></td>
                                        </tr>
                                    </table></td>
                                  </tr>

                                    <%}
                                if(hashMenus != null && hashMenus.get(OperateBO.CHANGEMODULEID) != null){
                                    %>
                                    <tr>
                                      <td height="23"><div align="center"><img src="/images/maininterface/menu/form.gif" width="13" height="13" /></div></td>
                                      <td height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.CHANGEMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.CHANGEMODULEID)%></a></td>
                                          </tr>
                                      </table></td>
                                    </tr>

                                  <%}
                              if(hashMenus != null && hashMenus.get(OperateBO.SYSMODULEID) != null){
                                  %>
                                  <tr>
                                    <td height="23" align="center"><img src="/images/maininterface/menu/config.gif" width="13" height="13" /></td>
                                    <td height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.SYSMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.SYSMODULEID)%></a></td>
                                        </tr>
                                    </table></td>
                                  </tr>
                                  <%} %>
                                </table></td>
                              </tr>

                              <tr>
                                <td height="5"><img src="/images/maininterface/hd_main_52.gif" width="151" height="5" /></td>
                              </tr>
                            </table></div></td>
                          </tr>

                        </table></td>
                      </tr>

                      <tr>
                        <td>
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="23" background="/images/maininterface/hd_main_47.gif" id="imgmenu2" class="menu_title" onmouseover="this.className='menu_title2';" onclick="showsubmenu(2)" onmouseout="this.className='menu_title';" style="cursor:hand">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%">&nbsp;</td>
                                  <td width="82%" align="left"><%=LanguageSupport.getResource("MSG-0004","业务模块")%></td>
                                </tr>
                              </table></td>
                          </tr>

                          <tr>
                            <td background="/images/maininterface/hd_main_51.gif" id="submenu2">
                                <div class="sec_menu" >
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td>
                                        <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <%
                                            if(hashMenus != null && hashMenus.get(OperateBO.LABORMODULEID) != null){
                                        %>
                                        <tr>
                                          <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/cup.gif" width="13" height="13" alt=""/></td>
                                          <td width="84%" height="23" align="left">
                                              <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.LABORMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.LABORMODULEID)%></a></td>
                                              </tr>
                                             </table>
                                          </td>
                                        </tr>
                                            <%}
                                                if(hashMenus != null && hashMenus.get(OperateBO.ATTMODULEID) != null){
                                            %>
                                            <tr>
                                              <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/remind.gif" width="13" height="13" alt=""/></td>
                                              <td width="84%" height="23" align="left">
                                                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.ATTMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.ATTMODULEID)%></a></td>
                                                  </tr>
                                                 </table>
                                              </td>
                                            </tr>
                                            <%}
                                                   if(hashMenus != null && hashMenus.get(OperateBO.TITLEMODULEID) != null){
                                            %>
                                            <tr>
                                              <td height="23" align="center"><img src="/images/maininterface/menu/zhicheng.gif" width="13" height="13" /></td>
                                              <td height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.TITLEMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.TITLEMODULEID)%></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                            <%}
                                              if(hashMenus != null && hashMenus.get(OperateBO.CONTMODULEID) != null){
                                            %>
                                            <tr>
                                              <td height="23"  align="center"><img src="/images/maininterface/menu/log.gif" width="13" height="13" /></td>
                                              <td height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.CONTMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.CONTMODULEID)%></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                            <%}
                                              if(hashMenus != null && hashMenus.get(OperateBO.INSURMODULEID) != null){
                                             %>
                                            <tr>
                                              <td width="16%" height="23"  align="center"><img src="/images/maininterface/menu/InfoManage.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.INSURMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.INSURMODULEID)%></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                            <%}
                                              if(hashMenus != null && hashMenus.get(OperateBO.WAGEMODULEID) != null){
                                             %>
                                            <tr>
                                              <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/wage.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.WAGEMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.WAGEMODULEID)%></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                            <%}
                                            if(hashMenus != null && hashMenus.get(OperateBO.EVAMODULEID) != null){
                                            %>
                                             <tr>
                                              <td width="16%" height="23"  align="center"><img src="/images/maininterface/menu/orgchart.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.EVAMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.EVAMODULEID)%></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                            <%}
                                            if(hashMenus != null && hashMenus.get(OperateBO.RECUMODULEID) != null){
                                            %>
                                             <tr>
                                              <td width="16%" height="23"  align="center"><img src="/images/maininterface/menu/EditPerson.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.RECUMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.RECUMODULEID)%></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                            <%}
                                            if(hashMenus != null && hashMenus.get(OperateBO.TRAINMODULEID) != null){
                                            %>
                                             <tr>
                                              <td width="16%" height="23"  align="center"><img src="/images/maininterface/menu/status.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.TRAINMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.TRAINMODULEID)%></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                            <%}
                                            if(hashMenus != null && hashMenus.get(OperateBO.RUNMODULEID) != null){
                                            %>
                                            <tr>
                                              <td width="16%" height="23"  align="center"><img src="/images/maininterface/menu/exchange.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.RUNMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.RUNMODULEID)%></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                            <%} %>
                                        </table></td>
                                  </tr>

                                  <tr>
                                    <td height="5"><img src="/images/maininterface/hd_main_52.gif" width="151" height="5" /></td>
                                  </tr>
                                </table>
                            </div>
                            </td>

                          </tr>
                        </table></td>
                      </tr>
                       <tr>
                        <td>

                         <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="23" id="submenu3_title" background="/images/maininterface/hd_main_47.gif" id="imgmenu3" class="menu_title" onmouseover="this.className='menu_title2';" onclick="showsubmenu(3)" onmouseout="this.className='menu_title';" style="cursor:hand"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%">&nbsp;</td>
                                  <td width="82%" align="left"><%=LanguageSupport.getResource("MSG-0005","决策支持")%></td>
                                </tr>
                            </table>
                            </td>
                          </tr>

                           <tr>
                            <td background="/images/maininterface/hd_main_51.gif" id="submenu3" style="DISPLAY:block">
                               <div class="sec_menu" >
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <%
                                         menuCount=0;
                                         if (hashMenus != null && hashMenus.get(OperateBO.QUERYMODULEID) != null){
                                             menuCount++;
                                         %>
                                        <tr>
                                          <td width="16%" height="25"  align="center"><img src="/images/maininterface/menu/query.gif" width="13" height="13" /></td>
                                          <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.QUERYMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.QUERYMODULEID)%></a></td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                        <%}
                                        if(hashMenus != null && hashMenus.get(OperateBO.RPTMODULEID) != null){
                                            menuCount++;
                                        %>
                                        <tr>
                                          <td width="16%" height="23"  align="center"><img src="/images/maininterface/menu/operate.gif" width="13" height="13" /></td>
                                          <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/pages/function2.jsp?moduleid=<%=OperateBO.RPTMODULEID %>"><%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID,OperateBO.RPTMODULEID)%></a></td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                       <% }
                                          if (menuCount==0){
                                              out.println("<script language='javascript'>document.all('submenu3_title').style.display='none';</script>");                                              
                                          }
                                       %>
                                    </table></td>
                                  </tr>
                                  <tr>
                                    <td height="5"><img src="/images/maininterface/hd_main_52.gif" width="151" height="5" /></td>
                                  </tr>
                                </table>
                            </div></td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td>
                           <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="23" background="/images/maininterface/hd_main_47.gif" id="imgmenu4" class="menu_title" onmouseover="this.className='menu_title2';" onclick="showsubmenu(4)" onmouseout="this.className='menu_title';" style="cursor:hand">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%">&nbsp;</td>
                                  <td width="82%" align="left"><%=LanguageSupport.getResource("MSG-0006","帮助中心")%></td>
                                </tr>
                               </table>
                            </td>
                          </tr>

                          <tr>
                            <td background="/images/maininterface/hd_main_51.gif" id="submenu4" style="DISPLAY: block"><div class="sec_menu" >
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td>
                                       <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <% if ("1".equals(Constants.SHOW_MEMO)){%>
                                           <tr>
                                             <td width="16%" height="25"  align="center"><img src="/images/maininterface/menu/notepad.gif" width="13" height="13" /></td>
                                             <td width="84%" height="23" align="left">
                                                 <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                 <tr>
                                                   <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="#" onclick="LoadWorkLog()"><%=LanguageSupport.getResource("COMM-0019","备忘录")%></a></td>
                                                 </tr>
                                             </table>
                                             </td>
                                           </tr>
                                   <%}%>

                                      <% if ("1".equals(Constants.SHOW_DOWN_SOFT)){%>
                                         <tr>
                                          <td width="16%" height="25"  align="center"><img src="/images/maininterface/menu/calculate.gif" width="13" height="13" /></td>
                                          <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="#" onclick="downLoadSoft()"><%=LanguageSupport.getResource("COMM-0020","常用软件")%></a></td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                      <%}%>

                                       <% if ("1".equals(Constants.SHOW_SHORT_MESSAGE)){%> 
                                       <tr>
                                          <td width="16%" height="25" align="center"><img src="/images/maininterface/menu/comment.gif" width="13" height="13" /></td>
                                          <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a onclick="doOpenShortMessage();"  href="#"><%=LanguageSupport.getResource("COMM-0021","在线消息")%></a></td>
                                              </tr>
                                          </table>
                                          </td>
                                        </tr>
                                        <%}%>

                                       <% if ("1".equals(Constants.SHOW_FORUM)){%>
                                        <tr>
                                          <td width="16%" height="25" align="center"><img src="/images/maininterface/menu/mailedit.gif" width="13" height="13" /></td>
                                          <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a onclick="doOpenForum();"  href="#"><%=LanguageSupport.getResource("COMM-0022","论坛中心")%></a></td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                       <%}%>

                                        <% if ("1".equals(Constants.SHOW_ADVICE)){%>
                                        <tr>
                                          <td width="16%" height="25" align="center"><img src="/images/maininterface/menu/database.gif" width="13" height="13" /></td>
                                          <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a onclick="doOpenAdvice();"  href="#"><%=LanguageSupport.getResource("COMM-0023","建议反馈")%></a></td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                        <%}%>

                                        <tr>
                                          <td width="16%" height="25" align="center"><img src="/images/maininterface/menu/help.gif" width="13" height="13" /></td>
                                          <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a onclick="doOpenUseForum();" href="#"><%=LanguageSupport.getResource("COMM-0024","使用答疑")%></a></td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                        <tr>
                                          <td height="23" align="center"><img src="/images/maininterface/menu/copy.gif" width="13" height="13" /></td>
                                          <td height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="<%=Constants.HELP_DOCUMENT_URL%>" target="_blank"><%=LanguageSupport.getResource("MSG-0006","帮助中心")%></a></td>
                                              </tr>
                                          </table></td>
                                        </tr>

                                    </table></td>
                                  </tr>
                                  <tr>
                                    <td height="5"><img src="/images/maininterface/hd_main_52.gif" width="151" height="5" /></td>
                                  </tr>
                                </table>
                            </div></td>
                          </tr>
                        </table></td>
                      </tr>
                </table>
                </td>
              </tr>
            </table>

            </td>

            <td width="10" bgcolor="#92BBD7"  onclick="return hide()" style="cursor:hand">
                <table width="10" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8DEE6">
                      <tr>
                      <td><img src="/images/button_1.gif" name="frameshow" width="10" height="53"  style="cursor:hand" alt=""></td>
                      </tr>
                </table>
            </td>

            <td align="left" valign="top">
                 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                 <tr>

                <td align="center" valign="top" >
                    <br>
                    <table width="96%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="left" valign="middle" width="5" background="/images/maininterface/desktop_bar_bg.gif">
                            <img src="/images/maininterface/desktop_bar_left.gif" width="5" height="25" >
                        </td>
                        <td align="left" background="/images/maininterface/desktop_bar_bg.gif">    
                            <img src="/images/maininterface/radio_blue.gif" width="16" height="16">
                            &nbsp;<font color="#0a66a0"><b><%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER,"0951")%></b></font>
                        </td>
                        <td background="/images/maininterface/desktop_bar_bg.gif" align="right">
                                <img src="/images/maininterface/hd_main_30.gif" alt="">&nbsp;<a target="_blank" href="/system/BulletinBriefMore.jsf"><%=LanguageSupport.getResource("COMM-0025","更多")%></a>
                                <%
                                    List operList = user.getPmsOperateList();
                                    for(int i=0;i<operList.size();i++){
                                        OperateBO obo=(OperateBO)operList.get(i);
                                        if ("0951".equals(obo.getOperateId())){
                                            out.println("<img src=\"/images/maininterface/hd_main_30.gif\" alt=\"\">&nbsp;<a target='_self' href='/pages/function2.jsp?moduleid=XTGL&url=/system/BulletinList.jsf'>"+LanguageSupport.getResource("COMM-0026","发布")+"</a>");
                                            break;
                                        }
                                    }
                                %>
                        </td>
                        <td background="/images/maininterface/desktop_bar_right.gif"  width="5"></td>
                      </tr>
                    </table>

                    <table width="96%" border="0" cellpadding="0" cellspacing="0" class="table_main" height="140" valign=top>
                      <tr>
                        <td bgcolor="#FFFFFF" valign=top align="left">
                        </f:verbatim>
                              <x:dataTable value="#{sys_bulletinbriefMoreBB.bulletinList}"
                                           var="briefList"  columnClasses="left_y2" width="100%"  >
                                  <h:column>
                                      <h:graphicImage alt="No Image"
                                                      value="../images/common/piece.gif"
                                                      height="13" width="12"/>
                                      <h:graphicImage alt="新公告" value="/images/common/new.gif" rendered="#{briefList.newBlltn}"/>
                                      <h:commandLink  value="#{briefList.blltnTopic}" style="color:black;"
                                                     onclick="doShowBulletin('#{briefList.blltnId}');">                                         >
                                      </h:commandLink>
                                  </h:column>
                              </x:dataTable>
                     <f:verbatim>
                     </td>
                      </tr>
                    </table>
                    <br>

                   <table width="96%" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                      <td width="50%">
                       <table width="98%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="left" valign="middle" width="5" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="5" height="25"></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" align="left"><img src="/images/maininterface/radio_blue.gif" width="16" height="16">&nbsp;<font color="#0a66a0"><b><%=LanguageSupport.getResource("COMM-0027","提醒信息")%></b></font></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" align="right"><img src="/images/maininterface/hd_main_30.gif" alt="">&nbsp;<a target="_blank" href="/system/RemindMore.jsf"><%=LanguageSupport.getResource("COMM-0025","更多")%></a></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" width="5"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></td>
                          </tr>
                        </table>

                       <table width="98%" border="0" cellpadding="0" cellspacing="0" class="table_main" height="120" valign=top>
                          <tr>
                            <td bgcolor="#FFFFFF" valign=top align="left">
                        </f:verbatim>
                                  <x:dataTable value="#{sys_RemindResultBackingBean.remBriefList}"
                                               var="briefList" columnClasses="left_y2" width="100%" >
                                      <h:column>
                                          <h:graphicImage alt="No Image"
                                                          value="../images/common/piece.gif"
                                                          height="13" width="12"/>
                                          <h:commandLink value="#{briefList.remMsg}" style="color:black"
                                                         onclick="return showDetail('#{briefList.remId}','#{briefList.remMsg}')" >
                                          </h:commandLink>
                                      </h:column>
                                  </x:dataTable>
                        <f:verbatim>
                             </td>
                           </tr>
                          </table>
                       </td>

                       <td width="50%" valign="top" align="right">
                                <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                   <tr>
                                     <td align="left" width="5" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="5" height="25"></td>
                                     <td background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b><%=LanguageSupport.getResource("COMM-0028","常用查询")%></b></font></td>
                                     <td background="/images/maininterface/desktop_bar_bg.gif" align="right"><img src="/images/maininterface/hd_main_30.gif" alt="">&nbsp;<a target="_self" href="/pages/function2.jsp?moduleid=RYGL&url=/qry/QueryIndex.jsf?setType=A~~qsType=Q~~unitType=ORG"><%=LanguageSupport.getResource("COMM-0025","更多")%></a></td>
                                     <td background="/images/maininterface/desktop_bar_right.gif" width="5"></td>
                                   </tr>
                                 </table>

                            <table width="98%" border="0" cellpadding="0" cellspacing="0" class="table_main" height="120" valign=top>
                               <tr>
                                 <td bgcolor="#FFFFFF" valign=top align="left">
                            </f:verbatim>
                                <h:dataTable var="list" value="#{qry_queryBB.mainqueryBo}" columnClasses="left_y2" width="100%">
                                   <h:column>
                                    <h:graphicImage alt="No Image"
                                                    value="../images/common/piece.gif"
                                                    height="13" width="12"/>
                                    <h:commandLink value="#{list.name}" style="color:black"
                                                   onclick="return showQueryResult('#{list.qryId}')" >
                                    </h:commandLink>
                                   </h:column>
                                   </h:dataTable>
                            <f:verbatim>
                                 </td>
                               </tr>
                              </table>

                       </td>
                     </tr>
                    </table>

                    <br>

                    <table width="96%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif" width="5" ><img src="/images/maininterface/desktop_bar_left.gif" width="5" height="25" ></td>
                        <td background="/images/maininterface/desktop_bar_bg.gif" align="left"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" >&nbsp;<font color="#0a66a0"><b><%=LanguageSupport.getResource("COMM-0029","待办事宜")%></b></font></td>
                        <td background="/images/maininterface/desktop_bar_bg.gif" align="right"><img src="/images/maininterface/hd_main_30.gif" alt="">&nbsp;<a href="/system/InProcessMore.jsf" target="_blank"><%=LanguageSupport.getResource("COMM-0025","更多")%></a></td>
                        <td background="/images/maininterface/desktop_bar_right.gif"  width="5"></td>
                      </tr>
                    </table>

                    <table width="96%" border="0" cellpadding="0" cellspacing="0" class="table_main" height="140" valign=top>
                      <tr>
                        <td bgcolor="#FFFFFF" valign=top>
                        </f:verbatim>
                                    <h:inputHidden id="operID" value="#{sys_inProcessBB.operID}"></h:inputHidden>
                                    <h:commandButton id="processMore" value="处理待办事宜" style="display:none" action="#{sys_inProcessBB.doMoreAciton2}"/>
                                    <h:commandButton id="processOper" value="处理关联操作" style="display:none" action="#{sys_inProcessBB.doMainLinkOper}"/>

                                   <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%"
                                                       columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{sys_inProcessBB.linkList}"    var="list">
                                          <h:column>
                                              <c:facet name="header"><h:outputText style="width:140px; color:#333333; " value="#{user_firstPageBB.taskTime}"/></c:facet>
                                              <h:outputText value="#{list.sendDate}" style="width:140px;" />
                                          </h:column>

                                          <h:column>
                                              <c:facet name="header"><h:outputText  value="#{user_firstPageBB.taskPerson}" style="color:#333333; " /></c:facet>
                                              <h:outputText value="#{list.sendPersonName}"/>
                                          </h:column>

                                           <h:column>
                                               <c:facet name="header"><h:outputText  value="#{user_firstPageBB.taskName}" style="color:#333333; " /></c:facet>
                                               <h:outputText value="#{list.operateName}"/>
                                           </h:column>

                                          <h:column>
                                              <c:facet name="header"><h:outputText  value="#{user_firstPageBB.taskMemo}"style="width:140px; color:#333333; " /></c:facet>
                                              <h:outputText value="#{list.content}"/>
                                          </h:column>

                                          <h:column>
                                              <c:facet name="header"><h:outputText  style="width:80px; color:#333333; "  value="#{user_firstPageBB.taskOperate}" /></c:facet>
                                              <h:commandButton value="#{user_firstPageBB.view}" styleClass="button01" type="button" onclick="showWorkFlowLog('#{list.processID}');" rendered="#{list.processID!=null && list.processID!=''}"></h:commandButton>
                                              <h:commandButton value="#{user_firstPageBB.open}" id="process" action="#{sys_inProcessBB.doaciton2}" styleClass="button01">
                                                 <x:updateActionListener property="#{sys_inProcessBB.itemID}" value="#{list.itemID}"/>
                                              </h:commandButton>
                                          </h:column>
                                      </x:dataTable>
                        <f:verbatim></td>
                      </tr>
                    </table><br/>
                    <br/>
                    </td>

                <td width="1" valign="top" background="/images/maininterface/hd_main_41.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>

                <td width="200" align="center" valign="top" ><br>
                  <table width="180" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td height="25" align="left"><img src="/images/maininterface/menu/backperson.gif" > <strong><%=LanguageSupport.getResource("COMM-0005","个人信息")%></strong></td>
                    </tr>
                  </table>

                  <table width="180" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="5" width="5" background="/images/maininterface/hd_main_65.gif"></td>
                          <td height="5" width="170" background="/images/maininterface/hd_main_66.gif"></td>
                          <td height="5" width="5" background="/images/maininterface/hd_main_69.gif"></td>
                        </tr>
                      
                        <tr>
                          <td width="5" background="/images/maininterface/hd_main_70.gif"></td>
                          <td class="td06">
                              <table width="100%" border="0" cellspacing="4" cellpadding="0">
                              <tr>
                                <td align="left" style="line-height:18px;"><%=user.getName()%>，<br>
                                  <% String sysName=LanguageSupport.getResource("MSG-0001","欢迎使用")+LanguageSupport.getParaValue("TITLE_NAME");out.println(sysName);%><br>
                                  <br>
                                  <%=LanguageSupport.getResource("MSG-0007","上次登录时间")%>：<br>
                                  <span class="F01"><a href="/system/QueryOwnLog.jsf" target="_blank"><%=user.getLastLoginTime()%></a></span><br>
                                  <%=LanguageSupport.getResource("MSG-0008","当日登录次数")+":"%><span class="F01"><%=user.getTodayTimes()%></span>
                                </td>
                              </tr>
                          </table>
                          </td>
                          <td width="5" background="/images/maininterface/hd_main_72.gif"></td>
                        </tr>

                        <tr>
                          <td background="/images/maininterface/hd_main_80.gif" height="5" width="5"></td>
                          <td background="/images/maininterface/hd_main_81.gif" height="5" width="170"></td>
                          <td background="/images/maininterface/hd_main_82.gif" height="5" width="5"></td>
                        </tr>
                      </table>
                  <br>

                  <table width="180" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="25" align="left"><img src="/images/maininterface/menu/notepad.gif"  align="absmiddle"><strong><%=LanguageSupport.getResource("COMM-0031","日程管理")%></strong></td>
                        </tr>

                        <tr>
                          <td>
                          <table border="0" cellspacing="1" cellpadding="0" bgcolor="#CCCCCC">
                              <tr>
                                <td bgcolor="#FFFFFF">
                                <script type="text/javascript">
                                var now = new Date();
                                var month_array = new Array("一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月");
                                document.write("<form name=date_list><table bgcolor=white border=0 onclick='showCalendar()'><tr><td>");
                                document.write("<select name=month onchange=change_month(this.options.selectedIndex)>");
                                for(i=0;i<month_array.length;i++)
                                {
                                 if (now.getMonth() != i)
                                 {document.write ("<option value="+i+">"+month_array[i]);}
                                 else
                                 {document.write ("<option value="+i+" selected>"+month_array[i]);}

                                }
                                document.write("</select>");
                                document.write("</td><td>");
                                document.write ("<select name=year onchange=change_year(this.options[this.options.selectedIndex])>");
                                for(i=1950;i<3000;i++)
                                {
                                 if (now.getYear() != i)
                                 {document.write("<option value="+i+">"+i);}
                                 else
                                 {document.write("<option value="+i+" selected>"+i);}
                                }
                                document.write("</select></td></tr><tr><td colspan=2><center>");

                                document.write("<table bgcolor=white border=0 cellspacing = 1 cellpading = 0 width=100%><tr bgcolor=666666 align=center>");
                                document.write("<td heigh=25 width=20 class=F02>M</td><td width=20 class=F02>T</td><td width=20 class=F02>W</td><td width=20 class=F02>T</td><td width=20 class=F02>F</td><td width=20 class=F03>S</td><td width=20 class=F03>S</td>");
                                document.write("</tr><tr>");
                                for(j=0;j<6;j++)
                                {
                                 for(i=0;i<7;i++)
                                 {
                                   document.write("<td bgcolor=EFEFEF align=center id=d"+i+"r"+j+"></td>")
                                 }
                                 document.write("</tr>");
                                }

                                document.write("</table>");

                                document.write("</center></from></td></tr></table>");

                                var show_date = new Date();

                                function set_cal(show_date)
                                {
                                begin_day = new Date (show_date.getYear(),show_date.getMonth(),1);
                                begin_day_date = begin_day.getDay();
                                end_day = new Date (show_date.getYear(),show_date.getMonth()+1,1);
                                count_day = (end_day - begin_day)/1000/60/60/24;
                                input_table(begin_day_date,count_day);
                                }
                                set_cal(show_date);

                                function input_table(begin,count)
                                {
                                init();
                                j=0;
                                if (begin!=0){i=begin-1;}else{i=6}
                                for (c=1;c<count+1;c++)
                                {
                                 colum_name = eval("d"+i+"r"+j);
                                 if ((now.getDate() == c)&&(show_date.getMonth() == now.getMonth())&&(show_date.getYear() == now.getYear())) {colum_name.style.backgroundColor = "FF7700";colum_name.style.color = "white";};
                                 colum_name.innerText =  c;
                                 i++;
                                 if (i==7){i=0;j++;}
                                }
                                }

                                function init()
                                {
                                for(j=0;j<6;j++)
                                {
                                 for(i=0;i<7;i++)
                                 {
                                 colum_name = eval("d"+i+"r"+j);
                                 colum_name.innerText =  " ";
                                 colum_name.style.backgroundColor ="";
                                 colum_name.style.color ="";
                                 }
                                }
                                }

                                function change_month(sel_month)
                                {
                                show_date = new Date(show_date.getYear(),sel_month,1);
                                set_cal(show_date);
                                }

                                function change_year(sel_year)
                                {
                                sel_year = sel_year.value;
                                show_date = new Date(sel_year,show_date.getMonth(),1);
                                set_cal(show_date);
                                }
                                </script>

                                </td>
                              </tr>
                          </table></td>
                        </tr>
                      </table>

                  <br>
                  <table width="180" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="25" align="absmiddle"><img src="/images/maininterface/menu/document.gif" >
                              <strong>
                              <a target="_blank" href="/self/AddressList.jsf"></f:verbatim>
                                  <h:outputText value="#{emp_AddressBB.addressBook}"></h:outputText><f:verbatim>
                              </a>
                              </strong>
                              <br>
                          </td>
                        </tr>
                  </table>

                  <table width="180" border="0" cellspacing="0" cellpadding="0">
                        <tr><td>
                        </f:verbatim>
                                    <x:dataTable style="height:152px" headerClass="td_top" styleClass="table03"  width="98%"
                                                 columnClasses="td_middle_left,td_middle_left" id="addressList"  align="center" border="0"  value="#{emp_AddressBB.deptAddress}"    var="list">
                                    <h:column>
                                        <c:facet name="header"><h:outputText style="width:30px;color:#333333;" value="#{emp_AddressBB.nameTile}"/></c:facet>
                                        <h:outputText value="#{list.name}"/>
                                    </h:column>

                                    <h:column>
                                        <c:facet name="header"><h:outputText style="color:#333333;" value="#{emp_AddressBB.telTile}"/></c:facet>
                                        <h:outputText value="#{list.officeTel}"/>
                                    </h:column>

                                </x:dataTable>
                          <f:verbatim>

                        </td></tr>
                      </table>

                  </td>
              </tr>
            </table>
           </td>
      </tr>
    </table>
        </td>
      </tr>
                      
     <%
        if ("1".equals(Constants.MAIN_INCLUDE_FRIENDLINK)){
     %>
          <tr>
             <td>
              <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>友好链接</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
               </table>
               <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                  <td  colspan=4 valign="top" bgcolor='<%=Constants.FRAMECOLOR%>' height="75px" >
                     <jsp:include page="/pages/self/friendLink.jsp"></jsp:include>
                  </td>
                </tr>
              </table>
              </td>
          </tr>
     <%
         }
     %>

      <tr>
        <td>
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td  align="center" valign="middle" bgcolor="#F2F2F2"><%=CommonFuns.filterNull(Constants.COPY_RIGHT)%></td>
                <td width="30%"  bgcolor="#F2F2F2" align="right">
                    <script type="text/javascript">
                        document.write("屏幕分辨率(Screen Resolution):"+screen.width+"*"+screen.height+"<br>");
                        document.write("浏览器(Browser):"+judgeBrowser());
                        setDataTableOver("form1:linkList");
                    </script>
                </td>
            </tr>
            </table>
        </td>
      </tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:addressList");
   if (document.all('form1:gotoSelf')==null || document.all('form1:gotoSelf')==undefined){
       document.all('selfButton').style.display="none";
    }
</script>


