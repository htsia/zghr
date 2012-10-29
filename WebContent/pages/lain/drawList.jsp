<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/lain/DrawEdit.jsf?add=true", null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doModify(id){
            window.showModalDialog("/lain/DrawEdit.jsf?modify=true&drawId="+id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true ;
        }
        function doShow(id){
            window.showModalDialog("/lain/DrawEdit.jsf?isBrower=true&drawId="+id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true ;
        }
    </script>

<x:saveState value="#{lain_DrawBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{lain_DrawBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
							<h:graphicImage value="/images/tips.gif" />
							<h:outputText value=" �ͱ����� ->  �������뵥" styleClass="f04"  />
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2"  >

						<h:panelGroup>
							<h:outputText value="��¼��:#{lain_DrawBB.pagevo.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ҳ��:#{lain_DrawBB.pagevo.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ÿҳ��#{lain_DrawBB.pagevo.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="��ǰΪ��#{lain_DrawBB.pagevo.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ" action="#{lain_DrawBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{lain_DrawBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{lain_DrawBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ" action="#{lain_DrawBB.last}"
								styleClass="button01"></h:commandButton>
							<h:outputText value="  "></h:outputText>
							<h:commandButton value="����" onclick="return doAdd();"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>

					</h:panelGrid>
				</h:panelGrid> <c:verbatim></td>
			</tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> <h:dataTable value="#{lain_DrawBB.drawkList}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center, td_middle_center, td_middle_center"
					styleClass="table03" width="94%">
					<h:column>
						<c:facet name="header">
							<h:outputText value="���뵥���" />
						</c:facet>
						<h:outputText value="#{list.drawCode}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="������" />
						</c:facet>
						<h:outputText value="#{list.drawPerName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.drawDate}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="�༭" styleClass="button01" rendered="#{list.drawStatus == '0'}"
							onclick="doModify('#{list.drawId}')" />
						<h:commandButton value="�鿴" styleClass="button01"  rendered="#{list.drawStatus == '1'}"
							onclick="doShow('#{list.drawId}')"  />
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
							action="#{lain_DrawBB.deleteDrawBO}"
							styleClass="button01">
							<x:updateActionListener
								property="#{lain_DrawBB.drawBO.drawId}"
								value="#{list.drawId}" />
						</h:commandButton>
						<h:commandButton value="��  Ч"  rendered="#{list.drawStatus == '0'}"
						  styleClass="button01"  action="#{lain_DrawBB.changeStatus}">
						   <x:updateActionListener
								property="#{lain_DrawBB.drawBO.drawId}"
								value="#{list.drawId}" />
						 </h:commandButton>
						<h:commandButton value="����Ч"  rendered="#{list.drawStatus == '1'}"
								styleClass="button01"></h:commandButton>
					    
					</h:column>
				</h:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
