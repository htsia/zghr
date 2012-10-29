<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function SetProbation() {
		window.showModalDialog(
						"/employee/beginner/orgBeginnerEdit.jsf",
						null,
						"dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
	function selPerson() {
		window.showModalDialog(
						"/employee/beginner/selBginner.jsf",
						null,
						"dialogWidth:600px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
	function modifyDate(itemId) {
		window.showModalDialog(
						"/employee/beginner/beginnerPassDateEdit.jsf?itemId="+ itemId,
						null,
						"dialogWidth:350px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
	function selectPerson() {
		var str = "|";
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
			var str = "|";
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
		window.showModalDialog(
						"/employee/beginner/beginnerWageEdit.jsf?itemId=" + id,
						null,
						"dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
	function selectPerson3(id) {
		window.showModalDialog(
						"/employee/beginner/beginnerWageEdit2.jsf?itemId=" + id,
						null,
						"dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{empbeginnerMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{empbeginnerMgrBB.pageInit}" />
	<h:inputHidden id="personStr" value="" />
	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8>
					<table align="center" border="0" cellpadding="0" cellspacing="0"
						width=100% bgcolor="#FFFFFF">
						<tr>
							<td class=td_title></f:verbatim> <h:graphicImage
									value="/images/tips.gif" /> <f:verbatim>
					                 <%=LanguageSupport.getResource("RYGL-2124", "��ϰ����")%>
								</f:verbatim> <f:verbatim>
							</td>

                                <td align="right" class=td_title></f:verbatim> <f:verbatim>
									��ϰ
								</f:verbatim>
                                    <h:selectBooleanCheckbox value="#{empbeginnerMgrBB.probation}"
									onclick="submit();"
									valueChangeListener="#{empbeginnerMgrBB.queryApply}" />
                                   <h:outputText	value=" " rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />

                                   <h:outputText	value="����" rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />
                                   <h:selectBooleanCheckbox value="#{empbeginnerMgrBB.appring}" 	onclick="submit();"
									valueChangeListener="#{empbeginnerMgrBB.queryApprving}"
									rendered="#{empbeginnerMgrBB.mustApprov=='0'}" /> <h:outputText
									value=" " rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />

                                   <h:outputText	value="ת��" rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />
                                   <h:selectBooleanCheckbox
									value="#{empbeginnerMgrBB.approved}" onclick="submit();"
									valueChangeListener="#{empbeginnerMgrBB.queryApprived}"
									rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />

                                   <h:outputText value=" " /> <h:outputText value="������Ϣ��Ч" />
                                   <h:selectBooleanCheckbox
									value="#{empbeginnerMgrBB.humanEfient}" onclick="submit();"
									valueChangeListener="#{empbeginnerMgrBB.queryEfficent}" /> <h:outputText
									value=" " />

                                    <h:outputText value="���ʵ���" />
                                    <h:selectBooleanCheckbox
									value="#{empbeginnerMgrBB.wageChange}" onclick="submit();"
									valueChangeListener="#{empbeginnerMgrBB.queryWageChange}" />

                                    <h:outputText	value=" " rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />
                                    <h:outputText	value="�˻�" rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />
                                    <h:selectBooleanCheckbox
									value="#{empbeginnerMgrBB.refuse}" onclick="submit();"
									valueChangeListener="#{empbeginnerMgrBB.queryRsfuse}"
									rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />
                            <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td height=8>
					<table width="95%">
						<tr>
							<td align="right"></f:verbatim>
                                <h:outputText value="��ϰ����"></h:outputText>
								<h:inputText value="#{empbeginnerMgrBB.passMonth}" size="7"></h:inputText>
								<h:commandButton value="��ϰ����" styleClass="button01"
									onclick="return SetProbation()" /> <h:outputText value="  "
									rendered="#{empbeginnerMgrBB.mustApprov=='0'}"></h:outputText>
								<h:commandButton value="����" styleClass="button01"
									onclick="selectPerson();" action="#{empbeginnerMgrBB.approvid}"
									rendered="#{empbeginnerMgrBB.mustApprov=='0'}" />
                                    <h:outputText	value="  "></h:outputText>
                                    <h:commandButton value="������Ϣ��Ч"
									styleClass="button01" onclick="return selectPerson4();"
									action="#{empbeginnerMgrBB.shengxiao}" /> <f:verbatim>
							</td>
							<td align="right"></f:verbatim> <h:panelGroup>

									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1043",
								"��¼��")%> : 
	            </f:verbatim>
									<h:outputText value="#{empbeginnerMgrBB.mypage.totalRecord}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport
								.getResource("COMM-1044", "ҳ��")%> :
	            </f:verbatim>
									<h:outputText value="#{empbeginnerMgrBB.mypage.totalPage}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1045",
								"ÿҳ��")%>
									</f:verbatim>
									<h:outputText value="#{empbeginnerMgrBB.mypage.pageSize}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1046",
								"��ǰΪ��")%>
									</f:verbatim>
									<h:outputText value="#{empbeginnerMgrBB.mypage.currentPage}ҳ"></h:outputText>
									<h:commandButton value="��ҳ" action="#{empbeginnerMgrBB.first}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="��ҳ" action="#{empbeginnerMgrBB.pre}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="��ҳ" action="#{empbeginnerMgrBB.next}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="βҳ" action="#{empbeginnerMgrBB.last}"
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
						<h:dataTable value="#{empbeginnerMgrBB.empbeginnerList}"
							var="list" align="center" id="dateList"
							headerClass="td_top tr_fixrow"
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
                    <h:outputText value="#{list.itemId}"/>
                    <f:verbatim escape="false">" />
									</div>
								</f:verbatim>
							</h:column>

							<h:column>
								<c:facet name="header">
				  			     	<f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("RYGL-1016", "����")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personId}" />
							</h:column>
                            <h:column>
                                <c:facet name="header">
                                   <f:verbatim>
                                               ��ǰ��λ
                                    </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.curPost}" />
                            </h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("RYGL-2127", "��ǰ��λ����")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.curPostLevel}" />
							</h:column>

                            <h:column>
                                <c:facet name="header">
                                     <f:verbatim>
                                            ת�����λ
                                    </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.passPost}" />
                            </h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("RYGL-2126", "ת�����λ����")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.passPostLevel}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								    <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("RYGL-2129", "Ԥ��ת��ʱ��")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.planPassDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								    <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("RYGL-2130", "ת������ʱ����")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.haveDays}" />
							</h:column>
							<h:column rendered="#{empbeginnerMgrBB.mustApprov=='0'}">
								<c:facet name="header"> 
								   <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("RYGL-2028", "�������")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes}" />
							</h:column>
							<h:column rendered="#{empbeginnerMgrBB.mustApprov=='0'}">
								<c:facet name="header">
								    <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("RYGL-2029", "�������")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes1}" />
							</h:column>
							<h:column rendered="#{empbeginnerMgrBB.mustApprov=='0'}">
								<c:facet name="header">
								   <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("RYGL-2030", "�������")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes2}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								    <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("XTGL-1051", "״̬")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.statusDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								      <f:verbatim> 
				  			     	        <%=LanguageSupport.getResource("YXGL-1026", "����")%>
									</f:verbatim>
								</c:facet>
								<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
									action="#{empbeginnerMgrBB.delete}" styleClass="button01"
									rendered="#{list.status=='0'}">
									<x:updateActionListener value="#{list.itemId}"
										property="#{empbeginnerMgrBB.itemId}"></x:updateActionListener>
								</h:commandButton>
								<h:commandButton value="����ת��ʱ��"
									onclick="return modifyDate('#{list.itemId}')"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="�鿴����"
									onclick="return showWorkFlowLogByLinkID('#{list.itemId}')"
									styleClass="button01"
									rendered="#{empbeginnerMgrBB.mustApprov=='0'}"></h:commandButton>
								<h:commandButton value="�ⶨн��" styleClass="button01"
									onclick="return selectPerson2('#{list.itemId}');"
									rendered="#{list.status=='0'}" />
								<h:commandButton value="�鿴н��" styleClass="button01"
									onclick="return selectPerson3('#{list.itemId}');"
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