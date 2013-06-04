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
            <h:outputText value="报表上传 -> 权限设置"/>
            </h:panelGroup>
        </h:panelGrid>

	<h:panelGrid columns="1" cellpadding="5" align="center" width="100%">
		<h:panelGrid width="98%" columns="1" align="center" rowClasses="left,left,left,left">
			
			<h:panelGrid columns="1" width="98%" >
				<h:panelGrid columns="2">
					<h:outputText value="权限设置方式"/>
					<h:selectOneRadio
						value="#{uploadReportBB.scopeType}"
						valueChangeListener="#{uploadReportBB.selChanged}"
						onclick="submit();">
						<f:selectItem itemValue="0" itemLabel="人  员" />
						<f:selectItem itemValue="1" itemLabel="角  色" />
					</h:selectOneRadio>
				</h:panelGrid>

				<h:panelGrid columns="1" width="100%" rowClasses="center,center,center,center,center"
					rendered="#{uploadReportBB.scopeType=='0'}">
                    <h:panelGroup>
                         <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1351", "已设置人员")%>:
		                 </f:verbatim>
                        <h:commandButton value="选择人员"
                            onclick="return selPerson();"
                            action="#{uploadReportBB.addPerson}"
                            styleClass="button01" />
                    </h:panelGroup>
					<h:dataTable id="dataperson" value="#{uploadReportBB.personList}" var="person" headerClass="td_top"  styleClass="table03"
						width="100%" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" align="center">
						<h:column>
							<f:facet name="header">
							<h:outputText value="员工编号"/>
							</f:facet>
							<h:outputText escape="false" value="#{person.pCode}" />
						</h:column>
						<h:column>
							<f:facet name="header">
							<h:outputText value="姓名"/>
							</f:facet>
							<h:outputText escape="false" value="#{person.name}" />
						</h:column>
						<h:column>
							<f:facet name="header">
							<h:outputText value="所在单位"/>
							</f:facet>
							<h:outputText escape="false" value="#{person.org}" />
						</h:column>
						<h:column>
							<f:facet name="header">
							<h:outputText value="所在部门"/>
							</f:facet>
							<h:outputText escape="false" value="#{person.dept}" />
						</h:column>
						<h:column>
							<f:facet name="header">
							  <f:verbatim>
		       			      <%=LanguageSupport.getResource("YXGL-1026", "操作")%> 
		                     </f:verbatim>
							</f:facet>
							<h:commandButton onclick="return confirm('确定移除吗');"
								action="#{uploadReportBB.deletePerson}" value="移 除" styleClass="button01">
								<x:updateActionListener property="#{uploadReportBB.operUserID}" value="#{person.userID}" />
							</h:commandButton>
						</h:column>
					</h:dataTable>
				</h:panelGrid>

				<h:panelGrid columns="1" width="100%" rowClasses="left,left" headerClass="td_top"  styleClass="table03"
									rendered="#{uploadReportBB.scopeType=='1'}">
					<h:panelGroup>
					   <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1353", "已设置的角色")%>:
		              </f:verbatim>
                        <h:commandButton value="选择角色"
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
		       			      <%=LanguageSupport.getResource("XTGL-1064", "角色名称")%>:
		                   </f:verbatim>
							</f:facet>
							<h:outputText escape="false" value="#{role.roleName}" />
						</h:column>
						<h:column>
							<f:facet name="header">
						     <f:verbatim>
		       			      <%=LanguageSupport.getResource("YXGL-1026", "操作")%>:
		                    </f:verbatim>
							</f:facet>
							<h:commandButton onclick="return confirm('确定移除吗');"
								action="#{uploadReportBB.deleteRole}" value="移 除" styleClass="button01">
								<x:updateActionListener property="#{uploadReportBB.operRoleID}" value="#{role.roleId}" />
							</h:commandButton>
						</h:column>
					</h:dataTable>
				</h:panelGrid>
			</h:panelGrid>

		</h:panelGrid>
		<h:panelGrid columns="3" cellpadding="5" align="center" >
			<h:commandButton value="  保   存  "
				action="#{uploadReportBB.saveScope}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>

<script type="text/javascript">
    setDataTableOver("form1:dataperson");
    setDataTableOver("form1:datarole");
</script>

