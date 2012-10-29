<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<c:verbatim>
    <script type="text/javascript">
    </script>
</c:verbatim>

<x:saveState value="#{wage_inputManagerBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{wage_inputManagerBB.initAuditInput}"></h:inputHidden>
      <h:inputHidden id="dateID" value="#{wage_inputManagerBB.dateId}"></h:inputHidden>
<c:verbatim>
       <table height=98% width=98% align="center">
            <tr>
                 <td height=8 align="right" class="td_title">
</c:verbatim>
                    <h:outputText value="请选择用户"></h:outputText>
                    <h:selectOneMenu id="personID" value="#{wage_inputManagerBB.personID}">
                        <c:selectItems value="#{wage_inputManagerBB.personList}"></c:selectItems>
                    </h:selectOneMenu>
                    <h:commandButton value="审核通过"  styleClass="button01" action="#{wage_inputManagerBB.auditOK}"></h:commandButton>
                    <h:commandButton value="审核未通过"  styleClass="button01" action="#{wage_inputManagerBB.auditNO}"></h:commandButton>
                    <h:commandButton value="关闭" type="button" onclick="window.close();" styleClass="button01"></h:commandButton>
<c:verbatim>
                </td>
            </tr>


           <tr><td>
               <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
               <h:dataTable value="#{wage_inputManagerBB.inputList}" var="list" align="left"  id="dateList"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle"
                 styleClass="table03"  >
                    <h:column>
                        <c:facet name="header"><h:outputText value="录入人员" style="width:220px"/></c:facet>
                        <h:outputText value="#{list.inputName}"></h:outputText>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="审核状态" style="width:100px"/></c:facet>
                        <h:outputText value="#{list.statusDes}"></h:outputText>
                    </h:column>
                  </h:dataTable>
<c:verbatim>
               </div>
           </td></tr>
        </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>