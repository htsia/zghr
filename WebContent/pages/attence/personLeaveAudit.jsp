<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
		window.showModalDialog("/attence/personLeaveAuditEdit.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.7 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem1(id) {
		window.showModalDialog("/attence/personLeaveAuditEdit1.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem2(id) {
		window.showModalDialog("/attence/personLeaveAuditEdit2.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
   //�ܼ�����
	function doAddItem3(id) { 
		window.showModalDialog("/attence/personLeaveAuditEdit3.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
	   //�ܾ�������
	function doAddItem4(id) { 
		window.showModalDialog("/attence/personLeaveAuditEdit4.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personleaveBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{personleaveBB.initEdit}" />
	<h:inputHidden id="operID" value="#{personleaveBB.operID}" />
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">
				�������</td>
			</tr>
		</table>
		<table height=98% width=98%>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:panelGroup>
					<h:selectBooleanCheckbox value="#{personleaveBB.isExist1}"
						onclick="submit();"
						valueChangeListener="#{personleaveBB.changeNowYearValue1}" />
					<h:outputText value="��ʾȫ��" />
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="��¼��:#{personleaveBB.mypage.totalRecord}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="ҳ��:#{personleaveBB.mypage.totalPage}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="ÿҳ��#{personleaveBB.mypage.pageSize}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="��ǰΪ��#{personleaveBB.mypage.currentPage}ҳ"></h:outputText>

					<h:commandButton value="��ҳ" action="#{personleaveBB.first}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="��ҳ" action="#{personleaveBB.pre}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="��ҳ" action="#{personleaveBB.next}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="βҳ" action="#{personleaveBB.last}"
						styleClass="button01"></h:commandButton>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
				</h:panelGroup> <h:dataTable value="#{personleaveBB.persBos2}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
						<f:facet name="header">
							<h:outputText value="�����" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����״̬" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.statusValueName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="��������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="��������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.superFlIdName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flIdProcessName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�Ƿ��ύ���֤������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flIdStatusName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.applyDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ٿ�ʼʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.beginTime}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ٽ���ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.endTime}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:outputText escape="false" value="#{list.reason}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="ȷ��֤��"
							onclick="return confirm('ȷ��Ҫ�ύ֤����?');"
							action="#{personleaveBB.makeDemonstrate}" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0532' && list.flIdStatus=='0' && (list.flID=='02' || list.flID=='04')}">
							<x:updateActionListener property="#{personleaveBB.furloughNO}"
								value="#{list.furloughNO}" />
						</h:commandButton>
						<h:commandButton value="�鿴����" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0530' && list.statusValue!='3'}"
							onclick="doAddItem('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0531' && list.statusValue!='3'}"
							onclick="doAddItem1('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0532' && list.statusValue!='3'}"
							onclick="doAddItem2('#{list.furloughNO}');"></h:commandButton>
					    <h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0538' && list.statusValue!='3'}"
							onclick="doAddItem3('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0539' && list.statusValue!='3'}"
							onclick="doAddItem4('#{list.furloughNO}');"></h:commandButton>
					</h:column>
				</h:dataTable> <f:verbatim></div>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>





