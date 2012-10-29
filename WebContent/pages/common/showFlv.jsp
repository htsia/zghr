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
	<BODY bgColor="#cccccc" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
		<TABLE cellSpacing="0" cellPadding="0" border="0" align="center">
            <tr>
				<td>
					<object type="application/x-shockwave-flash" data="vcastr3.swf" width="900" height="600">
						<param name="movie" value="/file/videoNews/vcastr3.swf"/>
						<param name="allowFullScreen" value="true" />
						<param name="FlashVars" value="xml={vcastr}{channel}{item}{source}<%=url%>{/source}{/item}{/channel}{config}
						{bufferTime}1{/bufferTime}{contralPanelAlpha}0.8{/contralPanelAlpha}{isShowAbout}false{/isShowAbout}
						{controlPanelBgColor}0x1F1F1F{/controlPanelBgColor}{controlPanelBtnColor}0xFFFFFF{/controlPanelBtnColor}
						{contralPanelBtnGlowColro}0x66FF00{/contralPanelBtnGlowColro}{controlPanelMode}float{/controlPanelMode}
						{defautVolume}0.8{/defautVolume}{isAutoPlay}true{/isAutoPlay}{isLoadBegin}true{/isLoadBegin}
						{scaleMode}showAll{/scaleMode}{isRepeat}true{/isRepeat}{/config}{/vcastr}"/>
					</object>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>
