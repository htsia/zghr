<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function audit(){
          if (document.all('form1:auditResult').value==''){
              alert("请选择审批结果！")
              return false;
          }
          return true;
    }
    function audit2(){
          if (document.all('form1:auditResult2').value==''){
              alert("请选择审批结果！")
              return false;
          }
          return true;
    }
    function audit3(){
          if (document.all('form1:auditResult3').value==''){
              alert("请选择审批结果！")
              return false;
          }
          return true;
    }
    function audit4(){
          if (document.all('form1:auditResult4').value==''){
              alert("请选择审批结果！")
              return false;
          }
          return true;
    }
    function audit5(){
          if (document.all('form1:auditResult5').value==''){
              alert("请选择审批结果！")
              return false;
          }
          return true;
    }
    function audit6(){
          if (document.all('form1:auditResult6').value==''){
              alert("请选择审批结果！")
              return false;
          }
          return true;
    }
    function audit7(){
          if (document.all('form1:auditResult7').value==''){
              alert("请选择审批结果！")
              return false;
          }
          return true;
    }

</script>
<x:saveState value="#{emp_reduceAuditEditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_reduceAuditEditBB.pageInit}"/>
    <h:inputHidden value="#{emp_reduceAuditEditBB.operid}"/>
    <f:verbatim>
    <table  width=100%>
     <tr><td height=8 class=td_title>
    </f:verbatim>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="#{emp_reduceAuditEditBB.opername}"/>
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
                      <h:outputText value="申请时间"></h:outputText>
                      <h:outputText value="#{emp_reduceAuditEditBB.auditEditBO.applyDate}"></h:outputText>
                       <h:outputText value="姓名"></h:outputText>
                       <h:outputText value="#{emp_reduceAuditEditBB.auditEditBO.persName}"></h:outputText>

                      <h:outputText value="所在机构"></h:outputText>
                      <h:outputText value="#{emp_reduceAuditEditBB.auditEditBO.orgName}"></h:outputText>
                  </h:panelGrid>
           </h:panelGrid>
           <f:verbatim><br></f:verbatim>
    
            <h:panelGrid width="98%" align="center" rendered="#{emp_reduceAuditEditBB.auditEditBO.auditResult=='0' || emp_reduceAuditEditBB.auditEditBO.auditResult=='1' || emp_reduceAuditEditBB.auditEditBO.auditResult=='2'}">
                 <h:panelGrid align="left">
                    <h:outputText escape="false" value="<strong>#{emp_reduceAuditEditBB.title0372}</strong>"></h:outputText>
                 </h:panelGrid>

                 <h:selectOneMenu id="auditResult" value="#{emp_reduceAuditEditBB.auditEditBO.auditResult}" disabled="#{!emp_reduceAuditEditBB.auditEditBO.edit}">
                     <c:selectItems value="#{emp_reduceAuditEditBB.resultList}"></c:selectItems>
                 </h:selectOneMenu>
                 <h:inputTextarea value="#{emp_reduceAuditEditBB.auditEditBO.auditOption}" readonly="#{!emp_reduceAuditEditBB.auditEditBO.edit}" rows="3" cols="60"></h:inputTextarea>
                 <h:outputText rendered="#{!emp_reduceAuditEditBB.auditEditBO.edit}" value="#{emp_reduceAuditEditBB.auditEditBO.auditDate}   #{emp_reduceAuditEditBB.auditEditBO.audit1Name}"></h:outputText>
                <h:panelGrid align="right" rendered="#{emp_reduceAuditEditBB.auditEditBO.edit}">
                     <h:commandButton value="提交" styleClass="button01" action="#{emp_reduceAuditEditBB.audit0372}"></h:commandButton>
                </h:panelGrid>
                 <h:outputText escape="false" value="<br>"></h:outputText>
            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_reduceAuditEditBB.auditEditBO.auditResult2=='0' || emp_reduceAuditEditBB.auditEditBO.auditResult2=='1' || emp_reduceAuditEditBB.auditEditBO.auditResult2=='2'}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_reduceAuditEditBB.title0373}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneMenu id="auditResult2" value="#{emp_reduceAuditEditBB.auditEditBO.auditResult2}" disabled="#{!emp_reduceAuditEditBB.auditEditBO.edit2}">
                    <c:selectItems value="#{emp_reduceAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneMenu>
                <h:inputTextarea value="#{emp_reduceAuditEditBB.auditEditBO.auditOption2}" readonly="#{!emp_reduceAuditEditBB.auditEditBO.edit2}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_reduceAuditEditBB.auditEditBO.edit2}" value="#{emp_reduceAuditEditBB.auditEditBO.auditDate2}   #{emp_reduceAuditEditBB.auditEditBO.audit2Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_reduceAuditEditBB.auditEditBO.edit2}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_reduceAuditEditBB.audit0373}"></h:commandButton>
               </h:panelGrid>

                <h:outputText escape="false" value="<br>"></h:outputText>
            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_reduceAuditEditBB.auditEditBO.auditResult3=='0' || emp_reduceAuditEditBB.auditEditBO.auditResult3=='1' || emp_reduceAuditEditBB.auditEditBO.auditResult3=='2'}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_reduceAuditEditBB.title0374}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneMenu id="auditResult3" value="#{emp_reduceAuditEditBB.auditEditBO.auditResult3}" disabled="#{!emp_reduceAuditEditBB.auditEditBO.edit3}">
                    <c:selectItems value="#{emp_reduceAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneMenu>
                <h:inputTextarea value="#{emp_reduceAuditEditBB.auditEditBO.auditOption3}" readonly="#{!emp_reduceAuditEditBB.auditEditBO.edit3}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_reduceAuditEditBB.auditEditBO.edit3}" value="#{emp_reduceAuditEditBB.auditEditBO.auditDate3}   #{emp_reduceAuditEditBB.auditEditBO.audit3Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_reduceAuditEditBB.auditEditBO.edit3}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_reduceAuditEditBB.audit0374}"></h:commandButton>
               </h:panelGrid>

                <h:outputText escape="false" value="<br>"></h:outputText>
            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_reduceAuditEditBB.auditEditBO.auditResult4=='0' || emp_reduceAuditEditBB.auditEditBO.auditResult4=='1' || emp_reduceAuditEditBB.auditEditBO.auditResult4=='2'}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_reduceAuditEditBB.title0375}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneMenu id="auditResult4" value="#{emp_reduceAuditEditBB.auditEditBO.auditResult4}" disabled="#{!emp_reduceAuditEditBB.auditEditBO.edit4}">
                    <c:selectItems value="#{emp_reduceAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneMenu>
                <h:inputTextarea value="#{emp_reduceAuditEditBB.auditEditBO.auditOption4}" readonly="#{!emp_reduceAuditEditBB.auditEditBO.edit4}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_reduceAuditEditBB.auditEditBO.edit4}" value="#{emp_reduceAuditEditBB.auditEditBO.auditDate4}   #{emp_reduceAuditEditBB.auditEditBO.audit4Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_reduceAuditEditBB.auditEditBO.edit4}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_reduceAuditEditBB.audit0375}"></h:commandButton>
               </h:panelGrid>

                <h:outputText escape="false" value="<br>"></h:outputText>

            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_reduceAuditEditBB.auditEditBO.auditResult5=='0' || emp_reduceAuditEditBB.auditEditBO.auditResult5=='1' || emp_reduceAuditEditBB.auditEditBO.auditResult5=='2'}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_reduceAuditEditBB.title0376}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneMenu id="auditResult5" value="#{emp_reduceAuditEditBB.auditEditBO.auditResult5}" disabled="#{!emp_reduceAuditEditBB.auditEditBO.edit5}">
                    <c:selectItems value="#{emp_reduceAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneMenu>
                <h:inputTextarea value="#{emp_reduceAuditEditBB.auditEditBO.auditOption5}" readonly="#{!emp_reduceAuditEditBB.auditEditBO.edit5}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_reduceAuditEditBB.auditEditBO.edit5}" value="#{emp_reduceAuditEditBB.auditEditBO.auditDate5}   #{emp_reduceAuditEditBB.auditEditBO.audit5Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_reduceAuditEditBB.auditEditBO.edit5}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_reduceAuditEditBB.audit0376}"></h:commandButton>
               </h:panelGrid>

                <h:outputText escape="false" value="<br>"></h:outputText>

            </h:panelGrid>

            <h:panelGrid width="98%" align="center" rendered="#{emp_reduceAuditEditBB.auditEditBO.auditResult6=='0' || emp_reduceAuditEditBB.auditEditBO.auditResult6=='1' || emp_reduceAuditEditBB.auditEditBO.auditResult6=='2'}">
                <h:panelGrid align="left">
                   <h:outputText escape="false" value="<strong>#{emp_reduceAuditEditBB.title0377}</strong>"></h:outputText>
                </h:panelGrid>

                <h:selectOneMenu id="auditResult6" value="#{emp_reduceAuditEditBB.auditEditBO.auditResult6}" disabled="#{!emp_reduceAuditEditBB.auditEditBO.edit6}">
                    <c:selectItems value="#{emp_reduceAuditEditBB.resultList}"></c:selectItems>
                </h:selectOneMenu>
                <h:inputTextarea value="#{emp_reduceAuditEditBB.auditEditBO.auditOption6}" readonly="#{!emp_reduceAuditEditBB.auditEditBO.edit6}" rows="3" cols="60"></h:inputTextarea>
                <h:outputText rendered="#{!emp_reduceAuditEditBB.auditEditBO.edit6}" value="#{emp_reduceAuditEditBB.auditEditBO.auditDate6}   #{emp_reduceAuditEditBB.auditEditBO.audit6Name}"></h:outputText>
               <h:panelGrid align="right" rendered="#{emp_reduceAuditEditBB.auditEditBO.edit6}">
                    <h:commandButton value="提交" styleClass="button01" action="#{emp_reduceAuditEditBB.audit0377}"></h:commandButton>
               </h:panelGrid>

            </h:panelGrid>

    <h:panelGrid width="98%" align="center" rendered="#{emp_reduceAuditEditBB.auditEditBO.auditResult7=='0' || emp_reduceAuditEditBB.auditEditBO.auditResult7=='1' || emp_reduceAuditEditBB.auditEditBO.auditResult7=='2'}">
        <h:panelGrid align="left">
           <h:outputText escape="false" value="<strong>#{emp_reduceAuditEditBB.title0378}</strong>"></h:outputText>
        </h:panelGrid>

        <h:selectOneMenu id="auditResult7" value="#{emp_reduceAuditEditBB.auditEditBO.auditResult7}" disabled="#{!emp_reduceAuditEditBB.auditEditBO.edit7}">
            <c:selectItems value="#{emp_reduceAuditEditBB.resultList}"></c:selectItems>
        </h:selectOneMenu>
        <h:inputTextarea value="#{emp_reduceAuditEditBB.auditEditBO.auditOption7}" readonly="#{!emp_reduceAuditEditBB.auditEditBO.edit6}" rows="3" cols="60"></h:inputTextarea>
        <h:outputText rendered="#{!emp_reduceAuditEditBB.auditEditBO.edit7}" value="#{emp_reduceAuditEditBB.auditEditBO.auditDate7}   #{emp_reduceAuditEditBB.auditEditBO.audit7Name}"></h:outputText>
       <h:panelGrid align="right" rendered="#{emp_reduceAuditEditBB.auditEditBO.edit7}">
            <h:commandButton value="提交" styleClass="button01" action="#{emp_reduceAuditEditBB.audit0378}"></h:commandButton>
       </h:panelGrid>

    </h:panelGrid>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
