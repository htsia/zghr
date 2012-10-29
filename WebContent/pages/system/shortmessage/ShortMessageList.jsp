<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	request.setCharacterEncoding("gb2312");
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function groupSendMessage() {
		window
				.showModalDialog(
						"/system/GroupSendMessage.jsf",
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function manGroup() {
		window
				.showModalDialog(
						"/system/GroupList.jsf",
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		return false;
	}
	function doView(id) {
		window
				.showModalDialog(
						"/system/ViewMessage.jsf?smID=" + id,
						null,
						"dialogWidth:500px; dialogHeight:320px;center:center;resizable:yes;status:no;scroll:yes;");
		return false;
	}
</script>

<x:saveState value="#{sys_smListBackingBean}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{sys_smListBackingBean.pageInit}" />

	<h:panelGrid align="center" styleClass="td_title" width="100%"
		border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF"
		columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<f:verbatim>
				<%=LanguageSupport.getResource("XTGL-1366",
									"在线消息")%>
			</f:verbatim>
		</h:panelGroup>

		<h:panelGrid columns="1" align="right">
			<h:panelGroup>
				<h:selectOneMenu value="#{sys_smListBackingBean.mailBox}"
					onchange="submit();"
					valueChangeListener="#{sys_smListBackingBean.changeBox}">
					<c:selectItem itemLabel="收件箱" itemValue="0"></c:selectItem>
					<c:selectItem itemLabel="发件箱" itemValue="1"></c:selectItem>
				</h:selectOneMenu>
				<c:verbatim>&nbsp;&nbsp;</c:verbatim>
				<h:commandButton value="发信" styleClass="button01"
					onclick="sendMessage('','');"></h:commandButton>
				<h:commandButton value="管理群" type="button"
					rendered="#{sys_smListBackingBean.useGroup}" styleClass="button01"
					onclick="manGroup();"></h:commandButton>
				<h:commandButton value="群发" type="button" styleClass="button01"
					onclick="groupSendMessage();"></h:commandButton>
				<h:commandButton value="关闭" type="button" styleClass="button01"
					onclick="window.close();"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>

	</h:panelGrid>

	<h:panelGrid columns="1" width="98%" align="center">
		<h:dataTable value="#{sys_smListBackingBean.smList}" var="list"
			align="center" id="dateList" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
				 <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1243", "时间")%>
			    </f:verbatim> 
				</c:facet>
				<h:outputText value="#{list.sendTime}" />
			</h:column>
			<h:column>
				<c:facet name="header">
				 <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1304", "发送人")%>
			    </f:verbatim> 
				</c:facet>
				<h:outputText value="#{list.sendName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
			    <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1303", "收信人")%>
			    </f:verbatim> 
				</c:facet>
				<h:outputText value="#{list.receiveName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
			    <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1320", "附件")%>
			    </f:verbatim> 
				</c:facet>
				<h:outputLink value="/file/shortmessage/#{list.att_file}"
					target="blank">
					<h:outputText value="#{list.att_file}"></h:outputText>
				</h:outputLink>
			</h:column>

			<h:column>
				<c:facet name="header">
				 <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1111", "内容")%>
			    </f:verbatim> 
				</c:facet>
				<h:outputText value="#{list.content}" />
			</h:column>

			<h:column>
				<c:facet name="header">
				  <f:verbatim>
		        <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
			    </f:verbatim> 
				</c:facet>
				<h:commandButton value="查看" styleClass="button01"
					onclick="doView('#{list.smID}')"></h:commandButton>
			</h:column>
		</h:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>