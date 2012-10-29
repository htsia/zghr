<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contQueryBB}"/>
<html>
<head>
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script type="text/javascript" language="javascript">

</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="合同信息 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<br/>
<h:form id="form1">
    <h:inputHidden id="personId" value="#{cont_contQueryBB.personId}"/>
    <h:inputHidden id="displayFlag" value="#{cont_contQueryBB.displayFlag}"/>
   <h:panelGrid  border="0"  align="center" columns="1" width="400">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:commandButton styleClass="button01" value="返回" action="cont_queryHistory_jsf"/>
        <h:panelGroup>
            <c:verbatim escape="false">
            <input type="hidden" name="personId" value="</c:verbatim>
            <h:outputText value="#{cont_contQueryBB.personId}"/>
            <c:verbatim escape="false">"/></c:verbatim>
        </h:panelGroup>
        <h:panelGroup>
            <c:verbatim escape="false">
            <input type="hidden" name="displayFlag" value="</c:verbatim>
            <h:outputText value="#{cont_contQueryBB.displayFlag}"/>
            <c:verbatim escape="false">"/></c:verbatim>
        </h:panelGroup>
     </h:panelGrid>
   </h:panelGrid>
   <br/>
   <h:panelGrid width="400" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="2" columnClasses="td_form01,td_form02">
           <h:outputText value="合同编号"></h:outputText>
           <h:outputText value="#{cont_contQueryBB.bo.contCode}" />

           <h:outputText value="协议文档"></h:outputText>
           <h:panelGroup>
                <c:verbatim escape="false"><A  href="/pages/cont/Download.jsp?attachmentId=</c:verbatim><h:outputText value="#{cont_contQueryBB.bo.attachmentId}"/><c:verbatim escape="false">" taget="_blank" ></c:verbatim>
                <h:outputText value="协议查看" />
                <c:verbatim escape="false"></A></c:verbatim>
           </h:panelGroup>

           <h:outputText value="协议类别"></h:outputText>
           <h:panelGroup>
              <h:inputText styleClass="input" value="#{cont_contQueryBB.bo.protClass}" id="protClass"  code="" dict="yes" dict_num="0222" readonly="true"/>
           </h:panelGroup>

           <h:outputText value="协议约定劳动合同终止时间"></h:outputText>
           <h:panelGroup>
                    <h:outputText value="#{cont_contQueryBB.bo.contEndDate}"></h:outputText>
           </h:panelGroup>

           <h:outputText value="生效时间"></h:outputText>
           <h:panelGroup>
                    <h:outputText value="#{cont_contQueryBB.bo.validDate}"></h:outputText>
           </h:panelGroup>

           <h:outputText value="协议摘要"></h:outputText>
           <h:panelGroup>
                  <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_contQueryBB.bo.contRemark}"/>
           </h:panelGroup>

           <h:outputText value="是否同意鉴证"></h:outputText>
           <h:panelGroup>
                 <h:inputText value="#{cont_contQueryBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
           </h:panelGroup>

   </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>