<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<c:verbatim><br></c:verbatim>
<h:form id="form1">
<h:outputText escape="false" value="<strong>����ĿΪ������Ŀ֮�ͣ�</strong>"></h:outputText>
<h:dataTable styleClass="table03" align="center" width="95%" id="dateList"
                         headerClass="td_top" columnClasses="td_middle,td_middle"
                         value="#{wage_OrgSumItemSetBB.wageBosDes}"
                         var="list" border="0">
        <h:column>
            <f:facet name="header"><h:outputText value="������Ŀ" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.itemName}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="���ܷ�ʽ" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.description}"/>
        </h:column>
</h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>