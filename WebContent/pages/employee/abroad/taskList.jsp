<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
         function addtask(){
        	 var reval = window.showModalDialog("/employee/abroad/planListQuery.jsf?superId="+document.all('form1:superId').value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
             if (reval != null && reval!="") {
            	 document.all("form1:planId").value = reval;
             	return true;
             } else {
                 return false;
             }
         }
        function modifyTask(id){
            window.showModalDialog("/employee/abroad/aboardTaskEdit.jsf?taskId="+id, "", "dialogWidth:600px; dialogHeight:200px; status:0;resizable:yes");
            return true;
        }
        function query(id){
            window.showModalDialog("/employee/abroad/taskDetial.jsf?taskId="+id, "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
            return true;
        }
        function selectPerson(id){
        	 window.showModalDialog("/employee/abroad/selectTaskPersonList.jsf?taskId="+id+"&orgId="+document.all("form1:superId").value, "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
             return true;
        }
    </script>

<x:saveState value="#{aboradtaskMannageBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{aboradtaskMannageBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{aboradtaskMannageBB.superId}"></h:inputHidden>
	<h:inputHidden id="planId" value=""></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid width="98%" columns="2">
						<h:panelGrid align="left">
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"JGGL-1092", "��ǰ����")%>:
            </f:verbatim>
								<h:outputText value="#{aboradtaskMannageBB.superName}"></h:outputText>
							</h:panelGroup>
						</h:panelGrid>
						<h:panelGrid align="right" columns="2">
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "��¼��")%>:
                </f:verbatim>
								<h:outputText value="#{aboradtaskMannageBB.mypage.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "ҳ��")%>��
				 </f:verbatim>
								<h:outputText value="#{aboradtaskMannageBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "ÿҳ��")%>
								</f:verbatim>
								<h:outputText value="#{aboradtaskMannageBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "��ǰΪ��")%>
								</f:verbatim>
								<h:outputText value="#{aboradtaskMannageBB.mypage.currentPage}ҳ"></h:outputText>
								<h:commandButton value="��ҳ"
									action="#{aboradtaskMannageBB.first}" styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ" action="#{aboradtaskMannageBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ" action="#{aboradtaskMannageBB.next}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="βҳ" action="#{aboradtaskMannageBB.last}"
									styleClass="button01"></h:commandButton>
								<h:outputText value="  "></h:outputText>
								<h:commandButton value="����" onclick="return addtask();"
									styleClass="button01" action="#{aboradtaskMannageBB.addtask}"></h:commandButton>
							</h:panelGroup>

						</h:panelGrid>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>
			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{aboradtaskMannageBB.taskList}" var="list"
							rowIndexVar="index" align="center" id="dateList"
							headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="90%">
							<h:column>
								<c:facet name="header">
									  <f:verbatim>
								 	<%=LanguageSupport.getResource( "YXGL-1035", "���")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column>
								<c:facet name="header">
							    <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2004", "���ù���")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.county}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								   <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2002", "����Ŀ��")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.aim}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2009", "��ʼ����")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.beginDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									 <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2008", "��������")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.endDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									 <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2018", "�ͻ�")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.costomer}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									 <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2006", "Ԥ��")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.budget}" />
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
								<h:commandButton value="�༭����"
									onclick="return modifyTask('#{list.taskId}')"
									styleClass="button01" rendered="#{list.status=='0'}"></h:commandButton>
								<h:commandButton value="�༭��Ա"
									onclick="return selectPerson('#{list.taskId}')"
									styleClass="button01" rendered="#{list.status=='0'}"></h:commandButton>
								<h:commandButton value="����"
									action="#{aboradtaskMannageBB.endTask}" styleClass="button01"
									rendered="#{list.status=='0'}">
									<x:updateActionListener
										property="#{aboradtaskMannageBB.taskId}"
										value="#{list.taskId}" />
								</h:commandButton>
								<h:commandButton value="�鿴"
									onclick="return query('#{list.taskId}')" styleClass="button01"></h:commandButton>
							</h:column>
						</x:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
