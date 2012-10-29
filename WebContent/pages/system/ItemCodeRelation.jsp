<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script language="javascript">
	function doCalc() {
		if (confirm("确定进行计算吗?")) {
			forsubmit(document.forms[0])
			showProcessBar();
			return true;
		} else
			return false;
	}
	function showProcessBar() {
		x = document.body.clientWidth / 2 - 150;
		y = document.body.clientHeight / 2;
		document.all('processbar').style.top = y;
		document.all('processbar').style.left = x;
		document.all('processbar').style.display = "";
	}
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
		if (document.getElementById("form1:oper1").value == ""
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
	<h:inputHidden id="desField"		value="#{sys_codeItemListBB.codeRel.desField}" />
	<h:inputHidden id="sourceField" 		value="#{sys_codeItemListBB.codeRel.sourceField}" />
	<h:inputHidden id="setType" value="#{sys_codeItemListBB.setType}" />

	<f:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8 class="td_title"><img src="/images/tips.gif">
					<%=LanguageSupport.getResource("XTGL-1188","设定对应关系")%></td>
			</tr>

			<tr>
				<td height=8></f:verbatim> <h:selectBooleanCheckbox
						value="#{sys_codeItemListBB.showSuper}" onclick="submit();"></h:selectBooleanCheckbox>
					<c:verbatim>
						<%=LanguageSupport.getResource("XTGL-1208",
							" 代码显示上级 ")%>
						<%=LanguageSupport.getResource("XTGL-1188",
							" 设定对应关系")%>
					</c:verbatim> <h:inputText id="orgId" value="#{sys_codeItemListBB.orgID}"
						readonly="true" size="30" styleClass="input" code="" dict="yes"
						dict_num="OU" /> <h:commandButton
						onclick="PopUpOrgDlg('form1:orgId',2,'')"
						styleClass="button_select" type="button" /> <h:commandButton
						value="全部计算" styleClass="button01" onclick="return doCalc();"
						action="#{sys_codeItemListBB.CaclByOrg}"></h:commandButton> <f:verbatim>
				</td>
			</tr>


			<tr>
				<td height=8></td>
			</tr>

			<tr>
				<td height=8>
				 	<%=LanguageSupport.getResource("XTGL-1163",
							"当")%>
				</f:verbatim> 
				 <h:inputText
						id="itemName" readonly="true"
						value="#{sys_codeItemListBB.codeRel.sourceFieldName}" /> <h:commandButton
						styleClass="button_select" type="button"
						onclick="selectInfoItem(document.all('form1:setType').value,document.all('form1:itemName'),document.all('form1:sourceField'))"
						rendered="#{sys_codeItemListBB.codeRel.sourceField==''}"></h:commandButton>
					<h:selectOneMenu id="oper1"
						value="#{sys_codeItemListBB.codeRel.oper}">
						<c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
						<c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
					</h:selectOneMenu> <h:inputText readonly="true" style="width:300px"
						id="classvaluedes" /> <h:inputHidden id="classvalue"
						value="#{sys_codeItemListBB.codeRel.sourceCode}" /> <h:commandButton
						id="source" type="button" styleClass="button01" value="选择"
						onclick="forSelSource()" /> <f:verbatim>
				</td>
			</tr>
			<tr>
				<td height=8></f:verbatim> <h:outputText escape="false"
						value="<strong>#{sys_codeItemListBB.codeRel.desFieldName}</strong>" />
					<c:verbatim>
						<%=LanguageSupport.getResource("XTGL-1209", "赋值为 ")%>
					</c:verbatim> <h:inputText readonly="true" style="width:200px" id="desdes" /> <h:inputHidden
						id="desid" value="#{sys_codeItemListBB.codeRel.desCode}" /> <h:commandButton
						id="select" type="button" styleClass="button01" value="选择"
						onclick="forSelDes()" /> <h:commandButton value="增加"
						styleClass="button01" onclick="return chkNull();"
						action="#{sys_codeItemListBB.saveSet}"></h:commandButton> <f:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable styleClass="table03" align="center" width="95%"
							id="dateList" headerClass="td_top tr_fixrow"
							columnClasses="td_top,td_middle,td_middle,td_middle,td_middle,td_middle"
							value="#{sys_codeItemListBB.relationBos}" var="list" border="0">

							<h:column>
								<f:facet name="header">
							  <c:verbatim>
								<%=LanguageSupport.getResource("XTGL-1232", " 分类 ")%>
							  </c:verbatim> 
								</f:facet>
								<h:outputText value="#{list.desSuperCodeDes}" />
							</h:column>

							<h:column>
								<f:facet name="header">
							     <c:verbatim>
									<%=LanguageSupport.getResource("XTGL-1231", " 条件")%>
								  </c:verbatim> 
								</f:facet>
								<h:outputText
									value="#{list.sourceFieldName}#{list.operDes}#{list.sourceCodeDes}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								  <c:verbatim>
									<%=LanguageSupport.getResource("XTGL-1230", "结果")%>
								  </c:verbatim> 
								</f:facet>
								<h:outputText value="#{list.desFieldName}" />
								 <c:verbatim>
									<%=LanguageSupport.getResource("XTGL-1189", "等于")%>
								  </c:verbatim> 
								<h:outputText value="#{list.desCodeDes}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								  <c:verbatim>
									<%=LanguageSupport.getResource("XTGL-1051", "状态")%>
								  </c:verbatim> 
								</f:facet>
								<h:outputText value="#{list.stopDes}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								  <c:verbatim>
									<%=LanguageSupport.getResource("XTGL-1026", "操作")%>
								  </c:verbatim> 
								</f:facet>
								<h:commandButton value="启用" styleClass="button01"
									action="#{sys_codeItemListBB.start}"
									rendered="#{list.stop=='1'}">
									<x:updateActionListener
										property="#{sys_codeItemListBB.curCode}"
										value="#{list.itemID}" />
								</h:commandButton>
								<h:commandButton value="停用" styleClass="button01"
									action="#{sys_codeItemListBB.stop}"
									rendered="#{list.stop!='1'}">
									<x:updateActionListener
										property="#{sys_codeItemListBB.curCode}"
										value="#{list.itemID}" />
								</h:commandButton>

								<h:commandButton value="单个计算" styleClass="button01"
									onclick="return doCalc();"
									action="#{sys_codeItemListBB.CaclItem}">
									<x:updateActionListener
										property="#{sys_codeItemListBB.curCode}"
										value="#{list.itemID}" />
								</h:commandButton>
								<h:commandButton value="删除" styleClass="button01"
									action="#{sys_codeItemListBB.deleteItem}">
									<x:updateActionListener
										property="#{sys_codeItemListBB.curCode}"
										value="#{list.itemID}" />
								</h:commandButton>
								<h:commandButton value="修改" styleClass="button01"
									onclick="doModify('#{list.itemID}');"></h:commandButton>
							</h:column>
						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
	if (document.all('form1:classvalue').value == '')
		document.all('form1:classvaluedes').value = "";
	if (document.all('form1:desid').value == '')
		document.all('form1:desdes').value = "";
</script>
<marquee id="processbar"
	style="position: absolute; display: none; border: 1px solid #000000"
	direction="right" width="300" scrollamount="5" scrolldelay="10"
	bgcolor="#ECF2FF">
	<table cellspacing="1" cellpadding="0">
		<tr height=8>
			<td bgcolor=#3399FF width=8></td>
			<td></td>
			<td bgcolor=#3399FF width=8></td>
			<td></td>
			<td bgcolor=#3399FF width=8></td>
			<td></td>
			<td bgcolor=#3399FF width=8></td>
			<td></td>
		</tr>
	</table>
</marquee>
