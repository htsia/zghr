<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function checkSelect(){
        if (checkMutilSelect(document.form1.selected_ids)){
             document.all('form1:batchItemID').value=getAllSelectValue(document.form1.selected_ids,'|');
        }
        else{
            alert("��ѡ�������Ŀ!")
            return false;
        }
        return true;
    }
    function changeStatus(){
         document.all("form1").submit();
    }

</script>

<x:saveState value="#{emp_selfauditBB}"/>
<h:form id="form1">
<h:inputHidden value="#{emp_selfauditBB.beginInsert}"/>
  <f:verbatim>
    <table height=98% width=98% align="center">
     <tr><td height=8 colspan="2">
        <table width="50%" align="left">
            <tr>
                <td align="center" width="50%" class=tab>&nbsp;<a href="/datachk/ChkList.jsf?Init=true">��Ϣ��ˣ��޸���Ϣ</a></td>
                <td align="center" width="50%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/datachk/ChkInsertList.jsf?Init=true">��Ϣ��ˣ�������Ϣ</a></td>
            </tr>
        </table>
    </td></tr>

    <tr><td height=8 align="left">
  </f:verbatim>
             <h:inputHidden id="batchItemID" value="#{emp_selfauditBB.batchItemID}"></h:inputHidden>
            <h:outputText value="����Ա����š��������ƴ"></h:outputText>
            <h:inputText value="#{emp_selfauditBB.name}"></h:inputText>
            <h:commandButton value="��ѯ" styleClass="button01" action="#{emp_selfauditBB.doQueryInsert}"></h:commandButton>
    
             <h:outputText value="ѡ����Ϣ���״̬=>"></h:outputText>
             <h:selectOneMenu id="status" value="#{emp_selfauditBB.status}" onchange="changeStatus();" valueChangeListener="#{emp_selfauditBB.changeStuats}">
                 <c:selectItem itemValue="0" itemLabel="������"></c:selectItem>
                 <c:selectItem itemValue="1" itemLabel="��Ч"></c:selectItem>
                 <c:selectItem itemValue="2" itemLabel="ȡ��"></c:selectItem>
             </h:selectOneMenu>
                <h:outputText value="  "></h:outputText>
                <h:selectOneMenu value="#{emp_selfauditBB.setID}" onchange="changeStatus();" valueChangeListener="#{emp_selfauditBB.changeSet}">
                     <c:selectItems value="#{emp_selfauditBB.setList}"></c:selectItems>
                </h:selectOneMenu>

    <f:verbatim>
        </td>
       </tr>
        <tr>
       <td height=8 id="oper"  align="right">
      </f:verbatim>
          <h:outputText value="��¼��:#{emp_selfauditBB.pagevo.totalRecord}"></h:outputText>
          <h:outputText value="  "></h:outputText>
          <h:outputText value="ҳ��:#{emp_selfauditBB.pagevo.totalPage}"></h:outputText>
          <h:outputText value="  "></h:outputText>
          <h:outputText value="ÿҳ��#{emp_selfauditBB.pagevo.pageSize}"></h:outputText>
          <h:outputText value="  "></h:outputText>
          <h:outputText value="��ǰΪ��#{emp_selfauditBB.pagevo.currentPage}ҳ"></h:outputText>
          <h:commandButton value="��ҳ" action="#{emp_selfauditBB.insertFirst}" styleClass="button01"></h:commandButton>
          <h:commandButton value="��ҳ" action="#{emp_selfauditBB.insertPre}" styleClass="button01"></h:commandButton>
          <h:commandButton value="��ҳ" action="#{emp_selfauditBB.insertNext}" styleClass="button01"></h:commandButton>
          <h:commandButton value="βҳ" action="#{emp_selfauditBB.insertLast}" styleClass="button01"></h:commandButton>
          <h:outputText value="  "></h:outputText>
        <h:commandButton styleClass="button01" value="������Ч"  onclick="return checkSelect();"  action="#{emp_selfauditBB.executeBatchInsert}"></h:commandButton>
        <h:commandButton styleClass="button01" value="����ȡ��"  onclick="return checkSelect();"  action="#{emp_selfauditBB.cancelBatchInsert}"></h:commandButton>
    
  <f:verbatim>
    </td></tr>

    <tr><td colspan="2"> 
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
  </f:verbatim>
            <h:dataTable align="center" width="98%"  value="#{emp_selfauditBB.insertList}" var="list" id="dateList"
                         headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle"
                         styleClass="table03">
           <h:column>
                <c:facet name="header">
                    <c:verbatim escape="false">
                    <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                    </c:verbatim>
                    </c:facet>
                <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                <h:outputText value="#{list.itemIDs}"/>
                <c:verbatim>"></c:verbatim>
            </h:column>

                <h:column>
                    <f:facet name="header"><h:outputText value="������"/></f:facet>
                    <h:outputText value="#{list.persName}"/>
                </h:column>

                <h:column>
                    <f:facet name="header"><h:outputText value="��Ϣ��"/></f:facet>
                    <h:outputText value="#{list.setIDDes}"/>
                </h:column>

                <h:column>
                    <f:facet name="header"><h:outputText value="��Ϣ��"/></f:facet>
                    <h:outputText escape="false" value="#{list.fields}"/>
                </h:column>

                <h:column>
                    <f:facet name="header"><h:outputText value="״̬"/></f:facet>
                    <h:outputText value="#{list.statusDes}"/>
                </h:column>

                <h:column>
                    <f:facet name="header"><h:outputText value="����"/></f:facet>
                    <h:commandButton value="��Ч" styleClass="button01" rendered="#{list.status=='0'}" action="#{emp_selfauditBB.executeInsert}">
                        <x:updateActionListener property="#{emp_selfauditBB.itemID}" value="#{list.itemIDs}"/>
                    </h:commandButton>
                    <h:commandButton value="ȡ��" styleClass="button01" rendered="#{list.status=='0'}" action="#{emp_selfauditBB.cancelInsert}">
                        <x:updateActionListener property="#{emp_selfauditBB.itemID}" value="#{list.itemIDs}"/>
                    </h:commandButton>
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
