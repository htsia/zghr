<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<x:saveState value="#{competitionBB}"></x:saveState>
<h:form>
	<h:inputHidden value="#{competitionBB.editInit}"></h:inputHidden>
	<%!
	   String compeId = "";
	   String cuId = "";
	%>
	<%
	compeId = (String) request.getAttribute("compeId");
	cuId = (String)request.getAttribute("cuId");
	%>
	<h:inputHidden value="#{competitionBB.compeId}"></h:inputHidden>
	<f:verbatim>
	    <table width="100%">
	    <tr>
		    <td class="td_title" width="100%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="竞争对手 - > 详细信息" rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		    </tr>
	    
	    </table>
		<table width="95%" align="center">
		
			<tr>
				<td id="private"  align="center" width="10%" class="activeTab" onclick="changePrivate()">  公司信息 </td>
				<td id="person" align="center" width="10%" class='tab'         onclick="changeCustomer()"> 人员信息   </td>
				<td id="act" align="center" width="10%" class='tab'         onclick="changeCompAct()"> 活动信息   </td>
			</tr>
			
			<tr>
				<td colspan="3" width="100%"><iframe id="tree" frameborder="0"
					framespacing="0"
					src="/crm/competition/CompetitionDetail.jsf?compeId=<%=compeId%>"
					scrolling="no" width="100%" height="200%"> </iframe></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
	function changePrivate() {
		document.all("private").className = "activeTab";
		document.all("person").className = "tab";
		document.all("act").className = "tab";
		document.all("tree").src = "/crm/competition/CompetitionDetail.jsf?compeId=<%=compeId%>";
	}

	function changeCustomer() {
		document.all("private").className = "tab";
		document.all("person").className = "activeTab";
		document.all("act").className = "tab";
		document.all("tree").src = "/crm/competition/CompetitionPersonMger.jsf?init=detail&comId=<%=compeId%>";
	}

	function changeCompAct() {
		document.all("private").className = "tab";
		document.all("person").className = "tab";
		document.all("act").className = "activeTab";
		document.all("tree").src = "/crm/customer/CompetitionActionList.jsf?operation=frame&cuId=<%=cuId%>&compId=<%=compeId%>";
	}
</script>