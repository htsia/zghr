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
        function doAudit(id){
            window.showModalDialog("/employee/probation/empProbationAuditEdit.jsf?OperID="+document.all('form1:operate').value+"&personId="+id, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function selectPerson4(perid){
            window.showModalDialog("/employee/probation/probationWageEdit2.jsf?personId="+perid, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{empprobastionaduitBB}" />
<h:form id="form1">
	<h:inputHidden value="#{empprobastionaduitBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{empprobastionaduitBB.superId}"></h:inputHidden>
	<h:inputHidden id="operate" value="#{empprobastionaduitBB.operate}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8" align="left">
					  <strong><%=LanguageSupport.getResource("JGGL-1092", "��ǰ����")%>:</strong>
                  </c:verbatim>
								<h:outputText value="#{empprobastionaduitBB.superName}"></h:outputText>
                  <f:verbatim>
                </td>
            </tr>
            <tr>
               <td  height="8" align="right">
                 </f:verbatim>
                        <h:panelGrid align="right" columns="2">
							<h:panelGroup>
								<h:selectBooleanCheckbox
									value="#{empprobastionaduitBB.selectAllPass}"
									onclick="submit();"
									valueChangeListener="#{empprobastionaduitBB.queryAll}" />
								<f:verbatim>
									<%=LanguageSupport.getResource(	"RYGL-2027", "ȫ����ʾ")%>
								</f:verbatim>
							</h:panelGroup>
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(	"COMM-1043", "��¼��")%>:
              	</f:verbatim>
								<h:outputText value="#{empprobastionaduitBB.mypage.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "ҳ��")%>:
              	</f:verbatim>
								<h:outputText value="#{empprobastionaduitBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "ÿҳ��")%>
								</f:verbatim>
								<h:outputText value="#{empprobastionaduitBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "��ǰΪ��")%>
								</f:verbatim>
								<h:outputText value="#{empprobastionaduitBB.mypage.currentPage}"></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "ҳ")%>
								</f:verbatim>
								<h:commandButton value="��ҳ"
									action="#{empprobastionaduitBB.first}" styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ" action="#{empprobastionaduitBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ"
									action="#{empprobastionaduitBB.next}" styleClass="button01"></h:commandButton>
								<h:commandButton value="βҳ"
									action="#{empprobastionaduitBB.last}" styleClass="button01"></h:commandButton>
							</h:panelGroup>

						</h:panelGrid>
<c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>

						<x:dataTable value="#{empprobastionaduitBB.personList}"
							 var="list" rowIndexVar="index" align="center"
							id="dateList" headerClass="td_top"   width="960"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03">
                        <x:column width="100">
                            <c:facet name="header">
                            <f:verbatim>
                                <%=LanguageSupport.getResource("YXGL-1026", "����")%>
                            </f:verbatim>
                            </c:facet>
                            <h:commandButton value="����" styleClass="button01"
                                onclick="return doAudit('#{list.personId}');"
                                rendered="#{list.canAudit}"></h:commandButton>
                            <h:commandButton value="�鿴н��" styleClass="button01"
                                onclick="return selectPerson4('#{list.personId}');"
                                rendered="#{list.auditResult=='0' || list.auditResult=='1' || list.auditResult=='2'}" />
                            <h:commandButton value="�鿴����"
                                onclick="return showWorkFlowLogByLinkID('#{list.personId}')"
                                styleClass="button01"></h:commandButton>
                        </x:column>

							<x:column width="60">
								<c:facet name="header">
									 <f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-1016", "����")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</x:column>

							<x:column width="40">
								<c:facet name="header">
								 <f:verbatim>
								    <%=LanguageSupport.getResource("MSG-0012", "�Ա�")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.sex}" />
							</x:column>
							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("MSG-0013", "��������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.birthday}" />
							</x:column>
							<x:column width="80">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2137", "���ڻ���")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</x:column>

							<x:column width="80">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2063", "���ڲ���")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</x:column>

							<x:column width="80">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1061", "��Ա���")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personType}" />
							</x:column>
							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2139", "Ԥ��ת������")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.planPassDate}" />
							</x:column>
							<x:column width="120">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2131", "ת������ʱ����")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.haveDays}" />
							</x:column>
							<x:column width="80">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1051", "״̬")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.statusDes}" />
							</x:column>
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