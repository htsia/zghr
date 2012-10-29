<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function addSheet(){
            window.showModalDialog("/wage/base/AddWageSheetSet.jsf", null, "dialogWidth:330px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        }

    </script>

<x:saveState value="#{wage_sheetBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_sheetBB.pageInit}"/>

    <c:verbatim>
    <table width=600 height=98% align="center">
      <tr><td height=8 align="right">
    </c:verbatim>
         <h:commandButton value="新建" styleClass="button01" onclick="return addSheet();"></h:commandButton>
    <c:verbatim>
    </td></tr>

      <tr><td>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
     </c:verbatim>
        <h:dataTable value="#{wage_sheetBB.sheetList}" var="list"    id="dateList"
                     headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_left,td_middle_left,td_middle_left,td_middle_center"
                     styleClass="table03"
                     width="100%">

            <h:column>
                <c:facet name="header"><h:outputText value="年份"/></c:facet>
                <h:outputText value="#{list.sheetYear}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="创建日期"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="创建人"/></c:facet>
                <h:outputText value="#{list.creator}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="包含字段"/></c:facet>
                <h:outputText value="#{list.fieldDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="对应子集"/></c:facet>
                <h:outputText value="#{list.setID}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton id="view" styleClass="button01"  value="删除" onclick="return confirm('确定要删除吗?'); " action="#{wage_sheetBB.delete}">
                    <x:updateActionListener property="#{wage_sheetBB.itemID}" value="#{list.sheetID}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    <c:verbatim>
       </div>
        </td></tr>
    </table>
    </c:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
    setDataTableOver("form1:dateList");
</script>
