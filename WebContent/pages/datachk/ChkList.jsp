<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<script type="text/javascript" language="javascript">
    function checkSelect(){
        var str=getAllSelectValue(document.form1.selected_ids,",");
        if (str==""){
            alert("请选择数据！");
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
                <td align="center" width="50%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/datachk/ChkList.jsf?Init=true">信息审核－修改信息</a></td>
                <td align="center" width="50%" class=tab>&nbsp;<a href="/datachk/ChkInsertList.jsf?Init=true">信息审核－新增信息</a></td>
            </tr>
        </table>
    </td></tr>

    <tr><td height=8 align="left">
  </f:verbatim>
         <h:outputText value="输入员工编号、姓名或简拼"></h:outputText>
         <h:inputText value="#{emp_selfauditBB.name}"></h:inputText>
         <h:commandButton value="查询" styleClass="button01" action="#{emp_selfauditBB.doQueryUpdate}"></h:commandButton>
         <h:outputText escape="false" value="&nbsp;&nbsp;选择信息审核状态=>"></h:outputText>
         <h:selectOneMenu id="status" value="#{emp_selfauditBB.status}" onchange="changeStatus();" valueChangeListener="#{emp_selfauditBB.changeUpdateStuats}">
             <c:selectItem itemValue="0" itemLabel="待审批"></c:selectItem>
             <c:selectItem itemValue="1" itemLabel="生效"></c:selectItem>
             <c:selectItem itemValue="2" itemLabel="取消"></c:selectItem>
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
       <h:outputText value="记录数:#{emp_selfauditBB.pagevo.totalRecord}"></h:outputText>
       <h:outputText value="  "></h:outputText>
       <h:outputText value="页数:#{emp_selfauditBB.pagevo.totalPage}"></h:outputText>
       <h:outputText value="  "></h:outputText>
       <h:outputText value="每页有#{emp_selfauditBB.pagevo.pageSize}"></h:outputText>
       <h:outputText value="  "></h:outputText>
       <h:outputText value="当前为第#{emp_selfauditBB.pageVO.currentPage}页"></h:outputText>
       <h:commandButton value="首页" action="#{emp_selfauditBB.first}" styleClass="button01"></h:commandButton>
       <h:commandButton value="上页" action="#{emp_selfauditBB.pre}" styleClass="button01"></h:commandButton>
       <h:commandButton value="下页" action="#{emp_selfauditBB.next}" styleClass="button01"></h:commandButton>
       <h:commandButton value="尾页" action="#{emp_selfauditBB.last}" styleClass="button01"></h:commandButton>
       <h:outputText value="  "></h:outputText>
       <h:commandButton value="批量生效" id="ok" styleClass="button01"  onclick="return checkSelect();" action="#{emp_selfauditBB.executeBatchUpdate}"/>
       <h:commandButton value="批量取消" id="cancel" styleClass="button01"  onclick="return checkSelect();" action="#{emp_selfauditBB.cancelBatchUpdate}"/>
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
                <f:facet name="header"><h:outputText value="变更人"/></f:facet>
                <h:outputText value="#{list.persName}"/>
            </h:column>

              <h:column>
                  <f:facet name="header"><h:outputText value="申请时间"/></f:facet>
                  <h:outputText value="#{list.applyDate}"/>
              </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="修改项目"/></f:facet>
                <h:outputText value="#{list.fieldDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="原值"/></f:facet>
                <h:outputText value="#{list.oldValueDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="新值"/></f:facet>
                <h:outputText value="#{list.newValueDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="修改原因"/></f:facet>
                <h:outputText value="#{list.reason}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="状态"/></f:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="操作"/></f:facet>
                <h:commandButton value="生效" styleClass="button01" rendered="#{list.status=='0'}" action="#{emp_selfauditBB.executeUpdate}">
                    <x:updateActionListener property="#{emp_selfauditBB.itemID}" value="#{list.itemID}"/>
                </h:commandButton>
                <h:commandButton value="取消" styleClass="button01" rendered="#{list.status=='0'}" action="#{emp_selfauditBB.cancelUpdate}">
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
