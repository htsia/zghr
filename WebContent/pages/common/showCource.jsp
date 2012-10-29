<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    // 显示课件 调用realplay控件
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String url = request.getParameter("URL");
    String title="";
    if ("TOMCAT".equals(CommonFuns.getAppType())){
      title=CommonFuns.getParaFromURL(request.getQueryString(),"Title");
    }
    else{
      title = request.getParameter("Title");
    }
%>

<HTML>
	<HEAD>
		<TITLE>视频播放</TITLE>
	</HEAD>
	<BODY bgColor="#cccccc" leftMargin="0" topMargin="3" marginheight="3" marginwidth="0">
		<TABLE cellSpacing="0" cellPadding="0" border="0" align="center">
			<tr>
                <td colspan="2" height=30 valign="center" align="left">题目:<%=title%> 播放器:Real Play</td>
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
											<OBJECT height="600" width="800" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" VIEWASTEXT>
												<PARAM NAME="_ExtentX" VALUE="21167">
												<PARAM NAME="_ExtentY" VALUE="15875">
												<PARAM NAME="AUTOSTART" VALUE="-1">
												<PARAM NAME="SHUFFLE" VALUE="0">
												<PARAM NAME="PREFETCH" VALUE="0">
												<PARAM NAME="NOLABELS" VALUE="0">
												<PARAM NAME="SRC" VALUE="<%=url%>">
												<PARAM NAME="CONTROLS" VALUE="Imagewindow">
												<PARAM NAME="CONSOLE" VALUE="clip1">
												<PARAM NAME="LOOP" VALUE="0">
												<PARAM NAME="NUMLOOP" VALUE="0">
												<PARAM NAME="CENTER" VALUE="0">
												<PARAM NAME="MAINTAINASPECT" VALUE="0">
												<PARAM NAME="BACKGROUNDCOLOR" VALUE="#000000">
											</OBJECT>
											<BR>
											<OBJECT height="30" width="800" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" VIEWASTEXT>
												<PARAM NAME="_ExtentX" VALUE="21167">
												<PARAM NAME="_ExtentY" VALUE="794">
												<PARAM NAME="AUTOSTART" VALUE="-1">
												<PARAM NAME="SHUFFLE" VALUE="0">
												<PARAM NAME="PREFETCH" VALUE="0">
												<PARAM NAME="NOLABELS" VALUE="0">
												<PARAM NAME="SRC" VALUE="<%=url%>">
												<PARAM NAME="CONTROLS" VALUE="ControlPanel">
												<PARAM NAME="CONSOLE" VALUE="clip1">
												<PARAM NAME="LOOP" VALUE="0">
												<PARAM NAME="NUMLOOP" VALUE="0">
												<PARAM NAME="CENTER" VALUE="0">
												<PARAM NAME="MAINTAINASPECT" VALUE="0">
												<PARAM NAME="BACKGROUNDCOLOR" VALUE="#000000">
											</OBJECT>
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
