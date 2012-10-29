<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.self.ucc.IStarsUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.self.pojo.bo.StarsBO" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.self.pojo.bo.SysToolsBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.NewsContentBO" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
    <c:verbatim>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        function doProcess(href){
            parent.main.location.href=href;
        }
        function showMoreWeather(city){
            window.showModalDialog("/pages/self/MoreWeather.jsp?city"+city, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowRecruit(){
            window.showModalDialog("/recruit/innerRecruit.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenShortMessage(){
            window.showModalDialog("/system/ShortMessageList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenAdvice(){
            window.showModalDialog("/self/SenderAdvicesList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenForum(){
            window.showModalDialog("/self/ForumList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doshowMoreStars(){
            window.showModalDialog("/self/StarsList.jsf", null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function showMoreVideo(){
            window.showModalDialog("/self/VideoNewsList.jsf", null, "dialogWidth:400px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function openURL(url){
            window.open(url, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.05+",width="+screen.width*0.9+",toolbar=no,scrollbars=yes,menubar=no");
        }
    </script>
    </c:verbatim>

<h:form id="form1">
    <x:saveState value="#{self_selfbulletinbb}"></x:saveState>
    <x:saveState value="#{self_selfnewsbb}"></x:saveState>
    <x:saveState value="#{emp_AddressBB}"></x:saveState>
    <x:saveState value="#{self_surveyBB}"></x:saveState>
    <h:inputHidden id="pageInit" value="#{self_selfbulletinbb.pageInit}"/>
    <h:inputHidden id="pageInit2" value="#{self_selfnewsbb.pageInit}"/>
    <h:inputHidden value="#{sys_videoNewsBB.initShow}"></h:inputHidden>

    <%
        SysAPI api = (SysAPI) SysContext.getBean("sys_SysAPI");
        List tools=api.getAllTools();
    %>
    <c:verbatim>
    <table width="99%" align="center" cellpadding="0" cellspacing="4" >
       <tr>
          <td width="20%" valign=top rowspan=3>
               <iframe frameborder="0" width="100%" height="173" class="table_main2"  scrolling="no" src="/pages/self/CommonService.jsp"></iframe>

               <table><tr><td height="10"></td></tr></table>


               <table  border=0  cellspacing=0 cellpadding=0 align="center">
                   <tr>
                   <td height=134 width=175 background="/images/common/videoFrame.jpg" align="center" valign="middle">
                   <a onclick="showMoreVideo();"><img style='cursor:pointer' src="/file/videoNews/morevideo.jpg" alt="" height=20 width=160></a>
                   <a onclick="doShowCource('1','</c:verbatim><h:outputText value="#{sys_videoNewsBB.showbo.title}"/><c:verbatim>','</c:verbatim><h:outputText value="/file/videoNews/#{sys_videoNewsBB.showbo.fileName}"/><c:verbatim>')">
    </c:verbatim>
                     <h:graphicImage height="80" width="160" style='cursor:pointer' value="/file/videoNews/#{sys_videoNewsBB.showbo.iconfileName}"></h:graphicImage>
    <c:verbatim>
                   </a>
                   </td>
                   </tr>
               </table>
          </td>
          <td width="60%" valign="top">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>待办事宜</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/system/InProcessMore.jsf?InSelf=true">更多</a></div></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>

        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_main" height="150" valign="bottom">
          <tr>
            <td bgcolor="#FFFFFF" valign=top>
            </c:verbatim>
                              <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%"
                                           columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{sys_inProcessBB.selflinkList}"    var="list">
                              <h:column>
                                  <c:facet name="header"><h:outputText style="width:140px; color:#333333; " value="发起时间"/></c:facet>
                                  <h:outputText value="#{list.sendDate}" style="width:140px;" />
                              </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  value="发起人" style="width:140px; color:#333333; " /></c:facet>
                                  <h:outputText value="#{list.sendPersonName}"/>
                              </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  value="说明"style="width:140px; color:#333333; " /></c:facet>
                                  <h:outputText value="#{list.content}"/>
                              </h:column>

                              <h:column>
                                  <c:facet name="header"><h:outputText  style="width:80px; color:#333333; "  value="操作" /></c:facet>
                                  <h:commandButton value="查看" styleClass="button01" type="button" onclick="showWorkFlowLog('#{list.processID}');" rendered="#{list.processID!=null && list.processID!=''}"></h:commandButton>
                                  <h:commandButton value="处理" action="#{sys_inProcessBB.doSelf2}" styleClass="button01">
                                     <x:updateActionListener property="#{sys_inProcessBB.itemID}" value="#{list.itemID}"/>
                                  </h:commandButton>
                              </h:column>
                          </x:dataTable>
            <c:verbatim></td>
          </tr>
        </table>
        </td>

          <td width="20%" valign="top">
              <table  border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="25" align="left"><img src="/images/maininterface/hd_main_61.gif" width="9" height="9" align="absmiddle"> <strong>日程管理</strong></td>
                </tr>
                <tr><td>
                   <table border="0" cellspacing="1" cellpadding="0" bgcolor="#CCCCCC">
                      <tr><td bgcolor="#FFFFFF" valign="bottom">
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
                          document.write("<td heigh=25 width=22 class=F02>M</td><td width=22 class=F02>T</td><td width=22 class=F02>W</td><td width=22 class=F02>T</td><td width=22 class=F02>F</td><td width=22 class=F03>S</td><td width=22 class=F03>S</td>");
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

                      </td></tr>
                  </table>
                </td>
              </table>
          </td>
       </tr>

       <tr>

          <td width="61%" valign=top>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
              <tr>
                <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>公司新闻</b></font></td>
                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/system/NewsBriefMore.jsf">更多</a></div></td>
                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
              </tr>
            </table>


            <table class="table02" border=0 bgcolor='<%=Constants.FRAMECOLOR%>' cellspacing=0 cellpadding=0 width="100%">
            <tr>
                   <td height=275 valign="middle" align="center">
                   <script language="javascript">
                        <%
                        out.println("var focus_width=160;");
                        out.println("var focus_height=260;");
                        out.println("var text_height=5;");
                        out.println("var swf_height = focus_height+text_height;");
                        List photoList = (List) session.getAttribute("PHOTONEWS");
                        String pics = "";
                        String links = "";
                        String texts = "";
                        for (int i = 0; i < photoList.size(); i++) {
                            NewsContentBO bo = (NewsContentBO) photoList.get(i);
                            if ("".equals(pics)){
                               pics=bo.getNewsFile();
                               links="/self/QueryOneNews.jsf?subOneId="+bo.getNewId();
                               texts="";
                            }
                            else{
                               pics+="|"+bo.getNewsFile();
                               links+="|"+"/self/QueryOneNews.jsf?subOneId="+bo.getNewId();
                               texts+="|";
                            }
                        }
                        out.println("var pics='" + pics + "';");
                        out.println("var links='" + links + "';");
                        out.println("var texts='" + texts + "';");

                        out.println("document.write('<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0\" 	 width=\"'+ focus_width +'\" height=\"'+ swf_height +'\">' );");
                        out.println("document.write('<param name=\"allowScriptAccess\" value=\"sameDomain\"><param name=\"movie\" value=\"/file/news/focus.swf\"><param name=\"quality\" value=\"high\"><param name=\"bgcolor\" value=\"#FFFFFF\">');");
                        out.println("document.write('<param name=\"menu\" value=\"false\"><param name=wmode value=\"opaque\">');");
                        out.println("document.write('<param name=\"FlashVars\" value=\"pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'\">');");
                        out.println("document.write('</object>');");

                    %>
                    </script>
                   </td>
                   <td height=275 valign="top">
</c:verbatim>
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
<c:verbatim>
            </td></tr>

           </table>
           </td>

          <td  valign="top" width="20%">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>员工风采</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" onclick="doshowMoreStars()">更多</a></div></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>

              <table bgcolor='<%=Constants.FRAMECOLOR%>' border=0 width=100% align="center" cellpadding="0" cellspacing="0" class="table02">
                <tr>
                   <td height="275" valign="top" align="left"  colspan=2>
                      <iframe id="ifPhoto" src="/self/ShowStars.jsf" frameBorder="0"  width="100%" scrolling="no" height="275"></iframe>
                   </td>
                </tr>
              </table>
          </td>
       </tr>

       <tr>
          <td valign="top">
            <table border=0 cellspacing=0 cellpadding=0 width="100%">
                <tr>
                    <td valign="top" bgcolor='<%=Constants.FRAMECOLOR%>'>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>公司公告</b></font></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/system/BulletinBriefMore.jsf">更多</a></div></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                          </tr>
                        </table>

                        <table height=300 border=0 width="100%"  cellspacing=0 cellpadding=0 class="table02">
                            <tr><td colspan=2 valign="top">
                        </c:verbatim>
                                <x:dataTable id="bulletinList" width="100%" align="center" border="0"  value="#{self_selfbulletinbb.bulletinList}"    var="bulletinList">
                                    <h:column>
                                        <h:graphicImage  value="/images/self/gridcode.gif"/>
                                        <h:graphicImage alt="新公告" value="/images/common/new.gif" rendered="#{bulletinList.newBlltn}"/>
                                        <h:commandLink  onclick="javascript:doShowBulletin('#{bulletinList.blltnId}');return false;">
                                           <h:outputText value=" #{bulletinList.blltnTopic}"  />
                                        </h:commandLink>
                                        <br>
                                    </h:column>
                                </x:dataTable>
                        <c:verbatim>
                             </td></tr>
                       </table>
                    </td>

                    <td width=4 bgcolor='<%=Constants.BGCOLOR%>'></td>

                    <td  valign="top" bgcolor='<%=Constants.FRAMECOLOR%>'>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>学习园地</b></font></td>
                                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/train/CWMore.jsf">更多</a></div></td>
                                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                              </tr>
                            </table>

                        <table border=0 height=300 width="100%" cellspacing=0  cellpadding=0 class="table02">
                        <tr><td colspan=2 valign="top">
        </c:verbatim>
                        <x:dataTable id="courceList" width="100%" align="center" border="0"  value="#{train_courcebb.courceList}"    var="courceList">
                            <h:column>
                                <h:graphicImage  value="/images/self/gridcode.gif"/>
                                <h:graphicImage alt="新课件" value="/images/common/new.gif" rendered="#{courceList.newCource}"/>
                                <h:commandLink  onclick="doShowCource('#{courceList.action}','#{courceList.title}','#{courceList.fileName}');return false;">
                                     <h:outputText value="#{courceList.title}"  />
                                </h:commandLink>
                                <h:outputText value="(#{courceList.createDate})"  />
                                <f:verbatim>
                                <br>
                                </f:verbatim>
                            </h:column>
                        </x:dataTable>
        <c:verbatim>
                        </td></tr>
                       </table>
                    </td>

                </tr>
            </table>
          </td>
            
          <td valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>调查问卷</b></font></td>
                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="">更多</a></div></td>
                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
              </tr>
            </table>

               <table height=300 border=0 width="100%" bgcolor='<%=Constants.FRAMECOLOR%>' cellspacing=0 cellpadding=0 class="table02">
                    <tr><td colspan=2 valign="top">
        </c:verbatim>
                     <x:dataTable id="paperList" width="100%" align="center" border="0"  value="#{self_surveyBB.paperList}"    var="paperList">
                        <h:column>
                            <h:graphicImage  value="/images/self/gridcode.gif"/>
                            <h:commandLink  onclick="doSurvey('#{paperList.paperID}');return false;" rendered="#{paperList.publish!='1'}">
                                <h:outputText value="#{paperList.name}"  />
                            </h:commandLink>
                            <h:outputText value="(#{paperList.createDate})"  rendered="#{paperList.publish!='1'}" />

                            <h:graphicImage alt="公布结果" value="/images/common/new.gif" rendered="#{paperList.publish=='1'}"/>
                            <h:commandLink  onclick="showSurveyResult('#{paperList.paperID}');return false;" rendered="#{paperList.publish=='1'}">
                                <h:outputText value="#{paperList.name}结果公布"  />
                            </h:commandLink>
                            <br>
                        </h:column>
                    </x:dataTable>
        <c:verbatim>
                    </td></tr>
               </table>
          </td>
       </tr>

       <tr>
           <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
             <tr>
               <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>友好链接</b></font></td>
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
       </tr>
    </table>

  </c:verbatim>
</h:form>
    <script language="jscript">
        <%
           if (session.getAttribute("URL")!=null){
               String url=(String)session.getAttribute("URL");
               session.removeAttribute("URL");
               out.println("doProcess('"+url+"');");
           }
        %>
        // 处理员工风采
        var startList=SplitStr('<%
                                 try{
                                     User user = (User) (session.getAttribute(Constants.USER_INFO));
                                     IStarsUCC rc=(IStarsUCC)SysContext.getBean("self_starsUCC");
                                     List list=rc.getALLShow(user.getOrgId());
                                     String starts="";
                                     for(int i=0;i<list.size();i++){
                                         StarsBO sb=(StarsBO)list.get(i);
                                         if ("".equals(starts)){
                                             starts=sb.getItemID();
                                         }
                                         else{
                                             starts+=","+sb.getItemID();
                                         }
                                     }
                                     out.print(starts);
                                   }
                                   catch(Exception e){

                                   }
                                %>');

        function SplitStr(s){
            ss = s.split(",");
            return(ss);
        }

        function change_img(index){
            if (startList.length<=0) return;  // 没有内容
            document.all('ifPhoto').src="/self/ShowStars.jsf?ID="+startList[index];
            index++;
            if (index==startList.length) index=0;
            setTimeout("change_img("+index+")",10000);
        }
        change_img(0);
    </script>

