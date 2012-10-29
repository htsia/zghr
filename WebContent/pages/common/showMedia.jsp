<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    // 显示课件 调用realplay控件
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String url = request.getParameter("URL");
    String title = "";
    if ("TOMCAT".equals(CommonFuns.getAppType())) {
        title = CommonFuns.getParaFromURL(request.getQueryString(), "Title");
    } else {
        title = request.getParameter("Title");
    }

%>

<HTML>
	<HEAD>
		<TITLE>视屏播放</TITLE>
	</HEAD>
	<BODY bgColor="#cccccc" leftMargin="0" topMargin="3" marginheight="3" marginwidth="0">
		<TABLE cellSpacing="0" cellPadding="0" border="0" align="center">
			<tr>
                <td colspan="2" height=30 valign="center" align="left">标题:<%=title%> 播放器:Windows Media Play</td>
            </tr>
            <TR>
				<TD width="208" background="/images/self/bg.gif"><IMG height="25" src="/images/self/train.gif" width="208"></TD>
				<TD vAlign="bottom" align="right" background="/images/self/bg.gif"><IMG height="9" src="/images/self/coner.gif" width="3"></TD>
			</TR>

			<TR>
				<TD colSpan="2" height="12">
					<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
						<TR>
							<TD width="1" bgColor="#ffdda2"></TD>
							<TD width="7" bgColor="#ffa200"></TD>
							<TD width="1" bgColor="#000000"></TD>
							
							<TD vAlign="top" align="center">
								<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR >
										<TD align="center" colSpan="2">
                                            <object id="NSPlay" width=800 height=600 classid="CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95" codeｂａｓｅ="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab# Version=6,4,5,715" standby="Loading Microsoft Windows Media Player components..." type="application/x-oleobject" align="right" hspace="5">
                                            <!-- ASX File Name -->
                                            <param name="AutoRewind" value=1>
                                            <param name="FileName" value="<%=url%>">
                                            <!-- Display Controls -->

                                            <param name="ShowControls" value="1">
                                            <!-- Display Position Controls -->

                                            <param name="ShowPositionControls" value="0">
                                            <!-- Display Audio Controls -->

                                            <param name="ShowAudioControls" value="1">
                                            <!-- Display Tracker Controls -->

                                            <param name="ShowTracker" value="0">
                                            <!-- Show Display -->

                                            <param name="ShowDisplay" value="0">
                                            <!-- Display Status Bar -->

                                            <param name="ShowStatusBar" value="0">
                                            <!-- Diplay Go To Bar -->

                                            <param name="ShowGotoBar" value="0">
                                            <!-- Display Controls -->

                                            <param name="ShowCaptioning" value="0">
                                            <!-- Player Autostart -->

                                            <param name="AutoStart" value=1>
                                            <!-- Animation at Start -->

                                            <param name="Volume" value="-2500">
                                            <param name="AnimationAtStart" value="0">
                                            <!-- Transparent at Start -->

                                            <param name="TransparentAtStart" value="0">
                                            <!-- Do not allow a change in display size -->

                                            <param name="AllowChangeDisplaySize" value="0">
                                            <!-- Do not allow scanning -->

                                            <param name="AllowScan" value="0">
                                            <!-- Do not show contect menu on right mouse click -->

                                            <param name="EnableContextMenu" value="0">
                                            <!-- Do not allow playback toggling on mouse click -->
                                            <param name="ClickToPlay" value="0">
                                            </object>
										</TD>
									</TR>
								</TABLE>
							</TD>
							
							<TD width="1" bgColor="#000000"></TD>
							<TD width="7" bgColor="#ffa200"></TD>
							<TD width="1" bgColor="#ffdda2"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			
			<TR>
				<TD colSpan="2">
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffa200" border="0">
						<TR>
							<TD style="BORDER-LEFT: #ffdda2 1px solid; BORDER-BOTTOM: #ffdda2 1px solid" width="7" height="9"></TD>
							<TD style="BORDER-TOP: #000000 1px solid; BORDER-BOTTOM: #ffdda2 1px solid"></TD>
							<TD style="BORDER-RIGHT: #ffdda2 1px solid; BORDER-BOTTOM: #ffdda2 1px solid" width="6"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
