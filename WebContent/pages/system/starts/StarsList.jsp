<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
        function foradd() {
            window.showModalDialog("/system/StarsEdit.jsf", null, "dialogWidth:"+screen.width*3/4+"px; dialogHeight:"+screen.height*3/4+"px;center:center;resizable:no;status:no;");
            return true;
        }
        function forModify(ID) {
            window.showModalDialog("/system/StarsEdit.jsf?ID="+ID, null, "dialogWidth:"+screen.width*3/4+"px; dialogHeight:"+screen.height*3/4+"px;center:center;resizable:no;status:no;");
            return true;
        }
        function showStars(ID){
            window.showModalDialog("/self/ShowStars.jsf?ID="+ID, null, "dialogWidth:250px; dialogHeight:250px;center:center;resizable:no;status:no;");
            return false;
        }
    </script>

<x:saveState value="#{sys_StarsBB}" />
<h:form id="form1">
	<f:verbatim>
		<table width=98% height=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid styleClass="td_title" width="100%"
						border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF"
						columns="2">
						<h:panelGroup>
							<h:graphicImage value="/images/tips.gif" />
							<f:verbatim>
								<%=LanguageSupport.getResource("XTGL-0900", "系统管理 ")%>-> 
                 				<%=LanguageSupport.getResource("XTGL-1098", "员工风采 ")%>
							</f:verbatim>
						</h:panelGroup>

						<h:panelGrid align="right" columns="1" cellspacing="2" width="30%">
							<h:commandButton styleClass="button01" value="新建"
								onclick="foradd()" />
						</h:panelGrid>
					</h:panelGrid> <f:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<x:dataTable id="bookListTable" value="#{sys_StarsBB.starsList}"
							var="list" align="center" headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="90%" rowIndexVar="rowdex">

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
					                 <%=LanguageSupport.getResource("XTGL-1099","序号 ")%>  
				                 </f:verbatim>
								</c:facet>
								<h:outputText value="#{rowdex+1}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
					                 <%=LanguageSupport.getResource("XTGL-1100","单位范围")%>  
				                    </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
					                 <%=LanguageSupport.getResource("MSG-0010","姓名")%>
				                    </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.persName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
					                 <%=LanguageSupport.getResource("XTGL-1101","是否显示")%>  
				                    </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.isShow}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
					                 <%=LanguageSupport.getResource("XTGL-1102","事迹")%>  
				                    </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.story}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
					                 <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
				                    </f:verbatim>
								</c:facet>
								<h:panelGrid columns="5" align="center" cellspacing="2">
									<h:commandButton value="显示效果" styleClass="button01"
										type="button" action=""
										onclick="return showStars('#{list.itemID}')">
									</h:commandButton>
									<h:commandButton value="删除" styleClass="button01"
										action="#{sys_StarsBB.Delete}"
										onclick="return confirm('确认删除？')">
										<x:updateActionListener property="#{sys_StarsBB.itemID}"
											value="#{list.itemID}" />
									</h:commandButton>
									<h:commandButton value="修改" styleClass="button01" action=""
										onclick="return forModify('#{list.itemID}')">
									</h:commandButton>
								</h:panelGrid>
							</h:column>
						</x:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:bookListTable");
</script>