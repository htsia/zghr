<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function OpenRpt(perID){
           if (document.all("form1:ReportID").value=="-1"){
               alert("����ѡ������ʽ��");
               return false;
           }
           doShowPersonTable(document.all("form1:ReportID").value,perID);
           return false;
        }
        function addWork() {
            window.showModalDialog("/employee/cadres/addWork.jsf", null, "dialogWidth:350px; dialogHeight:250px;center:center;resizable:no;status:no;");
            return true;
        }
        function doProcess(pid) {
            window.showModalDialog("/employee/cadres/processWorker.jsf?personID="+pid, null, "dialogWidth:350px; dialogHeight:250px;center:center;resizable:no;status:no;");
            return true;
        }
    </script>

<x:saveState value="#{emp_WorkImportBB}" />
<h:form id="form1">
	<h:inputHidden id="fromOrg" value="#{emp_WorkImportBB.pageInit}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<f:verbatim>
				<%=LanguageSupport.getResource("RYGL-0350","ͳһ�й�")%>
			</f:verbatim>
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid columns="2" width="95%" align="center">
		<h:panelGroup>
			<f:verbatim>
				<%=LanguageSupport.getResource("COMM-1048",
									"��")%>
			</f:verbatim>
			<h:outputText value="#{emp_WorkImportBB.pagevo.totalPage}"></h:outputText>
			<f:verbatim>
				<%=LanguageSupport.getResource("COMM-1047",
									"ҳ")%>
			</f:verbatim>
			<h:outputText value="  "></h:outputText>
			<f:verbatim>
				<%=LanguageSupport.getResource("COMM-1045",
									"ÿҳ��")%>
			</f:verbatim>
			<h:outputText value="#{emp_WorkImportBB.pagevo.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<f:verbatim>
				<%=LanguageSupport.getResource("COMM-1046",
									"��ǰΪ��")%>
			</f:verbatim>
			<h:outputText value="#{emp_WorkImportBB.pagevo.currentPage}"></h:outputText>
			<f:verbatim>
				<%=LanguageSupport.getResource("COMM-1047",
									"ҳ")%>
			</f:verbatim>

			<h:commandButton value="��ҳ" action="#{emp_WorkImportBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{emp_WorkImportBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{emp_WorkImportBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{emp_WorkImportBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>

		<h:panelGrid columns="4" align="right">
			<h:selectOneMenu id="ReportID" style="width:140px">
				<c:selectItems value="#{emp_WorkImportBB.reportList}" />
			</h:selectOneMenu>
			<h:commandButton value="����" styleClass="button01"
				action="#{emp_WorkImportBB.doQuery}" onclick="return addWork();"></h:commandButton>
		</h:panelGrid>
	</h:panelGrid>

	<h:panelGrid columns="1" cellspacing="2" width="95%" align="center">
		<h:dataTable value="#{emp_WorkImportBB.personList}" var="list"
			align="center" headerClass="td_top"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
					 <f:verbatim>
                      <%=LanguageSupport.getResource("RYGL-2148","��������")%>  
                    </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.addDate}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					 <f:verbatim>
                      <%=LanguageSupport.getResource("MSG-0010","����")%>
                    </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.name}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					 <f:verbatim>
                      <%=LanguageSupport.getResource("MSG-0012","�Ա�")%>
                    </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.sex}" />
			</h:column>

			<h:column>
				<c:facet name="header">
				 <f:verbatim>
                      <%=LanguageSupport.getResource("RYGL-1015","���֤��")%>  
                    </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.pid}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					 <f:verbatim>
                      <%=LanguageSupport.getResource("RYGL-2146","ԭ��λ")%>  
                    </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.oldOrg}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					 <f:verbatim>
                      <%=LanguageSupport.getResource("RYGL-2152","����䵥λ")%>  
                    </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.orgName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					 <f:verbatim>
                      <%=LanguageSupport.getResource("RYGL-2150","����״̬")%>  
                    </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.stautsDes}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					 <f:verbatim>
                      <%=LanguageSupport.getResource("YXGL-1026","����")%>  
                    </f:verbatim>
				</c:facet>
				<h:panelGroup>
					<h:commandButton styleClass="button01" type="button" value="��ӡ���"
						onclick="OpenRpt('#{list.personid}')"></h:commandButton>
					<h:commandButton styleClass="button01"
						action="#{emp_WorkImportBB.doQuery}" value="ҵ�����"
						rendered="#{list.stauts=='0' || list.stauts=='1'}"
						onclick="doProcess('#{list.personid}')"></h:commandButton>
					<h:commandButton styleClass="button01"
						action="#{emp_WorkImportBB.doDismiss}" value="����"
						rendered="#{list.stauts=='1'}">
						<x:updateActionListener
							property="#{emp_WorkImportBB.cadbo.personid}"
							value="#{list.personid}" />
					</h:commandButton>
				</h:panelGroup>
			</h:column>

		</h:dataTable>
	</h:panelGrid>
</h:form>
