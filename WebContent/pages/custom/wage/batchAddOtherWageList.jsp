<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	List<Map> list = (List) session.getAttribute("infoList");
%>
<script type="text/javascript">
	function process(){
		x = document.body.clientWidth / 2 - 150;
		y = document.body.clientHeight / 2;
		document.all('processbar').style.top = y;
		document.all('processbar').style.left = x;
		document.all('processbar').style.display = "";
	}
</script>
<x:saveState value="#{wage_dataOtherBB}"></x:saveState>
<h:form id="form1">
	<h:panelGrid columns="1" align="center" width="95%">
		<h:panelGroup>
			<h:commandButton styleClass="button01" value="保存" onclick="process();" action="#{wage_dataOtherBB.saveFile}" />
			<h:outputText value=" " />
			<h:commandButton styleClass="button01" value="返回" action="upload" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" align="center" width="95%">
		<h:outputLink target="_blank" rendered="#{wage_dataOtherBB.showError}"
			style="color:red" value="#{wage_dataOtherBB.errorFileUrl}">
			<f:verbatim>
				<%=LanguageSupport.getResource("JGGL-1097","上传文件数据有错误，点击下载错误数据文件")%>
			</f:verbatim>
		</h:outputLink>
	</h:panelGrid>

	<c:verbatim>
		<%
			if (list != null && list.size() > 0) {
				int col = list.size();
		%>
		<table width="95%" border="0" align="center" class="table03">
			<tr align="left" class="td_top">
				<td height="27" colspan="<%=col + 2%>" class="td_top"><%=LanguageSupport.getResource("RYGL-2273",
								"导入文件数据如下(共")%><%=list.size()%><%=LanguageSupport.getResource("RYGL-2274", "个")%>):</td>
			</tr>
			<tr>
				<td class="td_top">员工编号</td>
				<td class="td_top">姓名</td>
				<td class="td_top">所在部门</td>
				<td class="td_top">金额</td>
				<td class="td_top">备注</td>
			</tr>
			<%
				for (Map m : list) {
			%>
			<tr>
				<td class="td_middle"><%=m.get("code") %></td>
				<td class="td_middle"><%=m.get("name") %></td>
				<td class="td_middle"><%=m.get("dept") %></td>
				<td class="td_middle"><%=m.get("wage") %></td>
				<td class="td_middle"><%=m.get("remark") %></td>
			</tr>
			<%
				}
			%>
		</table>
		<%
			}
		%>
	</c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>