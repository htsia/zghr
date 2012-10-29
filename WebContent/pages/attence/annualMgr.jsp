<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function openSee(recID){
    window.showModalDialog("/attence/annualQuery.jsf?recID="+recID, "", "dialogWidth:1000px; dialogHeight:600px; status:0;resizable:yes");
    return true;
}

function PunshCardmanager(recID){
    window.showModalDialog("/attence/annualMgrList.jsf?recID="+recID, "", "dialogWidth:1300px; dialogHeight:1000px; status:0;resizable:yes");
    return true;
}

function addRecuNeed(){
             window.showModalDialog("/attence/annualMgrAdd.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:"+screen.width*0.3+"px; dialogHeight:"+screen.height*0.3+"px; status:0;resizable:yes");
             return true;
}

function modify(id){
    window.showModalDialog("/attence/annualMgrAdd.jsf?recID="+id, "", "dialogWidth:"+screen.width*0.3+"px; dialogHeight:"+screen.height*0.3+"px; status:0;resizable:yes");
    return true;
}
</script>
<x:saveState value="#{annualMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{annualMgrBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{annualMgrBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif"> 年假管理</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:outputText value="当前机构:"></h:outputText>
							<h:outputText value="#{annualMgrBB.superName}"></h:outputText>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">


						<h:panelGroup>
							<h:outputText value="记录数:#{annualMgrBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{annualMgrBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{annualMgrBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{annualMgrBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{annualMgrBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{annualMgrBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{annualMgrBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{annualMgrBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton value="新增" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{annualMgrBB.lists}" var="list" rowIndexVar="index"
					id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">

					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="年度" />
						</c:facet>
						<h:outputText value="#{list.recodeYear}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="计算规则" />
						</c:facet>
						<h:outputText value="#{list.ruleName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="年度开始日期" />
						</c:facet>
						<h:outputText value="#{list.yearBegin}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="年度结束日期" />
						</c:facet>
						<h:outputText value="#{list.yearEnd}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="最后计算时间" />
						</c:facet>
						<h:outputText value="#{list.lastCaclDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="修改" rendered="#{list.statusValue=='0'}"
							onclick="return modify('#{list.recID}');" styleClass="button01"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							rendered="#{list.statusValue=='0'}"
							action="#{annualMgrBB.delete}" styleClass="button01">
							<x:updateActionListener property="#{annualMgrBB.recID}"
								value="#{list.recID}" />
						</h:commandButton>
						<h:commandButton value="管理"
							onclick="return PunshCardmanager('#{list.recID}');"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="结束" onclick="return confirm('确定要结束吗?');"
							rendered="#{list.statusValue=='0'}"
							action="#{annualMgrBB.gameOver}" styleClass="button01">
							<x:updateActionListener property="#{annualMgrBB.recID}"
								value="#{list.recID}" />
						</h:commandButton>
						<h:commandButton value="实时数据查询" onclick="return openSee('#{list.recID}');" styleClass="button01"></h:commandButton>
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





