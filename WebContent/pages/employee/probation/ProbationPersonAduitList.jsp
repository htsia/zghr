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
					  <strong><%=LanguageSupport.getResource("JGGL-1092", "当前机构")%>:</strong>
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
									<%=LanguageSupport.getResource(	"RYGL-2027", "全部显示")%>
								</f:verbatim>
							</h:panelGroup>
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(	"COMM-1043", "记录数")%>:
              	</f:verbatim>
								<h:outputText value="#{empprobastionaduitBB.mypage.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "页数")%>:
              	</f:verbatim>
								<h:outputText value="#{empprobastionaduitBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "每页有")%>
								</f:verbatim>
								<h:outputText value="#{empprobastionaduitBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "当前为第")%>
								</f:verbatim>
								<h:outputText value="#{empprobastionaduitBB.mypage.currentPage}"></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "页")%>
								</f:verbatim>
								<h:commandButton value="首页"
									action="#{empprobastionaduitBB.first}" styleClass="button01"></h:commandButton>
								<h:commandButton value="上页" action="#{empprobastionaduitBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="下页"
									action="#{empprobastionaduitBB.next}" styleClass="button01"></h:commandButton>
								<h:commandButton value="尾页"
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
                                <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
                            </f:verbatim>
                            </c:facet>
                            <h:commandButton value="审批" styleClass="button01"
                                onclick="return doAudit('#{list.personId}');"
                                rendered="#{list.canAudit}"></h:commandButton>
                            <h:commandButton value="查看薪资" styleClass="button01"
                                onclick="return selectPerson4('#{list.personId}');"
                                rendered="#{list.auditResult=='0' || list.auditResult=='1' || list.auditResult=='2'}" />
                            <h:commandButton value="查看流程"
                                onclick="return showWorkFlowLogByLinkID('#{list.personId}')"
                                styleClass="button01"></h:commandButton>
                        </x:column>

							<x:column width="60">
								<c:facet name="header">
									 <f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-1016", "姓名")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</x:column>

							<x:column width="40">
								<c:facet name="header">
								 <f:verbatim>
								    <%=LanguageSupport.getResource("MSG-0012", "性别")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.sex}" />
							</x:column>
							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("MSG-0013", "出生日期")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.birthday}" />
							</x:column>
							<x:column width="80">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2137", "所在机构")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</x:column>

							<x:column width="80">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2063", "所在部门")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</x:column>

							<x:column width="80">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1061", "人员类别")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personType}" />
							</x:column>
							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2139", "预计转正日期")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.planPassDate}" />
							</x:column>
							<x:column width="120">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2131", "转正倒计时天数")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.haveDays}" />
							</x:column>
							<x:column width="80">
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1051", "状态")%>
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
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>