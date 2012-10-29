<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
         function addPerson(){
            window.showModalDialog("/train/TrainStudentAdd.jsf?classID="+document.all("form1:classID").value, "", "dialogWidth:315px; dialogHeight:215px; status:0;resizable:yes");
			return true;
         }
    </script>

<x:saveState value="#{TrainStudentSign_listBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{TrainStudentSign_listBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="classID" value="#{TrainStudentSign_listBB.classID}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim><h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:outputText value="��ǰ��ѵ��:"></h:outputText>
							<h:outputText value="#{TrainStudentSign_listBB.className}"></h:outputText>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">
						
						<h:panelGroup>
							<h:outputText
								value="��¼��:#{TrainStudentSign_listBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="ҳ��:#{TrainStudentSign_listBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="ÿҳ��#{TrainStudentSign_listBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="��ǰΪ��#{TrainStudentSign_listBB.mypage.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ"
								action="#{TrainStudentSign_listBB.first}" styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ"
								action="#{TrainStudentSign_listBB.pre}" styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ"
								action="#{TrainStudentSign_listBB.next}" styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ"
								action="#{TrainStudentSign_listBB.last}" styleClass="button01"></h:commandButton>
							
						</h:panelGroup>
					</h:panelGrid>
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{TrainStudentSign_listBB.studentList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="90%">
					<h:column>
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
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
							<h:outputText value="Ա��״̬" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
					
				</x:dataTable>
				<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
