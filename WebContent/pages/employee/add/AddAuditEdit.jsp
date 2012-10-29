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
<x:saveState value="#{emp_personAddAuditEditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_personAddAuditEditBB.pageInit}"/>
    <h:inputHidden value="#{emp_personAddAuditEditBB.operid}"/>
    <f:verbatim>
    <table  width=100%>
     <tr><td height=8 class=td_title>
    </f:verbatim>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="#{emp_personAddAuditEditBB.opername}"/>
     <f:verbatim>
         </td>
      </tr>
      </table>

    </f:verbatim>
           <h:panelGrid width="98%" align="center" columns="1">
                 <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>基本情况:</strong>"></h:outputText>
                 </h:panelGrid>
               <h:panelGrid align="right">
                   <h:selectOneMenu id="ReportID" style="width:190px">
                       <c:selectItems value="#{emp_personAddAuditEditBB.regTableList}"/>
                   </h:selectOneMenu>
                   <h:commandButton styleClass="button01" type="button" value="显示表格" onclick="OpenRpt('#{emp_personAddAuditEditBB.auditEditBO.itemID}','#{emp_personAddAuditEditBB.auditEditBO.personID}');"></h:commandButton>
               </h:panelGrid>

                  <h:panelGrid align="left" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
                      <h:outputText value="申请时间"></h:outputText>
                      <h:outputText value="#{emp_personAddAuditEditBB.auditEditBO.applyDate}"></h:outputText>
                       <h:outputText value="姓名"></h:outputText>
                       <h:outputText value="#{emp_personAddAuditEditBB.auditEditBO.personName}"></h:outputText>

                      <h:outputText value="所在部门"></h:outputText>
                      <h:outputText value="#{emp_personAddAuditEditBB.auditEditBO.deptName}"></h:outputText>
                      <h:outputText value="所在岗位"></h:outputText>
                      <h:outputText value="#{emp_personAddAuditEditBB.auditEditBO.postName}"></h:outputText>
                  </h:panelGrid>
           </h:panelGrid>
           <f:verbatim><br></f:verbatim>
    
            <h:panelGrid width="98%" align="center" rendered="#{emp_personAddAuditEditBB.auditEditBO.use1}">
                 <h:panelGrid align="left">
                    <h:outputText escape="false" value="<strong>#{emp_personAddAuditEditBB.title0333}</strong>"></h:outputText>
                 </h:panelGrid>

                 <h:selectOneRadio value="#{emp_personAddAuditEditBB.auditEditBO.audit1Result}" disabled="#{!emp_personAddAuditEditBB.auditEditBO.edit1}">
                     <c:selectItems value="#{emp_personAddAuditEditBB.resultList}"></c:selectItems>
                 </h:selectOneRadio>
                 <h:inputTextarea value="#{emp_personAddAuditEditBB.auditEditBO.audit1Memo}" readonly="#{!emp_personAddAuditEditBB.auditEditBO.edit1}" rows="3" cols="60"></h:inputTextarea>
                 <h:outputText rendered="#{!emp_personAddAuditEditBB.auditEditBO.edit1}" value="#{emp_personAddAuditEditBB.auditEditBO.audit1Date}   #{emp_personAddAuditEditBB.auditEditBO.audit1Name}"></h:outputText>
                <h:panelGrid align="right" rendered="#{emp_personAddAuditEditBB.auditEditBO.edit1}">
                     <h:commandButton value="提交" styleClass="button01" action="#{emp_personAddAuditEditBB.audit0333}"></h:commandButton>
                </h:panelGrid>
                 <h:outputText escape="false" value="<br>"></h:outputText>
            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_personAddAuditEditBB.auditEditBO.use2}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_personAddAuditEditBB.title0334}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneRadio value="#{emp_personAddAuditEditBB.auditEditBO.audit2Result}" disabled="#{!emp_personAddAuditEditBB.auditEditBO.edit2}">
                    <c:selectItems value="#{emp_personAddAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneRadio>
                <h:inputTextarea value="#{emp_personAddAuditEditBB.auditEditBO.audit2Memo}" readonly="#{!emp_personAddAuditEditBB.auditEditBO.edit2}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_personAddAuditEditBB.auditEditBO.edit2}" value="#{emp_personAddAuditEditBB.auditEditBO.audit2Date}   #{emp_personAddAuditEditBB.auditEditBO.audit2Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_personAddAuditEditBB.auditEditBO.edit2}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_personAddAuditEditBB.audit0334}"></h:commandButton>
               </h:panelGrid>

                <h:outputText escape="false" value="<br>"></h:outputText>
            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_personAddAuditEditBB.auditEditBO.use3}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_personAddAuditEditBB.title0335}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneRadio value="#{emp_personAddAuditEditBB.auditEditBO.audit3Result}" disabled="#{!emp_personAddAuditEditBB.auditEditBO.edit3}">
                    <c:selectItems value="#{emp_personAddAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneRadio>
                <h:inputTextarea value="#{emp_personAddAuditEditBB.auditEditBO.audit3Memo}" readonly="#{!emp_personAddAuditEditBB.auditEditBO.edit3}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_personAddAuditEditBB.auditEditBO.edit3}" value="#{emp_personAddAuditEditBB.auditEditBO.audit3Date}   #{emp_personAddAuditEditBB.auditEditBO.audit3Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_personAddAuditEditBB.auditEditBO.edit3}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_personAddAuditEditBB.audit0335}"></h:commandButton>
               </h:panelGrid>

                <h:outputText escape="false" value="<br>"></h:outputText>
            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_personAddAuditEditBB.auditEditBO.use4}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_personAddAuditEditBB.title0337}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneRadio value="#{emp_personAddAuditEditBB.auditEditBO.audit4Result}" disabled="#{!emp_personAddAuditEditBB.auditEditBO.edit4}">
                    <c:selectItems value="#{emp_personAddAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneRadio>
                <h:inputTextarea value="#{emp_personAddAuditEditBB.auditEditBO.audit4Memo}" readonly="#{!emp_personAddAuditEditBB.auditEditBO.edit4}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_personAddAuditEditBB.auditEditBO.edit4}" value="#{emp_personAddAuditEditBB.auditEditBO.audit4Date}   #{emp_personAddAuditEditBB.auditEditBO.audit4Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_personAddAuditEditBB.auditEditBO.edit4}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_personAddAuditEditBB.audit0337}"></h:commandButton>
               </h:panelGrid>

                <h:outputText escape="false" value="<br>"></h:outputText>

            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_personAddAuditEditBB.auditEditBO.use5}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_personAddAuditEditBB.title0338}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneRadio value="#{emp_personAddAuditEditBB.auditEditBO.audit5Result}" disabled="#{!emp_personAddAuditEditBB.auditEditBO.edit5}">
                    <c:selectItems value="#{emp_personAddAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneRadio>
                <h:inputTextarea value="#{emp_personAddAuditEditBB.auditEditBO.audit5Memo}" readonly="#{!emp_personAddAuditEditBB.auditEditBO.edit5}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_personAddAuditEditBB.auditEditBO.edit5}" value="#{emp_personAddAuditEditBB.auditEditBO.audit5Date}   #{emp_personAddAuditEditBB.auditEditBO.audit5Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_personAddAuditEditBB.auditEditBO.edit5}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_personAddAuditEditBB.audit0338}"></h:commandButton>
               </h:panelGrid>

                <h:outputText escape="false" value="<br>"></h:outputText>

            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_personAddAuditEditBB.auditEditBO.use6}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_personAddAuditEditBB.title0339}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneRadio value="#{emp_personAddAuditEditBB.auditEditBO.audit6Result}" disabled="#{!emp_personAddAuditEditBB.auditEditBO.edit6}">
                    <c:selectItems value="#{emp_personAddAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneRadio>
                <h:inputTextarea value="#{emp_personAddAuditEditBB.auditEditBO.audit6Memo}" readonly="#{!emp_personAddAuditEditBB.auditEditBO.edit6}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_personAddAuditEditBB.auditEditBO.edit6}" value="#{emp_personAddAuditEditBB.auditEditBO.audit6Date}   #{emp_personAddAuditEditBB.auditEditBO.audit6Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_personAddAuditEditBB.auditEditBO.edit6}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_personAddAuditEditBB.audit0339}"></h:commandButton>
               </h:panelGrid>

            </h:panelGrid>


</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
