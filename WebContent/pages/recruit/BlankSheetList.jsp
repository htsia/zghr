<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
         function doQuery(id){
             window.showModalDialog("/recruit/resumeDetail2.jsf?personId="+id, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.7+"px; status:0;resizable:yes");
             return true;
         }
</script>
<x:saveState value="#{blanksheetBB}" />
<h:form id="form1">
	<h:inputHidden value="#{blanksheetBB.initPage}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8"></c:verbatim> <h:panelGrid align="right" columns="2">
					<h:panelGroup>
						<h:outputText value="记录数:#{blanksheetBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{blanksheetBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{blanksheetBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="当前为第#{blanksheetBB.mypage.currentPage}页"></h:outputText>
						<h:commandButton value="首页" action="#{blanksheetBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{blanksheetBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{blanksheetBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{blanksheetBB.last}"
							styleClass="button01"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> <x:dataTable value="#{blanksheetBB.personList}" width="100%"
					var="list" rowIndexVar="index" align="center" id="dateList"
					headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03">
					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.a001001}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="性别" />
						</c:facet>
						<h:outputText rendered="#{list.a001007=='01001'}" value="男" />
						<h:outputText rendered="#{list.a001007=='01002'}" value="女" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="出生日期" />
						</c:facet>
						<h:outputText value="#{list.a001011}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="状态" />
						</c:facet>
						<h:outputText value="#{list.statusDes}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="启用" styleClass="button01"
							onclick="return confirm('确定重新启用吗?');"
							action="#{blanksheetBB.reuse}">
							<x:updateActionListener property="#{blanksheetBB.personId}"
								value="#{list.id}" />
						</h:commandButton>
						<h:commandButton value="查看" styleClass="button01"
							onclick="return doQuery('#{list.id}');"></h:commandButton>
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