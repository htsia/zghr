<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function freeHoubei(id) {
    window.showModalDialog("/employee/info/RefusePerson.jsf?subId="+id, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selPerson(id) {
    window.showModalDialog("/employee/info/dupyPersonList.jsf?forId="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function addPerson() {
    window.showModalDialog("/employee/info/addReservePerson.jsf", null, "dialogWidth:600px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
</script>

<x:saveState value="#{empResverPersonMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{empResverPersonMgrBB.pageInit}" />
	<h:inputHidden id="personStr" value="" />
	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8>
					<table align="center" border="0" cellpadding="0" cellspacing="0"
						width=100% bgcolor="#FFFFFF">
						<tr>
							<td class=td_title></f:verbatim> <h:graphicImage
									value="/images/tips.gif" /> <f:verbatim>
									<%=LanguageSupport
							.getResource("RYGL-0330", "���˲�  ")%> ->
              <%=LanguageSupport
							.getResource("RYGL-0332", "���˲Ź���")%>
								</f:verbatim> <f:verbatim>
							</td>
							<td align="right" class=td_title></td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td height=8>
					<table width="95%">
						<tr>
							<td align="right"></td>
							<td align="right"></f:verbatim> <h:panelGroup>
									<h:selectBooleanCheckbox
										value="#{empResverPersonMgrBB.sellAll}" onclick="submit();"
										valueChangeListener="#{empResverPersonMgrBB.queryAll}" />
									<f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2027",
								"ȫ����ʾ")%>
									</f:verbatim>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1043",
								"��¼��")%>:
                 </f:verbatim>
									<h:outputText
										value="#{empResverPersonMgrBB.mypage.totalRecord}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport
								.getResource("COMM-1044", "ҳ��")%>:
                 </f:verbatim>
									<h:outputText value="#{empResverPersonMgrBB.mypage.totalPage}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1045",
								"ÿҳ��")%>:
                 </f:verbatim>
									<h:outputText value="#{empResverPersonMgrBB.mypage.pageSize}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1046",
								"��ǰΪ��")%>:
                 </f:verbatim>
									<h:outputText
										value="#{empResverPersonMgrBB.mypage.currentPage}"></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1047", "ҳ")%>:
                 </f:verbatim>
									<h:commandButton value="��ҳ"
										action="#{empResverPersonMgrBB.first}" styleClass="button01"></h:commandButton>
									<h:commandButton value="��ҳ"
										action="#{empResverPersonMgrBB.pre}" styleClass="button01"></h:commandButton>
									<h:commandButton value="��ҳ"
										action="#{empResverPersonMgrBB.next}" styleClass="button01"></h:commandButton>
									<h:commandButton value="βҳ"
										action="#{empResverPersonMgrBB.last}" styleClass="button01"></h:commandButton>
									<h:outputText value="  "></h:outputText>
									<h:commandButton value="����" onclick="return addPerson()"
										styleClass="button01"></h:commandButton>
								</h:panelGroup> <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<x:dataTable value="#{empResverPersonMgrBB.personList}" var="list"
							align="center" rowIndexVar="index" id="dateList"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<c:facet name="header">
								   <f:verbatim>
										 <%=LanguageSupport.getResource("YXGL-1035", "���")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								        <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2271", "��˾")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("GWGL-1017", "����")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("MSG-0010", "����")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("MSG-0012", "�Ա�")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.sex}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2270", "����")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.age}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2239", "ѧ��")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.degraee}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2053", "����")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.nativePlace}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2269", "��˾ʱ��")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.entComTime}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2268", "����ְʱ��")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.time}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2267", "����ǰְ��")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.preJob}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2266", "����������")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.forJob}" />
							</h:column>
							<h:column rendered="#{empResverPersonMgrBB.showAll=='1'}">
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2265", "�˳�ʱ��")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.refuseTime}" />
							</h:column>
							<h:column rendered="#{empResverPersonMgrBB.showAll=='1'}">
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2264", "�˳�ԭ��")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.reson}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("YXGL-1026", "����")%>
                                   </f:verbatim>
								</c:facet>
								<h:commandButton value="ȡ����"
									onclick="return freeHoubei('#{list.subId}')"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="ѡ��������"
									onclick="return selPerson('#{list.subId}')"
									styleClass="button01"></h:commandButton>
							</h:column>
						</x:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>