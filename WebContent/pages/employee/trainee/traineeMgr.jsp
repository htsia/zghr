<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function SetProbation() {
		window
				.showModalDialog(
						"/employee/trainee/orgTraineeEdit.jsf",
						null,
						"dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
	function selPerson() {
		window
				.showModalDialog(
						"/employee/trainee/selTrainee.jsf",
						null,
						"dialogWidth:600px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
	function modifyDate(itemId) {
		window
				.showModalDialog(
						"/employee/trainee/planPassDateEdit.jsf?pid=" + itemId,
						null,
						"dialogWidth:350px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
	function selectPerson() {
		var str = " |";
		chk = document.forms(0).selectItem;
		if (checkMutilSelect(chk)) {
			var size = chk.length;
			if (size == null) {
				if (chk.checked) {
					str += chk.value;
				}
			} else {
				for ( var i = 0; i < size; i++) {
					if (chk[i].checked) {
						if (i == 0) {
							str += chk[i].value;
						} else {
							str += "," + chk[i].value;
						}
					}
				}
			}
			if (str != null && str != "") {
				var vars = str.split("|");
				document.all("form1:personStr").value = vars[1];
			}
		}
	}
	function selectPerson4() {
		if (confirm("ȷ��Ҫ��Ч��")) {
			var str = " |";
			chk = document.forms(0).selectItem;
			if (checkMutilSelect(chk)) {
				var size = chk.length;
				if (size == null) {
					if (chk.checked) {
						str += chk.value;
					}
				} else {
					for ( var i = 0; i < size; i++) {
						if (chk[i].checked) {
							if (i == 0) {
								str += chk[i].value;
							} else {
								str += "," + chk[i].value;
							}
						}
					}
				}
				if (str != null && str != "") {
					var vars = str.split("|");
					document.all("form1:personStr").value = vars[1];
				}
			}
		} else {
			return false;
		}
	}
	function selectPerson2(id) {
		window
				.showModalDialog(
						"/employee/trainee/traineeWageEdit.jsf?personId=" + id,
						null,
						"dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
	function selectPerson3(id) {
		window
				.showModalDialog(
						"/employee/trainee/traineeWageEdit2.jsf?personId=" + id,
						null,
						"dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{empTraineeMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{empTraineeMgrBB.pageInit}" />
	<h:inputHidden id="personStr" value="" />
	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8>
					<table align="center" border="0" cellpadding="0" cellspacing="0"
						width=100% bgcolor="#FFFFFF">
						<tr>
							<td class=td_title></f:verbatim> <h:graphicImage
									value="/images/tips.gif" />
									<f:verbatim>
									<%=LanguageSupport.getResource("RYGL-2123", "��Ա����")%>->
              						 <%=LanguageSupport.getResource("RYGL-2508", "ʵϰת��ʽ����")%>      
									</f:verbatim>
									  <f:verbatim>
							</td>
							<td align="right" class=td_title>
							 <%=LanguageSupport.getResource("RYGL-2132", "����")%>      
							</f:verbatim> 
								<h:selectBooleanCheckbox value="#{empTraineeMgrBB.probation}"
									onclick="submit();"
									valueChangeListener="#{empTraineeMgrBB.queryApply}" /> <h:outputText
									value=" " rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:outputText
									value="ת������" rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:selectBooleanCheckbox
									value="#{empTraineeMgrBB.appring}" onclick="submit();"
									valueChangeListener="#{empTraineeMgrBB.queryApprving}"
									rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:outputText
									value=" " rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:outputText
									value="ת��" rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:selectBooleanCheckbox
									value="#{empTraineeMgrBB.approved}" onclick="submit();"
									valueChangeListener="#{empTraineeMgrBB.queryApprived}"
									rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:outputText
									value=" " />
									<f:verbatim>
              						 <%=LanguageSupport.getResource("RYGL-2035", "������Ϣ��Ч")%>      
									</f:verbatim>
									 <h:selectBooleanCheckbox
									value="#{empTraineeMgrBB.humanEfient}" onclick="submit();"
									valueChangeListener="#{empTraineeMgrBB.queryEfficent}" /> <h:outputText
									value=" " />
                                     <f:verbatim>
              						 <%=LanguageSupport.getResource("RYGL-2036", "���ʵ���")%>      
									</f:verbatim>
                                      <h:selectBooleanCheckbox
									value="#{empTraineeMgrBB.wageChange}" onclick="submit();"
									valueChangeListener="#{empTraineeMgrBB.queryWageChange}" /> <h:outputText
									value=" " rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:outputText
									value="�˻�" rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:selectBooleanCheckbox
									value="#{empTraineeMgrBB.refuse}" onclick="submit();"
									valueChangeListener="#{empTraineeMgrBB.queryRsfuse}"
									rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td height=8>
					<table width="95%">
						<tr>
							<td align="right"></f:verbatim> 
								 <f:verbatim>
              						 <%=LanguageSupport.getResource("RYGL-2430", "ת������")%>      
									</f:verbatim>
								<h:inputText value="#{empTraineeMgrBB.passMonth}" size="7"></h:inputText>
								<h:commandButton value="ʵϰԱ��ת������" styleClass="button01"
									onclick="return SetProbation()" /> <h:outputText value="  "
									rendered="#{empTraineeMgrBB.mustApprov=='0'}"></h:outputText> <h:commandButton
									value="����" styleClass="button01" onclick="selectPerson();"
									action="#{empTraineeMgrBB.approvid}"
									rendered="#{empTraineeMgrBB.mustApprov=='0'}" /> <h:outputText
									value="  "></h:outputText> <h:commandButton value="������Ϣ��Ч"
									styleClass="button01" onclick="return selectPerson4();"
									action="#{empTraineeMgrBB.shengxiao}" /> <f:verbatim>
							</td>
							<td align="right"></f:verbatim> <h:panelGroup>
							<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "��¼��")%>
								</f:verbatim>
									<h:outputText value="#{empTraineeMgrBB.mypage.totalRecord}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "ҳ��")%>
								</f:verbatim>
									<h:outputText value="#{empTraineeMgrBB.mypage.totalPage}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "ÿҳ��")%>
								</f:verbatim>
									<h:outputText value="#{empTraineeMgrBB.mypage.pageSize}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "��ǰΪ��")%>
								</f:verbatim>
									<h:outputText
										value="#{empTraineeMgrBB.mypage.currentPage}"></h:outputText>
								 <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "ҳ")%>
								</f:verbatim>
									<h:commandButton value="��ҳ" action="#{empTraineeMgrBB.first}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="��ҳ" action="#{empTraineeMgrBB.pre}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="��ҳ" action="#{empTraineeMgrBB.next}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="βҳ" action="#{empTraineeMgrBB.last}"
										styleClass="button01"></h:commandButton>
									<h:outputText value="  "></h:outputText>
									<h:commandButton value="ѡ����Ա" styleClass="button01"
										onclick="return selPerson()" />
								</h:panelGroup> <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable value="#{empTraineeMgrBB.personList}" var="list"
							align="center" id="dateList" headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<f:facet name="header">
									<f:verbatim escape="false">
										<input type="checkbox" name="all"
											onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)" />
									</f:verbatim>
								</f:facet>
								<f:verbatim escape="false">
									<div align="center">
										<input type="checkbox" name="selectItem"
											value="</f:verbatim>
                    <h:outputText value="#{list.personId}"/>
                    <f:verbatim escape="false">" />
									</div>
								</f:verbatim>
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
									<%=LanguageSupport.getResource( "MSG-0010", "����")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "JGGL-1024", "��������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "JGGL-1025", "��������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "RYGL-2507", "��ǰԱ�����")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.curType}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "RYGL-2506", "ת����Ա�����")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.passType}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "RYGL-2129", "Ԥ��ת��ʱ��")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.planPassDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "RYGL-2130", "ת������ʱ����")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.haveDays}" />
							</h:column>
							<h:column rendered="#{empTraineeMgrBB.mustApprov=='0'}">
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "RYGL-2028", "�������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes}" />
							</h:column>
							<h:column rendered="#{empTraineeMgrBB.mustApprov=='0'}">
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "RYGL-2029", "�������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes1}" />
							</h:column>
							<h:column rendered="#{empTraineeMgrBB.mustApprov=='0'}">
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "RYGL-2030", "�������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes2}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "XTGL-1051", "״̬")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.statusDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
									<%=LanguageSupport.getResource( "YXGL-1026", "����")%>
								</f:verbatim>
								</c:facet>
								<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
									action="#{empTraineeMgrBB.delete}" styleClass="button01"
									rendered="#{list.status=='0'}">
									<x:updateActionListener value="#{list.personId}"
										property="#{empTraineeMgrBB.personId}"></x:updateActionListener>
								</h:commandButton>
								<h:commandButton value="����ת��ʱ��"
									onclick="return modifyDate('#{list.personId}')"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="�鿴����"
									onclick="return showWorkFlowLogByLinkID('#{list.personId}')"
									styleClass="button01"
									rendered="#{empTraineeMgrBB.mustApprov=='0'}"></h:commandButton>
								<h:commandButton value="�ⶨн��" styleClass="button01"
									onclick="return selectPerson2('#{list.personId}');"
									rendered="#{list.status=='0'}" />
								<h:commandButton value="�鿴н��" styleClass="button01"
									onclick="return selectPerson3('#{list.personId}');"
									rendered="#{list.status!='0'}" />
							</h:column>
						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>