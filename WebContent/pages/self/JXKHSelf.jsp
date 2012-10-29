<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="java.util.Hashtable" %>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String SecondMainUrl = "/pages/function.jsp";
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
            window.showModalDialog("/self/SenderAdvicesList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:no;");
            return false;
        }
        function doOpenForum(){
            window.showModalDialog("/self/ForumList.jsf", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenUseForum(){
            window.showModalDialog("/system/ForumList.jsf", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
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
        function doJXKH(){
            parent.document.main.location.href="/eva/SelfEvaSetScore.jsf";
            return false;
        }
    </script>

<h:form id="form1">
    <f:verbatim>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor=<%=Constants.BGCOLOR%>>
    <tr><td valign="middle">

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
                        out.print("<tr><td><a onclick='doJXKH();' onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image9','','../images/maininterface/self_jx2.jpg',1)\" > ");
                        out.print("<img src='../images/maininterface/self_jx.jpg' name='Image9'  height='30' border='0'></a></td></tr>");

                        out.print("<tr><td><a  onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image10','','../images/maininterface/self_tfya2.jpg',1)\" > ");
                        out.print("<img src='../images/maininterface/self_tfya.jpg' name='Image10'  height='30' border='0'></a></td></tr>");

                        out.print("<tr><td><a  onMouseOut='SwapImgRestore()'  onMouseOver=\"SwapImage('Image11','','../images/maininterface/self_jxhb2.jpg',1)\" > ");
                        out.print("<img src='../images/maininterface/self_jxhb.jpg' name='Image11'  height='30' border='0'></a></td></tr>");
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
                                  <h:commandButton value="打开" action="#{sys_inProcessBB.doaciton}" styleClass="button01">
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
               document.write("本系统自动适应分辨率，您现在的分辨率是:"+screen.width+"*"+screen.height);
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


