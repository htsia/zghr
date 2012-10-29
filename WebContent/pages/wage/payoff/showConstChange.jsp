<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript" language="javascript">
</script>

<h:form id="form1">
<h:inputHidden value="#{wage_ConstBB.initShowHis}"></h:inputHidden>
<c:verbatim>
<table width=98% height=98% align="center">
    <tr><td height=8px>
</c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 薪酬管理 ->  #{wage_ConstBB.setName}常量情况"/>
            </h:panelGroup>
        </h:panelGrid>
<c:verbatim>
     </td></tr>

    <tr><td height=8px>
</c:verbatim>
        <h:panelGrid align="right" styleClass="locked_top">
            <h:panelGroup>
                <h:outputText value="记录数:#{wage_ConstBB.pagevo.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="页数:#{wage_ConstBB.pagevo.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="每页有#{wage_ConstBB.pagevo.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="当前为第#{wage_ConstBB.pagevo.currentPage}页"></h:outputText>
                <h:commandButton value="首页" action="#{wage_ConstBB.first}" styleClass="button01"></h:commandButton>
                <h:commandButton value="上页" action="#{wage_ConstBB.pre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="下页" action="#{wage_ConstBB.next}" styleClass="button01"></h:commandButton>
                <h:commandButton value="尾页" action="#{wage_ConstBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
<c:verbatim>
     </td></tr>

    <tr><td>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
        <x:dataTable value="#{wage_ConstBB.constHisList}" var="list"  rowIndexVar="index" id="data"
                             headerClass="td_top tr_fixrow"
                             rowClasses="td_middle" styleClass="table03" width="95%" border="0">
                    <h:column>
                        <c:facet name="header"><h:outputText value="序号"/></c:facet>
                        <h:outputText value="#{index+1}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="月份"/></c:facet>
                        <h:outputText value="#{list.month}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="常量名称"/></c:facet>
                        <h:outputText value="#{list.constName}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="常量值"/></c:facet>
                        <h:outputText value="#{list.constValue}"/>
                    </h:column>

        </x:dataTable>
<c:verbatim>
        </div>
    </td></tr>
</table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:data");
</script>