<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<base target="_self">
<script type="text/javascript">
	
</script>
<x:saveState value="#{emp_letterBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emp_letterBB.cadresDetail}"></h:inputHidden>
	<table width="100%" class="td_title">
		<tr>
			<td align="right"><h:commandButton type="button"
					styleClass="button01" value="关闭" onclick="window.close()"></h:commandButton>
			</td>
		</tr>
	</table>
	<br>
	<br>
	<h:dataTable width="1200px" value="#{emp_letterBB.personList}"
		var="list" align="center" headerClass="td_top"
		columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
		styleClass="table03">

		<h:column>
			<c:facet name="header">
				<f:verbatim>
					<%=LanguageSupport.getResource(
										"RYGL-2163", "申请日期")%>
				</f:verbatim>
			</c:facet>
			<h:outputText value="#{list.applyDate}" />
		</h:column>
		<h:column>
			<c:facet name="header">
			      <f:verbatim>
				     <%=LanguageSupport.getResource("XTGL-1042", "员工编号")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.personCode}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			    <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2161", "介绍信编号")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.letterNo}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			    <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-1016", "姓名")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.name}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			      <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2176", "身份")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.degree}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			    <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2146", "原单位")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.fromOrgName}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			     <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2175", "调往单位")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.toOrgName}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			      <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2169", "原单位意见")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.fromOpinionDes}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			     <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2172", "原单位审批原因")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.fromReason}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			      <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2171", "原单位审批时间")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.fromDate}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			    <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2170", "原单位合同情况")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.cont_old_end}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			      <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2169", "调入单位意见")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.toOpinionDes}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			     <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2168", "调入单位审批原因")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.toReason}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			     <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2167", "调入单位审批时间")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.toDate}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			     <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2177", "调入单位合同情况")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.cont_new_begin}" />
		</h:column>

		<h:column>
			<c:facet name="header">
			     <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2151", "办理状态")%>
			    </f:verbatim>
			</c:facet>
			<h:outputText value="#{list.applyStatusDes}" />
		</h:column>
	</h:dataTable>
</h:form>