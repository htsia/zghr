<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function doWorkLetter(ID) {
		var ret = window.showModalDialog("/employee/chg/WorkLetterList.jsf",
				null, "dialogWidth:" + screen.width * 0.85
						+ "px; dialogHeight:" + screen.height * 0.85
						+ "px;center:center;resizable:no;status:no;");
		return true;
	}
	function doCadresLetter(ID) {
		var ret = window.showModalDialog("/employee/chg/CadresLetterList.jsf",
				null, "dialogWidth:" + screen.width * 0.85
						+ "px; dialogHeight:" + screen.height * 0.85
						+ "px;center:center;resizable:no;status:no;");
		return true;
	}

	function doApprove(id) {
		var ret = window
				.showModalDialog("/employee/chg/ManagerOpinionEdit.jsf?Ids="
						+ id, null,
						"dialogWidth:730px; dialogHeight:450px;center:center;resizable:no;status:no;");
		return true;
	}
	function doShowPerson(id) {
		windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id + "&type=1",
				"aa", "", "1000", "600", "no", "10", "1", "yes");
	}
</script>

<x:saveState value="#{emp_PersonChgListBB}" />
<h:form id="form1">
	<h:inputHidden id="managerOrg"
		value="#{emp_PersonChgListBB.managerOrg}" />
	<h:inputHidden id="superID" value="#{emp_PersonChgListBB.superID}" />
	<h:inputHidden id="mode" value="#{emp_PersonChgListBB.mode}" />
	<c:verbatim>
		<table width="100%" height=96%>
			<tr>
				<td height=8></c:verbatim> <h:selectBooleanCheckbox
						value="#{emp_PersonChgListBB.onlyNotApprove}"
						id="selectNotApprove" onclick="submit()"
						valueChangeListener="#{emp_PersonChgListBB.changeManager}" /> <c:verbatim>
						<%=LanguageSupport
							.getResource("RYGL-2186", "����ʾ������")%>
				</td>

				<td height=8></c:verbatim> <h:selectOneRadio
						value="#{emp_PersonChgListBB.listStyle}" onclick="submit()"
						valueChangeListener="#{emp_PersonChgListBB.changeListStyle}">
						<c:selectItem itemValue="0" itemLabel="��������λ�鿴"></c:selectItem>
						<c:selectItem itemValue="1" itemLabel="�����뵥λ�鿴"></c:selectItem>
					</h:selectOneRadio> <c:verbatim>
				</td height=8>
			</tr>

			<tr>
				<td height=8 colspan=2><%=LanguageSupport.getResource("RYGL-2190", "����ʱ��")%>
					</c:verbatim> <h:inputText readonly="true" id="processDate"
						value="#{emp_PersonChgListBB.processDate}"></h:inputText> <h:commandButton
						type="button" styleClass="button_select"
						onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')" /> <h:commandButton
						value="��ѯ" styleClass="button01"></h:commandButton> <h:commandButton
						value="ȫ��" styleClass="button01"
						onclick="document.all('form1:processDate').value='';"></h:commandButton>
					<h:commandButton type="button" styleClass="button01"
						onclick="doWorkLetter();" value="���˵�ת������"
						rendered="#{emp_PersonChgListBB.mode=='worker'}"></h:commandButton>
					<h:commandButton type="button" styleClass="button01"
						value="�ɲ���ת������" onclick="doCadresLetter();"
						rendered="#{emp_PersonChgListBB.mode=='cadres'}"></h:commandButton>
					<h:commandButton value="����Excel"
						rendered="#{emp_PersonChgListBB.managerOrgPerson!=null}"
						action="#{emp_PersonChgListBB.downloadFile}" styleClass="button01" />
					<c:verbatim>
				</td>
			</tr>

			<tr>
				<td align="left" colspan=2>
					<div style='width: 100%; height: 100%; overflow: auto'
						id='datatable'>
						</c:verbatim>
						<h:dataTable value="#{emp_PersonChgListBB.managerOrgPerson}"
							var="list" align="center" id="dateList" headerClass="td_fixtop"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03">
							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"YXGL-1026", "����")%>
									</f:verbatim>
								</c:facet>
								<h:commandButton value="����" styleClass="button01"
									rendered="#{list.applyStatus=='2' && list.toOpinion=='1' && list.fromOpinion=='1'}"
									onclick="return doApprove('#{list.chgId}');"></h:commandButton>
								<h:commandButton styleClass="button01" value="�鿴��Ϣ"
									onclick="doShowPerson('#{list.personId}')"></h:commandButton>
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"RYGL-2163", "��������")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.applyDate}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1042", "Ա�����")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personCode}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2161", "�����ű��")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.letterNo}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-1016", "����")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2176", "���")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.degree}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2146", "ԭ��λ")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fromOrgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2164", "������λ")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.toOrgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								    <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2165", "ԭ��λ���")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fromOpinionDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2165", "ԭ��λ����ԭ��")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fromReason}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2171", "ԭ��λ����ʱ��")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fromDate}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2170", "ԭ��λ��ͬ���")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.cont_old_end}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2191", "ԭ��λ�������")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldOrgWageSet}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2169", "���뵥λ���")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.toOpinionDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2168", "���뵥λ����ԭ��")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.toReason}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2167", "���뵥λ����ʱ��")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.toDate}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2177", "���뵥λ��ͬ���")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.cont_new_begin}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2189", "���ܵ�λ���")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.managerOpinionDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2188", "��������ԭ��")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.managerReason}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2187", "��������ʱ��")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.managerDate}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
			                               <%=LanguageSupport.getResource( "RYGL-2151", "����״̬")%>
			                           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.applyStatusDes}" />
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
