<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{eva_BB}"/>
<h:form id="form1" enctype="multipart/form-data"> 
<h:inputHidden id="initEdit" value="#{eva_BB.initEdit}"></h:inputHidden>
<h:panelGrid columns="1" align="center">
  <f:verbatim>
    <br>
  </f:verbatim>
 <h:panelGrid columns="2">
 <h:outputLabel value="上传文档:"/>
 <h:outputLink value="/pages/eva/EvaDownload.jsf"  rendered="#{eva_BB.isExist==true}">
    <h:outputText value="述职报告"/>
</h:outputLink>
<h:outputText value="无" rendered="#{eva_BB.isExist==false}"></h:outputText>
 </h:panelGrid>
 <h:panelGrid columns="2">
 <x:inputFileUpload styleClass="input" id="excelFile" value="#{eva_BB.excelFile}"  storage="file" size="25" />
 <h:commandButton    value="上传"  styleClass="button01" action="#{eva_BB.uploadFile}"/>
  </h:panelGrid> 
</h:panelGrid>
</h:form>
