<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/lain/DrawItemEdit.jsf?drawId="+document.all("form1:drawId").value , null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doModify(id){
            window.showModalDialog("/lain/DrawItemEdit.jsf?drawItemId="+id, null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
            return true ;
        }
        function drawItem(id){
            window.showModalDialog("/lain/LainDrawItemIndex.jsf?drawId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{lain_DrawItemBB}"></x:saveState>
<f:verbatim>
</f:verbatim>
<h:form id="form1">
	<h:inputHidden value="#{lain_DrawItemBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="drawId" value="#{lain_DrawItemBB.drawId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:graphicImage value="/images/tips.gif" />
							<h:outputText value=" 物资领用 ->  领用申请单明细" styleClass="f04" />
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">
						<h:panelGroup>
							<h:outputText value="记录数:#{lain_DrawItemBB.pagevo.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{lain_DrawItemBB.pagevo.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{lain_DrawItemBB.pagevo.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{lain_DrawItemBB.pagevo.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{lain_DrawItemBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{lain_DrawItemBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{lain_DrawItemBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{lain_DrawItemBB.last}"
								styleClass="button01"></h:commandButton>
							<h:outputText value="  "></h:outputText>
							<h:commandButton value="增加" onclick="return doAdd();"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>

					</h:panelGrid>
				</h:panelGrid> <c:verbatim></td>
			</tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> <h:dataTable value="#{lain_DrawItemBB.drawItemkList}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center, td_middle_center, td_middle_center"
					styleClass="table03" width="93%">
					<h:column>
						<c:facet name="header">
							<h:outputText value="领用物资" />
						</c:facet>
						<h:outputText value="#{list.stockName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="领用数量" />
						</c:facet>
						<h:outputText value="#{list.drawSum}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="修改" styleClass="button01"
							onclick="doModify('#{list.drawItemId}')" />
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{lain_DrawItemBB.deleteDrawItemBO}" styleClass="button01">
							<x:updateActionListener
								property="#{lain_DrawItemBB.drawItemBO.drawItemId}"
								value="#{list.drawItemId}" />
						</h:commandButton>
					</h:column>
				</h:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
