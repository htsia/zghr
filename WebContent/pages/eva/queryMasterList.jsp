<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
 
</script>
<x:saveState value="#{evaobjectScoreListBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{evaobjectScoreListBB.initmaster}"></h:inputHidden>
	<h:inputHidden id="masterStr" value="" />
	<c:verbatim>
		<table height=97% width=98% align="center">
			<tr>
				<td height=8></td>
			</tr>
			<tr>
				<td height=8 ></c:verbatim>
				<h:outputText value="姓名或简称："></h:outputText>
				<h:inputText value="#{evaobjectScoreListBB.queryValue}"></h:inputText>
				<h:outputText value=""></h:outputText>
				 <h:commandButton
					value="查询" styleClass="button01"
					action="#{evaobjectScoreListBB.queryMaster}"></h:commandButton> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> 
				<x:dataTable value="#{evaobjectScoreListBB.masterPersonList}" var="list" rowIndexVar="index"
					width="100%" id="dateList" styleClass="table03"
					headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="序号" />
						</f:facet>
						<h:outputText value="#{index+1}"></h:outputText>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="姓名" />
						</f:facet>
						<h:outputText escape="false" value="#{list.personName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="部门" />
						</f:facet>
						<h:outputText escape="false" value="#{list.deptName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="考核人员类别" />
						</f:facet>
						<h:outputText escape="false" value="#{list.masterType}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="打分情况" />
						</f:facet>
						<h:outputText escape="false" value="#{list.isMark}" />
					</h:column>

				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
