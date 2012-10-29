<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>


<script type="text/javascript">
	function forView() {
		forViewPersonDetail(document.all("form1:code").value);
	}
</script>

<x:saveState value="#{emp_personListBB}" />
<h:form id="form1">
	<h:inputHidden value="#{emp_personListBB.doBatchReduceAudit}" />
	<h:inputHidden value="#{emp_personListBB.code}" />
	<c:verbatim>
		<table width="98%" height=98% align="center">
			<tr class="td_title">
				<td align="right" height=8></c:verbatim> <h:commandButton id="cancel"
						styleClass="button01" value="退回"
						action="#{emp_personListBB.batchauditReduceNO}" /> <h:commandButton
						id="save" styleClass="button01" value="同意"
						action="#{emp_personListBB.batchauditReduceOK}" /> <h:commandButton
						type="button" styleClass="button01" value="关闭"
						onclick="window.close()" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td height=8></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<h:dataTable value="#{emp_personListBB.reduceList}" var="list"
							align="center" id="dateList" headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<c:facet name="header">
							   <f:verbatim>
				                    <%=LanguageSupport.getResource("XTGL-1042","员工编号")%>
				               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.persCode}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
				                    <%=LanguageSupport.getResource("MSG-0010","姓名")%>
				               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.persName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				                    <%=LanguageSupport.getResource("RYGL-2297","变更前类别")%>
				               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.a001054cur}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									 <f:verbatim>
				                    <%=LanguageSupport.getResource("RYGL-2298","变更后类别")%>
				               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.a001054des}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				                    <%=LanguageSupport.getResource("RYGL-2299","减员原因")%>
				               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.a016010des}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									  <f:verbatim>
				                    <%=LanguageSupport.getResource("RYGL-2300","变更后状态")%>
				               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.a001725des}" />
							</h:column>
						</h:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
