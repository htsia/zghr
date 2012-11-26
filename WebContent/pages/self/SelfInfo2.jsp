<%@page import="java.io.File"%>
<%@page import="com.hr319wg.common.ucc.impl.AttachmentUCC"%>
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
<%@ include file="/pages/include/taglib.jsp" %>
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
	String basepath = application.getRealPath("/");
	String img = "/images/common/nophoto.JPG";
	AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");
    if (p.getImageId() != null) {
        img = "/file/tmp/" + p.getImageId() + ".JPG";
        if (!aucc.checkAttachFileExist(basepath, p.getImageId())) {
            aucc.getFileContentToFile(basepath, p.getImageId());
        }
    }
    File f = new File(basepath+img);
    if(!f.exists()){
    	img = "/images/common/nophoto.JPG";
    }
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
    </script>
   <body style="overflow-x:hidden;overflow-y:scroll"> 
    </c:verbatim>
    <x:saveState value="#{self_selfnewsbb}"/>
    <x:saveState value="#{train_courcebb}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit2" value="#{self_selfnewsbb.pageInit}"/>
    <h:inputHidden value="#{sys_videoNewsBB.initShow}"/>

    <h:inputHidden id="operID" value="#{sys_inProcessBB.operID}"></h:inputHidden>
    <h:commandButton value="关联操作" id="doLinkOper" action="#{sys_inProcessBB.doLinkOper}" style="display:none"></h:commandButton>
    <h:commandButton value="关联待办事宜" id="processMore" action="#{sys_inProcessBB.doMoreSelf2}" style="display:none"></h:commandButton>

    <c:verbatim>
		<table width="100%" align="center" cellpadding="0" cellspacing="10">
			<tr>
				<td width="20%" valign=top>
<!-- 				left _begin-->
<!--           常用功能 -->
             <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
					<tr>
					  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>常用功能</b></font></td>
					  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
					  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
					 </tr>
			     </table>
				 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" height="280" valign="bottom">
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
                       <!--           员工风采 -->
               <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>' style="margin-top:10px;">
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>员工风采</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>
			  
			<table width="260" border="0" cellpadding="0" cellspacing="0" class="table02">
			  <tr>
                  <td height="260" align="left" valign="top">
			   <div id="box" style="margin-top:30px;">
					<ul>
						<%
							IStarsUCC rc=(IStarsUCC)SysContext.getBean("self_starsUCC");
							List<StarsBO> list=rc.getALLShow(user.getOrgId());
							for(StarsBO sb : list){
								PersonBO pb = SysCacheTool.findPersonById(sb.getPersID());
								%>
								<li style="height:180px;">
								<table width="100%" height="180" width="100%" cellspacing="0" cellpadding="0">
									<tr valign="top">
										<td width="110" height="180" align="center"><img width="100" src="/images/maininterface/stars/<%=sb.getPhotoFile()%>"/></td>
										<td style="line-height:22px;" width="200">
											<b>编号:</b><%=pb.getPersonCode()%><br/>
											<b>姓名:</b><%=pb.getName()%><br/>
											<b>部门:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId())%><br/>
											<b>岗位:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId())%><br/>
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
<!-- 				left _end-->
				</td>
				<td width="58%" valign=top>
<!-- 				middle _begin-->
<!--             人事资讯 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
              <tr>
                <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b><%OperateBO oo1 = SysCacheTool.findOperate("0952");if (oo1!=null) out.println(oo1.getOperateName()); else out.println("新闻");%></b></font></td>
                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/system/NewsBriefMore.jsf">更多</a></div></td>
                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
              </tr>
            </table>

            <table class="table02" cellspacing=0 cellpadding=0 width="100%" border="0">
            <tr>
               <%
                 List photoList = (List) session.getAttribute("PHOTONEWS");
                 if (photoList==null) photoList=new ArrayList();
                 boolean hasFlash=true;
                 if(photoList.size()==1){
                 	NewsContentBO bo = (NewsContentBO) photoList.get(0);
                 	if("-1".equals(bo.getNewId())){
                 		hasFlash=false;
                 	}
                 }
                 if(hasFlash){
                 	%>
                 	<td valign="middle" align="right" width="250">
            			<script language="javascript">
                 	<%
                  out.println("var focus_width="+Constants.NEW_PHOTO_WIDTH+";");
                  out.println("var focus_height="+Constants.NEW_PHOTO_HEIGHT+";");
                  out.println("var text_height=5;");
                  out.println("var swf_height = focus_height+text_height;");
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
                  out.println("document.write('</object>');</script></td>");
                 }
             %>
                   
                   <td height=275 valign="top" style="padding:10px 0 0 20px;">
</c:verbatim>
                    <x:dataTable id="newsList" width="100%" align="center" border="0"  value="#{self_selfnewsbb.newsList}"    var="newsList">
                        <h:column>
                            <h:graphicImage value="/images/self/gridcode.gif" />
                            <h:graphicImage alt="新闻" value="/images/common/new.gif" rendered="#{newsList.newNews}"/>
                            <h:commandLink title="#{newsList.display}" onclick="doShowNews('#{newsList.newId}')">
                               <h:outputText value=" #{newsList.newTopic}"  />
                            </h:commandLink>
                            <h:outputText value="(#{newsList.startDate})"  />
                        </h:column>
                    </x:dataTable>
<c:verbatim>
                    </td>
            </tr>
           </table>
<!--           学习园地 -->
            <table cellspacing=0 cellpadding=0 width="100%" style="margin-top:10px;">
                <tr valign="top">                   
                    <td valign="top" bgcolor='<%=Constants.FRAMECOLOR%>'>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>学习园地</b></font></td>
                                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"><a target="_blank" href="/train/CWMore.jsf">更多</a></div></td>
                                <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                              </tr>
                            </table>

                        <table border=0 id="learnTable" height=263 width="100%" cellspacing=0  cellpadding=0 class="table02">
                        <tr><td>
						<table cellspacing=0  cellpadding=0>
							<tr valign="top">
								<%
									if(videofile!=null && !"".equals(videofile)){
									%>
									<td width="400" align="right">
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
								<td style="padding:10px 0 0 20px;" align="left">
        </c:verbatim>
                        <x:dataTable id="courceList" width="100%" align="center" border="0"  value="#{train_courcebb.courceList}"    var="courceList">
                            <h:column>
                                <h:graphicImage  value="/images/self/gridcode.gif"/>
                                <h:graphicImage alt="新课件" value="/images/common/new.gif" rendered="#{courceList.newCource}"/>
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

<!-- 				middle _end-->
				</td>
				<td valign="top">
<!-- 				right _begin-->
<!-- 		    用户信息 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>'>
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>用户信息</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"><div align="right"></div></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>
				 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" valign="center">
				  <tr>
					 <td height="165" align="center">
		              	  <table >
		              	  	<tr valign="top">
		              	  		<td>
		              	  			<img alt="<%=p.getName()%>" src="<%=img%>" width="110" />
		              	  		</td>
								<td style="line-height:22px;padding:10px 0 0 10px;">
									<b>编号:</b><%=p.getPersonCode()%><br/>
									<b>姓名:</b><%=p.getName()%><br/>
									<b>部门:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId())%><br/>
									<b>岗位:</b><%=CodeUtil.interpertCode(CodeUtil.TYPE_POST, p.getPostId())%><br/>
								</td>
							</tr>
		              	  </table>
					 </td>
				  </tr>
				</table>        
				<!--           日程管理 -->
             <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>' style="margin-top:10px;">
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>日程管理</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>

        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" height="160" valign="center">
          <tr><td valign="center" align="center">
                          <script type="text/javascript">
                          var now = new Date();
                          var month_array = new Array("一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月");
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
                  

<!--              问卷调查 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor='<%=Constants.FRAMECOLOR%>' style="margin-top:10px;">
                <tr>
                  <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>问卷调查</b></font></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;"></td>
                  <td background="/images/maininterface/desktop_bar_bg.gif" style=" line-height:25px;" width="5"><div align="right"><img src="/images/maininterface/desktop_bar_right.gif" width="5" height="25"></div></td>
                </tr>
              </table>

				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02" valign="center">
				  <tr>
					 <td valign="top" align="center">
						<iframe id="dcwj" src="/self/ShowSurvey.jsf" frameborder="0"  width="225" scrolling="no" height="180"></iframe>
					 </td>
				  </tr>
				</table>


                  
<!-- 				right _end-->
				</td>
			</tr>
		</table>
<!-- 友情链接 -->
		<table width="99%" align="center">
       <tr>
          <td>

            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
             <tr>
               <td align="left" valign="middle" background="/images/maininterface/desktop_bar_bg.gif"><img src="/images/maininterface/desktop_bar_left.gif" width="6" height="25" align="absmiddle"><img src="/images/maininterface/radio_blue.gif" width="16" height="16" align="absmiddle">&nbsp;<font color="#0a66a0"><b>友情链接</b></font></td>
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
    </body>
  </c:verbatim>

</h:form>    