<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim><base target="_self"></c:verbatim>
<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
<c:verbatim>
    <table height=98% width=100%>
     <tr><td height=8 class="td_title" align="right">
</c:verbatim>
         <h:commandButton value="关闭" styleClass="button01" onclick="window.close();" type="button"></h:commandButton>
<c:verbatim>
     </td></tr>

    <tr><td>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
       <x:dataTable value="#{wage_flowBB.computeHis}" var="list" align="center"  id="dateList"   rowIndexVar="index"
                    headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                    styleClass="table03" width="95%" >
           <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
           </h:column>
          
           <h:column>
               <c:facet name="header"><h:outputText value="操作员"/></c:facet>
               <h:outputText value="#{list.operName}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="机器"/></c:facet>
               <h:outputText value="#{list.loginIP}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="计算时间"/></c:facet>
               <h:outputText value="#{list.computeDate}"/>
           </h:column>

       </x:dataTable>
<c:verbatim>
       </div>
       </td></tr>
</table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>