<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<x:saveState value="#{taskprocessBB}" />
<h:form id="form1">
	<h:inputHidden value="#{taskprocessBB.initEdit}"></h:inputHidden>
	<h:inputHidden value="#{taskprocessBB.itemId}"></h:inputHidden>
<f:verbatim>
	<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
	<tr><td class="td_form01">完成情况</td><td class="td_form02">
</f:verbatim>	
		<h:inputText value="#{taskprocessBB.processbo.process}"></h:inputText>
<f:verbatim>
		</td>
	</tr>
	<tr><td class="td_form01">描述</td><td colspan="3" class="td_form02">
</f:verbatim>
		<h:inputTextarea value="#{taskprocessBB.processbo.description}" cols="50" rows="5">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr height="10"></tr>
	<tr><td colspan="4" align="right">
	
</f:verbatim>
<h:commandButton styleClass="button01" value="保存" action="#{taskprocessBB.save}">
		</h:commandButton>	
<f:verbatim>
	</td></tr></table>
</f:verbatim>
</h:form>