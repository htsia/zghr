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
						<%=LanguageSupport.getResource("YXGL-0800", "运行管理 ")%> ->
            			 <%=LanguageSupport.getResource("YXGL-0891", "在线用户")%>
					</f:verbatim> <h:outputText value="  " /> <f:verbatim>
				</td>
			</tr>

			<tr>
				<td height=8 align="right"></f:verbatim> <h:commandButton value="刷新"
						styleClass="button01"></h:commandButton> <h:commandButton
						value="停机公告" styleClass="button01" onclick="showWarn()"></h:commandButton>
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
                                  <%=LanguageSupport.getResource("YXGL-1028","机构")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									  <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1029","部门")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
                                  <%=LanguageSupport.getResource("MSG-0010","姓名")%>
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1031","登陆时间")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.lastLoginTime}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1032","操作时间")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.lastOperTime}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1033","总登陆次数")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.loginTimes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1034","当天登陆次数")%>  
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
