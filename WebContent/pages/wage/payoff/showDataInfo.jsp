<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   
    <script type="text/javascript">
         function checkNull(){
             if (document.all('form1:name').value==""){
                 alert("��¼����������ƴ���ţ�");
                 return false;
             }
             return true;
         }
    </script>

<x:saveState value="#{wage_dataChangeBB}"/>
<h:form id="form1">
<c:verbatim>
<table height=98% width=100%>
     <tr><td height=8 class="td_title" align="right">
        <h:inputHidden value="#{wage_dataChangeBB.pageInit}"></h:inputHidden>
</c:verbatim>
        <h:outputText value="��¼��:#{wage_dataChangeBB.pagevo.totalRecord}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="ҳ��:#{wage_dataChangeBB.pagevo.totalPage}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="ÿҳ��#{wage_dataChangeBB.pagevo.pageSize}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="��ǰΪ��#{wage_dataChangeBB.pagevo.currentPage}ҳ"></h:outputText>
        <h:commandButton value="��ҳ" action="#{wage_dataChangeBB.first}" styleClass="button01"></h:commandButton>
        <h:commandButton value="��ҳ" action="#{wage_dataChangeBB.pre}" styleClass="button01"></h:commandButton>
        <h:commandButton value="��ҳ" action="#{wage_dataChangeBB.next}" styleClass="button01"></h:commandButton>
        <h:commandButton value="βҳ" action="#{wage_dataChangeBB.last}" styleClass="button01"></h:commandButton>
        <h:commandButton value="�ر�" styleClass="button01" onclick="window.close();" type="button" ></h:commandButton>
<c:verbatim>
    </td></tr>

    <tr><td height=8  align="right">
</c:verbatim>
        <h:outputText value="����"></h:outputText>
        <h:inputText id="name" value="#{wage_dataChangeBB.name}"></h:inputText>
        <h:commandButton value="��ѯ" styleClass="button01"  action="#{wage_dataChangeBB.first}"></h:commandButton>
<c:verbatim>
    </td></tr>

    <tr><td>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
       <x:dataTable value="#{wage_dataChangeBB.dataInfo}" var="list" align="center"  id="dateList"   rowIndexVar="index"
                    headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                    styleClass="table03" width="95%" >
           <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
           </h:column>
          
           <h:column>
               <c:facet name="header"><h:outputText value="ʱ��"/></c:facet>
               <h:outputText value="#{list.modiDate}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="����Ա"/></c:facet>
               <h:outputText value="#{list.operName}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="��Ա"/></c:facet>
               <h:outputText value="#{list.personName}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="�޸��ֶ�"/></c:facet>
               <h:outputText value="#{list.fieldName}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="ԭֵ"/></c:facet>
               <h:outputText value="#{list.oldValue}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="��ֵ"/></c:facet>
               <h:outputText value="#{list.newValue}"/>
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