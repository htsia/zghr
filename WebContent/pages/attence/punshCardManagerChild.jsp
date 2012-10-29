<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
function forUploadFile() {
	window.showModalDialog("/attence/AttenceCardDataUpload.jsf", null, "dialogWidth:580px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
}
</script>

<x:saveState value="#{punshcardmanagerBB}" />
<h:form id="form1">
	<h:inputHidden id="superID" value="#{punshcardmanagerBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId1" value="#{punshcardmanagerBB.superId}"></h:inputHidden>
	<h:inputHidden id="yearManager" value="#{punshcardmanagerBB.yearManager}"></h:inputHidden>
	<h:inputHidden id="monthManager" value="#{punshcardmanagerBB.monthManager}"></h:inputHidden>

	<h:panelGrid width="98%" columns="1" align="center">
		
		<h:panelGrid columns="4" align="left">
			<h:outputText value="�������ƣ�"></h:outputText>
			<h:inputText id="classnamevalue"
				value="#{punshcardmanagerBB.findSeeValue}"></h:inputText>
			<h:commandButton value="��ѯ" styleClass="button01" action="#{punshcardmanagerBB.doQuery}"/>
			<h:commandButton value="�����ļ�" styleClass="button01" onclick="return forUploadFile()"/>
			<h:commandButton value="��ȡ���ڻ�����" styleClass="button01" onclick="showProcessBar();" action="#{punshcardmanagerBB.signData}"/>
		</h:panelGrid>
		<h:panelGrid align="right" columns="1">
             <h:panelGroup>
                <h:outputText value="��¼��:#{punshcardmanagerBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{punshcardmanagerBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{punshcardmanagerBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{punshcardmanagerBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{punshcardmanagerBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{punshcardmanagerBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{punshcardmanagerBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{punshcardmanagerBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>
		
		<x:dataTable value="#{punshcardmanagerBB.itemList}" id="dateList"
			headerClass="td_top" rowIndexVar="index" var="list"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
					<h:column>
						<f:facet name="header">
							<h:outputText value="���" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="���ڿ���" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.attCard}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="��������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.cardDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.cardTime}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="���ڻ�" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.machineName}" />
					</h:column>
										<h:column>
						<f:facet name="header">
							<h:outputText value="��������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.orgName}" />
					</h:column>
															<h:column>
						<f:facet name="header">
							<h:outputText value="���ڲ���" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.deptName}" />
					</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<marquee id="processbar"
	style="position: absolute; display: none; border: 1px solid #000000"
	direction="right" width="300" scrollamount="5" scrolldelay="10"
	bgcolor="#ECF2FF">
<table cellspacing="1" cellpadding="0">
	<tr height=8>
		<td bgcolor=#3399FF width=8></td>
		<td></td>
		<td bgcolor=#3399FF width=8></td>
		<td></td>
		<td bgcolor=#3399FF width=8></td>
		<td></td>
		<td bgcolor=#3399FF width=8></td>
		<td></td>
	</tr>
</table>
</marquee>

<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
	
	function showProcessBar() {
	    x = document.body.clientWidth / 2 - 150;
	    y = document.body.clientHeight / 2;
	    document.all('processbar').style.top = y;
	    document.all('processbar').style.left = x;
	    document.all('processbar').style.display = "";
	}
</script>


