<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
        function selPerson() {
        	fPopUpBackPerTreeDlg('');
        }
        function fPopUpMutiRoleDlg() {
            var obj1 = document.all(obj1);
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;

            retval = window.showModalDialog("/pages/custom/selRoleList.jsf", "", "dialogWidth:400px; dialogHeight:300px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            document.getElementById("form1:selectedRoleID").value=retval;
        }
 </script>
<x:saveState value="#{uploadReportBB}" />
<h:form id="form1">
<h:inputHidden value="#{uploadReportBB.scopeInit}" />
        <h:inputHidden id="remindID" value="#{uploadReportBB.operID}" />
        <h:inputHidden id="selectedRoleID" value="#{uploadReportBB.operRoleID}" />
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="�����ϴ� -> Ȩ������"/>
            </h:panelGroup>
        </h:panelGrid>

	<h:panelGrid columns="1" cellpadding="5" align="center" width="100%">
		<h:panelGrid width="98%" columns="1" align="center" rowClasses="left,left,left,left">
			
			<h:panelGrid columns="1" width="98%" >
				<h:panelGrid columns="2">
					<h:outputText value="Ȩ�����÷�ʽ"/>
					<h:selectOneRadio
						value="#{uploadReportBB.scopeType}"
						valueChangeListener="#{uploadReportBB.selChanged}"
						onclick="submit();">
						<f:selectItem itemValue="0" itemLabel="��  Ա" />
						<f:selectItem itemValue="1" itemLabel="��  ɫ" />
					</h:selectOneRadio>
				</h:panelGrid>

				<h:panelGrid columns="1" width="100%" rowClasses="center,center,center,center,center"
					rendered="#{uploadReportBB.scopeType=='0'}">
                    <h:panelGroup>
                         <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1351", "��������Ա")%>:
		                 </f:verbatim>
                        <h:commandButton value="ѡ����Ա"
                            onclick="return selPerson();"
                            action="#{uploadReportBB.addPerson}"
                            styleClass="button01" />
                    </h:panelGroup>
					<h:dataTable id="dataperson" value="#{uploadReportBB.personList}" var="person" headerClass="td_top"  styleClass="table03"
						width="100%" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" align="center">
						<h:column>
							<f:facet name="header">
							<h:outputText value="Ա�����"/>
							</f:facet>
							<h:outputText escape="false" value="#{person.pCode}" />
						</h:column>
						<h:column>
							<f:facet name="header">
							<h:outputText value="����"/>
							</f:facet>
							<h:outputText escape="false" value="#{person.name}" />
						</h:column>
						<h:column>
							<f:facet name="header">
							<h:outputText value="���ڵ�λ"/>
							</f:facet>
							<h:outputText escape="false" value="#{person.org}" />
						</h:column>
						<h:column>
							<f:facet name="header">
							<h:outputText value="���ڲ���"/>
							</f:facet>
							<h:outputText escape="false" value="#{person.dept}" />
						</h:column>
						<h:column>
							<f:facet name="header">
							  <f:verbatim>
		       			      <%=LanguageSupport.getResource("YXGL-1026", "����")%> 
		                     </f:verbatim>
							</f:facet>
							<h:commandButton onclick="return confirm('ȷ���Ƴ���');"
								action="#{uploadReportBB.deletePerson}" value="�� ��" styleClass="button01">
								<x:updateActionListener property="#{uploadReportBB.operUserID}" value="#{person.userID}" />
							</h:commandButton>
						</h:column>
					</h:dataTable>
				</h:panelGrid>

				<h:panelGrid columns="1" width="100%" rowClasses="left,left" headerClass="td_top"  styleClass="table03"
									rendered="#{uploadReportBB.scopeType=='1'}">
					<h:panelGroup>
					   <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1353", "�����õĽ�ɫ")%>:
		              </f:verbatim>
                        <h:commandButton value="ѡ���ɫ"
                            onclick="return fPopUpMutiRoleDlg();"
                            action="#{uploadReportBB.addRole}"
                            styleClass="button01" />
                    </h:panelGroup>
                    <h:dataTable id="datarole"
						value="#{uploadReportBB.roleList}" headerClass="td_top"  styleClass="table03"
						var="role" width="100%" columnClasses="td_middle_center,td_middle_center"
						align="center">
						<h:column>
							<f:facet name="header">
						   <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1064", "��ɫ����")%>:
		                   </f:verbatim>
							</f:facet>
							<h:outputText escape="false" value="#{role.roleName}" />
						</h:column>
						<h:column>
							<f:facet name="header">
						     <f:verbatim>
		       			      <%=LanguageSupport.getResource("YXGL-1026", "����")%>:
		                    </f:verbatim>
							</f:facet>
							<h:commandButton onclick="return confirm('ȷ���Ƴ���');"
								action="#{uploadReportBB.deleteRole}" value="�� ��" styleClass="button01">
								<x:updateActionListener property="#{uploadReportBB.operRoleID}" value="#{role.roleId}" />
							</h:commandButton>
						</h:column>
					</h:dataTable>
				</h:panelGrid>
			</h:panelGrid>

		</h:panelGrid>
		<h:panelGrid columns="3" cellpadding="5" align="center" >
			<h:commandButton value="  ��   ��  "
				action="#{uploadReportBB.saveScope}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>

<script type="text/javascript">
    setDataTableOver("form1:dataperson");
    setDataTableOver("form1:datarole");
</script>

