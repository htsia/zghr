<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
<title></title>
</head>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
    <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="审查信息查看 " styleClass="td_title" style="width:100%"></h:outputText>
    </h:panelGroup>
</h:panelGrid>
<br />
<h:form id="form1">
    <br />
    <h:panelGrid width="400" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="2" columnClasses="td_form01,td_form02">
       <h:outputText value="审查意见"></h:outputText>
       <h:inputText value="#{cont_contNewSignBB.bo.approveStatus}" id="approveStatus" styleClass="input"  code="" dict="yes" dict_num="2010" readonly="true" />

        <h:outputText value="截止办理时间"></h:outputText>
        <h:inputText styleClass="input" id="uptoValidDate" size="10" value="#{cont_contNewSignBB.bo.uptoValidDate}" readonly="true"/>

       <h:outputText value="备注"></h:outputText>
       <h:inputTextarea id="approveRemark" rows="4" cols="28"  value="#{cont_contNewSignBB.bo.approveRemark}" readonly="true"/>

       <h:outputText value="审查人"></h:outputText>
       <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.approvePersonId}" id="approvePersonId"  code="" dict="yes" dict_num="PE" readonly="true" alt="审查人|0"/>
       <h:outputText value="审查机构"></h:outputText>
       <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.approveOrgId}" id="approveOrgId"  code="" dict="yes" dict_num="OU" readonly="true" alt="审查机构|0"/>
       <h:outputText value="审查日期"></h:outputText>
       <h:panelGroup>
              <h:outputText value="#{cont_contNewSignBB.bo.approveDate}" />
       </h:panelGroup>

</h:panelGrid>
 <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="1">
                    <h:commandButton styleClass="button01" value="返回" action="#{cont_contNewSignBB.forwardList}"/>
</h:panelGrid>
</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>