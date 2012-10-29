<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{daexloginBB}"/>
<h:form id="form1" enctype="multipart/form-data"> 
<h:inputHidden id="initEdit" value="#{daexloginBB.initUpload}"></h:inputHidden>
 <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 数据交换平台 -> 产品上传"/>
          </h:panelGroup>
      </h:panelGrid>
<h:panelGrid columns="1"  width="98%" align="left">
	
 <h:panelGrid columns="2">
 	<h:outputText value="产品名称"></h:outputText>
    <h:panelGroup>
	 <x:inputFileUpload styleClass="input" id="excelFile" value="#{daexloginBB.excelFile}"  storage="file" size="25" />
	 <h:commandButton    value="上传"  styleClass="button01" action="#{daexloginBB.uploadFile}"/>
    </h:panelGroup>
  </h:panelGrid> 
</h:panelGrid>
</h:form>
