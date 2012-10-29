<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<script language="javascript">
	function addTrans() {
		window.showModalDialog(
						"/system/wfTransEdit.jsf?nodeid="
								+ document.all('form1:nodeid').value,
						null,
						"dialogWidth:580px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function modifyTrans(id) {
		window.showModalDialog(
						"/system/wfTransEdit.jsf?transid=" + id,
						null,
						"dialogWidth:580px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{sys_workflownodeBB}" />
<h:form id="form1">
	<h:inputHidden value="#{sys_workflownodeBB.initNodeTrans}" />
	<h:inputHidden id="nodeid" value="#{sys_workflownodeBB.nodeid}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8 align="left" colspan="2"><jsp:include
						page="/pages/system/workflow/workflowChart.jsp"></jsp:include></td>
			</tr>

			<tr>
				<td height=8 align="left"></f:verbatim> <h:outputText
						value="#{sys_workflownodeBB.nodeDes}"></h:outputText> <f:verbatim>
				</td>
				<td height=8 align="right"></f:verbatim> <h:commandButton value="增加"
						styleClass="button01" onclick="addTrans();"></h:commandButton> <f:verbatim>
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable styleClass="table03" align="center" width="95%"
							id="dateList" headerClass="tr_fixrow td_top"
							columnClasses="td_middle_center,td_middle,td_middle"
							value="#{sys_workflownodeBB.transList}" var="list" border="0">
							<h:column>
								<f:facet name="header">
								     <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1144", "转向节点序号")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.toSEQ}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								     <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1143", "转向节点名称")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.toNodeName}" />
							</h:column>

                            <h:column>
                                <f:facet name="header">
                                      <f:verbatim>
                                        转移条件
                                    </f:verbatim>
                                </f:facet>
                                <h:outputText value="#{list.transConditionDes}" />
                            </h:column>

							<h:column>
								<f:facet name="header">
								      <f:verbatim>
								        <%=LanguageSupport.getResource("XTGL-1142", "转向消息")%>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.toMessage}" />
							</h:column>


							<h:column>
								<f:facet name="header">
									<h:outputText value="操作" styleClass="td03" />
								</f:facet>
								<h:commandButton styleClass="button01" value="删除"
									action="#{sys_workflownodeBB.deleteTrans}">
									<x:updateActionListener
										property="#{sys_workflownodeBB.transid}"
										value="#{list.transID}"></x:updateActionListener>
								</h:commandButton>
								<h:commandButton styleClass="button01" value="修改"
									onclick="return modifyTrans('#{list.transID}');"></h:commandButton>
							</h:column>

						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	setDataTableOver("form1:dateList");
</script>
