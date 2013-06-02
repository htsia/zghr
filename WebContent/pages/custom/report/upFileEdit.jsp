<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
	function forsave(){
		var name = document.all("form1:name").value;
		if(name==null || name==''){
			alert("请填写报表名称");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{uploadReportBB}" />
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden value="#{uploadReportBB.editInit}"/>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="软件上传" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			
			<h:outputText value="报表名称"/>
			<h:inputText id="name" value="#{uploadReportBB.bo.name}" styleClass="input" size="30"/>
			<h:outputText value="顺序"/>
			<h:inputText id="sort" value="#{uploadReportBB.bo.sort}" styleClass="input" size="30"/>
			<h:outputText value="文件"/>
			<x:inputFileUpload id="file" value="#{uploadReportBB.myFile}" storage="file" styleClass="input" size="30"/>
		</h:panelGrid>
		
		<h:panelGrid align="center">
			<c:verbatim><br/></c:verbatim>
			<h:commandButton value="  保  存  " onclick="return forsave();" action="#{uploadReportBB.save}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>