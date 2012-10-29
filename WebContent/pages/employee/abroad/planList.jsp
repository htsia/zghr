<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
         function addPlan(){
             window.showModalDialog("/employee/abroad/deptPlanEdit.jsf?superId=new", "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/employee/abroad/deptPlanEdit.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
            return true;
        }
        function query(id){
            window.showModalDialog("/employee/abroad/deptPlanDetial.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
            return true;
        }
        function selectPerson(id){
        	 window.showModalDialog("/employee/abroad/selectPersonList.jsf?planID="+id+"&orgId="+document.all("form1:superId").value, "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
             return true;
        }
    </script>

<x:saveState value="#{aboradPlanMannageBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{aboradPlanMannageBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{aboradPlanMannageBB.superId}"></h:inputHidden>
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
								<h:outputText value="#{aboradPlanMannageBB.superName}"></h:outputText>
							</h:panelGroup>
						</h:panelGrid>
						<h:panelGrid align="right" columns="2">
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"RYGL-2003", "�ƻ�����")%>:
              </f:verbatim>
								<h:selectOneMenu value="#{aboradPlanMannageBB.planType}">
									<c:selectItem itemLabel="ȫ��" itemValue="-1"></c:selectItem>
									<c:selectItem itemLabel="���" itemValue="0"></c:selectItem>
									<c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
									<c:selectItem itemLabel="�¶�" itemValue="2"></c:selectItem>
								</h:selectOneMenu>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"RYGL-2015", "�ƻ�ʱ��")%>:
                </f:verbatim>
								<h:inputText value="#{aboradPlanMannageBB.planDate}"></h:inputText>
								<h:commandButton value="��ѯ"
									action="#{aboradPlanMannageBB.queryPlanList}"
									styleClass="button01"></h:commandButton>
								<h:outputText value=" "></h:outputText>

								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "��¼��")%>:
                              </f:verbatim>
								<h:outputText value="#{aboradPlanMannageBB.mypage.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "ҳ��")%>
								</f:verbatim>
								<h:outputText value="#{aboradPlanMannageBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "ÿҳ��")%>
								</f:verbatim>
								<h:outputText value="#{aboradPlanMannageBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "��ǰΪ��")%>
								</f:verbatim>
								<h:outputText value="#{aboradPlanMannageBB.mypage.currentPage}"></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "ҳ")%>
								</f:verbatim>

								<h:commandButton value="��ҳ"
									action="#{aboradPlanMannageBB.first}" styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ" action="#{aboradPlanMannageBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ" action="#{aboradPlanMannageBB.next}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="βҳ" action="#{aboradPlanMannageBB.last}"
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
						<x:dataTable value="#{aboradPlanMannageBB.planList}" var="list"
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
								 	<%=LanguageSupport.getResource( "GWGL-1017", "����")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptId}" />
							</h:column>
							<h:column>
								<c:facet name="header">
						       <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2003", "�ƻ�����")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.planTypeDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2015", "�ƻ�ʱ��")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.planDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2004", "���ù���")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.country}" />
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
								 	<%=LanguageSupport.getResource( "RYGL-2017", "�ƶ���")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.maker}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2016", "�ƶ�ʱ��")%>
							  	</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.makDate}" />
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
								<h:commandButton value="�޸�"
									onclick="return modify('#{list.planId}')" styleClass="button01"
									rendered="#{list.isExecute=='0'}"></h:commandButton>
								<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
									action="#{aboradPlanMannageBB.delete}" styleClass="button01"
									rendered="#{list.isExecute=='0'}">
									<x:updateActionListener
										property="#{aboradPlanMannageBB.planId}"
										value="#{list.planId}" />
								</h:commandButton>
								<h:commandButton value="�༭��Ա"
									onclick="return selectPerson('#{list.planId}')"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="�鿴"
									onclick="return query('#{list.planId}')" styleClass="button01"></h:commandButton>
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
