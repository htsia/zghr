<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
//删除报套
function deletedDictionary(){
    if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
        alert("请选择要删除的目录!");
        return false;
    }
    if (confirm("确定要删除吗?")){
        return true;
    }
    else{
        return false;
    }
}
//新增报套"document.tree.location.href="/pages/report/ShowRptSetCodeList.jsp";" 操作完毕之后立即刷新，此时在页面内执行查询，与托管bean无管。
function rptDesigner(){
    window.showModalDialog("/report/RptGroupEdit.jsf?ok=10000", null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
    document.tree.location.href="/pages/report/ShowRptGroupDefineCodeList.jsp";
}
//修改报套
function modifyDictionary(){
    if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
        alert("请选择要修改的目录!");
        return false;
    }
    window.showModalDialog("/report/RptGroupEdit.jsf?rptGroupId="+document.all("form1:currentID").value, null, "dialogWidth:390px; dialogHeight:230px;center:center;resizable:no;status:no;scroll:no;");
    document.tree.location.href="/pages/report/ShowRptGroupDefineCodeList.jsp";
    return false;
}

function refreshList(rptSetId) {
	document.all("form1:currentID").value=rptSetId;
    debugger;
    document.main.location.href = "/report/ShowRptGroupDir.jsf?init=true&superId="+rptSetId;
}
with (window) onload = onresize = function(){
    var mainHeight = document.body.offsetHeight - 50;
    document.getElementById("tree").style.height = "" + (mainHeight -30) + "px";
    $("iframe[name=main]").height(mainHeight);
}
</script>

<h:form id="form1">
	<h:inputHidden id="currentID" value="#{GroupDefineBB.rptGroupId}"></h:inputHidden>
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="汇总关系定义" />
		</h:panelGroup>
	</h:panelGrid>

	<c:verbatim>
		<table width="98%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td id="showTree" width="210" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="8px"></td>
					</tr>
					<tr>
						<td align="right"></c:verbatim> <h:commandButton styleClass="button01"
							type="button" value="新增分组" onclick="rptDesigner();"></h:commandButton>
						<h:commandButton styleClass="button01" type="button" value="修改"
							onclick="modifyDictionary()"></h:commandButton> <h:commandButton
							styleClass="button01" value="删除"
							action="#{GroupDefineBB.deleteRptGroupBO}"
							onclick="return deletedDictionary();"></h:commandButton> <c:verbatim></td>
					</tr>
					<tr>
						<td height="8px"></td>
					</tr>

					<tr>
						<td valign="top"><iframe name="tree" height="400"  frameborder="1"
							framespacing="0" scrolling="auto" height=600 width="100%"
							src="/pages/report/ShowRptGroupDefineCodeList.jsp"></iframe></td>
					</tr>
				</table>
				</td>

				<td width="10" class="ctrlbar" valign="middle"><img id=ctrlBnt
					src="/images/button_1.gif" onclick="ctrlbar()"></td>

				<td align="center" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><iframe name="main" height="100%"  frameborder="0" framespacing="0"
							scrolling="auto" height=600 width="100%"
							src="/report/ShowRptGroupDir.jsf"></iframe></td>
					
				</table>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>




