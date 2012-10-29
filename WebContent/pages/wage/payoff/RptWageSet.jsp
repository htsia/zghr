<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function doSetWage(id){
        window.showModalDialog("/wage/payoff/RptWageSetEdit.jsf?contentID=" + id, null, "dialogWidth:500px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
      </td></tr>


     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{wage_dateBB.rptOperList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="报表名称"/></c:facet>
                <h:outputText value="#{list.rptName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="适应帐套"/></c:facet>
                <h:outputText value="#{list.wagesetdes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="设置" styleClass="button01" onclick="return doSetWage('#{list.contentID}');"></h:commandButton>
            </h:column>
        </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
    </f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>