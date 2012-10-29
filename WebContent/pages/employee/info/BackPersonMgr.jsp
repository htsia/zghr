<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function freeHoubei(id) {
    window.showModalDialog("/employee/info/RefusePerson.jsf?subId="+id, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selPerson(id) {
    window.showModalDialog("/employee/info/dupyPersonList.jsf?forId="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function addPerson() {
    window.showModalDialog("/employee/info/addReservePerson.jsf", null, "dialogWidth:600px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
</script>

<x:saveState value="#{empResverPersonMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{empResverPersonMgrBB.pageInit}" />
	<h:inputHidden id="personStr" value="" />
	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8>
					<table align="center" border="0" cellpadding="0" cellspacing="0"
						width=100% bgcolor="#FFFFFF">
						<tr>
							<td class=td_title></f:verbatim> <h:graphicImage
									value="/images/tips.gif" /> <f:verbatim>
									<%=LanguageSupport
							.getResource("RYGL-0330", "后备人才  ")%> ->
              <%=LanguageSupport
							.getResource("RYGL-0332", "后备人才管理")%>
								</f:verbatim> <f:verbatim>
							</td>
							<td align="right" class=td_title></td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td height=8>
					<table width="95%">
						<tr>
							<td align="right"></td>
							<td align="right"></f:verbatim> <h:panelGroup>
									<h:selectBooleanCheckbox
										value="#{empResverPersonMgrBB.sellAll}" onclick="submit();"
										valueChangeListener="#{empResverPersonMgrBB.queryAll}" />
									<f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2027",
								"全部显示")%>
									</f:verbatim>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1043",
								"记录数")%>:
                 </f:verbatim>
									<h:outputText
										value="#{empResverPersonMgrBB.mypage.totalRecord}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport
								.getResource("COMM-1044", "页数")%>:
                 </f:verbatim>
									<h:outputText value="#{empResverPersonMgrBB.mypage.totalPage}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1045",
								"每页有")%>:
                 </f:verbatim>
									<h:outputText value="#{empResverPersonMgrBB.mypage.pageSize}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1046",
								"当前为第")%>:
                 </f:verbatim>
									<h:outputText
										value="#{empResverPersonMgrBB.mypage.currentPage}"></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1047", "页")%>:
                 </f:verbatim>
									<h:commandButton value="首页"
										action="#{empResverPersonMgrBB.first}" styleClass="button01"></h:commandButton>
									<h:commandButton value="上页"
										action="#{empResverPersonMgrBB.pre}" styleClass="button01"></h:commandButton>
									<h:commandButton value="下页"
										action="#{empResverPersonMgrBB.next}" styleClass="button01"></h:commandButton>
									<h:commandButton value="尾页"
										action="#{empResverPersonMgrBB.last}" styleClass="button01"></h:commandButton>
									<h:outputText value="  "></h:outputText>
									<h:commandButton value="增加" onclick="return addPerson()"
										styleClass="button01"></h:commandButton>
								</h:panelGroup> <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<x:dataTable value="#{empResverPersonMgrBB.personList}" var="list"
							align="center" rowIndexVar="index" id="dateList"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<c:facet name="header">
								   <f:verbatim>
										 <%=LanguageSupport.getResource("YXGL-1035", "序号")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								        <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2271", "公司")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("GWGL-1017", "部门")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("MSG-0010", "姓名")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("MSG-0012", "性别")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.sex}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2270", "年龄")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.age}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2239", "学历")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.degraee}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2053", "籍贯")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.nativePlace}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2269", "入司时间")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.entComTime}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2268", "任现职时间")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.time}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2267", "培养前职务")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.preJob}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2266", "拟培养方向")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.forJob}" />
							</h:column>
							<h:column rendered="#{empResverPersonMgrBB.showAll=='1'}">
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2265", "退出时间")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.refuseTime}" />
							</h:column>
							<h:column rendered="#{empResverPersonMgrBB.showAll=='1'}">
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("RYGL-2264", "退出原因")%>
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.reson}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										 <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
                                   </f:verbatim>
								</c:facet>
								<h:commandButton value="取消后备"
									onclick="return freeHoubei('#{list.subId}')"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="选择责任人"
									onclick="return selPerson('#{list.subId}')"
									styleClass="button01"></h:commandButton>
							</h:column>
						</x:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>