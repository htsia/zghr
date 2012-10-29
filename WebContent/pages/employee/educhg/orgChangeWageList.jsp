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
	   window.showModalDialog("/employee/title/orgWageItemEdit.jsf?itemId="+id, null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
	   return true;
   }

</script>
<c:verbatim>
	<link href="/css/style.css" rel="stylesheet" type="text/css" />
</c:verbatim>
<x:saveState value="#{empEduChangeMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{empEduChangeMgrBB.initOrgWageList}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td class=td_title height=8></c:verbatim> <h:graphicImage
						value="/images/tips.gif" /> <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-0300", "人员管理 ")%>->
                       <%=LanguageSupport
							.getResource("RYGL-2237", "薪资规则设定")%>
					</f:verbatim> <c:verbatim>
				</td>
			</tr>
			<tr>
				<td height=8 align="right"></td>
			</tr>
			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{empEduChangeMgrBB.orgWageItemList}"
							var="list" align="center" id="dateList" headerClass="td_top"
							columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
							styleClass="table03" width="90%" rowIndexVar="index">

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1029", "序号")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2005", "项目")%>
							   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.wageItem}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
								 	<%=LanguageSupport.getResource( "RYGL-2108", "项目名称")%>
							   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.wageItemDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
								 	<%=LanguageSupport.getResource( "XTGL-1002", "类型")%>
							   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.typeDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								   <f:verbatim>
								 	<%=LanguageSupport.getResource( "XTGL-1157", "顺序")%>
							   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.wageOrder}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									 <f:verbatim>
						     		<%=LanguageSupport.getResource("YXGL-1026", "操作")%>
					            </f:verbatim>
								</c:facet>
								<h:commandButton value="修改"
									onclick="return modify('#{list.itemId}')" styleClass="button01"></h:commandButton>
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
