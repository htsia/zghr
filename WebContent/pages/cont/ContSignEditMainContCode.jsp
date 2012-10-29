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
<script type="text/javascript" language="javascript">
    function forView(form, id, type) {
        window.open("/cont/ContQueryHistory.jsf?displayFlag=false&personId=" + id ,"","left=50,top=50,height=400,width=850,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes")
       }
</script>
<body>
<x:saveState value="#{cont_contSignBB}"/>
<h:form id="form1">
    <h:panelGrid width="100%" border="0" cellspacing="0" cellpadding="0" >
       <h:outputText value="合同补签" styleClass="td_title" style="width:100%"></h:outputText>
    </h:panelGrid>

    <h:panelGrid  border="0"  align="center" columns="1" width="600">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="4" >
         <h:panelGroup>
            <h:selectBooleanCheckbox value="#{cont_contSignBB.asPersonCode}"></h:selectBooleanCheckbox>
            <h:outputText value="同时用于员工编号"></h:outputText>
         </h:panelGroup>

         <h:panelGroup>
             <h:selectBooleanCheckbox value="#{cont_contSignBB.asLogin}"></h:selectBooleanCheckbox>
             <h:outputText value="同时用于登录名"></h:outputText>
         </h:panelGroup>
        <h:commandButton styleClass="button01" value=" 保存 " action="#{cont_contSignBB.save_mainContCode}" onclick="if( forsubmit(document.forms(0)) ){}else{return false;}"/>
        <h:commandButton styleClass="button01" value="取消返回" action="#{cont_contSignBB.forwardList}"/>
     </h:panelGrid>
    </h:panelGrid>
<br/>
<center>
<x:dataTable value="#{cont_contSignBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="600" border="1">
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <c:verbatim escape="false"><A  href="javascript:forView('','</c:verbatim><h:outputText value="#{list.personId}"/><c:verbatim escape="false">','')" ></c:verbatim>
            <h:outputText value="#{list.personName}" />
            <c:verbatim escape="false"></A></c:verbatim>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="合同编号"/></c:facet>
            <h:inputText styleClass="input" id="mainContCode" value="#{list.contCode}"  size = "30" maxlength="20" alt="主合同编号|1|s" />
        </h:column>
</x:dataTable>
<br/>
</center>
</h:form>
</body>
</html>