<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script language="javascript">
	
</script>

<x:saveState value="#{sys_workflowprocessBB}" />
<h:form id="form1">
	<h:inputHidden value="#{sys_workflowprocessBB.pageInit}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8 align="left">
                      <jsp:include		page="/pages/system/workflow/workflowChart.jsp"></jsp:include>
                </td>
			</tr>
			<tr>
				<td td height=8></f:verbatim> <h:outputText
						value="#{sys_workflowprocessBB.processDes}"></h:outputText> <f:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable styleClass="table03" align="center" width="95%"
							id="dateList" headerClass="tr_fixrow td_top"
							columnClasses="td_middle_left,td_middle,td_middle"
							value="#{sys_workflowprocessBB.logList}" var="list" border="0">

							<h:column>
								<f:facet name="header">
								    <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1141", "节点名称")%>
								    </f:verbatim>
								</f:facet>
								<h:graphicImage value="/images/tips.gif"
									rendered="#{list.exitTime=='' || list.exitTime==null}"></h:graphicImage>
								<h:graphicImage value="/images/notips.gif"
									rendered="#{list.exitTime!='' && list.exitTime!=null}"></h:graphicImage>
								<h:outputText value="#{list.nodeName}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								    <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1150", "请求人")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.operName}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								     <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1149", "进入时间")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.enterTime}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								     <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1148", "处理人")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.executorName}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								   <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1147", "离开时间")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.exitTime}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								       <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1146", "当前状态")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.statusValueDes}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								     <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1145", "当前项目值")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.conValue}" />
							</h:column>

						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>
