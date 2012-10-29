<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="java.util.Hashtable" %>

<%@ include file="./include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String SecondMainUrl = "/pages/function.jsp";
    Hashtable hashMenus = user.getPmsMenus();
%>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        function showDetail(id,msg){
            arg="remindid="+id+"&remindmsg="+msg;
            window.showModalDialog("/system/RemResultDetail.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenShortMessage(){
            window.showModalDialog("/system/ShortMessageList.jsf", null, "dialogWidth:750px; dialogHeight:550px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenAdvice(){
            window.showModalDialog("/system/SenderAdvicesList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:no;");
            return false;
        }
        function doOpenForum(){
            window.showModalDialog("/system/ForumList.jsf", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenUseForum(){
            window.showModalDialog("/system/help/ForumList.jsf", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowHelp(){
            window.showModalDialog("/pages/include/document.doc", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowDownload(){
            window.showModalDialog("/run/DownFile.jsf", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<h:form id="form1">
    <div id='ModuleShow' onmouseout='Exit_Div()' onmouseover='Enter_Div()' style='BORDER-RIGHT:black 1px solid;BORDER-TOP:black 1px solid;BORDER-LEFT:black 1px solid;BORDER-BOTTOM:black 1px solid;Z-INDEX:180;TABLE-LAYOUT: fixed; FONT-SIZE: 9pt;BACKGROUND-COLOR: #f0f8ff;LEFT:"+divleft+"px;TOP:85px;POSITION: absolute;VISIBILITY:hidden;Width:120px;HEIGHT:350px;'>
        <table>
            <%
              if(hashMenus != null && hashMenus.get(OperateBO.ORGMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.ORGMODULEID+"'> <font size='2pt' color='blue'>机构管理</font></a> </td>");
                  out.println("</tr>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.POSTMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.POSTMODULEID+"'> <font size='2pt' color='blue'>岗位管理</font></a> </td>");
                  out.println("</tr>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.PERMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.PERMODULEID+"'> <font size='2pt' color='blue'>人员管理</font></a> </td>");
                  out.println("</tr>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.ATTMODULEID)!=null){
                    out.println("<tr>");
                    out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.ATTMODULEID+"'> <font size='2pt' color='blue'>考勤管理</font></a> </td>");
                    out.println("</tr>");
                }
              if(hashMenus != null && hashMenus.get(OperateBO.LABORMODULEID)!=null){
                      out.println("<tr>");
                      out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.LABORMODULEID+"'> <font size='2pt' color='blue'>劳保用品</font></a> </td>");
                      out.println("</tr>");
                  }
              if(hashMenus != null && hashMenus.get(OperateBO.WAGEMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.WAGEMODULEID+"'> <font size='2pt' color='blue'>薪资管理</font></a> </td>");
                  out.println("</tr>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.INSURMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.INSURMODULEID+"'> <font size='2pt' color='blue'>保险管理</font></a> </td>");
                  out.println("</tr>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.CONTMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.CONTMODULEID+"'> <font size='2pt' color='blue'>合同管理</font></a> </td>");
                  out.println("</tr>");
              }
               if(hashMenus != null && hashMenus.get(OperateBO.EVAMODULEID)!=null){
                    out.println("<tr>");
                    out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.EVAMODULEID+"'> <font size='2pt' color='blue'>绩效管理</font></a> </td>");
                    out.println("</tr>");
                }
                if(hashMenus != null && hashMenus.get(OperateBO.TRAINMODULEID)!=null){
                     out.println("<tr>");
                     out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.TRAINMODULEID+"'> <font size='2pt' color='blue'>培训管理</font></a> </td>");
                     out.println("</tr>");
                 }
                if(hashMenus != null && hashMenus.get(OperateBO.TESTMODULEID)!=null){
                     out.println("<tr>");
                     out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.TESTMODULEID+"'> <font size='2pt' color='blue'>考试管理</font></a> </td>");
                     out.println("</tr>");
                 }
                if(hashMenus != null && hashMenus.get(OperateBO.MONITORMODULEID)!=null){
                     out.println("<tr>");
                     out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.MONITORMODULEID+"'> <font size='2pt' color='blue'>监督执法</font></a> </td>");
                     out.println("</tr>");
                 }

                if(hashMenus != null && hashMenus.get(OperateBO.RECUMODULEID)!=null){
                     out.println("<tr>");
                     out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.RECUMODULEID+"'> <font size='2pt' color='blue'>招聘管理</font></a> </td>");
                     out.println("</tr>");
                 }
              if(hashMenus != null && hashMenus.get(OperateBO.QUERYMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.QUERYMODULEID+"'> <font size='2pt' color='blue'>查询管理</font></a> </td>");
                  out.println("</tr>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.RPTMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.RPTMODULEID+"'> <font size='2pt' color='blue'>报表管理</font></a> </td>");
                  out.println("</tr>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.RUNMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.RUNMODULEID+"'> <font size='2pt' color='blue'>运行管理</font></a> </td>");
                  out.println("</tr>");
              }
              if(hashMenus != null && hashMenus.get(OperateBO.SYSMODULEID)!=null){
                  out.println("<tr>");
                  out.println("<td height=20px><a  href='/pages/function.jsp?moduleid="+OperateBO.SYSMODULEID+"'> <font size='2pt' color='blue'>系统管理</font></a> </td>");
                  out.println("</tr>");
              }
            %>
            </table>
    </div>

    <f:verbatim>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor=<%=Constants.BGCOLOR%>>
   <tr><td valign="middle">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan=2>
                <table  border="0" cellspacing="0" cellpadding="0" width="100%">
                   <tr>
                    <td width=260 height=62 background="/images/maininterface/logo.jpg"></td>
                    <td width=450 align="left" height=62 background="../images/maininterface/toptitle.gif" valign="middle">
                        <span style="font-size:30px; color:#000000; line-height:31px; font-weight:bold; padding-left:0px; padding-top:0px; height:31px; width:450px;"><%=Constants.TITLE_NAME%></span>
                    </td>
                    <td background="../images/maininterface/toptitle_extend.gif" align="right">
                        <%=user.getName()%>，您好！ 欢迎登录<% out.println(Constants.SYSTEM_NAME);%><br><a href="/system/QueryOwnLog.jsf" target="_blank">上次登录：<%=user.getLastLoginTime()%>这是您今天第<%=user.getTodayTimes()%>次登录本系统</a>
                    </td>
                   </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td width="78%" height="22" bgcolor="#2074C5">
</f:verbatim>
                <h:outputText rendered="#{user_loginBB.haveMultiRole}" escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<font color=white>您有多个身份，请选择：</font>"></h:outputText>
                <h:selectOneMenu rendered="#{user_loginBB.haveMultiRole}" value="#{user_loginBB.curRole}">
                      <c:selectItems value="#{user_loginBB.roleList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value="切换" rendered="#{user_loginBB.haveMultiRole}" action="#{user_loginBB.changeRole}"></h:commandButton>
<f:verbatim>
            </td>
            <td bgcolor=red height="22" align="left">
                &nbsp;<img src="../images/maininterface/icon_r.gif" width="13" height="13"><a onmouseover='Enter_Lable()'  onmouseout='Exit_Lable()'  class="a01">功能模块</a>
                <img src="../images/maininterface/icon_h.gif" width="13" height="13"><a href="javascript:doModifyPassword();">修改密码</a>
                <img src="../images/common/exit.gif"  alt="退出"><a href="/pages/LogOff.jsp" class="a01"><font color=white>退出</font></a>
             </td>
        </tr>
    </table>
 </f:verbatim>

    <f:verbatim>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width=5></td>

          <td width=19%  valign="top">
                <table  border="0" cellspacing="0" cellpadding="0">
                  <tr height=10></tr>
                  <tr>
                      <td height="20" class="f143"><img src="../images/maininterface/function.jpg"  align="middle" alt="功能"></td>
                  </tr>
                  <tr height=20></tr>
                   <%
                       if (hashMenus != null && hashMenus.get(OperateBO.ORGMODULEID) != null) {
                           out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.ORGMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image9','','../images/maininterface/org2.jpg',1)\" > ");
                           out.print("<img src='../images/maininterface/org.jpg' name='Image9'  height='30' border='0'></a></td></tr>");
                       }

                       if (hashMenus != null && hashMenus.get(OperateBO.POSTMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.POSTMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image10','','../images/maininterface/job2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/job.jpg' name='Image10'  height='30' border='0'></a></td></tr>");
                       }

                       if (hashMenus != null && hashMenus.get(OperateBO.PERMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.PERMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image11','','../images/maininterface/person2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/person.jpg' name='Image11'  height='30' border='0'></a></td></tr>");
                       }

                       if (hashMenus != null && hashMenus.get(OperateBO.ATTMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.ATTMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image12','','../images/maininterface/attend2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/attend.jpg' name='Image12'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.CONTMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.CONTMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image13','','../images/maininterface/contract2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/contract.jpg' name='Image13'  height='30' border='0'></a></td></tr>");
                       }

                       if (hashMenus != null && hashMenus.get(OperateBO.WAGEMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.WAGEMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image14','','../images/maininterface/wage2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/wage.jpg' name='Image14'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.INSURMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.INSURMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image15','','../images/maininterface/insurance2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/insurance.jpg' name='Image15'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.EVAMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.EVAMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image20','','../images/maininterface/perform2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/perform.jpg' name='Image20'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.RECUMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.RECUMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image21','','../images/maininterface/recruit2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/recruit.jpg' name='Image21'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.TRAINMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.TRAINMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image22','','../images/maininterface/train2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/train.jpg' name='Image22'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.TESTMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.TESTMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image22','','../images/maininterface/test2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/test.jpg' name='Image22'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.MONITORMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.MONITORMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image22','','../images/maininterface/monitor2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/monitor.jpg' name='Image22'  height='30' border='0'></a></td></tr>");
                       }

                       if (hashMenus != null && hashMenus.get(OperateBO.QUERYMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.QUERYMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image16','','../images/maininterface/query2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/query.jpg' name='Image16'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.RPTMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.RPTMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image17','','../images/maininterface/report2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/report.jpg' name='Image17'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.RUNMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.RUNMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image18','','../images/maininterface/run2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/run.jpg' name='Image18'  height='30' border='0'></a></td></tr>");
                       }
                       if (hashMenus != null && hashMenus.get(OperateBO.SYSMODULEID) != null) {
                            out.print("<tr><td><a href='"+SecondMainUrl+"?moduleid="+OperateBO.SYSMODULEID+"' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image19','','../images/maininterface/system2.jpg',1)\" > ");
                            out.print("<img src='../images/maininterface/system.jpg' name='Image19'  height='30' border='0'></a></td></tr>");
                       }
                   %>
                 </table>
          </td>

          <td width='1'  bgcolor=#808080></td>

          <td width=58% valign="top">
            <table align="center" width="100%" cellpadding="0" cellspacing="0">
              <tr>
                  <td  height=280 valign="top" width=50% >
                      <table  width="98%" border="0" cellspacing="0" cellpadding="0">
                          <tr height=10></tr>
                          <tr>
                              <td height="20" class="f143"><img src="../images/maininterface/news.jpg"  alt="公告" align="middle"></td>
                              <td width="39"><a target="_blank" href="/system/BulletinBriefMore.jsf"><img src="../images/common/more.gif"  alt="更多" border="0"></a></td>
                          </tr>
                          <tr>
                              <td  valign="top" colspan="2">
        </f:verbatim>
                                  <x:dataTable value="#{sys_bulletinbriefMoreBB.bulletinList}"
                                               var="briefList"  columnClasses="left_y2">
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
                  </td>

                  <td width='1' bgcolor=#808080></td>

                  <td valign="top">
                      <table  border="0" cellspacing="0" cellpadding="0">
                          <tr height=10></tr>
                          <tr>
                              <td height="20" class="f143"><img src="../images/maininterface/warns.jpg"  alt="提醒" align="middle"></td>
                              <td width="39"><a target="_blank" href="/system/RemindMore.jsf"><img src="../images/common/more.gif"  alt="更多" border="0"></a></td>
                          </tr>

                          <tr>
                              <td height=180 valign="top">
          </f:verbatim>
                                  <x:dataTable value="#{sys_RemindResultBackingBean.remBriefList}"
                                               var="briefList" columnClasses="left_y2">
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
              </tr>

               <tr>
                  <td colspan=3 height=1 bgcolor=#808080></td>
               </tr>

               <tr>
                  <td colspan=3 >
                      <table width="98%">
                          <tr>
                              <td height="20" class="f143"><img src="../images/maininterface/work.jpg"  alt="工作" align="middle"></td>
                              <td width="39"></td>
                          </tr>
                          <td  valign="top" colspan="2">
            </f:verbatim>                              
                              <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%"
                                           columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{sys_inProcessBB.linkList}"    var="list">
                              <h:column>
                                  <c:facet name="header"><h:outputText style="width:140px" value="发起时间"/></c:facet>
                                  <h:outputText value="#{list.sendDate}" style="width:140px" />
                              </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  value="发起人"/></c:facet>
                                  <h:outputText value="#{list.sendPersonName}"/>
                              </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  value="说明"/></c:facet>
                                  <h:outputText value="#{list.content}"/>
                              </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  style="width:80px" value="操作"/></c:facet>
                                  <h:commandButton value="查看" styleClass="button01" type="button" onclick="showWorkFlowLog('#{list.processID}');" rendered="#{list.processID!=null && list.processID!=''}"></h:commandButton>
                                  <h:commandButton value="处理" action="#{sys_inProcessBB.doaciton}" styleClass="button01">
                                     <x:updateActionListener property="#{sys_inProcessBB.itemID}" value="#{list.itemID}"/>
                                  </h:commandButton>
                              </h:column>
                          </x:dataTable>
            <f:verbatim>
                          </td>
                     </table>
                  </td>
              </tr>
             </table>
          </td>

          <td width='1'  bgcolor=#808080></td>

          <td valign="top" width=22%>
                <table border="0" width="98%" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="20"  ><img src="../images/maininterface/office.jpg"  align="middle" alt="办公"></td>
                    </tr>

                    <tr>
                        <td align="center">
                            <a onclick="doShowDownload();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:CommonFuns1','','../images/maininterface/hr_down2.gif',1)" >
                            </f:verbatim>
                                <h:graphicImage value="../images/maininterface/hr_down.gif" id='CommonFuns1' alt="" height="30" rendered="#{user_loginBB.showDownLoad}"></h:graphicImage>
                            <f:verbatim>
                            </a>
                        </td>
                    </tr>

                    <tr>
                        <td align="center">
            </f:verbatim>
                            <h:commandButton id="gotoSelf" action="#{user_loginBB.gotoSelf}" value="自助" style="display:none"></h:commandButton>
             <f:verbatim>
                            <a onclick="javascript:document.all('form1:gotoSelf').click();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:CommonFuns2','','../images/maininterface/hr_self2.gif',1)" >
                                </f:verbatim>
                                <h:graphicImage  value="../images/maininterface/hr_self.gif" id='CommonFuns2' alt=""  height="30" rendered="#{user_loginBB.showSelf}"/>
                                <f:verbatim>
                            </a>
                        </td>
                    </tr>

                    <tr>
                        <td align="center">
                            <a onclick="doOpenShortMessage();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:ImgShortMess','','../images/maininterface/hr_sm2.gif',1)" >
                                </f:verbatim>
                                <h:graphicImage  value="../images/maininterface/hr_sm.gif" id='ImgShortMess' alt=""  height="30" rendered="#{user_loginBB.showShortMessage}"/>
                                <f:verbatim>
                            </a>
                        </td>
                    </tr>

                    <tr><td align="center">
                            <a onclick="doOpenForum();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:ImgBulltin','','../images/maininterface/hr_bulltin2.gif',1)" >
                                </f:verbatim>
                                <h:graphicImage value="../images/maininterface/hr_bulltin.gif" id='ImgBulltin' alt="" height="30px" rendered="#{user_loginBB.showForum}"/>
                                <f:verbatim>
                            </a>
                    </td></tr>

                    <tr><td align="center">
                            <a onclick="doOpenAdvice();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:ImgAdvice','','../images/maininterface/hr_advice2.gif',1)" >
                              </f:verbatim>
                              <h:graphicImage  value="../images/maininterface/hr_advice.gif" id='ImgAdvice' alt=""  height="30px" rendered="#{user_loginBB.showAdvice}"/>
                              <f:verbatim>
                            </a>
                    </td></tr>

                    <tr><td align="center">
                            <a onclick="doOpenUseForum();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:ImgUseBulltin','','../images/maininterface/hr_Usebulltin2.gif',1)" >
                                </f:verbatim>
                                <h:graphicImage value="../images/maininterface/hr_Usebulltin.gif" id='ImgUseBulltin' alt="" height="30px" rendered="#{user_loginBB.showAnswer}"/>
                                <f:verbatim>
                            </a>
                    </td></tr>

                    <tr><td align="center">
                            <a onclick="doShowHelp();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:document','','../images/maininterface/document2.gif',1)" >
                                </f:verbatim>
                                <h:graphicImage value="../images/maininterface/document.gif" id='document' alt="" height="30px" rendered="#{user_loginBB.showHelp}"/>
                                <f:verbatim>
                            </a>
                    </td></tr>

                    <tr >
                        <td  height="230" align="left" valign="bottom">
              </f:verbatim>          
                           <h:outputText value="#{emp_AddressBB.addressBook}"></h:outputText>
                           <x:dataTable style="height:152px" headerClass="td_top" styleClass="table03"  width="98%"
                                             columnClasses="td_middle_left,td_middle_left" id="addressList"  align="center" border="0"  value="#{emp_AddressBB.deptAddress}"    var="list">
                                <h:column>
                                    <c:facet name="header"><h:outputText style="width:30px" value="姓名"/></c:facet>
                                    <h:outputText value="#{list.name}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText  value="办公电话"/></c:facet>
                                    <h:outputText value="#{list.officeTel}"/>
                                </h:column>

                            </x:dataTable>
              <f:verbatim>
                            <br>
                            <a target="_blank" href="/self/AddressList.jsf"><img src="/images/common/more.gif"  alt="更多" border="0"></a>
                        </td>
                    </tr>

                </table>
            </td>

          <td>&nbsp</td>
        </tr>
    </table>
    </f:verbatim>

    <table width="100%">
      <%
         if ("1".equals(Constants.MAIN_INCLUDE_FRIENDLINK)){
      %>
        <tr>
           <td  height=25px  align="left" bgcolor='<%=Constants.FRAMECOLOR%>' valign="center" background="../../images/self/extent.jpg">
                <img src="../../images/self/yhlj.jpg" >
            </td>
        </tr>

        <tr>
             <td  valign="top" bgcolor='<%=Constants.FRAMECOLOR%>' height="75px" >
                <jsp:include page="/pages/self/friendLink.jsp"></jsp:include>
             </td>
         </tr>
      <%
          }
      %>
    <tr>
        <td height=62 background="../images/maininterface/toptitle_extend.gif" align="right">
            <script type="text/javascript">
                document.write("本系统自动适应分辨率，您现在的分辨率是:"+screen.width+"*"+screen.height+"<br>");
                document.write("您的浏览器是:"+judgeBrowser());
            </script>
            <br>
            <%
                out.println(Constants.COMPANY_NAME);
            %>
        </td>
    </tr>
    </table>
    </td>
    </tr>
</table>
</h:form>
<script language="javascript">
    var divleft=document.body.clientWidth*0.78;
    document.all('ModuleShow').style.left=divleft;
    setDataTableOver("form1:linkList");
</script>


