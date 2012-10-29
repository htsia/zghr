<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<html>
<br><br><br><br><br>
<h:form>
<x:saveState value="#{wage_grossBB}"/>
  <h:panelGrid align="center" width="80%"  columns="1">
    <h:outputText value="文件下载成功！"/>
    <h:outputLink title="查看文件" value="/file/wage/gross/#{wage_grossBB.fileName}" target="_blank">
        <h:outputText value="#{wage_grossBB.fileName}"/>
    </h:outputLink>
    <h:commandButton value="返回" action="#{wage_grossBB.pageBack}"/>
  </h:panelGrid>
</h:form>
</html>