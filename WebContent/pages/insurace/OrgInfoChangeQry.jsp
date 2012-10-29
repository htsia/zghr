<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <base target="_self">
    <title></title>
</head>

<script type="text/javascript">
    function OpenRpt(){
        if (document.all("form1:modiMonth").value=="-1"){
            alert("请先选择年月！");
            return false;
        }

        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Where="+document.all("form1:modiMonth").value;
        window.open(url);
        return false;
    }
</script>

<body>
<x:saveState value="#{ins_orgChangeQueryBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{ins_orgChangeQueryBB.pageInit}"/>
    <h:inputHidden id="unitId" value="#{ins_orgChangeQueryBB.unitId}"/>
    <table width=100% height=97% border=0 >
    <tr><td height=8px>
        <h:outputText value="当前机构:#{ins_orgChangeQueryBB.unitName}"></h:outputText>
    </td>
    <td align="right">
        <h:selectOneMenu id="modiMonth" style="width:190px" value="#{ins_orgChangeQueryBB.month}">
            <c:selectItems value="#{ins_orgChangeQueryBB.modiMonth}"/>
        </h:selectOneMenu>
        <h:commandButton styleClass="button01" value="查询" action="#{ins_orgChangeQueryBB.query}"></h:commandButton>
        <h:outputText escape="false" value="&nbsp;&nbsp;"></h:outputText>

        <h:selectOneMenu id="ReportID" style="width:190px">
            <c:selectItems value="#{ins_orgChangeQueryBB.reportList}"/>
        </h:selectOneMenu>
        <h:commandButton value="Excel显示" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
    </td>
    </tr>

     <tr>
         <td valign="top" colspan=2>
             <h:dataTable value="#{ins_orgChangeQueryBB.modiinfo}" var="list" align="center"
                          headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                          styleClass="table03" width="90%" >
                 <h:column>
                     <c:facet name="header"><h:outputText value="修改日期"/></c:facet>
                     <h:outputText value="#{list.modidate}"/>
                 </h:column>
                 <h:column>
                     <c:facet name="header"><h:outputText value="变动机构"/></c:facet>
                     <h:outputText value="#{list.orgName}"/>
                 </h:column>
                 <h:column>
                     <c:facet name="header"><h:outputText value="变动项目"/></c:facet>
                     <h:outputText value="#{list.fieldDes}"/>
                 </h:column>

                 <h:column>
                     <c:facet name="header"><h:outputText value="原值"/></c:facet>
                     <h:outputText value="#{list.oldValue}"/>
                 </h:column>

                 <h:column>
                     <c:facet name="header"><h:outputText value="新值"/></c:facet>
                     <h:outputText value="#{list.newValue}"/>
                 </h:column>
             </h:dataTable>
         </td>
     </tr>
    </table>
</h:form>
</body>
</html>