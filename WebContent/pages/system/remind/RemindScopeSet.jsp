<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
        function fPopUpMutiPerDlg(obj1, obj2) {
            window.showModalDialog("/system/RemindSelectPeople.jsf?remindId="+document.all("form1:remindID").value, "", "dialogWidth:600px; dialogHeight:300px; center:center; status:0;resizable:yes");
        }
        function fPopUpMutiRoleDlg(obj1, obj2) {
            var obj1 = document.all(obj1);
            var obj2 = document.all(obj2);
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;

            retval = window.showModalDialog("/system/RemindSelectRole.jsf", "", "dialogWidth:600px; dialogHeight:300px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                rs = retval.split("||");
                if (obj2 != null) {
                    obj1.value = rs[1];
                    obj2.value = rs[0];

                } else {
                    obj1.value = rs[1];
                    obj1.code = rs[0];
                }
            }
        }
        
        function clearws() {
		    document.getElementById("checkSubmitFlg").value="0"; 
        }
        
        function clearStatew() {
            setInterval("clearws()",2000);
        }
 </script>
<x:saveState value="#{sys_RemindScopeSetBackingBean}" />
<h:form id="form1">
<h:inputHidden value="#{sys_RemindScopeSetBackingBean.pageInit}" />
        <h:inputHidden id="remindID" value="#{sys_RemindScopeSetBackingBean.remindID}" />
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-0900", "系统管理 ")%>->
		        <%=LanguageSupport.getResource("XTGL-1348", "提醒应用范围设置")%>
			</f:verbatim>
            </h:panelGroup>
        </h:panelGrid>

	<h:panelGrid columns="1" cellpadding="5" align="center" width="100%">
		<h:panelGrid width="98%" columns="1" align="center" 	rowClasses="left,left,left,left">
			<h:panelGrid columns="1" width="100%" >
				<h:panelGroup>
				  <f:verbatim>
				      <strong>
		       			 <%=LanguageSupport.getResource("XTGL-1349", "提醒名称")%>:
				      </strong>
		          </f:verbatim>
                <h:outputText escape="false"
                        value="#{sys_RemindScopeSetBackingBean.remindName}" />
				</h:panelGroup>

                <h:panelGroup>
                  <f:verbatim>
				      <strong>
		       			 <%=LanguageSupport.getResource("XTGL-1125", "条件说明")%>:
				     </strong>
		          </f:verbatim>
				<h:outputText escape="false"
					value="#{sys_RemindScopeSetBackingBean.remindCondDesc}" />
				</h:panelGroup>
			</h:panelGrid>
			
			<h:panelGrid columns="1" width="98%" >
				<h:panelGrid columns="2">
				  <f:verbatim>
		       			 <%=LanguageSupport.getResource("XTGL-1350", "提醒对象")%>:
		          </f:verbatim>
					<h:selectOneRadio
						value="#{sys_RemindScopeSetBackingBean.remToType}"
						valueChangeListener="#{sys_RemindScopeSetBackingBean.selChanged}"
						onclick="submit();">
						<f:selectItem itemValue="01" itemLabel="人  员" />
						<f:selectItem itemValue="02" itemLabel="角  色" />
					</h:selectOneRadio>
				</h:panelGrid>

				<h:panelGrid columns="1" width="100%" rowClasses="left,left"
					rendered="#{sys_RemindScopeSetBackingBean.hrOrRole}">
                    <h:panelGroup>
                         <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1351", "已设置提醒的人员")%>:
		                 </f:verbatim>
                        <h:commandButton value="选择人员"
                            onclick="clearws();return fPopUpMutiPerDlg();"
                            action="#{sys_RemindScopeSetBackingBean.selectHRPeople}"
                            styleClass="button01" />
                    </h:panelGroup>
					<h:dataTable id="dataperson"
						value="#{sys_RemindScopeSetBackingBean.hrRemToList}" var="hrList" headerClass="td_top"  styleClass="table03"
						width="100%" columnClasses="td_middle_center,td_middle,td_middle_center" align="center">
						<h:column>
							<f:facet name="header">
								<f:verbatim escape="false">
									<input type="checkbox" name="chkAllHr2" 
										onclick="selectAll(document.form1.chkAllHr2,document.form1.perId)" />
								</f:verbatim>
							</f:facet>
							<f:verbatim escape="false">
								<input type="checkbox" name="perId" 
									value="</f:verbatim><h:outputText value="#{hrList.remToID}"/><f:verbatim>">
							</f:verbatim>
						</h:column>

						<h:column>
							<f:facet name="header">
							  <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1352", "人员姓名")%> 
		                     </f:verbatim>
							</f:facet>
							<h:outputText escape="false" value="#{hrList.remToName}" />
						</h:column>

						<h:column>
							<f:facet name="header">
							  <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1183", "机构")%> 
		                     </f:verbatim>
							</f:facet>
							<h:outputText escape="false" value="#{hrList.orgName}" />
						</h:column>

						<h:column>
							<f:facet name="header">
							  <f:verbatim>
		       			      <%=LanguageSupport.getResource("YXGL-1029", "部门")%> 
		                     </f:verbatim>
							</f:facet>
							<h:outputText value="#{hrList.deptName}" />
						</h:column>
						
						<h:column>
							<f:facet name="header">
							  <f:verbatim>
		       			      <%=LanguageSupport.getResource("YXGL-1026", "操作")%> 
		                     </f:verbatim>
							</f:facet>
							<h:commandLink 
								action="#{sys_RemindScopeSetBackingBean.moveHrPeople}" value="移 除">
								<x:updateActionListener
									property="#{sys_RemindScopeSetBackingBean.moveId}"
									value="#{hrList.remToID}" />
							</h:commandLink>
						</h:column>
					</h:dataTable>
				</h:panelGrid>

				<h:panelGrid columns="1" width="100%" rowClasses="left,left" headerClass="td_top"  styleClass="table03"
									rendered="#{!sys_RemindScopeSetBackingBean.hrOrRole}">
					<h:panelGroup>
					   <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1353", "已设置提醒对象的角色")%>:
		              </f:verbatim>
                        <h:commandButton value="选择角色"
                            onclick="clearws();return fPopUpMutiRoleDlg();"
                            action="#{sys_RemindScopeSetBackingBean.selectRole}"
                            styleClass="button01" />
                    </h:panelGroup>
                    <h:dataTable   id="datarole"
						value="#{sys_RemindScopeSetBackingBean.roleRemToList}"   headerClass="td_top"  styleClass="table03"
						var="roleList" width="100%" columnClasses="td_middle_center,td_middle,td_middle_center"
						align="center">
						<h:column>
							<f:facet name="header">
								<f:verbatim escape="false">
									<input type="checkbox" name="chkAllRole" 
										onclick="selectAll(document.form1.chkAllRole,document.form1.roleIds)" />
								</f:verbatim>
							</f:facet>
							<f:verbatim escape="false">
								<input type="checkbox" name="roleIds" 
									value="</f:verbatim><h:outputText value="#{roleList.roleId}"/><f:verbatim>">
							</f:verbatim>
						</h:column>

						<h:column>
							<f:facet name="header">
						   <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1064", "角色名称")%>:
		                   </f:verbatim>
							</f:facet>
							<h:outputText escape="false" value="#{roleList.roleName}" />
						</h:column>

						<h:column>
							<f:facet name="header">
						   <f:verbatim>
		       			      <%=LanguageSupport.getResource("XTGL-1354", "创建时间")%>:
		                   </f:verbatim>
							</f:facet>
							<h:outputText escape="false" value="#{roleList.createTime}" />
						</h:column>
						
						<h:column>
							<f:facet name="header">
						     <f:verbatim>
		       			      <%=LanguageSupport.getResource("YXGL-1026", "操作")%>:
		                    </f:verbatim>
							</f:facet>
							<h:commandLink 
								action="#{sys_RemindScopeSetBackingBean.moveRole}" value="移 除">
								<x:updateActionListener
									property="#{sys_RemindScopeSetBackingBean.moveId}"
									value="#{roleList.roleId}" />
							</h:commandLink>
						</h:column>
					</h:dataTable>

					<f:verbatim>
						&nbsp;
					</f:verbatim>
				</h:panelGrid>
			</h:panelGrid>

		</h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>
		<h:panelGrid columns="3" cellpadding="5" align="right" >
			<h:commandButton value="保 存"
				action="#{sys_RemindScopeSetBackingBean.saveRemindScope}"
				styleClass="button01" />
			<f:verbatim>
					&nbsp;
				</f:verbatim>
		</h:panelGrid>
	</h:panelGrid>
</h:form>

<script type="text/javascript">
    setDataTableOver("form1:dataperson");
    setDataTableOver("form1:datarole");
</script>

