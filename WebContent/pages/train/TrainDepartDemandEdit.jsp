<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim>
	<link href="/css/editor.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/js/commonFuns.js"></script>
	<script language="javascript" src="/js/editor.js"></script>
	<script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>
	<script type="text/javascript">
	function forCheck() {
        if (document.all('form1:memo').value==null || document.all('form1:memo').value=="") {
            alert("��¼����������!");
            return false;
        }
        // ��Чʱ��
        if (document.all('form1:createDate').value==null || document.all('form1:createDate').value=="") {
            alert("��¼����Чʱ��!");
            return false;
        }
        return true;
	}
function forSave() {
        PutTextareaValue(document.all('form1:memo'),fGetContent());
        if (forCheck()) {
            return forsubmit(document.forms(0));
        }
        return false;
    }
</script>
<x:saveState value="#{train_departdemandeditbb}" />
<h:form id="form1">
	<h:inputHidden id="initEdit"
		value="#{train_departdemandeditbb.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ��ѵ���� -> ¼�벿����ѵ����" />
		</h:panelGroup>
	</h:panelGrid>

	<c:verbatim>
		<table border="0" align="center" cellspacing="2" cellpadding="10"
			columnClasses="td_form01,td_form02" styleClass="table03">
			<tr>
				<td class="td_form01">��ѵ����</td>
				<td class="td_form02">
	</c:verbatim> 
				<h:inputText  readonly="true"
					value="��������" />
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">��������</td>
				<td class="td_form02">
	</c:verbatim> 
	<h:inputText id="deptName"
					styleClass="input" value="#{train_departdemandeditbb.demandbo.deptName}"
					size="80" maxlength="50" readonly="true"/> 
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">��������</td>
				<td class="td_form02">
	</c:verbatim> 
			<h:selectOneMenu value="#{train_departdemandeditbb.demandbo.bullId}">
				<c:selectItems value="#{train_departdemandeditbb.bullList}"/>
			</h:selectOneMenu>
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">��ѵ��ʽ</td>
				<td class="td_form02">
	</c:verbatim> 
	<h:selectOneMenu value="#{train_departdemandeditbb.demandbo.demandStyle}">
			<f:selectItem itemValue="0" itemLabel="���ý���"/>
			<f:selectItem itemValue="1" itemLabel="��ѧУ����"/>
			<f:selectItem itemValue="2" itemLabel="��¼����Ӱ"/>
			<f:selectItem itemValue="3" itemLabel="�ֳ�����"/>
			<f:selectItem itemValue="4" itemLabel="��������"/>
			<f:selectItem itemValue="5" itemLabel="����"/>
	</h:selectOneMenu> 
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">���ʱ��</td>
				<td class="td_form02">
	</c:verbatim> 
	<h:inputText id="createDate"
					styleClass="input"
					value="#{train_departdemandeditbb.demandbo.createDate}" size="17"
					readonly="true">
				</h:inputText>
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">��ѵʱ��</td>
				<td class="td_form02">
	</c:verbatim> 
	<h:selectOneMenu value="#{train_departdemandeditbb.demandbo.demandTime}">
			<f:selectItem itemValue="0" itemLabel="����ʱ������"/>
			<f:selectItem itemValue="1" itemLabel="����ʱ������"/>
			<f:selectItem itemValue="2" itemLabel="����ʱ������"/>
			<f:selectItem itemValue="3" itemLabel="��ĩ"/>
	</h:selectOneMenu> 
	<c:verbatim></td>
			</tr>
			<tr>
				<td class="td_form01">˵��</td>
				<td class="td_form02">
	</c:verbatim> 
	<h:inputTextarea id="memo" rows="15" cols="80" style="display:none;" value="#{train_departdemandeditbb.demandbo.memo}" /> 
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
	<h:panelGrid align="right">
		<h:commandButton value="����" id="save" onclick="return forSave();"	action="#{train_departdemandeditbb.save}" styleClass="button01" />
	</h:panelGrid>

</h:form>
