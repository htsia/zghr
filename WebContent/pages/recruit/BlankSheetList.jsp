<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
         function doQuery(id){
             window.showModalDialog("/recruit/resumeDetail2.jsf?personId="+id, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.7+"px; status:0;resizable:yes");
             return true;
         }
</script>
<x:saveState value="#{blanksheetBB}" />
<h:form id="form1">
	<h:inputHidden value="#{blanksheetBB.initPage}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8"></c:verbatim> <h:panelGrid align="right" columns="2">
					<h:panelGroup>
						<h:outputText value="��¼��:#{blanksheetBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ҳ��:#{blanksheetBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ÿҳ��#{blanksheetBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��ǰΪ��#{blanksheetBB.mypage.currentPage}ҳ"></h:outputText>
						<h:commandButton value="��ҳ" action="#{blanksheetBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{blanksheetBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{blanksheetBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="βҳ" action="#{blanksheetBB.last}"
							styleClass="button01"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> <x:dataTable value="#{blanksheetBB.personList}" width="100%"
					var="list" rowIndexVar="index" align="center" id="dateList"
					headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03">
					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.a001001}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ա�" />
						</c:facet>
						<h:outputText rendered="#{list.a001007=='01001'}" value="��" />
						<h:outputText rendered="#{list.a001007=='01002'}" value="Ů" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.a001011}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="״̬" />
						</c:facet>
						<h:outputText value="#{list.statusDes}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="����" styleClass="button01"
							onclick="return confirm('ȷ������������?');"
							action="#{blanksheetBB.reuse}">
							<x:updateActionListener property="#{blanksheetBB.personId}"
								value="#{list.id}" />
						</h:commandButton>
						<h:commandButton value="�鿴" styleClass="button01"
							onclick="return doQuery('#{list.id}');"></h:commandButton>
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