<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function addConPost(){
         window.showModalDialog("/custom/emp/conPostAdd.jsf?act=init", "", "dialogWidth:365px; dialogHeight:270px; status:0;resizable:yes");
         return true;
     }
</script>

<x:saveState value="#{emp_conPostBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emp_conPostBB.pageInit}"></h:inputHidden>
	<h:inputHidden value="#{emp_conPostBB.superID}"></h:inputHidden>
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8px align="right">
    </f:verbatim>
                   <h:commandButton value="增加"	styleClass="button01" onclick="return addConPost();"></h:commandButton>
					<f:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable value="#{emp_conPostBB.list}" var="list"
							align="center" id="dateList" headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
							styleClass="table03" width="90%">
							<h:column>
								<c:facet name="header">
								<h:outputText value="员工编号"/>
								</c:facet>
								<h:outputText value="#{list.pCode}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="姓名"/>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="兼职单位"/>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="兼职部门"/>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="兼职岗位"/>
								</c:facet>
								<h:outputText value="#{list.postName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="操作"/>
								</c:facet>
								<h:commandButton value="取消兼职" styleClass="button01"
									onclick="return confirm('确定取消吗?');" action="#{emp_conPostBB.cancel}">
									<x:updateActionListener value="#{list.id}" property="#{emp_conPostBB.operUserID}"/>
									<x:updateActionListener value="#{list.conPostID}" property="#{emp_conPostBB.operConPostID}"/>
								</h:commandButton>
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
