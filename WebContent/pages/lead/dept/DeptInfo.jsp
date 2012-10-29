<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.self.ucc.IStarsUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.self.pojo.bo.StarsBO" %>
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
            window.showModalDialog("/self/StarsList.jsf", null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
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

    <c:verbatim>
    <table width="96%" align="center" cellpadding="0" cellspacing="4" >
       <tr>
          <td width="39%">
                <table border=0 width="100%" >
                <tr><td width="100%" height=25px background="../../images/self/extent.jpg" align="right" valign="center">
                    <img src="../../images/self/gsgg.jpg">
                </td></tr>

                <tr><td>
                    <marquee direction=up height=182 width=350 onMouseOut=this.start()   onMouseOver=this.stop() scrollamount=1 scrolldelay=40>
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
                    </marquee>
                </td></tr>
                <tr><td align="left">
                   <a target="_blank" href="/system/BulletinBriefMore.jsf"><img src="/images/common/more.gif"  alt="更多" border="0"></a>
                </td></tr>
              </table>
          </td>

          <td width="39%">
            <table border=0 width="100%">
            <tr><td width="100%" height=25px background="../../images/self/extent.jpg" valign="center" align="right">
                <img src="../../images/self/gsxw.jpg">
            </td></tr>

            <tr><td>
                <marquee direction=up height=182 width=350 onMouseOut=this.start()   onMouseOver=this.stop() scrollamount=1 scrolldelay=40>
</c:verbatim>
                    <x:dataTable id="newsList" width="100%" align="center" border="0"  value="#{self_selfnewsbb.newsList}"    var="newsList">
                        <h:column>
                            <h:graphicImage value="/images/self/gridcode.gif" />
                            <h:graphicImage alt="新新闻" value="/images/common/new.gif" rendered="#{newsList.newNews}"/>
                            <h:commandLink  onclick="javascript:windowOpen('/self/QueryOneNews.jsf?subOneId=#{newsList.newId}','','','600','300','','50','50');return false;">
                               <h:outputText value=" #{newsList.newTopic}"  />
                            </h:commandLink>
                            <h:outputText value="(#{newsList.startDate})"  />
                            <br>
                        </h:column>
                    </x:dataTable>
<c:verbatim>
                 </marquee>
            </td></tr>

            <tr><td align="left">
              <a target="_blank" href="/system/NewsBriefMore.jsf"><img src="/images/common/more.gif"  alt="更多" border="0"></a>
            </td></tr>
           </table>
           </td>

          <td rowspan=5  valign="top" width="20%">
              <table bgColor="#dce6f7" border=0 width="250px" cellpadding="0" cellspacing="0">
                  <tr ><td height="100" valign="top" align="left">
                    <img src="../../images/self/jlzx.jpg" alt="">
                    <a onclick="doOpenAdvice();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('ImgAdvice','','../images/maininterface/hr_advice2.gif',1)" >
                      <img border="0" src="../images/maininterface/hr_advice.gif" name='ImgAdvice' alt="" width="164px" height="30px">
                    </a>

                    <a onclick="doOpenShortMessage();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('ImgShortMess','','../images/maininterface/hr_sm2.gif',1)" >
                       <img border="0" src="../images/maininterface/hr_sm.gif" name='ImgShortMess' alt="" width="164px" height="30px">
                    </a>

                    <a onclick="doOpenForum();" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('ImgBulltin','','../images/maininterface/hr_bulltin2.gif',1)" >
                       <img border="0" src="../images/maininterface/hr_bulltin.gif" name='ImgBulltin' alt="" width="164px" height="30px">
                    </a>
                  </td></tr>


                <tr ><td height="265" valign="top" align="left"  >
                    <img src="../../images/self/ygfc.jpg" alt="">
                    <iframe id="ifPhoto" src="/self/ShowStars.jsf" frameBorder="0"  width="244px" scrolling="no" height="250"></iframe>
                    <a  onclick="doshowMoreStars()"><img style="cursor:pointer" src="/images/common/more.gif"  alt="更多" border="0"></a>
                </td></tr>

                <tr><td>
                    <table width="98%" bgColor="#ffffff" cellpadding="0" cellspacing="0">
                        <tr><td>
                         <img src="../../images/self/txl.jpg" alt="">
                        </td></tr>

                        <tr><td>
</c:verbatim>
                            <x:dataTable style="height:152px" headerClass="td_top" styleClass="table03"
                                         columnClasses="td_middle_left,td_middle_left,td_middle_left" id="addressList" width="100%" align="center" border="0"  value="#{emp_AddressBB.deptAddress}"    var="list">
                            <h:column>
                                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                                <h:outputText value="#{list.name}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="办公电话"/></c:facet>
                                <h:outputText value="#{list.officeTel}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="电子邮件"/></c:facet>
                                <h:outputText value="#{list.email}"/>
                            </h:column>
                        </x:dataTable>
<c:verbatim>
                        </td></tr>

                        <tr><td width="100%" align="left"><a target="_blank" href="/self/AddressList.jsf"><img src="/images/common/more.gif"  alt="更多" border="0"></a></td></tr>

                    </table>
                </td></tr>


                <tr><td  height="210" valign="top">
                    <img src="../../images/self/gjx.jpg" alt="">
                    <a href="<%=request.getContextPath()%>/run/DownFile.jsf" target="_blank" onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('CommonFuns1','','../images/maininterface/hr_down2.gif',1)" >
                     <img border="0" src="../../images/maininterface/hr_down.gif" name='CommonFuns1' alt="" width="164" height="30">
                    </a>
                    <a onclick="javascript:parent.document.all('form1:gotoSys').click();"  onMouseOut='SwapImgRestore()'  onMouseOver="SwapImage('CommonFuns2','','../images/maininterface/hr_busi2.gif',1)" >
                        <img border="0" src="../../images/maininterface/hr_busi.gif" name='CommonFuns2' alt="" width="164" height="30">
                    </a>
                </td></tr>
           </table>
            </td>
       </tr>

       <tr>
           <td width="39%">
           <table border=0 width="100%">
                <tr><td width="100%" height=25px background="../../images/self/extent.jpg" align="right" colspan=2>
                    <img src="../../images/self/xxyd.jpg">
                </td></tr>

                <tr><td colspan=2>
                <marquee direction=up height=182 width=350 onMouseOut=this.start()   onMouseOver=this.stop() scrollamount=1 scrolldelay=40>
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
                </marquee>
                </td></tr>

                <tr>
                    <td>
                    <a target="_blank" href="/train/CWMore.jsf"><img src="/images/common/more.gif"  alt="更多" border="0"></a>
                    </td>
                    <td align="right">
</c:verbatim>
                        <h:commandButton type="button" image="/images/eLearn/LoginEducation.gif" onclick="return doLearn();"/>
<c:verbatim>
                    </td>
                </tr>
            </table>
        </td>

           <td width="39%">
            <table border=0 width="100%">
            <tr><td width="100%" height=25px background="../../images/self/extent.jpg" align="right">
                <img src="../../images/self/dcwj.jpg">
            </td></tr>

            <tr><td>
            <marquee direction=up height=182 width=350 onMouseOut=this.start()   onMouseOver=this.stop() scrollamount=1 scrolldelay=40>
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
            </marquee>
            </td></tr>

            <tr><td>
                <a target="_blank" href=""><img src="/images/common/more.gif"  alt="更多" border="0"></a>
            </td></tr>
            </table>
          </td>
       </tr>

       <tr>
          <td width="39%">
             <table border=0 width="100%">
               <tr><td width="100%" height=25px background="../../images/self/extent.jpg" align="right">
                   <img src="../../images/self/zcfg.jpg">
               </td></tr>

               <tr><td>
</c:verbatim>
                <x:dataTable style="height:182px" headerClass="td_top" styleClass="table03"
                             columnClasses="td_middle_left,td_middle_left,td_middle_left" id="lawList" width="100%" align="center" border="0"
                             value="#{law_infobb.lawlist}"    var="lawlist">
                    <h:column>
                        <c:facet name="header"><h:outputText style="width:80px" value="颁布日期"/></c:facet>
                        <h:outputText style="width:80px" value="#{lawlist.publicDate}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="标题"/></c:facet>
                        <h:commandLink  type="button" onclick="return doShowLaw('#{lawlist.fileID}')">
                           <h:outputText value="#{lawlist.title}"/>
                        </h:commandLink>
                    </h:column>
                </x:dataTable>
    <c:verbatim>
               </td></tr>

              <tr><td>
                 <a target="_blank" href="/rule/LawList.jsf"><img src="/images/common/more.gif"  alt="更多" border="0"></a>
               </td></tr>
            </table>
          </td>

          <td width="39%">
              <table border=0 width="100%">
               <tr><td width="100%" height=25px background="../../images/self/extent.jpg" align="right">
                   <img src="../../images/self/qygz.jpg">
               </td></tr>

               <tr><td>
</c:verbatim>
                <x:dataTable style="height:182px" headerClass="td_top" styleClass="table03"
                             columnClasses="td_middle_left,td_middle_left" id="ruleList" width="100%" align="center" border="0"
                             value="#{rule_infobb.rulelist}"    var="list">
                    <h:column>
                        <c:facet name="header"><h:outputText style="width:90px" value="颁布日期"/></c:facet>
                        <h:outputText style="width:90px" value="#{list.publicDate}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="标题"/></c:facet>
                        <h:commandLink  type="button" onclick="return doShowRule('#{list.fileID}')">
                         <h:outputText value="#{list.title}"/>
                        </h:commandLink>
                    </h:column>
                </x:dataTable>
<c:verbatim>
               </td></tr>

               <tr><td>
                <a target="_blank" href="/rule/RulesList.jsf"><img src="/images/common/more.gif"  alt="更多" border="0"></a>
               </td></tr>
            </table>
           </td>
        </tr>

       <tr>
          <td  colspan=2 align="right" valign="center" background="../../images/self/extent.jpg">
               <img src="../../images/self/yhlj.jpg" >
           </td>
       </tr>

       <tr>
            <td  colspan=2 valign="top" height="75px">
               <jsp:include page="/pages/self/friendLink.jsp"></jsp:include>
            </td>
        </tr>
    </table>

    <table width="100%">
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
            document.all('ifPhoto').src="/self/ShowStars.jsf?ID="+startList[index];
            index++;
            if (index==startList.length) index=0;
            setTimeout("change_img("+index+")",8000);
        }
        change_img(0);
    </script>

