<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function PunshCardmanager(yearManager,monthManager){
    window.showModalDialog("/custom/attence/attLogMgr.jsf", "", "dialogWidth:1100px; dialogHeight:600px; status:0;resizable:yes");
    return true;
}
		function PeriodSetSee(id,id1,id2,id3){
		    window.showModalDialog("/attence/PeriodSetOpen.jsf?orgID="+id+"&duraYear="+id1+"&duraMonth="+id2+"&duraID="+id3+"&see=see", "", "dialogWidth:"+screen.width*1.0+"px; dialogHeight:"+screen.height*1.0+"px; status:0;resizable:yes");
		    return true;
		}
function PeriodSetOpen(orgID,duraID,isView){
    window.showModalDialog("/custom/attence/attCalcMgr.jsf?dID="+duraID+"&isView="+isView, "", "dialogWidth:"+screen.width*1.0+"px; dialogHeight:"+screen.height*1.0+"px; status:0;resizable:yes");
    return true;
}
         function addRecuNeed(){
             window.showModalDialog("/attence/PeriodSetEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
             return true;
         }
function modify(id,id1){
    window.showModalDialog("/attence/PeriodSetEdit.jsf?duraID="+id+"&oid="+id1, "", "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
    return true;
}
function caclrule(){
    window.showModalDialog("/attence/attcaclrule.jsf", "", "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
    return true;
}
function verify(ym){
    window.showModalDialog("/custom/attence/attCalcRestulVerify.jsf", "", "dialogWidth:1100px; dialogHeight:600px; status:0;resizable:yes");
}
</script>
<x:saveState value="#{period_setBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{period_setBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{period_setBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">考勤管理 -> 考勤计算</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="right" columns="3">
						<h:panelGroup>
							<h:outputText value="记录数:#{period_setBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{period_setBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{period_setBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{period_setBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{period_setBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{period_setBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{period_setBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{period_setBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton value="增加" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{period_setBB.attenceSetList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
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
							<h:outputText value="工资年度" />
						</c:facet>
						<h:outputText value="#{list.duraYear}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="工资月度" />
						</c:facet>
						<h:outputText value="#{list.duraMonth}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="起始日期" />
						</c:facet>
						<h:outputText value="#{list.duraBegin}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="终止日期" />
						</c:facet>
						<h:outputText value="#{list.duraEnd}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="关联查询方案" />
						</c:facet>
						<h:outputText value="#{list.qryName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="读取打卡记录"
							onclick="return PunshCardmanager('#{list.duraBegin}','#{list.duraEnd}');"
							styleClass="button01" rendered="#{list.status=='0'}"
							></h:commandButton>
						<h:commandButton value="计算"
							onclick="return PeriodSetOpen('#{list.orgID}','#{list.duraID}',0);"
							styleClass="button01"
							rendered="#{list.status=='0'}"></h:commandButton>
						<h:commandButton value="发布" styleClass="button01" onclick="return confirm('确定要发布吗');"
							action="#{period_setBB.issue}" rendered="#{list.status=='0'}">
							<x:updateActionListener property="#{period_setBB.duraID}"
								value="#{list.duraID}" />
						</h:commandButton>
						<h:commandButton value="审核" styleClass="button01" onclick="verify('#{list.duraYear}#{list.duraMonth}')"
							rendered="#{list.status=='1'}"></h:commandButton>
						<h:commandButton value="完结" styleClass="button01" onclick="return confirm('确定要完结吗:');"
							action="#{period_setBB.end}" rendered="#{list.status=='1'}">
							<x:updateActionListener property="#{period_setBB.duraID}"
								value="#{list.duraID}" />
						</h:commandButton>
						<h:commandButton value="查看"
							onclick="return PeriodSetOpen('#{list.orgID}','#{list.duraID}',1);"
							styleClass="button01" rendered="#{list.status=='2'}"></h:commandButton>
						<h:commandButton value="编辑"
							onclick="return modify('#{list.duraID}','#{period_setBB.superId}')"
							styleClass="button01"
							rendered="#{list.status=='0' || list.status=='1'}"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?删除以后，本次计算的结果也将一并删除');"
							action="#{period_setBB.delete}" styleClass="button01"
							rendered="#{list.status=='0' || list.status=='1'}">
							<x:updateActionListener property="#{period_setBB.duraID}"
								value="#{list.duraID}" />
						</h:commandButton>

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




