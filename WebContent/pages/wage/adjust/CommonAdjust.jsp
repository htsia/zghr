
<%@ page import="com.hr319wg.sys.pojo.bo.WFTypeBO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function setItem(id){
        window.showModalDialog("/wage/adjust/CommonAdjustEdit.jsf?itemID="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    function doOK(id){
        window.showModalDialog("/wage/adjust/validateAdjust.jsf?itemID="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    function setRule(){
        window.showModalDialog("/wage/adjust/OrgAdjustItemSet.jsf?Action=set", null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return false;
    }
</script>
    <x:saveState value="#{wage_commonAdjustBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{wage_commonAdjustBB.pageInit}"/>
        <c:verbatim><table width="98%" height="100%" align="center" cellpadding="0" cellspacing="0">
            <tr><td height="1">
        </c:verbatim>
        <h:panelGrid align="right" styleClass="locked_top">
         <h:panelGroup>
             <h:outputText value="��¼��:#{wage_commonAdjustBB.pagevo.totalRecord}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ҳ��:#{wage_commonAdjustBB.pagevo.totalPage}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ÿҳ��#{wage_commonAdjustBB.pagevo.pageSize}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="��ǰΪ��#{wage_commonAdjustBB.pagevo.currentPage}ҳ"></h:outputText>
             <h:commandButton value="��ҳ" action="#{wage_commonAdjustBB.first}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{wage_commonAdjustBB.pre}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{wage_commonAdjustBB.next}" styleClass="button01"></h:commandButton>
             <h:commandButton value="βҳ" action="#{wage_commonAdjustBB.last}" styleClass="button01"></h:commandButton>
             <h:commandButton value="����˵��" onclick="return showWorkDefine('<%=WFTypeBO.WAGE_ADJUST_AUDIT%>');" styleClass="button01" rendered="#{wage_commonAdjustBB.followFlow}"></h:commandButton>
             <h:commandButton value="����" onclick="return setRule('');" type="button"  styleClass="button01"></h:commandButton>
             <h:commandButton value="����" onclick="return fPopUpBackPerTreeDlg('');" action="#{wage_commonAdjustBB.selPerson}"  styleClass="button01"></h:commandButton>
         </h:panelGroup>
     </h:panelGrid>
        <c:verbatim>
            </td></tr>
            <tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
        </c:verbatim>
            <h:dataTable value="#{wage_commonAdjustBB.adjustList}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_left,td_middle,td_middle,td_middle_center"
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
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.adjustbo.adjustType}"/>
            </h:column>
                

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText escape="false" value="#{list.adjustDes}"/>
        </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                    <h:outputText value="#{list.adjustbo.statusDes}"/>
                </h:column>

        <h:column >
            <c:facet name="header" ><h:outputText value="����" style="width:120px"/></c:facet>
                <h:commandButton value="�ⶨ" styleClass="button01"  action="#{wage_commonAdjustBB.doQuery}" onclick="return setItem('#{list.adjustbo.itemID}');"  rendered="#{list.adjustbo.status=='0'}"/>
                <h:commandButton value="����" styleClass="button01"  action="#{wage_commonAdjustBB.doDelete}" rendered="#{list.adjustbo.status=='0'}">
                    <x:updateActionListener property="#{wage_commonAdjustBB.itemID}" value="#{list.adjustbo.itemID}"/>
                 </h:commandButton>
                <h:commandButton value="����" styleClass="button01"  action="#{wage_commonAdjustBB.doApply}" rendered="#{list.adjustbo.status=='0' && sys_commonInfoBB.wage_adjust_mode!='1'}">
                    <x:updateActionListener property="#{wage_commonAdjustBB.itemID}" value="#{list.adjustbo.itemID}"/>
                 </h:commandButton>
                <h:commandButton value="�鿴����" styleClass="button01"  type="button" rendered="#{sys_commonInfoBB.wage_adjust_mode!='1'}" onclick="showWorkFlowLogByLinkID('#{list.adjustbo.itemID}');"/>
                <h:commandButton value="��Ч" styleClass="button01" onclick="return doOK('#{list.adjustbo.itemID}');" action="#{wage_commonAdjustBB.doQuery}" rendered="#{list.adjustbo.status=='2' || (list.adjustbo.status=='0' && sys_commonInfoBB.wage_adjust_mode=='1')}"/>

        </h:column>

    </h:dataTable>
        <c:verbatim>
        </div></td></tr></table>
        </c:verbatim>
    </h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>