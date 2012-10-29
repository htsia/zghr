<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<c:verbatim><br></c:verbatim>
<h:form id="form1">
<h:outputText escape="false" value="<strong>该项目为以下项目之和：</strong>"></h:outputText>
<h:dataTable styleClass="table03" align="center" width="95%" id="dateList"
                         headerClass="td_top" columnClasses="td_middle,td_middle"
                         value="#{wage_OrgSumItemSetBB.wageBosDes}"
                         var="list" border="0">
        <h:column>
            <f:facet name="header"><h:outputText value="汇总项目" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.itemName}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="汇总方式" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.description}"/>
        </h:column>
</h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>