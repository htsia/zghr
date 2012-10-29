<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/check.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script type="text/javascript">
         function sel() {
            if (checkMutilSelect(document.form1.reId)) {
                if(confirm('确认删除？')) {
                    return true;
                 }else{
                    return false
                }
            } else {
                alert("请选择删除项！")
                return false;
            }
        }
    </script>

<x:saveState value="#{org_orgLineBB}" />
<h:form id="form1">
	<h:inputHidden value="#{org_orgLineBB.pageInit}" />
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif" alt="">
					<%=LanguageSupport.getResource("JGGL-0113",
							"  部门隶属关系")%></td>
			</tr>
		</table>
		<br>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_page" align="left"></f:verbatim> <f:verbatim>
						<%=LanguageSupport.getResource("JGGL-1051", "本级部门：")%>
					</f:verbatim> <h:inputText id="deptId" value="#{org_orgLineBB.deptId}" size="20"
						styleClass="input" code="" dict="yes" dict_num="OU" /> <h:commandButton
						type="button" onclick="PopUpOrgDlg('form1:deptId',2,'')"
						styleClass="button_select" /> <f:verbatim>
						<%=LanguageSupport.getResource("JGGL-1052",
							"上级隶属关系部门：")%>
					</f:verbatim> 
				    <h:inputText
						id="superDeptId" value="#{org_orgLineBB.superDeptId}" size="20"
						styleClass="input" code="" dict="yes" dict_num="OU" /> <h:commandButton
						type="button" onclick="PopUpOrgDlg('form1:superDeptId')"
						styleClass="button_select" /> <h:commandButton
						styleClass="button01"
						onclick="return forsubmit(document.forms(0))" value=" 新增 "
						action="#{org_orgLineBB.createRelation}" /> <h:commandButton
						styleClass="button01" onclick="return sel()"
						action="#{org_orgLineBB.deleteRelation}" value=" 删除 " /> <f:verbatim>
				</td>
			</tr>
		</table>
		<br>
		<table width="95%" border="0" cellpadding="0" cellspacing="0"
			align="center">
			<tr>
				<td></f:verbatim> <h:dataTable width="100%" value="#{org_orgLineBB.orlist}"
						var="list" border="0" id="dateList"
						columnClasses="td_middle_center" headerClass="td_top"
						rowClasses="td_middle" styleClass="table03">
						<h:column>
							<c:facet name="header">
								<c:verbatim escape="false">
									<input type="checkbox" name="chkAll"
										onclick="selectAll(document.form1.chkAll,document.form1.reId)" />
								</c:verbatim>
							</c:facet>
							<c:verbatim escape="false">
								<div align=center>
									<input type="checkbox" name="reId"
										value="</c:verbatim>
                        <h:outputText value="#{list.relationId}"/><c:verbatim>">
								</div>
							</c:verbatim>
						</h:column>
						<h:column>
							<c:facet name="header">
							   <f:verbatim>
							    <%=LanguageSupport.getResource("JGGL-1051","本级部门")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.deptId}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							 <f:verbatim>
							    <%=LanguageSupport.getResource("JGGL-1053","本级部门所属机构")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.orgId}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							 <f:verbatim>
							    <%=LanguageSupport.getResource("JGGL-1052","上级隶属关系部门")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.superDeptId}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							 <f:verbatim>
							    <%=LanguageSupport.getResource("JGGL-1055","上级隶属关系部门所属机构")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.superOrgId}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							 <f:verbatim>
							    <%=LanguageSupport.getResource("JGGL-1056","设置日期")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.setDate}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							 <f:verbatim>
							    <%=LanguageSupport.getResource("JGGL-1057","设置人")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.setPerson}" />
						</h:column>
					</h:dataTable> <f:verbatim>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript>">
    interpret(document.forms(0));
    setDataTableOver("form1:dateList");
</script>
