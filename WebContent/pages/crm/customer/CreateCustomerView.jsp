<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forSave() {
		if (forCheck() == true) {
			forsubmit(document.forms(0));
			return true;
		} else {
			return false;
		}
	}

	function forCheck() {
		if (document.all("form1:vname").value == "") {
			alert("��ͼ���ֲ���Ϊ��!");
			document.all("form1:vname").focus();
			return false;
		} 
		if ( document.all("form1:a1").value != "" | document.all("form1:a2").value != "" |
			 document.all("form1:a3").value != "" |document.all("form1:a4").value != "" |
			 document.all("form1:a5").value != "" | document.all("form1:a6").value !="" |
			 document.all("form1:a7").value != "" | document.all("form1:a8").value !="" |
			 document.all("form1:a9").value != "" ) {
			 return true;
		} 
	}
</script>
<x:saveState value="#{customerViewBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{customerViewBB.pageInit}" />
    <h:inputHidden value="#{customerViewBB.viewId}" />
	<h:panelGrid columns="1" styleClass="td_title" width="100%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="�½���ͼ - > �ͻ� "></h:outputText>
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid columns="1" align="center">

		<h:panelGroup>
			<h:outputText value="������Ϣ   " styleClass="f04"></h:outputText>
		</h:panelGroup>

		<h:panelGrid columns="1" columnClasses="table02" align="center">
			<h:panelGrid columns="2" styleClass="td_form01">
				<h:outputText styleClass="f07" value="��ͼ����  "></h:outputText>
				<h:inputText id="vname" value="#{customerViewBB.cusViewBO.viewName}"></h:inputText>

				<h:outputText value="���ݷ�Χ  "></h:outputText>
				<h:panelGroup>
					<h:selectOneRadio value="#{customerViewBB.cusViewBO.viewType}">
						<f:selectItem itemLabel="��ӵ�е�" itemValue="0" />
						<f:selectItem itemLabel="������ҵ�" itemValue="1" />
						<f:selectItem itemLabel="���е�" itemValue="2" />
					</h:selectOneRadio>
				</h:panelGroup>

				<h:outputText value="�� �� "></h:outputText>
				<h:inputTextarea value="#{customerViewBB.cusViewBO.viewDes}"
					rows="5" cols="60">
				</h:inputTextarea>
			</h:panelGrid>
			<h:panelGroup>

			</h:panelGroup>
		</h:panelGrid>

		<h:panelGroup>
			<h:outputText value="��ѯ����    " styleClass="f04"></h:outputText>
		</h:panelGroup>

		<h:panelGrid columns="1" columnClasses="table02" align="left"
			width="100%">
			<h:panelGrid columns="4" styleClass="td_form01">
				<h:outputText value="�ͻ����� "></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu  id="a1" value="#{customerViewBB.cusViewItemBO.a1}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>

				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>
					<h:inputText value="#{customerViewBB.cusViewItemBO.b1}" id="cuname"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"></h:commandButton>
				</h:panelGroup>

				<h:outputText value="�� �� "></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu id="a2" value="#{customerViewBB.cusViewItemBO.a2}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>
				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>
					<h:inputText id="nation" code="" dict="yes" dict_num="0106"
						readonly="true" value="#{customerViewBB.cusViewItemBO.b2}"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"
						onclick="PopUpCodeDlgOneControl('form1:nation')" />
				</h:panelGroup>



				<h:outputText value="���� "></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu id="a3" value="#{customerViewBB.cusViewItemBO.a3}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>
				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>
					<h:inputText id="city" code="" dict="yes" dict_num="0105"
						readonly="true" value="#{customerViewBB.cusViewItemBO.b3}"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"
						onclick="PopUpCodeDlgOneControl('form1:city')" />
				</h:panelGroup>


				<h:outputText value="��ַ"></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu id="a4" value="#{customerViewBB.cusViewItemBO.a4}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>
				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>
					<h:inputText value="#{customerViewBB.cusViewItemBO.b4}" id="addr"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"></h:commandButton>
				</h:panelGroup>


				<h:outputText value="�ʱ�"></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu id="a5" value="#{customerViewBB.cusViewItemBO.a5}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>
				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>
					<h:inputText value="#{customerViewBB.cusViewItemBO.b5}" id="zip"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"></h:commandButton>
				</h:panelGroup>



				<h:outputText value="�ͻ�����"></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu  id="a6" value="#{customerViewBB.cusViewItemBO.a6}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>
				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>
					<h:inputText value="#{customerViewBB.cusViewItemBO.b6}" id="desc"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"></h:commandButton>
				</h:panelGroup>


				<h:outputText value="��������"></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu id="a7" value="#{customerViewBB.cusViewItemBO.a7}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>
				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>
					<h:inputText value="#{customerViewBB.cusViewItemBO.b7}"
						readonly="true" id="credate"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"
						onclick="PopUpCalendarDialog('form1:credate')"></h:commandButton>
				</h:panelGroup>



				<h:outputText value="�ͻ�����"></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu id="a8" value="#{customerViewBB.cusViewItemBO.a8}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>
				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>

					<h:inputText id="cu_type" code="" dict="yes" dict_num="2227"
						readonly="true" value="#{customerViewBB.cusViewItemBO.b8}"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"
						onclick="PopUpCodeDlgOneControl('form1:cu_type')" />
				</h:panelGroup>


				<h:outputText value="�ͻ���ҵ"></h:outputText>
				<h:panelGroup>
					<h:panelGroup>
						<h:selectOneMenu id="a9" value="#{customerViewBB.cusViewItemBO.a9}">
							<f:selectItems value="#{customerViewBB.conditionList}" />
						</h:selectOneMenu>
					</h:panelGroup>
				</h:panelGroup>
				<h:outputText value="  �ؼ���  "></h:outputText>
				<h:panelGroup>

					<h:inputText id="vocation" code="" dict="yes" dict_num="2228"
						readonly="true" value="#{customerViewBB.cusViewItemBO.b9}"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"
						onclick="PopUpCodeDlgOneControl('form1:vocation')" />
				</h:panelGroup>
			</h:panelGrid>

		</h:panelGrid>

		<h:panelGroup>
			<h:panelGrid columns="3" align="right">
				<h:commandButton value="��ѯ" styleClass="button01"
					action="#{customerViewBB.queryView}"></h:commandButton>
				<h:commandButton value="����" styleClass="button01"
					onclick="return forSave();" action="#{customerViewBB.saveOrUpdateView}"></h:commandButton>
				<h:commandButton value="�ر�" styleClass="button01"
					onclick="return window.close() ;"></h:commandButton>
			</h:panelGrid>
		</h:panelGroup>


	</h:panelGrid>
</h:form>
