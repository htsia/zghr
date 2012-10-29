<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
	function showWarn(dateid) {
		window
				.showModalDialog(
						"/run/StopWarn.jsf",
						null,
						"dialogWidth:400px; dialogHeight:150px;center:center;resizable:yes;status:no;scroll:yes;");
		return false;
	}
</script>

<x:saveState value="run_SystemInfoBackingBean"></x:saveState>
<h:form id="form1">
	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8 class="td_title"></f:verbatim> <h:graphicImage
						value="/images/tips.gif" /> <f:verbatim>
						<%=LanguageSupport.getResource("YXGL-0800", "���й��� ")%> ->
            			 <%=LanguageSupport.getResource("YXGL-0891", "�����û�")%>
					</f:verbatim> <h:outputText value="  " /> <f:verbatim>
				</td>
			</tr>

			<tr>
				<td height=8 align="right"></f:verbatim> <h:commandButton value="ˢ��"
						styleClass="button01"></h:commandButton> <h:commandButton
						value="ͣ������" styleClass="button01" onclick="showWarn()"></h:commandButton>
					<f:verbatim>
				</td>
			</tr>


			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable value="#{run_SystemInfoBackingBean.userList}"
							var="list" align="center" id="dateList"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1028","����")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									  <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1029","����")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
                                  <%=LanguageSupport.getResource("MSG-0010","����")%>
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1031","��½ʱ��")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.lastLoginTime}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1032","����ʱ��")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.lastOperTime}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1033","�ܵ�½����")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.loginTimes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1034","�����½����")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.todayTimes}" />
							</h:column>

						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>

</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
