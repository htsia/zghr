<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
    String  parentGroupId = request.getParameter("superId");
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
//新增节点
function rptDesigner(parentGroupId){
    window.showModalDialog("/report/RptGroupDirEdit.jsf?parentGroupId=<%=parentGroupId%>", null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
    document.tree.location.href="/pages/report/ShowRptGroupDirCodeList.jsp?parentGroupId=<%=parentGroupId%>";
    return false;
}
//修改节点
function modifyDictionary(){
    if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
        alert("请选择要修改的目录!");
        return false;
    }
    window.showModalDialog("/report/RptGroupDirEdit.jsf?rptGroupDirId="+document.all("form1:currentID").value, null, "dialogWidth:390px; dialogHeight:230px;center:center;resizable:no;status:no;scroll:no;");
    document.tree.location.href="/pages/report/ShowRptGroupDirCodeList.jsp?parentGroupId=<%=parentGroupId%>";
    return false;
}

function refreshList(rptSetId) {
	document.all("form1:currentID").value=rptSetId;
    debugger;
    document.main.location.href =  "/report/ShowRptGroupItem.jsf?superId="+rptSetId;
}
with (window) onload = onresize = function(){
    var mainHeight = document.body.offsetHeight - 50;
    document.getElementById("tree").style.height = "" + (mainHeight -30) + "px";
    document.getElementById("main").style.height = "" + mainHeight + "px";
}
</script>
   
<h:form id="form1">
     <h:inputHidden  value="#{GroupDirBB.groupDirInit}"></h:inputHidden>
	 <h:inputHidden id="currentID" value="#{GroupDirBB.rptGroupDirId}"></h:inputHidden>
	<c:verbatim>
		<table width="98%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				 <td height="8px"></td>
		    </tr>
			<tr><td colspan="3" height="8px"> 
			 </c:verbatim> 
			            <h:graphicImage value="/images/tips.gif" />
						<h:outputText styleClass="f04" value="#{GroupDirBB.rptGroupBO.groupName}"></h:outputText>
			  <c:verbatim>
			 <td></tr>
			<tr>
				<td id="showTree" width="210" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30px" colspan="2"></td>
					</tr>
					 
					<tr>
						<td align="right" colspan="2">   
						</c:verbatim> 
						<h:commandButton styleClass="button01"
							type="button" value="新增节点" onclick="rptDesigner('<%=parentGroupId %>');"></h:commandButton>
						<h:commandButton styleClass="button01" type="button" value="修改"
							onclick="modifyDictionary()">
						</h:commandButton> 
							<h:commandButton
							styleClass="button01" value="删除"
							action="#{GroupDirBB.deleteRptGroupDirBO}"
							onclick="return deletedDictionary();">
					    </h:commandButton> <c:verbatim></td>
					</tr>
					<tr>
						<td  cheight="8px" colspan="2"></td>
					</tr>

					<tr>
						<td valign="bottom"><iframe name="tree" height="400"  frameborder="1"
							framespacing="0" scrolling="auto" height=100% width="100%"
							src="/pages/report/ShowRptGroupDirCodeList.jsp?parentGroupId=<%=(String)session.getAttribute("parentGroupId")%>"></iframe></td>
				   <td    width="10" class="ctrlbar" valign="middle" ><img id=ctrlBnt
					src="/images/button_1.gif" onclick="ctrlbar()"></td>					
					</tr>
				</table>
				</td>
					
			
				<td align="center" valign="top"">
				
					 <table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="bottom"><iframe name="main" height="100%"  frameborder="0" framespacing="0"
							scrolling="no"  height=600 width="100%"
							src="/report/ShowRptGroupItem.jsf"></iframe></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>



