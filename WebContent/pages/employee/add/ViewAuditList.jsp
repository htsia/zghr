<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function audit(id){
        window.showModalDialog("/employee/add/AddAuditEdit.jsf?OperID="+document.all('form1:operid').value+"&itemID="+id, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    function OpenRpt(itemID,personID){
        if (document.all("form1:ReportID").value=="-1"){
            alert("����ѡ������ʽ��");
            return false;
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+personID+"&ORGUID=&Parameter="+itemID+"&Title=";
        window.open(url);
       return false;
   }
    
</script>
<x:saveState value="#{emp_personAddListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_personAddListBB.pageInit}"/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8 class=td_title>
    </f:verbatim>
               <h:graphicImage value="/images/tips.gif" />
               <h:outputText value="�����������Ա"/>
     <f:verbatim>
         </td>
      </tr>

         <tr><td height=8 align="right">
        </f:verbatim>
            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{emp_personAddListBB.regTableList}"/>
            </h:selectOneMenu>
         <f:verbatim>
             </td>
          </tr>

     <tr><td align="top">
          <div style='width:100%;height:100%;overflow:auto' id=datatable>
  </f:verbatim>
          <h:dataTable value="#{emp_personAddListBB.auditList}" var="list" align="center"  id="dateList"
                       headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                       styleClass="table03" width="95%" >
              <h:column>
                  <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                  <h:outputText value="#{list.applyDate}"/>
              </h:column>

              <h:column>
                  <c:facet name="header"><h:outputText value="��Ա����"/></c:facet>
                  <h:outputText value="#{list.personName}"/>
              </h:column>
              <h:column>
                  <c:facet name="header"><h:outputText value="��ְ����"/></c:facet>
                  <h:outputText value="#{list.deptName}"/>
              </h:column>
              <h:column>
                  <c:facet name="header"><h:outputText value="��ְ��λ"/></c:facet>
                  <h:outputText value="#{list.postName}"/>
              </h:column>
              <h:column>
                  <c:facet name="header"><h:outputText value="����"/></c:facet>
                  <h:commandButton styleClass="button01" value="�鿴����" type="button" onclick="return showWorkFlowLogByLinkID('#{list.itemID}')"></h:commandButton>
                  <h:commandButton styleClass="button01" type="button" value="��ʾ���" onclick="OpenRpt('#{list.itemID}','#{list.personID}');"></h:commandButton>
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
