<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim>
	<link href="/css/style.css" rel="stylesheet" type="text/css" />
</c:verbatim>
<x:saveState value="#{orgtemppostlistBB}"></x:saveState>

<h:form id="form1">
	<h:inputHidden value="#{orgtemppostlistBB.ininPage}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid width="98%" columns="2">
						<h:panelGrid align="left" columns="2">
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"JGGL-1092", "当前机构")%>:
                                 </f:verbatim>
								<h:outputText value="#{orgtemppostlistBB.orgName}"></h:outputText>
							</h:panelGroup>

						</h:panelGrid>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{orgtemppostlistBB.postList}" var="list"
							align="center" id="dateList" headerClass="td_top"
							columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
							styleClass="table03" width="90%">

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
									<%=LanguageSupport.getResource(
										"JGGL-1078", "岗位名称")%>  :
                                 </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
									<%=LanguageSupport.getResource(
										"JGGL-1024", "所属机构")%>  :
                                 </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgId}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
									<%=LanguageSupport.getResource(
										"JGGL-1093", "岗位类型")%>  :
                                     </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.postClass}" />
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
