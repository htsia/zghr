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
		window
				.showModalDialog(
						"/system/BookEdit.jsf",
						null,
						"dialogWidth:330px; dialogHeight:100px;center:center;resizable:no;status:no;scroll:no;");
		return true;
	}
	function forModify(bookID) {
		window
				.showModalDialog(
						"/system/BookEdit.jsf?bookID=" + bookID,
						null,
						"dialogWidth:300px; dialogHeight:100px;center:center;resizable:no;status:no;scroll:no;");
		return true;
	}
	function forModifyData(bookID, bookName) {
		window.showModalDialog("/system/BookItemList.jsf?bookID=" + bookID
				+ "&bookName=" + bookName, null, "dialogWidth:" + screen.width
				* 4 / 5 + "px; dialogHeight" + screen.height * 4 / 5
				+ ":px;center:center;resizable:no;status:no;scroll:no;");
		return false;
	}
</script>

<x:saveState value="#{sys_AddressBookBB}" />
<h:form id="form1">
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid styleClass="td_title" width="100%"
						border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF"
						columns="2">
						<h:panelGroup>
							<h:graphicImage value="/images/tips.gif" />
							<f:verbatim>
								<%=LanguageSupport.getResource("XTGL-0900",
									"ϵͳ���� ")%>->   
		                 <%=LanguageSupport.getResource("XTGL-1118",
									"ͨѶ¼ ")%>
							</f:verbatim>
						</h:panelGroup>

						<h:panelGrid align="right" columns="1" cellspacing="2" width="30%">
							<h:commandButton styleClass="button01" value="�½�"
								onclick="foradd()" />
						</h:panelGrid>

					</h:panelGrid> <f:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<x:dataTable id="bookListTable"
							value="#{sys_AddressBookBB.bookList}" var="list" align="center"
							headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="90%" rowIndexVar="rowdex">

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
						                 <%=LanguageSupport.getResource("XTGL-1099","��� ")%>  
						              </f:verbatim>
								</c:facet>
								<h:outputText value="#{rowdex+1}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								    <f:verbatim>
						                 <%=LanguageSupport.getResource("XTGL-1015","���� ")%>  
						              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.bookName}" />
							</h:column>


							<h:column>
								<c:facet name="header">
								       <%=LanguageSupport.getResource("YXGL-1026","����")%>  
									<h:outputText value="����" />
								</c:facet>
								<h:panelGrid columns="5" align="center" cellspacing="2">
									<h:outputText value="ϵͳԤ��ͨѶ¼" rendered="#{list.bookID=='-1'}"></h:outputText>
									<h:commandButton value="ɾ��" styleClass="button01"
										rendered="#{list.bookID!='-1'}"
										action="#{sys_AddressBookBB.Delete}"
										onclick="return confirm('ȷ��ɾ����')">
										<x:updateActionListener property="#{sys_AddressBookBB.bookID}"
											value="#{list.bookID}" />
									</h:commandButton>
									<h:commandButton value="�޸�����" styleClass="button01"
										rendered="#{list.bookID!='-1'}" action=""
										onclick="return forModify('#{list.bookID}')">
									</h:commandButton>
									<h:commandButton value="�޸�����" type="button"
										styleClass="button01" rendered="#{list.bookID!='-1'}"
										onclick="return forModifyData('#{list.bookID}','#{list.bookName}');">
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
