<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_formulaviewBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_formulaviewBB.viewDelete}"/>
    <c:verbatim>
    <table width="95%" height=98% width=98% align="center">
        <tr><td align="right" height=8>
            <input type="button" class="button01" value="返回" onclick="window.close()"/>
        </td></tr>

        <tr>
            <td>
              <div style='width:100%;height:100%;overflow:auto' id=datatable>
              </c:verbatim>
              <h:dataTable value="#{wage_formulaviewBB.deleteList}" var="list" align="center"  id="dateList"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="95%" >
        <h:column>
            <c:facet name="header"><h:outputText value="删除日期"/></c:facet>
            <h:outputText value="#{list.deleDate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="删除人"/></c:facet>
            <h:outputText value="#{list.deleOperName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="公式名称"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>

    </h:dataTable>
              <c:verbatim>
              </div>    
            </td>
        </tr>
    </table>
   </c:verbatim>
</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>
