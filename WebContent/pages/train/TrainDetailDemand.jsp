<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim>
	<base target="_self">
	<link href="/css/editor.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/js/commonFuns.js"></script>
	<script language="javascript" src="/js/editor.js"></script>
	<script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>
	 <script type="text/javascript">
        function goback(){
            window.close();
        }
    </script>
      <c:verbatim>
      <base target="_self">
      </c:verbatim>      
      <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<x:saveState value="#{train_demandshowdetailbb}" />
<h:form id="form1">
	<h:inputHidden id="initEdit"
		value="#{train_demandshowdetailbb.showDemand}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ��ѵ���� -> �鿴��ѵ��������" />
		</h:panelGroup>
	</h:panelGrid>

	<c:verbatim>
		<table border="0" align="center" cellspacing="2" cellpadding="10"
			columnClasses="td_form01,td_form02" styleClass="table03">
			<tr>
				<td class="td_form01" width="80">��ѵ����</td>
				<td class="td_form02" >
	</c:verbatim> 
				 <h:outputText value="#{train_demandshowdetailbb.demandbo.demandTypeDes}"></h:outputText>
	<c:verbatim>
	</td>
			</tr>
			<tr>
				<td class="td_form01">����������</td>
				<td class="td_form02">
	</c:verbatim> 
	<h:outputText value="#{train_demandshowdetailbb.demandbo.personID}"></h:outputText>
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">��������</td>
				<td class="td_form02">
	</c:verbatim> 
	<h:outputText value="#{train_demandshowdetailbb.demandbo.deptID}"></h:outputText>
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">��ѵ��ʽ</td>
				<td class="td_form02">
	</c:verbatim> 
	 <h:outputText value="#{train_demandshowdetailbb.demandbo.demandStyleDes}"></h:outputText>
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">���ʱ��</td>
				<td class="td_form02">
	</c:verbatim> 
	  <h:outputText value="#{train_demandshowdetailbb.demandbo.createDate}"></h:outputText>
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">��ѵʱ��</td>
				<td class="td_form02">
	</c:verbatim> 
	  <h:outputText value="#{train_demandshowdetailbb.demandbo.demandTimeDes}"></h:outputText>
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">˵��</td>
				<td class="td_form02">
	</c:verbatim> 
	<h:inputTextarea id="memo" rows="15" cols="80" style="display:none;" value="#{train_demandshowdetailbb.demandbo.memo}" /> 
	<c:verbatim>
					<script language="javascript">
	gFrame = 1;//1-�ڿ����ʹ�ñ༭��
	gContentId = "form1:memo";//Ҫ�������ݵ�content ID
	OutputEditorLoading();
</script>
					<iframe id="HtmlEditor" class="editor_frame" frameborder="0"
						marginheight="0" marginwidth="0"
						style="width: 100%; height: 300px; overflow: visible;"></iframe></td>
			</tr>
			</c:verbatim>
			<c:verbatim>
		</table>
		<br>
	</c:verbatim>
	<h:panelGrid align="center">
		 <h:commandButton value="��   ��" id="save" type="button" styleClass="button01" onclick="return goback();" />
	</h:panelGrid>

</h:form>
