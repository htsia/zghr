<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<script type="text/javascript">
</script>
<x:saveState value="#{sys_viewworkcfgBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{sys_viewworkcfgBB.pageInit}"></h:inputHidden>
    <c:verbatim>
		<table height="96%" width="98%" align="center">
			<tr>
				<td height=8 align="right">
    </c:verbatim>
                    <h:panelGroup>
                        <h:selectOneMenu value="#{sys_viewworkcfgBB.defID}">
                            <c:selectItems value="#{sys_viewworkcfgBB.deflist}"></c:selectItems>
                        </h:selectOneMenu>
                        <h:commandButton value="����" action="#{sys_viewworkcfgBB.first}" styleClass="button01"></h:commandButton>
                        <h:outputText value="��¼��:#{sys_viewworkcfgBB.pagevo.totalRecord}"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="ҳ��:#{sys_viewworkcfgBB.pagevo.totalPage}"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="ÿҳ��#{sys_viewworkcfgBB.pagevo.pageSize}"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="��ǰΪ��#{sys_viewworkcfgBB.pagevo.currentPage}ҳ"></h:outputText>
                        <h:commandButton value="��ҳ" action="#{sys_viewworkcfgBB.first}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="��ҳ" action="#{sys_viewworkcfgBB.pre}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="��ҳ" action="#{sys_viewworkcfgBB.next}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="βҳ" action="#{sys_viewworkcfgBB.last}" styleClass="button01"></h:commandButton>
                    </h:panelGroup>
     <c:verbatim>               
                </td>
			</tr>

			<tr>
				<td colspan="2" valign="top">
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{sys_viewworkcfgBB.flowlist}" var="list"
							align="center" id="dateList" rowIndexVar="index"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
                  				        ���
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				       ����ʱ��
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.processDate}" />
							</h:column>


                            <h:column>
                                <c:facet name="header">
                                 <f:verbatim>
                                         ������
                                   </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.processName}" />
                            </h:column>

                            <h:column>
                                <c:facet name="header">
                                 <f:verbatim>
                                         ��������
                                   </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.defName}" />
                            </h:column>

                            <h:column>
                                <c:facet name="header">
                                 <f:verbatim>
                                         ����״̬
                                   </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.processStatusDes}" />
                            </h:column>

                            <h:column>
                                <c:facet name="header">
                                 <f:verbatim>
                                         ��ǰ�ڵ�
                                   </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.curNodeName}" />
                            </h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        ����
                                   </f:verbatim>
                                </c:facet>
                                <h:commandButton value="�鿴����" id="showFlow" type="button" onclick="return showWorkFlowLogByLinkID('#{list.linkID}')" styleClass="button01" ></h:commandButton>
                                <h:commandButton value="ɾ��" styleClass="button01"  action="#{sys_viewworkcfgBB.delete}">
                                    <x:updateActionListener property="#{sys_viewworkcfgBB.processID}" value="#{list.processID}"></x:updateActionListener>
                                </h:commandButton>
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