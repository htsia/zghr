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
			   <h:outputText value="活动管理  - > 详细信息 " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>
	     
		<table width="95%" align="center">
			<tr>
				<td id="cusInfo"  align="center" width="10%" class="activeTab" onclick="changePrivate()">  活动信息 </td>
				<td id="contactInfo" align="center" width="10%" class='tab'       onclick="changeCustomer()"> 参与者信息   </td>
				 
			</tr>
		 
			<tr>
				<td colspan="2"><iframe id="tree" frameborder="0"
					framespacing="0"
					src="/crm/action/ActionDetailInfo.jsf?actId=<%=actId%>"
					scrolling="no" width="100%" height="300%"> </iframe></td>
			</tr>
			
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
	function changePrivate() {
		document.all("cusInfo").className = "activeTab";
		document.all("contactInfo").className = "tab";
		document.all("tree").src = "/crm/action/ActionDetailInfo.jsf?actId=<%=actId%>";
	}

	function changeCustomer() {
		document.all("cusInfo").className = "tab";
		document.all("contactInfo").className = "activeTab";
		document.all("tree").src = "/crm/action/ActionJoinerInfo.jsf?actId=<%=actId%>";
	}
</script>