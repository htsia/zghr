<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{evataskResultAnalyseBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{evataskResultAnalyseBB.superId}"></h:inputHidden>
	<h:inputHidden id="initpage" value="#{evataskResultAnalyseBB.initPage}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right"></c:verbatim> <h:panelGrid align="left">
					<h:panelGroup>
						<h:outputText value="��ǰ����:"></h:outputText>
						<h:outputText value="#{evataskResultAnalyseBB.superName}"></h:outputText>
					</h:panelGroup>
				</h:panelGrid> <c:verbatim></td>
			</tr>
			<br />
			
			<tr>
				<td align="center"><jsp:include page="/pages/eva/taskAnalyseResult.jsp"></jsp:include></td>
			</tr>

		</table>

	</c:verbatim>
    <h:inputHidden id="c" value="#{evataskResultAnalyseBB.clear}"></h:inputHidden>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
