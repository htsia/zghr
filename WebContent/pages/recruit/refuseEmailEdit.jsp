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
    	 PutTextareaValue(document.all('form1:desc'),fGetContent());
         if(forsubmit(document.forms(0)))
             {
                if(document.all('form1:desc').value=="<P>&nbsp;</P>"||document.all('form1:desc').value=="")
                  {
                    alert("谢绝邮件格式不能为空!")
                    return false;
                    }else{
                         return true;
                         }
               }else{
                     return false;
                    }
    }
</script>

<x:saveState value="#{refuseEmailEditbb}" />
<h:form id="form1">
	<h:inputHidden value="#{refuseEmailEditbb.pageInit}"></h:inputHidden>
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 业务管理-> 设置谢绝邮件格式" />
		</h:panelGroup>
	</h:panelGrid>
	<br>

	<h:panelGrid align="center" width="60%" columns="1">


		<h:panelGrid columns="2" width="80%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
			<h:panelGrid columns="3" width="100%">
				<h:panelGrid>
				<h:outputText value="设置谢绝邮件格式" />
				</h:panelGrid>
				<h:panelGrid align="right">
				<h:selectOneMenu value="#{refuseEmailEditbb.param}">
	                    <c:selectItem itemLabel="选择输入参数" itemValue=""></c:selectItem>
	                    <c:selectItem itemLabel="姓名" itemValue="$NAME$"></c:selectItem>
	                    <c:selectItem itemLabel="时间" itemValue="$DATE$"></c:selectItem>
	            </h:selectOneMenu>
	            </h:panelGrid>
	            <h:commandButton styleClass="button01" value="加入参数" action="#{refuseEmailEditbb.interParame}"/>
			</h:panelGrid>
			<h:outputText value="" style="display:none;"/>
			<h:inputTextarea id="desc"
				value="#{refuseEmailEditbb.sgContent}" cols="140"
				rows="20"/>
		</h:panelGrid>
		<h:panelGrid columns="2" align="right" cellspacing="2">
			<h:commandButton styleClass="button01" value="保存"
				action="#{refuseEmailEditbb.save}"
				onclick="return forCheck();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
