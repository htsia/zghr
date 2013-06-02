<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>

<%@ include file="./include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String SecondMainUrl = "/pages/function.jsp";
    Hashtable hashMenus = user.getPmsMenus();
%>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        function refreshMain(){
            parent.refreshMain();
        }
        function changeModule(id){
            parent.location.href="/MainInterface/MainStandard.jsf?moduleId="+id;
        }
        function showDetail(id,msg){
            arg="remindid="+id+"&remindmsg="+msg;
            windowOpen("/system/RemResultDetail.jsf?" + arg, "aa", "", "900", "600", "yes","10","1","yes");
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
        // 待办事宜处理
        function LinkAction(itemID){
            document.all('form1:itemID').value=itemID;
            document.all('form1:processMore').click();
        }
    </script>

<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{self_selfbulletinbb.pageInit}"/>
    <h:inputHidden id="pageInit2" value="#{self_selfnewsbb.pageInit}"/>

    <f:verbatim>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height=5 colspan=3></td>
        </tr>
        <tr>
          <td width=5></td>

          <td width=19%  valign="top" align="center">
              <table  border="0" cellspacing="0" cellpadding="0">
                  <tr>
                      <td height="20" colspan="3" class="f143"><img src="<%=LanguageSupport.getImg("../images/maininterface/","office.jpg")%>"  align="middle" alt="功能"></td>
                  </tr>

                <tr>
                  <td width="5"><img src="/images/maininterface/hd_main_65.gif" width="5" height="5"></td>
                  <td background="/images/maininterface/hd_main_66.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                  <td width="5"><img src="/images/maininterface/hd_main_69.gif" width="5" height="5"></td>
                </tr>
                  
                  <tr >
                      <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                      <td class="td06">
                          <table height="170" width="100%" border="0" cellspacing="4" cellpadding="0">
                              <tr>
                                  <td>
                                    <a onclick="doShowDownload();" target="_blank" >
                                        <img style="cursor: pointer;" alt="提供常用软件下载" src="<%=LanguageSupport.getImg("/images/maininterface/tools/","download.jpg")%>">
                                    </a>
                                  </td>

                                  <td>
                                      <a onclick="doOpenShortMessage();" target="_blank" >
                                         <img style="cursor: pointer;" alt="在线消息发送和查询" src="<%=LanguageSupport.getImg("/images/maininterface/tools/","shortmessage.jpg")%>"> 
                                      </a>
                                  </td>
                               </tr>

                              <tr>
                                  <td>
                                    <a onclick="doOpenForum();" target="_blank" >
                                        <img style="cursor: pointer;" alt="人力资源管理论坛中心" src="<%=LanguageSupport.getImg("/images/maininterface/tools/","forum.jpg")%>">
                                    </a>
                                  </td>

                                  <td>
                                      <a onclick="doOpenAdvice();" target="_blank" >
                                         <img style="cursor: pointer;" alt="对人力资源管理提出意见和建议" src="<%=LanguageSupport.getImg("/images/maininterface/tools/","advice.jpg")%>">
                                      </a>
                                  </td>
                               </tr>

                          </table>
                      </td>
                      <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                  </tr>

                   <tr>
                     <td><img src="/images/maininterface/hd_main_80.gif" width="5" height="5"></td>
                     <td background="/images/maininterface/hd_main_81.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                     <td><img src="/images/maininterface/hd_main_82.gif" width="5" height="5"></td>
                   </tr>
                   
                 </table>

              <br>
              <a target='_blank' href='/pages/custom/showSchedule.jsp'>
              <img src="/images/maininterface/worklog.jpg" alt="日程查看" style="border:none;"></a>
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
                  </table>
          </td>


          <td width=58% valign="top">
            <table align="center" width="100%" cellpadding="0" cellspacing="0">
              <tr>
                  <td   valign="top" width=50% >
                    <table width="99%" border="0" cellspacing="0" cellpadding="0">
                       <tr>
                         <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b><%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER, "0952")%></b></font></td>
                         <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><img src="/images/maininterface/hd_main_30.gif" alt="">&nbsp;<a target="_blank" href="/system/NewsBriefMore.jsf"><%=LanguageSupport.getResource("COMM-0025","更多")%></a></div></td>
                         <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                       </tr>
                     </table>
        
                      <table  height=250 width="99%" border="0" cellspacing="0" cellpadding="0" class="table_main">
                          <tr>
                              <td  valign="top" colspan="2">
        </f:verbatim>
                                <x:dataTable id="newsList" width="100%" align="center" border="0"  value="#{self_selfnewsbb.newsList}"    var="newsList">
                                    <h:column>
                                        <h:graphicImage value="/images/self/gridcode.gif" />
                                        <h:graphicImage alt="新新闻" value="/images/common/new.gif" rendered="#{newsList.newNews}"/>
                                        <h:commandLink  title="#{newsList.display}" onclick="doShowNews('#{newsList.newId}')">
                                           <h:outputText value=" #{newsList.newTopic}"  />
                                        </h:commandLink>
                                        <h:outputText value="(#{newsList.startDate})"  />
                                    </h:column>
                                </x:dataTable>
         <f:verbatim>
                              </td>
                          </tr>
                      </table>
                  </td>
                  
              </tr>

               <tr>
                  <td colspan=3 height=5 ></td>
               </tr>

               <tr>
                  <td colspan=3 >
                     <table width="99%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>待办事宜</b></font></td>
                          <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><img src="/images/maininterface/hd_main_30.gif" alt="">&nbsp;<a target="_blank" href="/system/InProcessMore.jsf"><%=LanguageSupport.getResource("COMM-0025","更多")%></a></div></td>
                          <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                        </tr>
                      </table>

                      <table width="99%" border="0" cellspacing="0" cellpadding="0" class="table_main" height="140">
                          <td  valign="top" colspan="2">
            </f:verbatim>
                            <h:commandButton id="processMore" style="display:none" value="处理待办事宜"  action="#{sys_inProcessBB.doaciton_standard}"/>

                              <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%"
                                           columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"
                                           value="#{sys_inProcessBB.linkList}"    var="list">
                              <h:column>
                                  <c:facet name="header"><h:outputText style="width:140px" value="#{user_firstPageBB.taskTime}"/></c:facet>
                                  <h:outputText value="#{list.sendDate}" style="width:140px" />
                              </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  value="#{user_firstPageBB.taskPerson}"/></c:facet>
                                  <h:outputText value="#{list.sendPersonName}"/>
                              </h:column>
                                  <h:column>
                                      <c:facet name="header"><h:outputText  value="#{user_firstPageBB.taskName}" style="color:#333333; " /></c:facet>
                                      <h:outputText value="#{list.operateName}"/>
                                  </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  value="#{user_firstPageBB.taskMemo}"/></c:facet>
                                  <h:outputText value="#{list.content}"/>
                              </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  style="width:80px" value="#{user_firstPageBB.taskOperate}"/></c:facet>
                                  <h:commandButton value="#{user_firstPageBB.view}" styleClass="button01" type="button" onclick="showWorkFlowLog('#{list.processID}');" rendered="#{list.processID!=null && list.processID!=''}"></h:commandButton>
                                  <h:commandButton value="#{user_firstPageBB.open}" action="#{sys_inProcessBB.doaciton_standard}" styleClass="button01">
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


          <td valign="top" width=22% align="center">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                <td height="25" align="left">
                    <img src="<%=LanguageSupport.getImg("/images/maininterface/","user.jpg")%>"  align="absmiddle">
                </td>
                <td align="left">    
                    <a href="javascript:doModifyLanguage();"><% if ("1".equals(Constants.LANGUAGE_SUPPORT)) out.print(LanguageSupport.getResource("COMM-0002","语言设置"));%></a>
                </td>
                </tr>
              </table>

              <table width="248" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="5"><img src="/images/maininterface/hd_main_65.gif" width="5" height="5"></td>
                      <td background="/images/maininterface/hd_main_66.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                      <td width="5"><img src="/images/maininterface/hd_main_69.gif" width="5" height="5"></td>
                    </tr>

                    <tr>
                      <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                      <td class="td06">
                          <table width="100%" border="0" cellspacing="4" cellpadding="0">
                          <tr>
                            <td align="left" style="line-height:18px;"><%=user.getName()%>,<br>
                              <% String str=LanguageSupport.getResource("MSG-0001","欢迎使用")+LanguageSupport.getParaValue("SYSTEM_NAME");out.print(str);%><br>
                              <br>
                              <%=LanguageSupport.getResource("MSG-0007","上次登录时间")%>:<br>
                              <span class="F01"><a href="/system/QueryOwnLog.jsf" target="_blank"><%=user.getLastLoginTime()%></a></span><br>
                              <%str=LanguageSupport.getResource("MSG-0008","当日登录次数")+":<br>"+user.getTodayTimes();out.print(str);%>
                              <br>
            </f:verbatim>
                            <h:outputText rendered="#{user_loginBB.haveMultiRole}" escape="false" value="<font color=black>请选择身份(Please Select Role)：</font>"></h:outputText>
                            <h:selectOneMenu rendered="#{user_loginBB.haveMultiRole}" value="#{user_loginBB.curRole}">
                                  <c:selectItems value="#{user_loginBB.roleList}"></c:selectItems>
                            </h:selectOneMenu>
                            <h:commandButton styleClass="button01" value="#{sys_buttonBB.btnSubmit}" rendered="#{user_loginBB.haveMultiRole}" action="#{user_loginBB.changeRole}"></h:commandButton>
            <f:verbatim>

                            </td>
                          </tr>
                         </table>
                      </td>
                      <td background="/images/maininterface/hd_main_72.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                    </tr>

                    <tr>
                      <td><img src="/images/maininterface/hd_main_80.gif" width="5" height="5"></td>
                      <td background="/images/maininterface/hd_main_81.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                      <td><img src="/images/maininterface/hd_main_82.gif" width="5" height="5"></td>
                    </tr>
                  </table>

              <table  width="248" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                      <td colspan="3">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                  <td height="20" class="f143" colspan="2"><img src="<%=LanguageSupport.getImg("/images/maininterface/","warns.jpg")%>"  alt="提醒" align="middle"></td>
                                  <td width="39" valign="bottom"><a target="_blank" href="/system/RemindMore.jsf"><img src="/images/maininterface/hd_main_30.gif"  alt="更多" border="0">&nbsp;更多</a></td>
                              </tr>
                          </table>
                      </td>
                  </tr>

                <tr>
                  <td width="5"><img src="/images/maininterface/hd_main_65.gif" width="5" height="5"></td>
                  <td background="/images/maininterface/hd_main_66.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                  <td width="5"><img src="/images/maininterface/hd_main_69.gif" width="5" height="5"></td>
                </tr>

                          <tr>
                              <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                              <td height=135 valign="top">
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
                              <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                          </tr>

              <tr>
                <td><img src="/images/maininterface/hd_main_80.gif" width="5" height="5"></td>
                <td background="/images/maininterface/hd_main_81.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                <td><img src="/images/maininterface/hd_main_82.gif" width="5" height="5"></td>
              </tr>

                      </table>
          </td>

          <td>&nbsp</td>
        </tr>
    </table>
    </f:verbatim>

    </td>
    </tr>
</table>
</h:form>
<script language="javascript">
    var divleft=document.body.clientWidth*0.78;
    setDataTableOver("form1:linkList");
</script>

<jsp:include page="/pages/system/shortmessage/checknew.jsp"></jsp:include>
