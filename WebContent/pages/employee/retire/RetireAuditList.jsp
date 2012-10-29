<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function audit(id){
        window.showModalDialog("/employee/retire/RetireAuditEdit.jsf?OperID="+document.all('form1:operid').value+"&itemID="+id, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");

    }
</script>
<x:saveState value="#{emp_personRetireAuditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_personRetireAuditBB.pageInit}"/>
    <h:inputHidden id="operid" value="#{emp_personRetireAuditBB.operid}"/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8 class=td_title>
    </f:verbatim>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="#{emp_personRetireAuditBB.opername}"/>
     <f:verbatim>
         </td>
      </tr>

     <tr><td align="top">
          <div style='width:100%;height:100%;overflow:auto' id=datatable>
  </f:verbatim>
          <h:dataTable value="#{emp_personRetireAuditBB.auditList}" var="list" align="center"  id="dateList"
                       headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                       styleClass="table03" width="95%" >
              <h:column>
                  <c:facet name="header"><h:outputText value="申请时间"/></c:facet>
                  <h:outputText value="#{list.applyDate}"/>
              </h:column>

              <h:column>
                  <c:facet name="header"><h:outputText value="人员姓名"/></c:facet>
                  <h:outputText value="#{list.persName}"/>
              </h:column>
              <h:column>
                  <c:facet name="header"><h:outputText value="入职部门"/></c:facet>
                  <h:outputText value="#{list.orgName}"/>
              </h:column>
              <h:column>
                  <c:facet name="header"><h:outputText value="操作"/></c:facet>
                  <h:commandButton styleClass="button01" value="查看流程" type="button" onclick="return showWorkFlowLogByLinkID('#{list.itemID}')"></h:commandButton>
                  <h:commandButton styleClass="button01" value="审批"  rendered="#{list.canAutit}" onclick="return audit('#{list.itemID}')"></h:commandButton>
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
