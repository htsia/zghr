<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<script type="text/javascript" language="javascript">
    function checkSelect(){
        var str=getAllSelectValue(document.form1.selected_ids,",");
        if (str==""){
            alert("��ѡ�����ݣ�");
            return false;
        }
        document.all("form1:ids").value=str;
        return true;
    }
    function changeStatus(){
         document.all("form1").submit();
    }
</script>

<x:saveState value="#{emp_selfauditBB}"/>
<h:form id="form1">
   <h:inputHidden value="#{emp_selfauditBB.beginUpdate}"/>
   <h:inputHidden id="ids" value="#{emp_selfauditBB.ids}"/>
  <f:verbatim>
   <table height=98% width=98% align="center">
    <tr><td height=8 colspan=2>
        <table width="50%" align="left">
            <tr>
                <td align="center" width="50%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/datachk/ChkList.jsf?Init=true">��Ϣ��ˣ��޸���Ϣ</a></td>
                <td align="center" width="50%" class=tab>&nbsp;<a href="/datachk/ChkInsertList.jsf?Init=true">��Ϣ��ˣ�������Ϣ</a></td>
            </tr>
        </table>
    </td></tr>

    <tr><td height=8 align="left">
  </f:verbatim>
         <h:outputText value="����Ա����š��������ƴ"></h:outputText>
         <h:inputText value="#{emp_selfauditBB.name}"></h:inputText>
         <h:commandButton value="��ѯ" styleClass="button01" action="#{emp_selfauditBB.doQueryUpdate}"></h:commandButton>
         <h:outputText escape="false" value="&nbsp;&nbsp;ѡ����Ϣ���״̬=>"></h:outputText>
         <h:selectOneMenu id="status" value="#{emp_selfauditBB.status}" onchange="changeStatus();" valueChangeListener="#{emp_selfauditBB.changeUpdateStuats}">
             <c:selectItem itemValue="0" itemLabel="������"></c:selectItem>
             <c:selectItem itemValue="1" itemLabel="��Ч"></c:selectItem>
             <c:selectItem itemValue="2" itemLabel="ȡ��"></c:selectItem>
         </h:selectOneMenu>
          <h:outputText value="  "></h:outputText>
         <h:selectOneMenu value="#{emp_selfauditBB.fieldID}" onchange="changeStatus();" valueChangeListener="#{emp_selfauditBB.changeUpdateField}">
              <c:selectItems value="#{emp_selfauditBB.fieldList}"></c:selectItems>
         </h:selectOneMenu>
<f:verbatim>
    </td>

    <tr>
     <td height=8 align="right">
 </f:verbatim>
       <h:outputText value="��¼��:#{emp_selfauditBB.pagevo.totalRecord}"></h:outputText>
       <h:outputText value="  "></h:outputText>
       <h:outputText value="ҳ��:#{emp_selfauditBB.pagevo.totalPage}"></h:outputText>
       <h:outputText value="  "></h:outputText>
       <h:outputText value="ÿҳ��#{emp_selfauditBB.pagevo.pageSize}"></h:outputText>
       <h:outputText value="  "></h:outputText>
       <h:outputText value="��ǰΪ��#{emp_selfauditBB.pageVO.currentPage}ҳ"></h:outputText>
       <h:commandButton value="��ҳ" action="#{emp_selfauditBB.first}" styleClass="button01"></h:commandButton>
       <h:commandButton value="��ҳ" action="#{emp_selfauditBB.pre}" styleClass="button01"></h:commandButton>
       <h:commandButton value="��ҳ" action="#{emp_selfauditBB.next}" styleClass="button01"></h:commandButton>
       <h:commandButton value="βҳ" action="#{emp_selfauditBB.last}" styleClass="button01"></h:commandButton>
       <h:outputText value="  "></h:outputText>
       <h:commandButton value="������Ч" id="ok" styleClass="button01"  onclick="return checkSelect();" action="#{emp_selfauditBB.executeBatchUpdate}"/>
       <h:commandButton value="����ȡ��" id="cancel" styleClass="button01"  onclick="return checkSelect();" action="#{emp_selfauditBB.cancelBatchUpdate}"/>
      <f:verbatim>
     </td></tr>

       <tr><td colspan=2>
         <div style='width:100%;height:100%;overflow:auto' id=datatable>
  </f:verbatim>
          <h:dataTable align="center" width="98%"  value="#{emp_selfauditBB.updateList}" var="list"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle"   id="dateList"
                     styleClass="table03">

              <h:column>
                   <c:facet name="header">
                       <c:verbatim escape="false">
                       <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                       </c:verbatim>
                    </c:facet>
                   <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                   <h:outputText value="#{list.itemID}"/>
                   <c:verbatim>"></c:verbatim>
               </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="�����"/></f:facet>
                <h:outputText value="#{list.persName}"/>
            </h:column>

              <h:column>
                  <f:facet name="header"><h:outputText value="����ʱ��"/></f:facet>
                  <h:outputText value="#{list.applyDate}"/>
              </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="�޸���Ŀ"/></f:facet>
                <h:outputText value="#{list.fieldDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="ԭֵ"/></f:facet>
                <h:outputText value="#{list.oldValueDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="��ֵ"/></f:facet>
                <h:outputText value="#{list.newValueDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="�޸�ԭ��"/></f:facet>
                <h:outputText value="#{list.reason}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="״̬"/></f:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="����"/></f:facet>
                <h:commandButton value="��Ч" styleClass="button01" rendered="#{list.status=='0'}" action="#{emp_selfauditBB.executeUpdate}">
                    <x:updateActionListener property="#{emp_selfauditBB.itemID}" value="#{list.itemID}"/>
                </h:commandButton>
                <h:commandButton value="ȡ��" styleClass="button01" rendered="#{list.status=='0'}" action="#{emp_selfauditBB.cancelUpdate}">
                    <x:updateActionListener property="#{emp_selfauditBB.itemID}" value="#{list.itemID}"/>
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
   if (document.all('form1:status').value=='0'){
       document.all('oper').style.display="block";
   }
   else{
       document.all('oper').style.display="none";
   }

</script>
