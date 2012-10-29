<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<x:saveState value="#{actionBB}"></x:saveState>
<h:form>
	<h:inputHidden value="#{actionBB.frameInit}"></h:inputHidden>
	<%!String actId = "";%>
	<%
		actId = (String) request.getAttribute("actId");
	%>
	<h:inputHidden value="#{actionBB.actId}"></h:inputHidden>
	<f:verbatim>
	 <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="参与者管理 - > 选择参与者 " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>
	
	
		<table width="100%" align="center">
			<tr>
				<td id="private"  align="center" width="10%" class="activeTab" onclick="changePrivate()">  本公司人员 </td>
				<td id="customer" align="center" width="10%" class='tab'       onclick="changeCustomer()"> 客户人员     </td>
			</tr>
		</table>
		<table width="100%" align="center">
			<tr>
				<td colspan="2"><iframe id="tree" frameborder="0"
					framespacing="0"
					src="/crm/action/SelectPersonItem.jsf?actId=<%=actId%>"
					scrolling="no" width="100%" height="300%"> </iframe></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
	function changePrivate() {
		document.all("private").className = "activeTab";
		document.all("customer").className = "tab";
		document.all("tree").src = "/crm/action/SelectPersonItem.jsf?actId=<%=actId%>";
	}

	function changeCustomer() {
		document.all("private").className = "tab";
		document.all("customer").className = "activeTab";
		document.all("tree").src = "/crm/action/SelectCustomerPerson.jsf?actId=<%=actId%>";
	}
</script>