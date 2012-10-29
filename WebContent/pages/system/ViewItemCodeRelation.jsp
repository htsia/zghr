<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script language="javascript">
	function forSelDes() {
		PopUpCodeDlgTwoControlSelectAll(document.all('form1:desid'), document
				.all('form1:desdes'), document.all("form1:desField").value, '');
		return false;
	}
	function forSelSource() {
		if (document.all('form1:oper1').value == '1') {
			PopUpMutilCodeDlgNoSubmit('form1:classvalue',
					'form1:classvaluedes',
					document.all("form1:sourceField").value, '');
		} else {
			PopUpCodeDlgTwoControlSelectAll(document.all('form1:classvalue'),
					document.all('form1:classvaluedes'), document
							.all("form1:sourceField").value, '');
		}
		return false;
	}
	function doModify(id) {
		window
				.showModalDialog(
						"/system/EditItemCodeRelation.jsf?itemID=" + id,
						null,
						"dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
		return true;
	}
	function chkNull() {
		if (document.getElementById("form1:desid").value == ""
				|| document.getElementById("form1:classvalue").value == "") {
			alert("请选择相关项目！")
			return false;
		} else {
			return true;
		}
	}
</script>


<x:saveState value="#{sys_codeItemListBB}" />
<h:form id="form1">
	<h:inputHidden value="#{sys_codeItemListBB.initRelation}" />
	<h:inputHidden id="desField"
		value="#{sys_codeItemListBB.codeRel.desField}" />
	<h:inputHidden id="sourceField"
		value="#{sys_codeItemListBB.codeRel.sourceField}" />
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8 class="td_title"></c:verbatim> <h:graphicImage
						value="/images/tips.gif" /> <f:verbatim>
						<%=LanguageSupport
							.getResource("XTGL-1270", "查看对应关系")%>
					</f:verbatim> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td height=5 align="right"></c:verbatim> <h:commandButton value="计算"
						styleClass="button01" action="#{sys_codeItemListBB.CaclByOrg}"></h:commandButton>
					<c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<h:dataTable styleClass="table03" align="center" width="95%"
							headerClass="td_top tr_fixrow"
							columnClasses="td_top,td_middle,td_middle,td_middle,td_middle,td_middle"
							value="#{sys_codeItemListBB.relationBos}" var="list" border="0">

							<h:column>
								<f:facet name="header"> 
								     <f:verbatim>
						                     <%=LanguageSupport.getResource("XTGL-1232","分类")%> 
						             </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.desSuperCodeDes}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								      <f:verbatim>
						                     <%=LanguageSupport.getResource("XTGL-1271","结果代码")%> 
						             </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.desCodeDes}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								     <f:verbatim>
						                     <%=LanguageSupport.getResource("XTGL-1272","关系符")%> 
						             </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.operDes}" />
							</h:column>

							<h:column>
								<f:facet name="header">
									<f:verbatim>
						                     <%=LanguageSupport.getResource("XTGL-1273","对应代码")%> 
						             </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.sourceCodeDes}" />
							</h:column>
						</h:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
</script>
