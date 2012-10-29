<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_grossctrlBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_grossctrlBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="year" value="#{wage_grossctrlBB.curYear}"></h:inputHidden>
    <h:inputHidden id="orgID" value="#{wage_grossctrlBB.orgID}"></h:inputHidden>
<c:verbatim>
    <table  width=100%>
     <tr><td height=8>
</c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 集团薪酬管控 -> 申请追加"/>
            </h:panelGroup>
        </h:panelGrid>

     </td></tr>

    <c:verbatim>
      <tr><td height=8>
    </c:verbatim>
        <h:outputText escape="false" value="<strong>控制项目:</strong>#{wage_grossctrlBB.grossFieldDes}<br>"></h:outputText>
        <h:outputText escape="false" value="<strong>设定总额:</strong>#{wage_grossctrlBB.amount}<br>"></h:outputText>
        <h:outputText escape="false" value="<strong>累计完成:</strong>#{wage_grossctrlBB.fulfill}<br>"></h:outputText>
        <h:outputText escape="false" value="<strong>当前余额:</strong>#{wage_grossctrlBB.diff}<br>"></h:outputText>
        <h:outputText escape="false" value="<strong>待审批追加:</strong>#{wage_grossctrlBB.addition}" rendered="#{wage_grossctrlBB.haveAppling}"></h:outputText >
        <h:outputText escape="false" value="<strong>申请追加:</strong>" rendered="#{!wage_grossctrlBB.haveAppling}"></h:outputText ><h:inputText rendered="#{!wage_grossctrlBB.haveAppling}" value="#{wage_grossctrlBB.addition}"></h:inputText>
        <c:verbatim><br></c:verbatim>
        <h:outputText escape="false" value="<strong>追加原因:</strong>" rendered="#{!wage_grossctrlBB.haveAppling}"></h:outputText ><c:verbatim><br></c:verbatim>
        <h:inputTextarea rendered="#{!wage_grossctrlBB.haveAppling}" rows="3" cols="45" value="#{wage_grossctrlBB.reason}"/>
    <c:verbatim>
      </td></tr>

      <tr><td height=8 align="right">
    </c:verbatim>
       <h:commandButton value="确定" styleClass="button01" action="#{wage_grossctrlBB.doApply}" rendered="#{!wage_grossctrlBB.haveAppling}"></h:commandButton>
       <h:commandButton value="取消" type="button" styleClass="button01" onclick="window.close();"></h:commandButton>
    <c:verbatim>
      </td></tr>
     </table>
    </c:verbatim>
</h:form>
