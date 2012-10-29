<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function doBatchWork() {
	var recID = document.all('form1:recID').value;
	var flag = 0;
	var perIds = "id";
    if (checkMutilSelect(document.forms(0).selected_ids)) {
        var obj = document.forms(0).selected_ids;
        var size = obj.length;
        if (size == null) {
            if (obj.checked) {
                perIds +=","+obj.value;
            }
        }else {
            for (var i = 0; i < size; i++) {
                   if (obj[i].checked) {
                       perIds +=","+obj[i].value;
                   }
            }

        }
        window.showModalDialog("/attence/annualMgrListExecludeRule.jsf?name="+perIds+"&recID="+recID, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    } else {
        alert("请先选择人员");
        return false;
    }
}

function PunshCardmanager(itemID){
    window.showModalDialog("/attence/annualMgrListChild.jsf?itemID="+itemID, "", "dialogWidth:1000px; dialogHeight:600px; status:0;resizable:yes");
    return true;
}

function PunshCardmanager1(){
	var recID=document.all('form1:recID').value;
    window.showModalDialog("/attence/annualMgrListExecludeRuleList.jsf?recID="+recID, "", "dialogWidth:1000px; dialogHeight:600px; status:0;resizable:yes");
    return true;
}
</script>
<x:saveState value="#{annualMgrListBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{annualMgrListBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{annualMgrListBB.superId}"></h:inputHidden>
	<h:inputHidden id="recID" value="#{annualMgrListBB.recID}"></h:inputHidden>
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
                            <h:outputText value="姓名和员工编号:"></h:outputText>
                            <h:inputText value="#{annualMgrListBB.personValue}" styleClass="input"></h:inputText>
                            <h:commandButton value="查询" action="#{annualMgrListBB.doQuery}"
								styleClass="button01"></h:commandButton>
							<h:outputText value=" "></h:outputText>
							<h:commandButton value="不符合年休假人员列表"
								onclick="return PunshCardmanager1();" styleClass="button01"></h:commandButton>
							<h:outputText value=" "></h:outputText>
							<h:commandButton value="手工排除" onclick="return doBatchWork();"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="4">


						<h:panelGroup>
							<h:outputText value="记录数:#{annualMgrListBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="页数:#{annualMgrListBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="每页有#{annualMgrListBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="当前为第#{annualMgrListBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页" action="#{annualMgrListBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="上页" action="#{annualMgrListBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="下页" action="#{annualMgrListBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页" action="#{annualMgrListBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton value="初始化" 
							action="#{annualMgrListBB.initializationMethod}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="清空" onclick="return confirm('确定要清空吗?');"
							action="#{annualMgrListBB.clearMethod}" styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{annualMgrListBB.lists}" var="list" rowIndexVar="index"
					id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">
					<h:column>
						<c:facet name="header">
							<c:verbatim escape="false">
								<input type="checkbox" name="chkAll"
									onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);" />
							</c:verbatim>
						</c:facet>
						<c:verbatim escape="false">
							<input type="checkbox" name="selected_ids"
								value="</c:verbatim>
                  <h:outputText value="#{list.personID}"/>
                  <c:verbatim>">
						</c:verbatim>
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="人员姓名" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="进入本单位时间" />
						</c:facet>
						<h:outputText value="#{list.enterDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="参加工作时间" />
						</c:facet>
						<h:outputText value="#{list.workDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="计算日期" />
						</c:facet>
						<h:outputText value="#{list.calcDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="假期天数" />
						</c:facet>
						<h:outputText value="#{list.annDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="已休天数" />
						</c:facet>
						<h:outputText value="#{list.useDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="剩余天数" />
						</c:facet>
						<h:outputText value="#{list.avaDay}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="临界日期" />
						</c:facet>
						<h:outputText value="#{list.criticalDate}" />
					</h:column>
					
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="临界后假期天数" />
						</c:facet>
						<h:outputText value="#{list.criticalAnnDay}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="临界后已休天数" />
						</c:facet>
						<h:outputText value="#{list.calcAnnDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="临界后剩余天数" />
						</c:facet>
						<h:outputText value="#{list.criticalAvaDay}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="休假" onclick="return PunshCardmanager('#{list.itemID}');" styleClass="button01"></h:commandButton>
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





