<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
</script>

<x:saveState value="#{sys_workflowcfgBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="initListFlow"
		value="#{sys_workflowcfgBB.initShowDefine}" />
	<c:verbatim>
		<table height="96%" width="98%" align="center">
			<tr>
				<td height=8><strong><%=LanguageSupport.getResource("XTGL-1028", "��ǰ����:")%></strong>
					</c:verbatim> <h:outputText value="#{sys_workflowcfgBB.orgName}"></h:outputText>
					<c:verbatim>
				</td>
			</tr>

			<tr>
				<td colspan="2" valign="top">
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{sys_workflowcfgBB.flowDefinelist}" var="list"
							align="center" id="dateList" rowIndexVar="index"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1029","���")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("JGGL-1058","����")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.defName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1030","�Ƿ�����")%>  
                                   </f:verbatim>
								</c:facet>
								<h:selectOneRadio value="#{list.isuse}" disabled="true">
									<c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
									<c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
								</h:selectOneRadio>
							</h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1031","��������")%>
                                   </f:verbatim>
								</c:facet>
								<h:selectOneMenu value="#{list.orguid}" disabled="true">
									<c:selectItems value="#{sys_workflowcfgBB.orgList}"></c:selectItems>
								</h:selectOneMenu>
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1032","���û���")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptiDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1033","��������")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.applyDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("YXGL-1026","����")%>  
                                   </f:verbatim>
								</c:facet>
								<h:commandButton value="��ʾ����" styleClass="button01" action="#{sys_workflowcfgBB.showWorkFlow}">
                                    <x:updateActionListener property="#{sys_workflowcfgBB.defid}" value="#{list.defID}"></x:updateActionListener>
                                </h:commandButton>
							</h:column>
						</x:dataTable>
						<c:verbatim>
					</div>
                  </td>
			</tr>

            <tr>
                <td height=450>
                     <iframe width="100%"  height="100%" src="/pages/system/workflow/workflowChart.jsp"></iframe>
                </td>
            </tr>
        </table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>