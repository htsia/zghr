<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function sel(code, vlaue) {
		window.returnValue = code + ":" + vlaue;
		window.close();
	}
</script>

<x:saveState value="#{fastcreatorgBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{fastcreatorgBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid width="98%" columns="2">

						<h:panelGrid align="right" columns="2">
							<h:panelGroup>
								<h:outputText value="记录数:#{fastcreatorgBB.mypage.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<h:outputText value="页数:#{fastcreatorgBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<h:outputText value="每页有#{fastcreatorgBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<h:outputText value="当前为第#{fastcreatorgBB.mypage.currentPage}页"></h:outputText>
								<h:commandButton value="首页" action="#{fastcreatorgBB.first}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="上页" action="#{fastcreatorgBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="下页" action="#{fastcreatorgBB.next}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="尾页" action="#{fastcreatorgBB.last}"
									styleClass="button01"></h:commandButton>
							</h:panelGroup>

						</h:panelGrid>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>
			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{fastcreatorgBB.templateList}" var="list"
							rowIndexVar="index" align="center" id="dateList"
							headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="90%">
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
								      <%=LanguageSupport.getResource("YXGL-1026"," 操作")%> : 
								    </f:verbatim>
								</c:facet>
								<c:verbatim>
									<a class="cursor:hand"
										onclick="sel('</c:verbatim><h:outputText value="#{list.templateName}"/><c:verbatim>','</c:verbatim><h:outputText value="#{list.templateId}"/><c:verbatim>')">选择</a>
								</c:verbatim>
							</h:column>
							<h:column>
								<c:facet name="header">
								     <f:verbatim>
								      <%=LanguageSupport.getResource("YXGL-1094"," 模板名称")%> : 
								    </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.templateName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
								      <%=LanguageSupport.getResource("XTGL-1354","创建时间")%> : 
								    </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.createDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
								      <%=LanguageSupport.getResource("XTGL-1015"," 描述")%> : 
								    </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.description}" />
							</h:column>
						</x:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
