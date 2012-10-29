<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{processMgrBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 流程管理 -> 部署新流程"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="80%" columns="1">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="部署文件(.zip)"></h:outputText>
            <h:panelGroup>
            	<x:inputFileUpload styleClass="input" id="zipFile" value="#{processMgrBB.zipFile}"  storage="file" size="25" />
 				
            </h:panelGroup>
        </h:panelGrid>
        <h:panelGrid align="right">
		<h:commandButton    value="上传"  styleClass="button01" action="#{processMgrBB.uploadFile}"/>
		</h:panelGrid>
    </h:panelGrid>
</h:form>
