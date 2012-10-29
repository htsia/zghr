<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
 <h:form id="form1">
        <c:verbatim>
            <table width="98%" height="98%" align="center">
            <tr><td height=30 align="right" valign="center">
</c:verbatim>
              <h:commandButton value="¹Ø±Õ" styleClass="button01" onclick="window.close();" type="button"></h:commandButton>
<c:verbatim>
            </td></tr>

            <tr><td>
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
        </c:verbatim>
        <h:dataTable value="#{run_SystemInfoBackingBean.versionList}" var="list" align="center"  id="dataList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="Ä£¿é"/></c:facet>
                <h:outputText value="#{list[0]}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="°æ±¾"/></c:facet>
                <h:outputText value="4.1.1203"/>
            </h:column>
        </h:dataTable>
        <c:verbatim>
        </div>
        </td></tr></table></c:verbatim>
 </h:form>
<script type="text/javascript">
   setDataTableOver("form1:dataList");
</script>
