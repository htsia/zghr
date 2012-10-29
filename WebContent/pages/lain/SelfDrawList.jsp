<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/lain/SelfDrawEdit.jsf?add=true", null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doModify(id){
            window.showModalDialog("/lain/SelfDrawEdit.jsf?modify=true&drawId="+id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true ;
        }
        function doShow(id){
            window.showModalDialog("/lain/SelfDrawEdit.jsf?isBrower=true&drawId="+id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true ;
        }
    </script>

<x:saveState value="#{lain_SelfDrawBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{lain_SelfDrawBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:graphicImage value="/images/tips.gif" />
							<h:outputText value=" 劳保管理 ->  自助领用申请单" styleClass="f04"  />
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2"  >

						<h:panelGroup>
							<h:outputText value="记录数:#{lain_SelfDrawBB.pagevo.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{lain_SelfDrawBB.pagevo.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{lain_SelfDrawBB.pagevo.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{lain_SelfDrawBB.pagevo.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{lain_SelfDrawBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{lain_SelfDrawBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{lain_SelfDrawBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{lain_SelfDrawBB.last}"
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
				</c:verbatim> <h:dataTable value="#{lain_SelfDrawBB.selfDrawList}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center, td_middle_center, td_middle_center"
					styleClass="table03" width="94%">
					<h:column>
						<c:facet name="header">
							<h:outputText value="申请单编号" />
						</c:facet>
						<h:outputText value="#{list.drawCode}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="申请人" />
						</c:facet>
						<h:outputText value="#{list.drawPerName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="申请日期" />
						</c:facet>
						<h:outputText value="#{list.drawDate}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="编辑" styleClass="button01" rendered="#{list.drawStatus == '0'}"
							onclick="doModify('#{list.drawId}')" />
						<h:commandButton value="查看" styleClass="button01"  rendered="#{list.drawStatus == '1'}"
							onclick="doShow('#{list.drawId}')"  />
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" rendered="#{list.drawStatus == '0'}"
							action="#{lain_SelfDrawBB.deleteDrawBO}"
							styleClass="button01">
							<x:updateActionListener
								property="#{lain_SelfDrawBB.drawBO.drawId}"
								value="#{list.drawId}" />
						</h:commandButton>
						<h:commandButton value="未生效"  rendered="#{list.drawStatus == '0'}"  styleClass="button01" />
						<h:commandButton value="已生效"  rendered="#{list.drawStatus == '1'}"  styleClass="button01" /> 
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
