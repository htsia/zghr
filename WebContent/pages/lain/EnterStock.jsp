<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/lain/acceptEdit.jsf?add=add", null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doModify(id){
            window.showModalDialog("/lain/acceptEdit.jsf?modify=modify&acceptId="+id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true ;
        }
        function doItem(id){
            window.showModalDialog("/lain/acceptEdit.jsf?item=item&acceptId="+id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true ;
        }
    </script>

<x:saveState value="#{lain_AcceptBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{lain_AcceptBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:graphicImage value="/images/tips.gif" />
							<h:outputText value=" 物资管理 ->  领用入库单" styleClass="f04" />
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">

						<h:panelGroup>
							<h:outputText value="记录数:#{lain_AcceptBB.pagevo.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{lain_AcceptBB.pagevo.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{lain_AcceptBB.pagevo.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{lain_AcceptBB.pagevo.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{lain_AcceptBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{lain_AcceptBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{lain_AcceptBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{lain_AcceptBB.last}"
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
				</c:verbatim> <h:dataTable value="#{lain_AcceptBB.acceptList}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center"
					styleClass="table03" width="94%">
					<h:column>
						<c:facet name="header">
							<h:outputText value="入库单编号" />
						</c:facet>
						<h:outputText value="#{list.acceptCode}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作员" />
						</c:facet>
						<h:outputText value="#{list.acceptPersonName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="申请日期" />
						</c:facet>
						<h:outputText value="#{list.acceptDate}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="编辑" styleClass="button01"
							onclick="doModify('#{list.acceptId}')" />
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{lain_AcceptBB.deleteAcceptBO}"
							styleClass="button01">
							<x:updateActionListener
								property="#{lain_AcceptBB.acceptBO.acceptId}"
								value="#{list.acceptId}" />
						</h:commandButton>
						<h:commandButton value="查看明细" styleClass="button01"
							onclick="doItem('#{list.acceptId}')" />
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
