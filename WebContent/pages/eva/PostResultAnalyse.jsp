<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{eva_postResultAnalyseBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{eva_postResultAnalyseBB.superId}"></h:inputHidden>
	<h:inputHidden id="initpage" value="#{eva_postResultAnalyseBB.initPage}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right"></c:verbatim> <h:panelGrid align="left">
					<h:panelGroup>
						<h:outputText value="当前机构:"></h:outputText>
						<h:outputText value="#{eva_postResultAnalyseBB.superName}"></h:outputText>
					</h:panelGroup>
				</h:panelGrid> <c:verbatim></td>
			</tr>
			<br />
			
			<tr>
				<td align="center"><jsp:include page="/pages/eva/PostAnalyseResult.jsp"></jsp:include></td>
			</tr>

		</table>

	</c:verbatim>
    <h:inputHidden id="c" value="#{eva_postResultAnalyseBB.clear}"></h:inputHidden>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
