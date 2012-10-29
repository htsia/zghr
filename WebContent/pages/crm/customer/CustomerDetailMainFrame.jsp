<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<x:saveState value="#{actionBB}"></x:saveState>
<h:form>
	<h:inputHidden value="#{customerBB.frameInit}"></h:inputHidden>
	<%!String cuId = "";%>
	<%
	   cuId = (String) request.getAttribute("cuId");
	%>
	<h:inputHidden value="#{customerBB.cuId}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="102%"
		align="center">
		<h:panelGroup >
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="客户管理 - > 客户详情 "></h:outputText>
		</h:panelGroup>
	</h:panelGrid>
	
	<f:verbatim>
	<br>
		<table width="95%" align="center">
			<tr>
				<td id="private"  align="center" width="10%" class="activeTab" onclick="changePrivate()">  客户信息 </td>
				<td id="customer" align="center" width="10%" class='tab'       onclick="changeCustomer()"> 联系人信息   </td>
				<td id="action" align="center" width="10%" class='tab'       onclick="changeAction()"> 活动信息  </td>
				<td id="compe" align="center" width="10%" class='tab'       onclick="changeCompe()"> 竞争对象  </td>
			</tr>
		</table>
		<table width="100%" align="center">
			<tr>
				<td colspan="2"><iframe id="tree" frameborder="0"
					framespacing="0"
					src="/crm/customer/CustomerDetailInfo.jsf?cuId=<%=cuId%>"
					scrolling="no" width="100%" height="300%"> </iframe></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
	function changePrivate() {
		document.all("private").className = "activeTab";
		document.all("customer").className = "tab";
		document.all("action").className = "tab";
		document.all("compe").className = "tab";
		document.all("tree").src = "/crm/customer/CustomerDetailInfo.jsf?cuId=<%=cuId%>";
	}

	function changeCustomer() {
		document.all("private").className = "tab";
		document.all("customer").className = "activeTab";
		document.all("action").className = "tab";
		document.all("compe").className = "tab";
		document.all("tree").src = "/crm/customer/ContactDetailInfo.jsf?cuId=<%=cuId%>";
	}

	function changeAction() {
		document.all("private").className = "tab";
		document.all("customer").className = "tab";
		document.all("action").className = "activeTab";
		document.all("compe").className = "tab";
		document.all("tree").src = "/crm/customer/ActionDetailInfo.jsf?cuId=<%=cuId%>";
	}
	function changeCompe() {
		document.all("private").className = "tab";
		document.all("customer").className = "tab";
		document.all("action").className = "tab";
		document.all("compe").className = "activeTab"; 
		document.all("tree").src = "/crm/customer/CompetitionPersonMger.jsf?init=detail&cuidd=<%=cuId%>";
	}
</script>