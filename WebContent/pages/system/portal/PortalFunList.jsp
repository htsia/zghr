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
        window.showModalDialog("/system/PortalFunEdit.jsf", null, "dialogWidth:400px; dialogHeight:310px;center:center;resizable:no;status:no;");
        return true;
    }
    function forModify(ID) {
        window.showModalDialog("/system/PortalFunEdit.jsf?ID="+ID, null, "dialogWidth:400px; dialogHeight:310px;center:center;resizable:no;status:no;");
        return true;
    }
</script>

<x:saveState value="#{sys_portalBB}" />
<h:form id="form1">
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<f:verbatim>
				<%=LanguageSupport.getResource("XTGL-0900",
									"系统管理 ")%>->  
		                 <%=LanguageSupport.getResource("XTGL-1122",
									"门户应用")%>
			</f:verbatim>
		</h:panelGroup>

		<h:panelGrid align="right" columns="1" cellspacing="2" width="30%">
			<h:commandButton styleClass="button01" value="新建" onclick="foradd();" />
		</h:panelGrid>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6"
		columns="1">
		<x:dataTable id="ListTable" value="#{sys_portalBB.portList}"
			var="list" align="center" headerClass="td_top"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
			styleClass="table03" width="90%" rowIndexVar="rowdex">

			<h:column>
				<c:facet name="header">
				     <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1105","序号")%>  
		               </f:verbatim>
				</c:facet>
				<h:outputText value="#{rowdex+1}" />
			</h:column>

			<h:column>
				<c:facet name="header">
			      	<f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1015","描述")%>  
		               </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.itemName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="URL" />
				</c:facet>
				<h:outputText value="#{list.url}" />
			</h:column>

			<h:column>
				<c:facet name="header">
				    	<f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1104","链接图片")%>  
		               </f:verbatim>
				</c:facet>
				<h:graphicImage value="/images/maininterface/portal/#{list.icon}" />
			</h:column>

			<h:column>
				<c:facet name="header">
				    <f:verbatim>
		                  <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
		               </f:verbatim>
				</c:facet>
				<h:panelGrid columns="5" align="center" cellspacing="2">
					<h:commandButton value="删除" styleClass="button01"
						action="#{sys_portalBB.Delete}" onclick="return confirm('确认删除？')">
						<x:updateActionListener property="#{sys_portalBB.itemID}"
							value="#{list.itemID}" />
					</h:commandButton>
					<h:commandButton value="修改" styleClass="button01" action=""
						onclick="return forModify('#{list.itemID}')">
					</h:commandButton>
				</h:panelGrid>
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:ListTable");
</script>
