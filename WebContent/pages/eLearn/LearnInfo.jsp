<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        function doSignClass(id){
            window.showModalDialog("/eLearn/selfClassSign.jsf?ClassID="+id, null, "dialogWidth:500px; dialogHeight:550px;center:center;resizable:yes;status:no;scroll:yes;");
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
        function doShowRule(ruleid){
            window.showModalDialog("/rule/ShowRule.jsf?RuleID="+ruleid, null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowLaw(lawid){
            window.showModalDialog("/rule/ShowLaw.jsf?LawID="+lawid, null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doshowMoreStars(){
            window.showModalDialog("/self/StarsList.jsf", null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function Study(id){
            window.showModalDialog("/eLearn/LMSMain.jsf?studyID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowCource(action,title,url){
            if (action=="2"){
                window.open(url, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=true,menubar=no");
            }
            else{
                showRealPlay(title,url);                
            }
        }
    </script>
	
	
<h:form id="form1">
   <x:saveState value="#{eLearn_learnInfoBB}"></x:saveState>

   <c:verbatim>
    <table width="100%" align="center" cellpadding="0" cellspacing="4" >
       <tr>
          <td width="70%">
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>学习公告</b></font></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/eLearn/BulletinMore.jsf">更多</a></div></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                          </tr>
                        </table>
           <table height=200 border=0 width="100%"  cellspacing=0 cellpadding=0 class="table02">
            <tr><td height="200px" valign="top">
</c:verbatim>
                   <x:dataTable id="bulletinList" width="100%" align="center" border="0"  value="#{eLearn_learnInfoBB.newsList}"    var="bulletinList">
                        <h:column>
                            <h:graphicImage  value="/images/self/gridcode.gif"/>
                            <h:graphicImage alt="新公告" value="/images/common/new.gif" rendered="#{bulletinList.newflag}"/>
                            <h:commandLink  onclick="javascript:doShowElearnBulletin('#{bulletinList.blltnId}');return false;">
                               <h:outputText value=" #{bulletinList.blltnTopic}"  />
                            </h:commandLink>
                            <br>
                        </h:column>
                    </x:dataTable>
<c:verbatim>
                 
            </td></tr>
            </table>
           </td>

          <td width="30%" rowspan="3" valign="top">
              <table border="0" width="98%" cellspacing="0" cellpadding="0" align="center">
                    <tr align="center">
                        <td height="20"  ><img src="../images/maininterface/office.jpg"  align="middle" alt="办公"></td>
                    </tr>

                    <tr>
                        <td align="center">
                            <a onclick="doShowDownload();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:CommonFuns1','','../images/maininterface/hr_down2.gif',1)" >
                            </c:verbatim>
                                <h:graphicImage value="../images/maininterface/hr_down.gif" id='CommonFuns1' alt="" height="30" rendered="#{user_loginBB.showDownLoad}"></h:graphicImage>
                            <c:verbatim>
                            </a>
                        </td>
                    </tr>


                    <tr>
                        <td align="center">
                            <a onclick="doOpenShortMessage();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:ImgShortMess','','../images/maininterface/hr_sm2.gif',1)" >
                                </c:verbatim>
                                <h:graphicImage  value="../images/maininterface/hr_sm.gif" id='ImgShortMess' alt=""  height="30" rendered="#{user_loginBB.showShortMessage}"/>
                                <c:verbatim>
                            </a>
                        </td>
                    </tr>

                    <tr><td align="center">
                            <a onclick="doOpenForum();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:ImgBulltin','','../images/maininterface/hr_bulltin2.gif',1)" >
                                </c:verbatim>
                                <h:graphicImage value="../images/maininterface/hr_bulltin.gif" id='ImgBulltin' alt="" height="30px" rendered="#{user_loginBB.showForum}"/>
                                <c:verbatim>
                            </a>
                    </td></tr>

                    <tr><td align="center">
                            <a onclick="doOpenAdvice();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('form1:ImgAdvice','','../images/maininterface/hr_advice2.gif',1)" >
                              </c:verbatim>
                              <h:graphicImage  value="../images/maininterface/hr_advice.gif" id='ImgAdvice' alt=""  height="30px" rendered="#{user_loginBB.showAdvice}"/>
                              <c:verbatim>
                            </a>
                    </td></tr>
                </table>

              <table height=200 border=0   cellspacing=0 cellpadding=0 width="98%" align="center">
                  <tr>
                      <td height="25" align="left" colspan="3"><img src="/images/maininterface/menu/notepad.gif"  align="absmiddle"> <strong>排行榜</strong></td>
                  </tr>

                  <tr>
                    <td width="5"><img src="/images/maininterface/hd_main_65.gif" width="5" height="5"></td>
                    <td background="/images/maininterface/hd_main_66.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                    <td width="5"><img src="/images/maininterface/hd_main_69.gif" width="5" height="5"></td>
                  </tr>

                  <tr>
                      <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                      <td height="200px" valign="top">
                           个人学分排行榜    
                       </td>
                      <td background="/images/maininterface/hd_main_72.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                   </tr>

                  <tr>
                 <td><img src="/images/maininterface/hd_main_80.gif" width="5" height="5"></td>
                 <td background="/images/maininterface/hd_main_81.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                 <td><img src="/images/maininterface/hd_main_82.gif" width="5" height="5"></td>
               </tr>

              </table>

              <table height=200 border=0   cellspacing=0 cellpadding=0 width="98%" align="center">
                  <tr>
                      <td height="25" align="left" colspan="3"><img src="/images/maininterface/menu/shortmessage.gif"  align="absmiddle"> <strong><a target="_blank" href="/self/AddressList.jsf">通讯录</a></strong></td>
                  </tr>

                  <tr>
                    <td width="5"><img src="/images/maininterface/hd_main_65.gif" width="5" height="5"></td>
                    <td background="/images/maininterface/hd_main_66.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                    <td width="5"><img src="/images/maininterface/hd_main_69.gif" width="5" height="5"></td>
                  </tr>

                  <tr>
                      <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                      <td height="200px" valign="top">
                              </c:verbatim>
                                          <x:dataTable style="height:152px" headerClass="td_top" styleClass="table03"  width="98%"
                                                       columnClasses="td_middle_left,td_middle_left" id="addressList"  align="center" border="0"  value="#{emp_AddressBB.deptAddress}"    var="list">
                                          <h:column>
                                              <c:facet name="header"><h:outputText style="width:30px;color:#333333;" value="姓名"/></c:facet>
                                              <h:outputText value="#{list.name}"/>
                                          </h:column>

                                          <h:column>
                                              <c:facet name="header"><h:outputText style="color:#333333;" value="办公电话"/></c:facet>
                                              <h:outputText value="#{list.officeTel}"/>
                                          </h:column>

                                      </x:dataTable>
                                <c:verbatim>

                       </td>
                      <td background="/images/maininterface/hd_main_72.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                   </tr>

                  <tr>
                 <td><img src="/images/maininterface/hd_main_80.gif" width="5" height="5"></td>
                 <td background="/images/maininterface/hd_main_81.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                 <td><img src="/images/maininterface/hd_main_82.gif" width="5" height="5"></td>
               </tr>

              </table>
          </td>
       </tr>

       <tr>
           <td width="30%" >
          	 	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>资料下载</b></font></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/eLearn/MaterialMore.jsf">更多</a></div></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                          </tr>
             	</table>
          	 	<table  border=0 height="200px" width="100%"  cellspacing=0 cellpadding=0 class="table02">
            			<tr><td  valign="top">
            
</c:verbatim>
             <x:dataTable id="filelist" width="100%" align="center" border="0"  value="#{eLearn_upFileBB.liststuent}"    var="filelist">
                        <h:column>
                            <h:graphicImage value="/images/self/gridcode.gif" />
                            <f:verbatim><a target="_blank" href="</f:verbatim><h:outputText value="#{filelist.relativepath}"/><f:verbatim>"></f:verbatim><h:outputText value="#{filelist.describe}"/><f:verbatim></a></f:verbatim>
                        </h:column>
              </x:dataTable>
<c:verbatim>
            </td></tr>
            	</table>
          </td>
       </tr>

       <tr>
          <td width="70%" valign="top"  >
                	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="13" height="13" align="absmiddle">&nbsp;<font color="#0a66a0"><b>公共课程</b></font></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div><a target="_blank" href="/train/CWMore.jsf">更多</a></div></td>
                            <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                          </tr>
                        </table>
              		<table height="100%" border=0 width="100%"  cellspacing=0 cellpadding=0 class="table02">
	                        <tr><td valign="top" height=200>
	</c:verbatim>
	                            <x:dataTable id="courceList" width="100%" align="center" border="0"  value="#{train_courcebb.courceList}"    var="courceList">
                            <h:column>
                                <h:graphicImage  value="/images/self/gridcode.gif" rendered="#{courceList.haveIcon=='0'}"/>
                                <h:graphicImage alt="新课件" value="#{courceList.iconFile}" rendered="#{courceList.haveIcon=='1'}"/>
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

                        <tr><td align="center">
                        </td></tr>
                    </table>
            </td>
       </tr>
    </table>

</c:verbatim>
</h:form>
