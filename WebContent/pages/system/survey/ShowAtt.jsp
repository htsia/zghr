<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{self_surveyprocessBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{self_surveyprocessBB.showAtt}" />
	<c:verbatim>
		<table width="98%" height=98% align="center">
			<tr>
				<td align="right" height=8></c:verbatim> <h:commandButton
						styleClass="button01" id="close" type="button" value="取消返回"
						onclick="window.close();" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td valign="top">
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{self_surveyprocessBB.att}" var="slist"
							align="center" id="dateList" headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle" rowIndexVar="index"
							styleClass="table03" width="100%">

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
										    <%=LanguageSupport.getResource( "XTGL-1029", "序号")%>
								       </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.isRegName}">
								<c:facet name="header">
								 <f:verbatim>
										    <%=LanguageSupport.getResource( "XTGL-1398", "被调查人")%>
								 </f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.personName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
										    <%=LanguageSupport.getResource( "XTGL-1111", "内容")%>
								 </f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.textResult}" />
							</h:column>
						</x:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
	setDataTableOver("dateList");
</script>