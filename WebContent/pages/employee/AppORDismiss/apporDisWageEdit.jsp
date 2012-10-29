<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
   function modify(id){
       window.showModalDialog("/wage/adjust/CommonWageItemEdit.jsf?adjustID="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
       return true;
   }

</script>
<c:verbatim>
	<link href="/css/style.css" rel="stylesheet" type="text/css" />
</c:verbatim>
<x:saveState value="#{empApporDisWageMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{empApporDisWageMgrBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8 class=td_title></c:verbatim> <h:graphicImage
						value="/images/tips.gif" /> <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-0300", "人员管理 ")%>->
			 <%=LanguageSupport.getResource("RYGL-2031", "任免管理")%>
					</f:verbatim> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{empApporDisWageMgrBB.wageItemList}"
							var="list" align="center" id="dateList" headerClass="td_top"
							columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
							styleClass="table03" width="90%" rowIndexVar="index">

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
								 	<%=LanguageSupport.getResource( "YXGL-1035", "序号")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2041", "指标项")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fieldID}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2042", "指标名称")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fieldName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2043", "原值")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldValue}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<f:verbatim>
								 	<%=LanguageSupport.getResource( "JGGL-1101", "新值")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newValue}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
								 	<%=LanguageSupport.getResource( "YXGL-1026", "操作")%>
								</f:verbatim>
								</c:facet>
								<h:commandButton value="录入新值"
									onclick="return modify('#{list.adjustID}')" styleClass="button01"></h:commandButton>
								<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
									action="#{empApporDisWageMgrBB.delete}" styleClass="button01">
									<x:updateActionListener
										property="#{empApporDisWageMgrBB.itemId}"
										value="#{list.adjustID}" />
								</h:commandButton>
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
