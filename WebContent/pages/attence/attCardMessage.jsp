<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{att_card_messageBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{att_card_messageBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							
                          
      <h:outputText value="��ѯ���ڿ���ʽ��"></h:outputText>
      <h:selectOneMenu value="#{att_card_messageBB.status}" onchange="submit();" valueChangeListener="#{att_card_messageBB.changeStatus}">
  <c:selectItem itemLabel="ȫ��" itemValue="0"></c:selectItem>
 <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
 <c:selectItem itemLabel="����" itemValue="2"></c:selectItem>
 <c:selectItem itemLabel="�˿�" itemValue="3"></c:selectItem>
</h:selectOneMenu>

                              
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">


						<h:panelGroup>
							<h:outputText
								value="��¼��:#{att_card_messageBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ҳ��:#{att_card_messageBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ÿҳ��#{att_card_messageBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="��ǰΪ��#{att_card_messageBB.mypage.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ" action="#{att_card_messageBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{att_card_messageBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{att_card_messageBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ" action="#{att_card_messageBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{att_card_messageBB.attmachineList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">

					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����Ա" />
						</c:facet>
						<h:outputText value="#{list.manageName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����ʱ��" />
						</c:facet>
						<h:outputText value="#{list.openTime}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��Ա" />
						</c:facet>
						<h:outputText value="#{list.cardName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.operTypeName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="ԭֵ" />
						</c:facet>
						<h:outputText value="#{list.oldValue}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��ֵ" />
						</c:facet>
						<h:outputText value="#{list.newValue}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
							action="#{att_card_messageBB.delete}" styleClass="button01">
							<x:updateActionListener property="#{att_card_messageBB.logID}"
								value="#{list.logID}" />
						</h:commandButton>
					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
</body>
