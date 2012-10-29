<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
         function addPerson(){
             if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
                 alert("��ѡ�����!");
                 return false;
             }
             window.showModalDialog("/train/TrainInnerteacherEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:315px; dialogHeight:215px; status:0;resizable:yes");
             return true;
         }
    </script>

<x:saveState value="#{train_innerteacherlistbb}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{train_innerteacherlistbb.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{train_innerteacherlistbb.superId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim><h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:outputText value="��ǰ����:"></h:outputText>
							<h:outputText value="#{train_innerteacherlistbb.superName}"></h:outputText>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">
						
						<h:panelGroup>
							<h:outputText
								value="��¼��:#{train_innerteacherlistbb.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="ҳ��:#{train_innerteacherlistbb.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="ÿҳ��#{train_innerteacherlistbb.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="��ǰΪ��#{train_innerteacherlistbb.mypage.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ"
								action="#{train_innerteacherlistbb.first}" styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ"
								action="#{train_innerteacherlistbb.pre}" styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ"
								action="#{train_innerteacherlistbb.next}" styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ"
								action="#{train_innerteacherlistbb.last}" styleClass="button01"></h:commandButton>
							<h:outputText value="  "></h:outputText>
							<h:commandButton value="����" onclick="return addPerson();"
							styleClass="button01"></h:commandButton>
						</h:panelGroup>
					</h:panelGrid>
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> <h:dataTable value="#{train_innerteacherlistbb.innerteacherList}"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="90%">
					<h:column>
						<c:facet name="header">
							<h:outputText value="Ա�����" />
						</c:facet>
						<h:outputText value="#{list.personNum}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ա�" />
						</c:facet>
						<h:outputText value="#{list.personSex}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.personDept}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="Ӧ�÷�Χ" />
						</c:facet>
						<h:outputText value="#{list.teacherOrg}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="ɾ��" styleClass="button01"
							onclick="return confirm('ȷ��Ҫɾ����?');"
							action="#{train_innerteacherlistbb.delete}">
							<x:updateActionListener
								property="#{train_innerteacherlistbb.teacherID}"
								value="#{list.teacherID}" />
						</h:commandButton>
					</h:column>
				</h:dataTable>
				<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
