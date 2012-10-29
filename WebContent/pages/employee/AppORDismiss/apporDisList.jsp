<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<f:verbatim>
	<script type="text/javascript">
        function doAudit1(id){
            window.showModalDialog("/employee/AppORDismiss/apporDisAuditEdit1.jsf?changeId="+id, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doAudit2(id){
            window.showModalDialog("/employee/AppORDismiss/apporDisAuditEdit2.jsf?changeId="+id, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doAudit3(id){
            window.showModalDialog("/employee/AppORDismiss/apporDisAuditEdit3.jsf?changeId="+id, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function selectPerson2(id){
            window.showModalDialog("/employee/AppORDismiss/apporDisWageEdit2.jsf?changeId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{empApporDisAuditBB}" />
<h:form id="form1">
	<h:inputHidden value="#{empApporDisAuditBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{empApporDisAuditBB.superId}"></h:inputHidden>
	<h:inputHidden id="operate" value="#{empApporDisAuditBB.operate}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8"></c:verbatim> <h:panelGrid width="98%" columns="2">
						<h:panelGrid align="left">
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"JGGL-1092", "��ǰ����")%>��
    	          </f:verbatim>
								<h:outputText value="#{empApporDisAuditBB.superName}"></h:outputText>
							</h:panelGroup>
						</h:panelGrid>
						<h:panelGrid align="right" columns="2">
							<h:panelGroup>
								<h:selectBooleanCheckbox
									value="#{empApporDisAuditBB.selectNoPass}" onclick="submit();"
									valueChangeListener="#{empApporDisAuditBB.queryAll}" />
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"RYGL-2027", "ȫ����ʾ")%>��
    	          </f:verbatim>
							</h:panelGroup>
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "ҳ��")%>��
    	        </f:verbatim>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "��¼��")%>��
    	        </f:verbatim>
								<h:outputText value="#{empApporDisAuditBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "ÿҳ��")%>��
    	        </f:verbatim>
								<h:outputText value="#{empApporDisAuditBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "��ǰΪ��")%>��
    	        </f:verbatim>
								<h:outputText value="#{empApporDisAuditBB.mypage.currentPage}"></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "ҳ")%>��
    	        </f:verbatim>
								<h:commandButton value="��ҳ" action="#{empApporDisAuditBB.first}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ" action="#{empApporDisAuditBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ" action="#{empApporDisAuditBB.next}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="βҳ" action="#{empApporDisAuditBB.last}"
									styleClass="button01"></h:commandButton>
							</h:panelGroup>

						</h:panelGrid>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>

						<x:dataTable value="#{empApporDisAuditBB.personList}" width="100%"
							var="list" rowIndexVar="index" align="center" id="dateList"
							headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03">
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
								 	  <%=LanguageSupport.getResource("RYGL-1016","����")%> 
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									  <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2025", "ԭְ��")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldJob}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									  <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2026", "��ְ��")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newJob}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									  <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2028", "�������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									  <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2029", "�������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes1}" />
							</h:column>
							<h:column>
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
								<h:commandButton value="����" styleClass="button01"
									onclick="return doAudit1('#{list.changeId}');"
									rendered="#{list.status=='1'&& list.canAduit=='1358'}"></h:commandButton>
								<h:commandButton value="����" styleClass="button01"
									onclick="return doAudit2('#{list.changeId}');"
									rendered="#{list.status=='1'&& list.canAduit=='1359'}"></h:commandButton>
								<h:commandButton value="����" styleClass="button01"
									onclick="return doAudit3('#{list.changeId}');"
									rendered="#{list.status=='1'&& list.canAduit=='1360'}"></h:commandButton>
								<h:commandButton value="�鿴н��" styleClass="button01"
									onclick="return selectPerson2('#{list.changeId}');" />
								<h:commandButton value="�鿴����"
									onclick="return showWorkFlowLogByLinkID('#{list.changeId}')"
									styleClass="button01"></h:commandButton>
							</h:column>
						</x:dataTable>

						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>