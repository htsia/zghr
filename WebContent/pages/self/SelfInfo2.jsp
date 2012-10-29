<%@page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.self.ucc.IStarsUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.self.pojo.bo.StarsBO" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.api.ActivePageAPI" %>
<%@ page import="com.hr319wg.self.pojo.bo.SysToolsBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.NewsContentBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	User user = (User) (session.getAttribute(Constants.USER_INFO));
	PersonBO p = SysCacheTool.findPersonById(user.getUserId());
	SysAPI api = (SysAPI) SysContext.getBean("sys_SysAPI");
	List tools=api.getAllUseTools();
	ActivePageAPI pageapi = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
	String sql="select t.file_name from TRAIN_COURCEWAREITEM t where to_date(t.start_date,'yyyy-MM-dd')< sysdate and sysdate <to_date(t.end_date,'yyyy-MM-dd')+1 and t.file_name is not null and rownum=1 order by t.item_id desc";
	String videofile=pageapi.queryForString(sql);
%>
    <c:verbatim>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/js/jcarousellite.min.js" type="text/javascript"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
		$(function(){
			$("#box").jCarouselLite({
				auto: 5000,
				scroll: 1,
				speed: 5000, 
				vertical: true,
				visible: 1,
				circular: true 
			});
		});
		
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
		function moreweather(){
			window.open("http://218.29.109.199/js/moreweather.jsp", "_blank", "top="+screen.height*0.1+",height="+screen.height*0.7+", left="+screen.width*0.05+",width="+screen.width*0.9+",toolbar=no,scrollbars=yes,menubar=no");
		}

        // �������˴���
        function LinkAction(itemID){
            document.all('form1:operID').value=itemID;
            document.all('form1:processMore').click();
        }
        // ��������
        function LinkOper(operID){
            document.all('form1:operID').value=operID;
            document.all('form1:doLinkOper').click();
        }
    </script>
   <body style="overflow-x:hidden;overflow-y:scroll"> 
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
    <h:commandButton value="��������" id="doLinkOper" action="#{sys_inProcessBB.doLinkOper}" style="display:none"></h:commandButton>
    <h:commandButton value="������������" id="processMore" action="#{sys_inProcessBB.doMoreSelf2}" style="display:none"></h:commandButton>

    <c:verbatim>
    <table width="100%" align="center" cellpadding="0" cellspacing="10">

       <tr>
          <td width="20%" valign=top rowspan=3>
             <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
					<tr>
					  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>���ù���</b></font></td>
					  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
					  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
					 </tr>
			     </table>
				 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" height="350" valign="bottom">
                        <%
                            for (int i = 0; i < tools.size(); i++) {
                                SysToolsBO sb =(SysToolsBO)tools.get(i);
                                out.println("<tr>");

                                out.println("<td bgcolor=\""+Constants.FRAMECOLOR+"\" valign=center align=center>");
                                if (sb.getOnclick()!=null && !"".equals(sb.getOnclick())){
                                    out.println("<a  onclick=\""+sb.getOnclick()+"\">");
                                }
                                else if (sb.getUrl()!=null && !"".equals(sb.getUrl())){
                                    out.println("<a  onclick=\"openURL('"+sb.getUrl()+"')\" >");
                                }
                                else{
                                  out.println("<a>");
                                }
                                out.println("<img src='"+sb.getIcon()+"' style='cursor:pointer' alt='"+sb.getItemName()+"'></a>");
                                out.println("</td>");
                                i++;

                                if (i<tools.size()){
                                    sb =(SysToolsBO)tools.get(i);
                                    out.println("<td bgcolor=\""+Constants.FRAMECOLOR+"\" valign=center align=center>");
                                    if (sb.getOnclick()!=null && !"".equals(sb.getOnclick())){
                                        out.println("<a  onclick=\""+sb.getOnclick()+"\">");
                                    }
                                    else if (sb.getUrl()!=null && !"".equals(sb.getUrl())){
                                        out.println("<a  onclick=\"openURL('"+sb.getUrl()+"')\" >");
                                    }
                                    else{
                                      out.println("<a>");
                                    }
                                    out.println("<img src='"+sb.getIcon()+"' style='cursor:pointer' alt='"+sb.getItemName()+"'></a>");
                                    out.println("</td>");
                                }
                                else{
                                    out.println("<td bgcolor=\""+Constants.FRAMECOLOR+"\">");
                                    out.println("</td>");
                                }
                                out.println("</tr>");
                            }
                        %>
                       </table>

				<%
               // 0959 �����ʾ����
               OperateBO oo=SysCacheTool.findOperate("0959");
               if (oo!=null && "1".equals(oo.getisUse())){
             %>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>' style="margin-top:10px;">
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>�ʾ����</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>

				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" valign="center">
				  <tr>
					 <td height="400" valign="top" align="center">
						<iframe id="dcwj" src="/self/ShowSurvey.jsf" frameborder="0"  width="225" scrolling="no" height="280"></iframe>
					 </td>
				  </tr>
				</table>
            <%
                }
                else{
            %>
            <table bgcolor='aliceblue' border=0 width=225 align="center" cellpadding="0" cellspacing="0" >
                <tr>
                  <td height="25"  align="left"><img src="/images/maininterface/menu/mobile.gif"  align="absmiddle"> <strong>ͨѶ¼</strong></td>
                  <td align="right"><a target="_blank" href="/self/AddressList.jsf">����</a></td>
                </tr>
              <tr>
                 <td height="285" valign="top" align="center"  colspan=2>
                    <iframe id="Address" src="/self/ShowAddress.jsf" frameBorder="0"  width="225" scrolling="no" height="285"></iframe>
                 </td>
              </tr>
            </table>
            <%
                }
            %>
               
          </td>
			<td width="61%" valign=top>
<!--             ���� -->
            	<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>��������</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/system/SelfInProcessMore.jsf">����</a></div></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>

		        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" height="168" valign="bottom">
		          <tr>
		            <td bgcolor="<%=Constants.FRAMECOLOR%>" valign=top>
		            </c:verbatim>
		                      <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%"
		                                   columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{sys_inProcessBB.selflinkList}"    var="list">
		                      <h:column>
		                          <c:facet name="header"><h:outputText style="width:140px; color:#333333; " value="����ʱ��"/></c:facet>
		                          <h:outputText value="#{list.sendDate}" style="width:140px;" />
		                      </h:column>
		
		                      <h:column>
		                          <c:facet name="header"><h:outputText  value="������" style="width:140px; color:#333333; " /></c:facet>
		                          <h:outputText value="#{list.sendPersonName}"/>
		                      </h:column>
		
		                          <h:column>
		                              <c:facet name="header"><h:outputText  value="Ҫ�����" style="color:#333333; " /></c:facet>
		                              <h:outputText value="#{list.operateName}"/>
		                          </h:column>
		
		                      <h:column>
		                          <c:facet name="header"><h:outputText  value="˵��"style="width:140px; color:#333333; " /></c:facet>
		                          <h:outputText value="#{list.content}"/>
		                      </h:column>
		
		                      <h:column>
		                          <c:facet name="header"><h:outputText  style="width:80px; color:#333333; "  value="����" /></c:facet>
		                          <h:commandButton value="�鿴" styleClass="button01" type="button" onclick="showWorkFlowLog('#{list.processID}');" rendered="#{list.processID!=null && list.processID!=''}"></h:commandButton>
		                          <h:commandButton value="����" id="process" action="#{sys_inProcessBB.doSelf2}" styleClass="button01">
		                             <x:updateActionListener property="#{sys_inProcessBB.itemID}" value="#{list.itemID}"/>
		                          </h:commandButton>
		                      </h:column>
		                  </x:dataTable>
		            <c:verbatim>
		            </td>
		          </tr>
		        </table>
           </td>
		    <td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>�û���Ϣ</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"></div></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>
				 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" valign="center">
				  <tr>
					 <td height="165" valign="top" align="left">
		              	  <table>
		              	  	<tr valign="top">
								<td style="line-height:22px;">
									<b>��ţ�</b><%=p.getPersonCode()%><br/>
									<b>������</b><%=p.getName()%><br/>
									<b>���ڲ���:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId())%><br/>
									<b>��λ����:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_POST, p.getPostId())%><br/>
								</td>
							</tr>
		              	  </table>
					 </td>
				  </tr>
				</table>        
          </td>   
       </tr>

       <tr>
          <td valign="top">
            <table border=0 cellspacing=0 cellpadding=0 width="100%">
                <tr>                   
                    <td  valign="top" bgcolor='<%=Constants.FRAMECOLOR%>'>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>ѧϰ԰��</b></font></td>
                                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/train/CWMore.jsf">����</a></div></td>
                                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                              </tr>
                            </table>

                        <table border=0 id="learnTable" height=263 width="100%" cellspacing=0  cellpadding=0 class="table02">
                        <tr><td colspan=2 valign="top" style="padding:10px 0 0 10px;">
						<table cellspacing=0  cellpadding=0>
							<tr valign="top">
								<%
									if(videofile!=null && !"".equals(videofile)){
									%>
									<td style="padding:0 80px 0 20px;">
										<object type="application/x-shockwave-flash" data="vcastr3.swf" width="350" height="240">
											<param name="movie" value="/file/videoNews/vcastr3.swf"/>
											<param name="allowFullScreen" value="true" />
											<param name="FlashVars" value="xml={vcastr}{channel}{item}{source}<%=videofile%>{/source}{/item}{/channel}{config}
											{bufferTime}1{/bufferTime}{contralPanelAlpha}0.8{/contralPanelAlpha}{isShowAbout}false{/isShowAbout}
											{controlPanelBgColor}0x1F1F1F{/controlPanelBgColor}{controlPanelBtnColor}0xFFFFFF{/controlPanelBtnColor}
											{contralPanelBtnGlowColro}0x66FF00{/contralPanelBtnGlowColro}{controlPanelMode}float{/controlPanelMode}
											{defautVolume}0.8{/defautVolume}{isAutoPlay}false{/isAutoPlay}{isLoadBegin}true{/isLoadBegin}
											{scaleMode}showAll{/scaleMode}{isRepeat}true{/isRepeat}{/config}{/vcastr}"/>
										</object>
									</td>
									<%									
									}
								%>								
								<td>
        </c:verbatim>
                        <x:dataTable id="courceList" width="100%" align="center" border="0"  value="#{train_courcebb.courceList}"    var="courceList">
                            <h:column>
                                <h:graphicImage  value="/images/self/gridcode.gif"/>
                                <h:graphicImage alt="�¿μ�" value="/images/common/new.gif" rendered="#{courceList.newCource}"/>
                                <h:commandLink  onclick="doShowCource('1','#{courceList.title}','#{courceList.fileName}');return false;">
                                     <h:outputText value="#{courceList.title}"  />
                                </h:commandLink>
                                <h:outputText value="(#{courceList.createDate})"  />
                                <f:verbatim>
                                <br>
                                </f:verbatim>
                            </h:column>
                        </x:dataTable>
        <c:verbatim>
							</td>
							</tr>
						</table>
                        </td></tr>
                       </table>
                    </td>

                </tr>
            </table>
          </td>
          <td valign="top" width="20%">
               <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>Ա�����</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>
			  
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" valign="center">
				  <tr>
                   <td height="220" align="center">
				   <div id="box" style="margin-top:30px;">
						<ul>
							<%
								IStarsUCC rc=(IStarsUCC)SysContext.getBean("self_starsUCC");
								List<StarsBO> list=rc.getALLShow(user.getOrgId());
								for(StarsBO sb : list){
									PersonBO pb = SysCacheTool.findPersonById(sb.getPersID());
									%>
									<li style="height:230px;">
									<table width="100%" height="260" border="0" cellspacing="5" cellpadding="0">
										<tr valign="top">
											<td width="110" height="150" align="center"><img width="100" src="/images/maininterface/stars/<%=sb.getPhotoFile()%>"/></td>
											<td style="line-height:22px;">
												<b>��ţ�</b><%=pb.getPersonCode()%><br/>
												<b>������</b><%=pb.getName()%><br/>
												<b>���ڵ�λ:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getOrgId())%><br/>
												<b>���ڲ���:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId())%><br/>
												<b>��λ����:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId())%><br/>
											</td>
										</tr>
										<tr>
											<td colspan=2>
												<%=CommonFuns.filterNull(sb.getStory())%>
											</td>
										</tr>
									</table>	
									</li>
									<%	
								}							  
							  %>							
						</ul>
					</div> 
                      
                   </td>
                </tr>
              </table>
          </td>         
       </tr>

       <tr>
		<td width="60%" valign="top">
<!--               ���� -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
              <tr>
                <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b><%OperateBO oo1 = SysCacheTool.findOperate("0952");if (oo1!=null) out.println(oo1.getOperateName()); else out.println("����");%></b></font></td>
                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/system/NewsBriefMore.jsf">����</a></div></td>
                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
              </tr>
            </table>

            <table class="table02" cellspacing=0 cellpadding=0 width="100%" border="0">
            <tr>
                   <td height=278 valign="middle" align="center">
                   <script language="javascript">
                        <%
                        out.println("var focus_width="+Constants.NEW_PHOTO_WIDTH+";");
                        out.println("var focus_height="+Constants.NEW_PHOTO_HEIGHT+";");
                        out.println("var text_height=5;");
                        out.println("var swf_height = focus_height+text_height;");
                        List photoList = (List) session.getAttribute("PHOTONEWS");
                        if (photoList==null) photoList=new ArrayList();
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

                        out.println("document.write('<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0\" 	 width=\"'+ (focus_width+30) +'\" height=\"'+ swf_height +'\">' );");
                        out.println("document.write('<param name=\"allowScriptAccess\" value=\"sameDomain\"><param name=\"movie\" value=\"/file/news/focus.swf\"><param name=\"quality\" value=\"high\"><param name=\"bgcolor\" value=\"#FFFFFF\">');");
                        out.println("document.write('<param name=\"menu\" value=\"false\"><param name=wmode value=\"opaque\">');");
                        out.println("document.write('<param name=\"FlashVars\" value=\"pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+(focus_width+30)+'&borderheight='+focus_height+'&textheight='+text_height+'\">');");
                        out.println("document.write('</object>');");

                    %>
                    </script>
                   </td>
                   <td height=275 valign="top"  style="padding-top:10px;">
</c:verbatim>
                    <x:dataTable id="newsList" width="100%" align="center" border="0"  value="#{self_selfnewsbb.newsList}"    var="newsList">
                        <h:column>
                            <h:graphicImage value="/images/self/gridcode.gif" />
                            <h:graphicImage alt="������" value="/images/common/new.gif" rendered="#{newsList.newNews}"/>
                            <h:commandLink  title="#{newsList.display}" onclick="doShowNews('#{newsList.newId}')">
                               <h:outputText value=" #{newsList.newTopic}"  />
                            </h:commandLink>
                            <h:outputText value="(#{newsList.startDate})"  />
                        </h:column>
                    </x:dataTable>
<c:verbatim>
                    </td>
            </tr>

           </table>
			
        </td>

          <td width="20%" valign="top">
             <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>�ճ�����</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>

        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" height="278" valign="center">
          <tr><td valign="center" align="center">
                          <script type="text/javascript">
                          var now = new Date();
                          var month_array = new Array("һ��","����","����","����","����","����","����","����","����","ʮ��","ʮһ��","ʮ����");
                          document.write("<form name=date_list><table bgcolor=white border=0 ><tr><td>");
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
                          for(i=2010;i<2031;i++)
                          {
                           if (now.getYear() != i)
                           {document.write("<option value="+i+">"+i);}
                           else
                           {document.write("<option value="+i+" selected>"+i);}
                          }
                          document.write("</select></td></tr><tr><td colspan=2><center>");

                          document.write("<table onclick='showCalendar()' bgcolor=white border=0 cellspacing = 1 cellpading = 0 width=100%><tr bgcolor=666666 align=center>");
                          document.write("<td heigh=25 width=22 class=F02>M</td><td width=22 class=F02>T</td><td width=22 class=F02>W</td><td width=22 class=F02>T</td><td width=22 class=F02>F</td><td width=22 class=F03>S</td><td width=22 class=F03>S</td>");
                          document.write("</tr><tr>");
                          for(j=0;j<6;j++)
                          {
                           for(i=0;i<7;i++)
                           {
                             document.write("<td style='cursor:pointer' bgcolor=EFEFEF align=center id=d"+i+"r"+j+"></td>")
                           }
                           document.write("</tr>");
                          }

                          document.write("</table>");

                          document.write("</center></from></td></tr></table>");

                          var show_date = new Date();

                          function set_cal(show_date){
                              begin_day = new Date (show_date.getYear(),show_date.getMonth(),1);
                              begin_day_date = begin_day.getDay();
                              end_day = new Date (show_date.getYear(),show_date.getMonth()+1,1);
                              count_day = (end_day - begin_day)/1000/60/60/24;
                              input_table(begin_day_date,count_day);
                          }
                          set_cal(show_date);

                          function input_table(begin,count){
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
          
       </tr>

    </table>

    <table width="99%" align="center">
       <tr>
          <td>

            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
             <tr>
               <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>�Ѻ�����</b></font></td>
               <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
               <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
             </tr>
            </table>

                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="table02">
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
                document.write("��ϵͳ�Զ���Ӧ�ֱ��ʣ������ڵķֱ�����:"+screen.width+"*"+screen.height+"<br>");
                document.write("�����������:"+judgeBrowser());
            </script>
            <br>
            <%
                out.println(Constants.COMPANY_NAME);
            %>
        </td>
    </tr>
    </table>
    </bodyy
  </c:verbatim>

</h:form>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             