<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
         function addRecuNeed(){
            
             window.showModalDialog("/recruit/recruitNeedEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:350px; dialogHeight:260px; status:0;resizable:yes");
             return true;
         }
         function modify(id){
             window.showModalDialog("/recruit/recruitNeedEdit.jsf?itemId="+id, "", "dialogWidth:350px; dialogHeight:260px; status:0;resizable:yes");
             return true;
         }
</script>
<x:saveState value="#{recu_need_collectBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{recu_need_collectBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{recu_need_collectBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim>  <br/>
					<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:outputText value="��ǰ����:"></h:outputText>
							<h:outputText value="#{recu_need_collectBB.superName}"></h:outputText>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">

						
						<h:panelGroup>
							<h:outputText
								value="��¼��:#{recu_need_collectBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ҳ��:#{recu_need_collectBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ÿҳ��#{recu_need_collectBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="��ǰΪ��#{recu_need_collectBB.mypage.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ" action="#{recu_need_collectBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{recu_need_collectBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{recu_need_collectBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ" action="#{recu_need_collectBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
                            <h:commandButton value="����" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br/>
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id="datatable" align="center">
				</c:verbatim> <x:dataTable value="#{recu_need_collectBB.recuNeedList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"  columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
				    styleClass="table03" width="90%" border="0">

					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����ʱ��" />
						</c:facet>
						<h:outputText value="#{list.publishDate}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="��λ����" />
						</c:facet>
						<h:outputText value="#{list.postId}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{list.publishPersonName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.needCount}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ƿ�����ƻ�" />
						</c:facet>
						<h:outputText value="#{list.isImportPlan}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>

						<h:commandButton value="�༭"
							onclick="return modify('#{list.itemId}')"
							styleClass="button01" rendered="#{list.isImportPlan=='��'}"></h:commandButton>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
							action="#{recu_need_collectBB.delete}"
							styleClass="button01" rendered="#{list.isImportPlan=='��'}">
							<x:updateActionListener
								property="#{recu_need_collectBB.itemId}"
								value="#{list.itemId}" />
						</h:commandButton>
						 <h:commandButton value="�鿴����" onclick="return showWorkFlowLogByLinkID('#{list.importPlan}')" styleClass="button01" rendered="#{list.canSeach=='1'}"></h:commandButton>
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