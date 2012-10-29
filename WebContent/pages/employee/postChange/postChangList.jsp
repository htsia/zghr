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
            window.showModalDialog("/employee/postChange/postChangAuditEdit.jsf?changeId="+id+"&OperID="+document.all('form1:operate').value, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function selectPerson2(id){
            window.showModalDialog("/employee/postChange/postChangeWageEdit2.jsf?postChangeId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{emppostChangeAuditBB}" />
<h:form id="form1">
	<h:inputHidden value="#{emppostChangeAuditBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{emppostChangeAuditBB.superId}"></h:inputHidden>
	<h:inputHidden id="operate" value="#{emppostChangeAuditBB.operate}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8"></c:verbatim> <h:panelGrid width="98%" columns="2">
						<h:panelGrid align="left">
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"JGGL-1092", "当前机构")%>:
                 </f:verbatim>
								<h:outputText value="#{emppostChangeAuditBB.superName}"></h:outputText>
							</h:panelGroup>
						</h:panelGrid>
						<h:panelGrid align="right" columns="2">
							<h:panelGroup>
								<h:selectBooleanCheckbox
									value="#{emppostChangeAuditBB.selectNoPass}"
									onclick="submit();"
									valueChangeListener="#{emppostChangeAuditBB.queryAll}" />
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"RYGL-2027", "全部显示")%>
								</f:verbatim>
							</h:panelGroup>
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "记录数")%>:
              	</f:verbatim>
								<h:outputText value="#{emppostChangeAuditBB.mypage.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "页数")%>:
              	</f:verbatim>
								<h:outputText value="#{emppostChangeAuditBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "每页有")%>
								</f:verbatim>
								<h:outputText value="#{emppostChangeAuditBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "当前为第")%>
								</f:verbatim>
								<h:outputText value="#{emppostChangeAuditBB.mypage.currentPage}"></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "页")%>
								</f:verbatim>
								<h:commandButton value="首页"
									action="#{emppostChangeAuditBB.first}" styleClass="button01"></h:commandButton>
								<h:commandButton value="上页" action="#{emppostChangeAuditBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="下页"
									action="#{emppostChangeAuditBB.next}" styleClass="button01"></h:commandButton>
								<h:commandButton value="尾页"
									action="#{emppostChangeAuditBB.last}" styleClass="button01"></h:commandButton>
							</h:panelGroup>

						</h:panelGrid>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>

						<x:dataTable value="#{emppostChangeAuditBB.personList}"
							width="100%" var="list" rowIndexVar="index" align="center"
							id="dateList" headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03">
							<h:column>
								<c:facet name="header">
									  <f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1099", "序号")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-1016", "姓名")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2423", "原部门 ")%>
			</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldDept}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2422", "原岗位 ")%>
			</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldPost}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									 <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2025", "原职务 ")%>
			</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldJob}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									 <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2421", "新部门 ")%>
			</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newDept}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									 <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2020", "新岗位 ")%>
			</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newPost}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									  <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2026", "新职务 ")%>
			</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newJob}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<f:verbatim>
				<%=LanguageSupport.getResource("XTGL-1051", "状态")%>
			</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.statusDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<f:verbatim>
				<%=LanguageSupport.getResource("YXGL-1026", "操作")%>
			</f:verbatim>
								</c:facet>
								<h:commandButton value="审批" styleClass="button01"
									onclick="return doAudit('#{list.postChangeId}');"
									rendered="#{list.canAduit}"></h:commandButton>
								<h:commandButton value="查看薪资" styleClass="button01"
									onclick="return selectPerson2('#{list.postChangeId}');" />
								<h:commandButton value="查看流程"
									onclick="return showWorkFlowLogByLinkID('#{list.postChangeId}')"
									styleClass="button01"></h:commandButton>
							</h:column>
						</x:dataTable>

						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>