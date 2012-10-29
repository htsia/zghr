<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function OpenRpt(itemID,personID){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+personID+"&ORGUID=&Parameter="+itemID+"&Title=";
        window.open(url);
       return false;
   }
</script>
<x:saveState value="#{wage_AdjustAuditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_AdjustAuditBB.initAudit}"/>
    <h:inputHidden value="#{wage_AdjustAuditBB.operID}"/>
    <f:verbatim>
    <table  width=100%>
     <tr><td height=8 class=td_title>
    </f:verbatim>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="#{wage_AdjustAuditBB.operName}"/>
     <f:verbatim>
         </td>
      </tr>
      </table>

    </f:verbatim>
           <h:panelGrid width="98%" align="center" columns="1">
                 <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>基本情况:</strong>"></h:outputText>
                 </h:panelGrid>
                  <h:panelGrid align="left" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
                      <h:outputText value="单位"></h:outputText>
                      <h:outputText value="#{wage_AdjustAuditBB.adjustvo.adjustbo.orgName}"></h:outputText>

                       <h:outputText value="姓名"></h:outputText>
                       <h:outputText value="#{wage_AdjustAuditBB.adjustvo.adjustbo.personName}"></h:outputText>
                  </h:panelGrid>

               <h:panelGrid align="left">
                 <h:outputText escape="false" value="<strong>调整情况:</strong>"></h:outputText>
               </h:panelGrid>

               <x:dataTable value="#{wage_AdjustAuditBB.adjustvo.itemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >

        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="指标项"/></c:facet>
            <h:outputText value="#{list.fieldName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="原值"/></c:facet>
            <h:outputText value="#{list.oldValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="新值"/></c:facet>
            <h:outputText value="#{list.newValue}"/>
        </h:column>

    </x:dataTable>
           </h:panelGrid>

     <h:panelGrid width="98%" align="center" rendered="#{wage_AdjustAuditBB.adjustvo.use1}">
          <h:panelGrid align="left">
             <h:outputText escape="false" value="<strong>#{wage_AdjustAuditBB.title0683}</strong>"></h:outputText>
          </h:panelGrid>

          <h:selectOneRadio value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit1Result}" disabled="#{!wage_AdjustAuditBB.adjustvo.edit1}">
              <c:selectItems value="#{wage_AdjustAuditBB.resultList}"></c:selectItems>
          </h:selectOneRadio>
          <h:inputTextarea value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit1Reason}" readonly="#{!wage_AdjustAuditBB.adjustvo.edit1}" rows="3" cols="60"></h:inputTextarea>
         <h:panelGrid columns="3" align="right" >
              <h:outputText value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit1Date}"></h:outputText>
              <h:outputText value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit1OperName}"></h:outputText>
              <h:commandButton value="提交" styleClass="button01" action="#{wage_AdjustAuditBB.submit0683}" rendered="#{wage_AdjustAuditBB.adjustvo.edit1}"></h:commandButton>
         </h:panelGrid>
          <h:outputText escape="false" value="<br>"></h:outputText>
     </h:panelGrid>

     <h:panelGrid width="98%" align="center" rendered="#{wage_AdjustAuditBB.adjustvo.use2}">
          <h:panelGrid align="left" >
             <h:outputText escape="false" value="<strong>#{wage_AdjustAuditBB.title0684}</strong>"></h:outputText>
          </h:panelGrid>

          <h:selectOneRadio value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit2Result}" disabled="#{!wage_AdjustAuditBB.adjustvo.edit2}">
              <c:selectItems value="#{wage_AdjustAuditBB.resultList}"></c:selectItems>
          </h:selectOneRadio>
          <h:inputTextarea value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit2Reason}" readonly="#{!wage_AdjustAuditBB.adjustvo.edit2}" rows="3" cols="60"></h:inputTextarea>
         <h:panelGrid align="right" columns="3">
             <h:outputText value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit2Date}"></h:outputText>
             <h:outputText value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit2OperName}"></h:outputText>
              <h:commandButton value="提交" styleClass="button01" action="#{wage_AdjustAuditBB.submit0684}" rendered="#{wage_AdjustAuditBB.adjustvo.edit2}"></h:commandButton>
         </h:panelGrid>
          <h:outputText escape="false" value="<br>"></h:outputText>
     </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{wage_AdjustAuditBB.adjustvo.use3}">
                 <h:panelGrid align="left">
                    <h:outputText escape="false" value="<strong>#{wage_AdjustAuditBB.title0685}</strong>"></h:outputText>
                 </h:panelGrid>

                 <h:selectOneRadio value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit3Result}" disabled="#{!wage_AdjustAuditBB.adjustvo.edit3}">
                     <c:selectItems value="#{wage_AdjustAuditBB.resultList}"></c:selectItems>
                 </h:selectOneRadio>
                 <h:inputTextarea value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit3Reason}" readonly="#{!wage_AdjustAuditBB.adjustvo.edit3}" rows="3" cols="60"></h:inputTextarea>
                <h:panelGrid align="right" columns="3">
                    <h:outputText value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit3Date}"></h:outputText>
                    <h:outputText value="#{wage_AdjustAuditBB.adjustvo.adjustbo.audit3OperName}"></h:outputText>
                     <h:commandButton value="提交" styleClass="button01" action="#{wage_AdjustAuditBB.submit0685}" rendered="#{wage_AdjustAuditBB.adjustvo.edit3}"></h:commandButton>
                </h:panelGrid>
                 <h:outputText escape="false" value="<br>"></h:outputText>
            </h:panelGrid>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
