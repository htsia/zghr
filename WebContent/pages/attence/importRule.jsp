<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
         function addRecuNeed(){
             window.showModalDialog("/attence/importRuleAdd.jsf?okID=100", "", "dialogWidth:"+screen.width*0.3+"px; dialogHeight:"+screen.height*0.4+"px; status:0;resizable:yes");
             return true;
         }
function modify(id,id1){
    window.showModalDialog("/attence/importRuleAdd.jsf?importID="+id+"&oid="+id1, "", "dialogWidth:"+screen.width*0.3+"px; dialogHeight:"+screen.height*0.4+"px; status:0;resizable:yes");
    return true;
}
function modify1(id,id1){
    window.showModalDialog("/attence/importRuleList.jsf?importID="+id+"&oid="+id1, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:yes");
    return true;
}
</script>
<x:saveState value="#{att_importRuleBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{att_importRuleBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">考勤数据文件接收规则</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="1">
					<h:panelGrid align="right" columns="1">
						<h:commandButton value="新建规则" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{att_importRuleBB.lists}" var="list" rowIndexVar="index"
					id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%" border="0">
					<h:column>
						<c:facet name="header">
							<h:outputText value="规则名称" />
						</c:facet>
						<h:outputText value="#{list.importName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="应用范围" />
						</c:facet>
						<h:outputText value="#{list.createOrgName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="创建机构" />
						</c:facet>
						<h:outputText value="#{list.createOrgName1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="文件格式" />
						</c:facet>
						<h:outputText value="#{list.fileFormatName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="文本文件格式" />
						</c:facet>
						<h:outputText value="#{list.txtModeName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="分割符号" />
						</c:facet>
						<h:outputText value="#{list.spiltChar}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="时间处理类别" />
						</c:facet>
						<h:outputText value="#{list.timeFormatName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{att_importRuleBB.delete}" styleClass="button01"
							rendered="#{list.status1=='1'}">
							<x:updateActionListener property="#{att_importRuleBB.importID}"
								value="#{list.importID}" />
						</h:commandButton>
						<h:commandButton value="修改定义"
							onclick="return modify('#{list.importID}','#{list.createOrg}')"
							styleClass="button01" rendered="#{list.status1=='1'}"></h:commandButton>
						<h:commandButton value="修改文件格式"
							onclick="return modify1('#{list.importID}','#{list.importName}')"
							styleClass="button01" rendered="#{list.status1=='1'}"></h:commandButton>
					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
</body>
