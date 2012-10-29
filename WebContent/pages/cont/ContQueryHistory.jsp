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
function forView(personId) {
    window.open("/pages/cont/ContQueryHistoryResultExcel.jsp?personId="+personId,"","left=50,top=50,height=400,width=800,toolbar=yes,menubar=yes,scrollbars=yes,resizable=yes,location=no,status=yes")
   }
</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="合同签订历史纪录" styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_contQueryBB.init_a}"/>
<h:inputHidden id="personId" value="#{cont_contQueryBB.personId}"/>
<h:inputHidden id="displayFlag" value="#{cont_contQueryBB.displayFlag}"/>
<h:panelGrid  border="0"  align="center" columns="1" width="95%">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="5" >
        <h:commandButton styleClass="button01" value="返回" action="#{cont_contQueryBB.queryAll}" rendered="#{cont_contQueryBB.displayFlag}"/>
         <h:panelGroup>
        <c:verbatim escape="false"><input type="button" class="button01" name="poe_button" value="导出excel" onclick="javascript:forView('</c:verbatim><h:outputText value="#{cont_contQueryBB.personId}"/><c:verbatim escape="false">')" /> </c:verbatim>
        </h:panelGroup>
         <h:panelGroup>
        <h:commandButton styleClass="button01" value="查看当前合同信息" action="#{cont_contQueryBB.findCurrentContInfoByPersonId}" />
        <c:verbatim>&nbsp</c:verbatim> 
        <h:commandButton styleClass="button01" value="劳动合同示范文本" onclick="javascript:windowOpen('../pages/self/ldhtwb_sl.doc','','','720','400','','0','0');return false;" />
         </h:panelGroup>
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
<h:panelGrid  border="0"  align="center" columns="1" width="95%">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="2" >
        <h:outputText value="员工姓名："/>
        <h:outputText value="#{cont_contQueryBB.personName}"/>
     </h:panelGrid>
</h:panelGrid>
<br/>
<center>
<x:dataTable value="#{cont_contQueryBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="95%" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同或协议编号"/></c:facet>
                <h:outputText value="#{list.contCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同或协议类别"/></c:facet>
                <h:outputText value="#{list.contClassName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="生效时间"/></c:facet>
                <h:outputText value="#{list.validDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同期限类型"/></c:facet>
                <h:outputText value="#{list.contTermClass}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandLink id="link1" value="详细信息查看" action="#{cont_contQueryBB.findContInfoById}" >
                     <c:param name="contId" value="#{list.contId}"/>
                     <c:param name="contClass" value="#{list.contClass}"/>
                </h:commandLink>
                <h:outputText value="  "/>
                <c:verbatim escape="false"><A  href="/pages/cont/Download.jsp?attachmentId=</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">" taget="_blank" ></c:verbatim>
                <h:outputText value="合同查看" />
                <c:verbatim escape="false"></A></c:verbatim>
            </h:column>

</x:dataTable>
<br/>
</center>
</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>