<%@ page import="com.hr319wg.sys.pojo.bo.WFTypeBO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function auditItem(id){
        window.showModalDialog("/wage/adjust/AuditAdjustEdit.jsf?OperID="+document.all("form1:operID").value+"&ItemID="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }

</script>
    <x:saveState value="#{wage_AdjustAuditBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{wage_AdjustAuditBB.pageInit}"/>
        <h:inputHidden id="operID" value="#{wage_AdjustAuditBB.operID}"></h:inputHidden>
        <c:verbatim><table width="98%" align="center" cellpadding="0" cellspacing="0">
            <tr><td>
        </c:verbatim>
        <h:panelGrid align="right" styleClass="locked_top">
         <h:panelGroup>
             <h:outputText value="��¼��:#{wage_AdjustAuditBB.pagevo.totalRecord}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ҳ��:#{wage_AdjustAuditBB.pagevo.totalPage}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ÿҳ��#{wage_AdjustAuditBB.pagevo.pageSize}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="��ǰΪ��#{wage_AdjustAuditBB.pagevo.currentPage}ҳ"></h:outputText>
             <h:commandButton value="��ҳ" action="#{wage_AdjustAuditBB.first}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{wage_AdjustAuditBB.pre}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{wage_AdjustAuditBB.next}" styleClass="button01"></h:commandButton>
             <h:commandButton value="βҳ" action="#{wage_AdjustAuditBB.last}" styleClass="button01"></h:commandButton>
         </h:panelGroup>
     </h:panelGrid>
        <c:verbatim>
            </td></tr>
            
            <tr><td>
        </c:verbatim>
            <h:dataTable value="#{wage_AdjustAuditBB.adjustList}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="95%" >
                <h:column>
                    <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                    <h:outputText value="#{list.adjustbo.applyDate}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="��λ"/></c:facet>
                    <h:outputText value="#{list.adjustbo.orgName}"/>
                </h:column>
                         
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.adjustbo.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText escape="false" value="#{list.adjustDes}"/>
        </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                    <h:outputText value="#{list.adjustbo.statusDes}"/>
                </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="����" styleClass="button01"  onclick="return auditItem('#{list.adjustbo.itemID}');" rendered="#{list.adjustbo.status=='1'}" action="#{wage_AdjustAuditBB.first}"/>
                <h:commandButton value="�鿴����" styleClass="button01"  type="button" onclick="showWorkFlowLogByLinkID('#{list.adjustbo.itemID}');"/>
        </h:column>

    </h:dataTable>
        <c:verbatim>
        </td></tr></table>
        </c:verbatim>
    </h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>