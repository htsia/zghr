<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contNewSignBB}"/>
<html>
<head>
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script language="javascript">
function forView(personId) {
     windowOpen("/pages/employee/DocPrint.jsf?id=" + personId , "", "status=no,toolbar=no,menubar=yes,location=no", "900", "600", "no");
}
</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="打印介绍信 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">
<h:panelGrid  border="0"  align="center" columns="2" width="850">
    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="1" >
         <h:commandButton styleClass="button01" value="返回合同新签" action="#{cont_contNewSignBB.forwardList}"/>
    </h:panelGrid>
</h:panelGrid>
<center>
<x:dataTable value="#{cont_contNewSignBB.bos_contPerson}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="800" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="人员编号"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="性别"/></c:facet>
                <h:outputText value="#{list.personSex}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="身份证号码"/></c:facet>
                <h:outputText value="#{list.idCard}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="所在机构"/></c:facet>
                <h:outputText value="#{list.enterOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="入系统时间"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
            </h:column>
             <h:column>
                <c:facet name="header"><h:outputText value="用工类别"/></c:facet>
                <h:outputText value="#{list.jobType}"/>
            </h:column>
             <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:outputText value="  "/>
                <c:verbatim escape="false"><input type="button" class="button01" value=" 打印介绍信 " onclick="forView(</c:verbatim>
                <h:outputText value="#{list.personId}"/>
                <c:verbatim escape="false">);"></c:verbatim>
                <h:outputText value="  "/>
            </h:column>

</x:dataTable>

</center>
<br/>

</h:form>
</body>
</html>