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
        function doAudit1(id){
            window.showModalDialog("/employee/DChange/DchangAuditEdit1.jsf?itemId="+id, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doAudit2(id){
            window.showModalDialog("/employee/DChange/DchangAuditEdit2.jsf?itemId="+id, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doAudit3(id){
            window.showModalDialog("/employee/DChange/DchangAuditEdit3.jsf?itemId="+id, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function selectPerson2(id){
            window.showModalDialog("/employee/DChange/DChangeWageEdit2.jsf?itemId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{empDchangeAuditMgrBB}" />
<h:form id="form1">
	<h:inputHidden value="#{empDchangeAuditMgrBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{empDchangeAuditMgrBB.superId}"></h:inputHidden>
	<h:inputHidden id="operate" value="#{empDchangeAuditMgrBB.operate}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8"></c:verbatim> <h:panelGrid width="98%" columns="2">
						<h:panelGrid align="left">
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"JGGL-1092", "当前机构 ")%>:
                   </f:verbatim>
								<h:outputText value="#{empDchangeAuditMgrBB.superName}"></h:outputText>
							</h:panelGroup>
						</h:panelGrid>
						<h:panelGrid align="right" columns="2">
							<h:panelGroup>
								<h:selectBooleanCheckbox
									value="#{empDchangeAuditMgrBB.selectNoPass}"
									onclick="submit();"
									valueChangeListener="#{empDchangeAuditMgrBB.queryAll}" />
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"RYGL-2027", "全部显示")%>
								</f:verbatim>
							</h:panelGroup>
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "记录数")%>：
			    </f:verbatim>
								<h:outputText value="#{empDchangeAuditMgrBB.mypage.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "页数")%>：
			    </f:verbatim>
								<h:outputText value="#{empDchangeAuditMgrBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "每页有")%>：
			    </f:verbatim>
								<h:outputText value="#{empDchangeAuditMgrBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "当前为第")%>
								</f:verbatim>
								<h:outputText value="#{empDchangeAuditMgrBB.mypage.currentPage}"></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "页")%>
								</f:verbatim>
								<h:commandButton value="首页"
									action="#{empDchangeAuditMgrBB.first}" styleClass="button01"></h:commandButton>
								<h:commandButton value="上页" action="#{empDchangeAuditMgrBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="下页"
									action="#{empDchangeAuditMgrBB.next}" styleClass="button01"></h:commandButton>
								<h:commandButton value="尾页"
									action="#{empDchangeAuditMgrBB.last}" styleClass="button01"></h:commandButton>
							</h:panelGroup>

						</h:panelGrid>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>

						<x:dataTable value="#{empDchangeAuditMgrBB.personList}"
							width="100%" var="list" rowIndexVar="index" align="center"
							id="dateList" headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03">
							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				     		<%=LanguageSupport.getResource("XTGL-1029", "序号")%>
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
				     		<%=LanguageSupport.getResource("RYGL-2127", "当前岗位级别")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.curPost}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								       <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2126", "转正后岗位级别")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.passPost}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2129", "预计转正时间")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.planPassDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2130", "转正倒计时天数")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.haveDays}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2028", "初审意见")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2029", "复审意见")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes1}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2030", "终审意见")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes2}" />
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
									onclick="return doAudit1('#{list.itemId}');"
									rendered="#{list.status=='1'&& list.canAduit=='1382'}"></h:commandButton>
								<h:commandButton value="审批" styleClass="button01"
									onclick="return doAudit2('#{list.itemId}');"
									rendered="#{list.status=='1'&& list.canAduit=='1383'}"></h:commandButton>
								<h:commandButton value="审批" styleClass="button01"
									onclick="return doAudit3('#{list.itemId}');"
									rendered="#{list.status=='1'&& list.canAduit=='1384'}"></h:commandButton>
								<h:commandButton value="查看薪资" styleClass="button01"
									onclick="return selectPerson2('#{list.itemId}');" />
								<h:commandButton value="查看流程"
									onclick="return showWorkFlowLogByLinkID('#{list.itemId}')"
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