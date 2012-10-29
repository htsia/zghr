<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function add() {
    window.showModalDialog("/run/dataexchange/systemEdit.jsf?new=true", null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function modify(id){
	window.showModalDialog("/run/dataexchange/systemEdit.jsf?sysId="+id, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function fabu(id){
	window.showModalDialog("/run/dataexchange/sendList.jsf?sysId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function dingyue(id){
	window.showModalDialog("/run/dataexchange/receivList.jsf?sysId="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}

</script>

<x:saveState value="#{regSystemMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{regSystemMgrBB.pageInit}" />
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
									<%=LanguageSupport.getResource("YXGL-0880",
							"数据交换平台 ")%> ->
            			 <%=LanguageSupport.getResource("YXGL-0881", "系统登记")%>
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
							 <f:verbatim>
                                  <%=LanguageSupport.getResource("COMM-1043","记录数:")%>
                              </f:verbatim>
									<h:outputText value="#{regSystemMgrBB.mypage.totalRecord}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									 <f:verbatim>
                                  <%=LanguageSupport.getResource("COMM-1044","页数:")%>
                              </f:verbatim>
									<h:outputText value="#{regSystemMgrBB.mypage.totalPage}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									 <f:verbatim>
                                  <%=LanguageSupport.getResource("COMM-1045","每页有")%>
                              </f:verbatim>
									<h:outputText value="#{regSystemMgrBB.mypage.pageSize}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									 <f:verbatim>
                                  <%=LanguageSupport.getResource("COMM-1046","当前为第")%>
                              </f:verbatim>
									<h:outputText value="#{regSystemMgrBB.mypage.currentPage}"></h:outputText>
									 <f:verbatim>
                                  <%=LanguageSupport.getResource("COMM-1047","页")%>
                              </f:verbatim>
									<h:commandButton value="首页" action="#{regSystemMgrBB.first}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="上页" action="#{regSystemMgrBB.pre}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="下页" action="#{regSystemMgrBB.next}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="尾页" action="#{regSystemMgrBB.last}"
										styleClass="button01"></h:commandButton>
									<h:outputText value="  "></h:outputText>
									<h:commandButton value="增加" styleClass="button01"
										onclick="return add()" />
								</h:panelGroup> <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<x:dataTable value="#{regSystemMgrBB.systemList}" var="list"
							align="center" id="dateList" rowIndexVar="index"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="1500">
							<x:column width="250">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1026","操作")%>
                              </f:verbatim>
								</c:facet>
								<h:commandButton value="修改" styleClass="button01"
									onclick="return modify('#{list.sysId}');" />
								<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
									action="#{regSystemMgrBB.delete}" styleClass="button01">
									<x:updateActionListener property="#{regSystemMgrBB.sysId}"
										value="#{list.sysId}" />
								</h:commandButton>
								<h:commandButton value="发布产品" styleClass="button01"
									onclick="return fabu('#{list.sysId}');" />
								<h:commandButton value="订阅产品" styleClass="button01"
									onclick="return dingyue('#{list.sysId}');" />
							</x:column>
                            
                            <x:column width="40">
								<c:facet name="header">
								 <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1035","序号")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</x:column>

							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1036","系统编号")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.sysId}" />
							</x:column>

							<x:column width="200">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1037","系统名称")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.sysName}" />
							</x:column>

							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1008","数据库类别")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.dbTypeName}" />
							</x:column>
							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1038","数据库服务器")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.dbHost}" />
							</x:column>
							<x:column width="40">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1039","端口")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.dbPort}" />
							</x:column>

							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1040","数据库名称")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.dbName}" />
							</x:column>

							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1041","数据库用户")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.dbUser}" />
							</x:column>
							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1048","产品投递地址")%>
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.postAdd}" />
							</x:column>
							<x:column width="100">
								<c:facet name="header">
								<f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1049","登录用户")%>  
                              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.loginUser}" />
							</x:column>

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