<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_setDeptChangeBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{wage_setDeptChangeBB.pageInit}"></h:inputHidden>
    <c:verbatim>
    <table height=98% width=98% >
    <tr><td height=8>
    </c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" н����� ->  ��Ա���ű仯"/>
            </h:panelGroup>
        </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td height=8>
</c:verbatim>
    <h:panelGrid align="right" styleClass="locked_top">
        <h:panelGroup>
            <h:outputText value="��¼��:#{wage_setDeptChangeBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ҳ��:#{wage_setDeptChangeBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{wage_setDeptChangeBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{wage_setDeptChangeBB.pagevo.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{wage_setDeptChangeBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{wage_setDeptChangeBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{wage_setDeptChangeBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{wage_setDeptChangeBB.last}" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td >
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
        <x:dataTable value="#{wage_setDeptChangeBB.personList}" var="list"  rowIndexVar="index" id="data"
                             headerClass="td_top tr_fixrow"
                             rowClasses="td_middle" styleClass="table03" width="95%" border="0">
                    <h:column>
                        <c:facet name="header"><h:outputText value="���"/></c:facet>
                        <h:outputText value="#{index+1}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="�仯����"/></c:facet>
                        <h:outputText value="#{list.changeDate}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="����"/></c:facet>
                        <h:outputText value="#{list.personName}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="ԭ����"/></c:facet>
                        <h:outputText value="#{list.olddept}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="�²���"/></c:facet>
                        <h:outputText value="#{list.newdept}"/>
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
