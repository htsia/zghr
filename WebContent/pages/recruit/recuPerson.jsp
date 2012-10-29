<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
         function doQuery(id){
             window.showModalDialog("/recruit/reservePersonList.jsf?personId="+id, "", "dialogWidth:600px; dialogHeight:450px; status:0;resizable:yes");
             return true;
         }
</script>

<x:saveState value="#{recu_recuPersonBB}" />
<h:form id="form1">
	<h:inputHidden value="#{recu_recuPersonBB.initPage}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8"></c:verbatim> <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{recu_recuPersonBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recu_recuPersonBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recu_recuPersonBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recu_recuPersonBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{recu_recuPersonBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recu_recuPersonBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recu_recuPersonBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recu_recuPersonBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> <x:dataTable value="#{recu_recuPersonBB.personList}" width="100%"
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
						<h:outputText value="#{recu_recuPersonBB.odbo.statusDes}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="审批" styleClass="button01"
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