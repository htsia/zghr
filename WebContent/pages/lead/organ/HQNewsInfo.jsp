<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.self.ucc.IStarsUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.self.pojo.bo.StarsBO" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
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
        function showMoreWeather(city){
            window.showModalDialog("/pages/self/MoreWeather.jsp?city"+city, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowRecruit(){
            window.showModalDialog("/recruit/innerRecruit.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowPerson(){
            window.showModalDialog("/self/PersonInfoList.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenShortMessage(){
            window.showModalDialog("/system/ShortMessageList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenAdvice(){
            window.showModalDialog("/system/SenderAdvicesList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function gotoHR(){
           parent.document.all('form1:gotoSys').click();
           return true;
        }
        function doOpenForum(){
            window.showModalDialog("/system/ForumList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doshowMoreStars(){
            window.showModalDialog("/self/StarsList.jsf", null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function showMoreVideo(){
            window.showModalDialog("/self/VideoNewsList.jsf", null, "dialogWidth:500px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function openURL(url){
            window.open(url, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.05+",width="+screen.width*0.9+",toolbar=no,scrollbars=yes,menubar=no");
        }

        // 待办事宜处理
        function LinkAction(itemID){
            document.all('form1:operID').value=itemID;
            document.all('form1:processMore').click();
        }
        // 关联操作
        function LinkOper(operID){
            document.all('form1:operID').value=operID;
            document.all('form1:doLinkOper').click();
        }
        function doQuery(){
            var name=document.all('name').value;
            if (name==""){
                alert('请输入姓名、姓名简拼或员工编号!');
                return false;
            }
            var url="/lead/PersonInfoList.jsf?superId=<%=Constants.ORG_BENBU%>&&queryMode=true&filter=(p.name like '%"+name+"%' or p.shortName like '%"+name+"%' or p.personCode like '%"+name+"%')";
            window.showModalDialog(url, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        function showQueryResult(qryId){
            window.showModalDialog("/qry/RunQuery.jsf?qryId=" + qryId, null, "dialogWidth:960px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
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

    <h:inputHidden id="operID" value="#{sys_inProcessBB.operID}"></h:inputHidden>
    
    <h:commandButton value="关联操作" id="doLinkOper" action="#{sys_inProcessBB.doLinkOper}" style="display:none"></h:commandButton>
    <h:commandButton value="关联待办事宜" id="processMore" action="#{sys_inProcessBB.doMoreSelf2}" style="display:none"></h:commandButton>

    <%
        SysAPI api = (SysAPI) SysContext.getBean("sys_SysAPI");
    %>
    <c:verbatim>
    <table width="99%" align="center" cellpadding="0" cellspacing="4" >
       <tr>
          <td  valign="top">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>待办事宜</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><img src="/images/maininterface/hd_main_30.gif" alt="">&nbsp;<a target="_blank" href="/system/SelfInProcessMore.jsf">更多</a></div></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>

              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_main" height="175" >
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
                                  <c:facet name="header"><h:outputText  value="要求操作" style="color:#333333; " /></c:facet>
                                  <h:outputText value="#{list.operateName}"/>
                              </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText  value="说明"style="width:140px; color:#333333; " /></c:facet>
                              <h:outputText value="#{list.content}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText  style="width:80px; color:#333333; "  value="操作" /></c:facet>
                              <h:commandButton value="查看" styleClass="button01" type="button" onclick="showWorkFlowLog('#{list.processID}');" rendered="#{list.processID!=null && list.processID!=''}"></h:commandButton>
                              <h:commandButton value="处理" id="process" action="#{sys_inProcessBB.doSelf2}" styleClass="button01">
                                 <x:updateActionListener property="#{sys_inProcessBB.itemID}" value="#{list.itemID}"/>
                              </h:commandButton>
                          </h:column>
                      </x:dataTable>
                <c:verbatim>
                </td>
              </tr>
            </table>
              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                      <td width="49%">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                              <td height="25" align="left"><img src="/images/maininterface/menu/notepad.gif"  alt="">
                                  <strong><a target="_blank" href="/system/NewsBriefMore.jsf"><%OperateBO oo1 = SysCacheTool.findOperate("0952");if (oo1!=null) out.println(oo1.getOperateName()); else out.println("新闻");%></a></strong>
                               </td>
                              </tr>
                        </table>
                        <table class="table02" border=0 align="center" bgcolor='<%=Constants.FRAMECOLOR%>' cellspacing=0 cellpadding=0 width="99%">
                        <tr>
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
                      <td width="3"></td>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                              <td height="25" align="left"><img src="/images/maininterface/menu/status.gif"  alt="">
                                  <strong><a target="_blank" href="/system/BulletinBriefMore.jsf"><%OperateBO oo = SysCacheTool.findOperate("0951");if (oo != null) out.println(oo.getOperateName());else out.println("公告");%></a></strong>
                               </td>
                              </tr>
                        </table>

                        <table  border=0 width="99%"  cellspacing=0 cellpadding=0 class="table02">
                            <tr><td colspan=2 height=275 valign="top">
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
                  </tr>
              </table>
         </td>

          <td width="1" valign="top" background="/images/maininterface/hd_main_41.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>

          <td width="260" valign="top" >
            <table  id="videoNews"  border=0  cellspacing=0 cellpadding=0 align="center">
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
           <script type="text/javascript">
               <%
                  if ("0".equals(Constants.SELF_SHOW_VIDEONEWS)){
                     out.println("document.all('videoNews').style.display='none';");
                  }
               %>
           </script>

            <table width="180" border="0" cellspacing="0" cellpadding="0">
              <tr>
              <td height="25" align="left"><img src="/images/maininterface/menu/backperson.gif"  alt="">
                  <a target="_blank" onclick="doshowMoreStars();"><strong><%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER, "0953")%></strong></a>
               </td>
              </tr>
            </table>

            <table bgcolor='<%=Constants.FRAMECOLOR%>' border=0 width=99% align="center" cellpadding="0" cellspacing="0" class="table02">
              <tr>
                 <td height="200" valign="top" align="left"  colspan=2>
                    <iframe id="ifPhoto" src="/self/ShowStars.jsf" frameBorder="0"  width="100%" scrolling="no" height="200"></iframe>
                 </td>
              </tr>
            </table>

            <br>
            <table width="180" border="0" cellspacing="0" cellpadding="0">
              <tr>
              <td height="25" align="left"><img src="/images/maininterface/menu/publish.gif"  alt="">
                  <strong>调查问卷</strong>
               </td>
              </tr>
            </table>

            <table  height="100" border=0 width="99%" align="center" bgcolor='<%=Constants.FRAMECOLOR%>' cellspacing=0 cellpadding=0 class="table02">
                        <tr><td colspan=2 valign="top">
            </c:verbatim>
                         <x:dataTable id="paperList" width="100%" align="center" border="0"  value="#{self_surveyBB.paperList}"    var="paperList">
                            <h:column>
                                <h:graphicImage  value="/images/common/hot.gif"/>
                                <h:commandLink  onclick="doSurvey('#{paperList.paperID}');return false;" rendered="#{paperList.publish!='1'}">
                                    <h:outputText value="#{paperList.name}"  />
                                </h:commandLink>
                                <h:outputText value="(#{paperList.createDate})"  rendered="#{paperList.publish!='1'}" />

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
    </table>

    <table width="99%" align="center">
       <tr>
          <td>

            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
             <tr>
               <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>友好链接</b></font></td>
               <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
               <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
             </tr>
            </table>

                <table class="table_main" width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                 <tr>
                   <td  valign="top" bgcolor='<%=Constants.FRAMECOLOR%>' height="75px" >
                      <jsp:include page="/pages/self/friendLink.jsp"></jsp:include>
                   </td>
                 </tr>
               </table>
           </td>
       </tr>
    </table>

    <table width="100%" align="center">
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
  </c:verbatim>

</h:form>
    <script language="jscript">
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
            document.all('ifPhoto').src="/desktop/ShowStars.jsf?ID="+startList[index];
            index++;
            if (index==startList.length) index=0;
            setTimeout("change_img("+index+")",10000);
        }
        change_img(0);
    </script>

