<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<x:saveState value="#{sys_RemindSelectBackingBean}" />
<h:form id="form1">
    <h:inputHidden value="#{sys_RemindSelectBackingBean.pageInit}" />
    <h:inputHidden value="#{sys_RemindSelectBackingBean.remindId}" />
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1355", " 人员选择")%>
			</f:verbatim>
        </h:panelGroup>
    </h:panelGrid>

	<h:panelGrid columns="1" cellpadding="5" align="center" width="100%">
		<h:panelGrid width="95%" columns="1" align="center"
			rowClasses="left,left,left,left">
			<h:panelGrid columns="1" width="100%" rowClasses="left,left" 				>
				<h:panelGroup>
			   <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1356", " 人员姓名或编号")%>：
			  </f:verbatim>
                    <h:inputText id="name" value="#{sys_RemindSelectBackingBean.name}"
                                    size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
					<h:commandButton value="查询人员"
						action="#{sys_RemindSelectBackingBean.queryHrPerson}"
						styleClass="button01" />
					<f:verbatim>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</f:verbatim>
					<h:commandButton value="选 择" action="#{sys_RemindSelectBackingBean.selHR}" styleClass="button01" />

				</h:panelGroup>

				<f:verbatim>
						&nbsp;
					</f:verbatim>

				<h:dataTable value="#{sys_RemindSelectBackingBean.hrList}"
					var="hrList" width="100%" columnClasses="center,left,left,left"  headerClass="td_top"  styleClass="table03"
					align="center">
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
					        <%=LanguageSupport.getResource("XTGL-1352", " 人员姓名")%>：
						  </f:verbatim>
						</f:facet>
						<h:outputText escape="false" value="#{hrList.remToName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
						 <f:verbatim>
					        <%=LanguageSupport.getResource("XTGL-1183", " 机构")%>：
						  </f:verbatim>
						</f:facet>
						<h:outputText escape="false" value="#{hrList.orgName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<f:verbatim>
					        <%=LanguageSupport.getResource("YXGL-1029", " 部门")%>：
						  </f:verbatim>
						</f:facet>
						<h:outputText value="#{hrList.deptName}" />
					</h:column>
				</h:dataTable>

			</h:panelGrid>

		</h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>

	</h:panelGrid>

</h:form>
