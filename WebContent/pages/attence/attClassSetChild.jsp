<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
	function doAddItem() {
		var superID = document.all('form1:superID').value;
		if (superID == null || superID == "") {
			alert("����ѡ�������");
			return false;
		}
		window.showModalDialog(
						"/attence/attClassSetEdit.jsf?superID=" + superID,
						null,
						"dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function doModifyCource(id, id1, id2) {
		if (id1 != id2) {
			alert("����Ȩ����");
			return false;
		}
		window.showModalDialog(
						"/attence/attClassSetEdit.jsf?classID=" + id + "&oid="
								+ id1,
						null,
						"dialogWidth:350px; dialogHeight:150px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function doAttClassDetail(id) {
		window.showModalDialog(
						"/attence/attClassDetail.jsf?classID=" + id,
						null,
						"dialogWidth:550px; dialogHeight:370px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function doFrequency(id) {
		window.showModalDialog(
						"/attence/AttFrequency.jsf?classId=" + id,
						null,
						"dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function doPerson(id) {
		window.showModalDialog(
						"/attence/AttPerson.jsf?classId=" + id,
						null,
						"dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{att_class_set_childBB}" />
<h:form id="form1">
	<h:inputHidden value="#{att_class_set_childBB.initItem}"/>
	<h:inputHidden id="superID" value="#{att_class_set_childBB.superID}"/>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="1" align="left">

			<h:panelGroup>
				<h:outputText
					value="��¼��:#{att_class_set_childBB.mypage.totalRecord}"/>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{att_class_set_childBB.mypage.totalPage}"/>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{att_class_set_childBB.mypage.pageSize}"/>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{att_class_set_childBB.mypage.currentPage}ҳ"/>

				<h:commandButton value="��ҳ" action="#{att_class_set_childBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{att_class_set_childBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{att_class_set_childBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{att_class_set_childBB.last}"
					styleClass="button01"></h:commandButton>

				<h:commandButton value="����" styleClass="button01" onclick="doAddItem();"/>
				<h:commandButton styleClass="button01" value="ɾ�� "
					action="#{att_class_set_childBB.deleteBatch}"
					onclick="return checkBatchDelete('selected_ids');" />
			</h:panelGroup>
		</h:panelGrid>

		<x:dataTable value="#{att_class_set_childBB.itemList}"
			headerClass="td_top" rowIndexVar="index" var="briefList"
			id="dateList" styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);" />
					</c:verbatim>
				</c:facet>
				<c:verbatim escape="false">
					<input type="checkbox" name="selected_ids"
						value="</c:verbatim>
                  <h:outputText value="#{briefList.classID}"/>
                  <c:verbatim>">
				</c:verbatim>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�������" />
				</f:facet>
				<h:outputText value="#{briefList.className}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" />
				</f:facet>
				<h:outputText value="#{briefList.createDate}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="������" />
				</f:facet>
				<h:outputText value="#{briefList.createUser}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��ֹ����/����ʱ��" />
				</f:facet>
				<h:outputText value="#{briefList.applyBeginDate}��" rendered="#{briefList.frequencyType!='1' }"></h:outputText>
				<h:outputText value="#{briefList.applyEndDate}" rendered="#{briefList.frequencyType!='1'}" ></h:outputText>
								<h:outputText value="#{briefList.frequencyTxt}" rendered="#{briefList.frequencyType=='1'}" ></h:outputText>
				
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" />
				</f:facet>
				<h:commandButton styleClass="button01" value="�޸�"
					onclick="return doModifyCource('#{briefList.classID}','#{att_class_set_childBB.superID}','#{briefList.createOrg}');" />
				<h:commandButton styleClass="button01" value="��������"
					onclick="return doFrequency('#{briefList.classID}');" />
				<h:commandButton styleClass="button01" value="ʱ������"
					onclick="return doAttClassDetail('#{briefList.classID}');" />
				<h:commandButton styleClass="button01" value="��Ա����"
					onclick="return doPerson('#{briefList.classID}');" />
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>