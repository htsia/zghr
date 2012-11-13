<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    var allCount=120;
</script>
<script type="text/javascript" language="javascript" src="/pages/wage/payoff/ComputePersonList.js"></script>

<x:saveState value="#{wage_computeBB}"/>
<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_computeBB.pageInit}"/>
    <h:inputHidden id="deptpower" value="#{wage_computeBB.deptpower}"/>
    <h:inputHidden id="setId" value="#{wage_computeBB.setId}"/>
    <h:inputHidden id="unitId" value="#{wage_computeBB.unitId}"/>
    <h:inputHidden id="setName" value="#{wage_computeBB.setName}"/>
    <h:inputHidden id="unitName" value="#{wage_computeBB.unitName}"/>
    <h:inputHidden id="dateId" value="#{wage_computeBB.dateId}"/>
    <h:inputHidden id="payoffDate" value="#{wage_computeBB.payoffDate}"/>
    <h:inputHidden id="str" value=""/>
    <h:inputHidden id="ManyPerson" value="#{wage_computeBB.manyPerson}"/>
    <h:inputHidden id="addPerson" value=""/>
    <h:inputHidden id="deletePerson" value=""/>

    <c:verbatim>
    <table width=100% height=100% border=0 >
    <tr><td height=8px>
    </c:verbatim>
        <h:panelGrid styleClass="td_title" columns="2" width="99%" align="center" style="height:20px">
               <h:panelGroup>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="#{wage_computeBB.setName}"/>
                   <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                   <h:outputText value="#{wage_computeBB.payoffDate}"/>
                   <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                   <h:outputText escape="false" value="<font color=red>总计#{wage_computeBB.allCount}</font>"/>
               </h:panelGroup>

               <h:panelGrid  columns="3" align="right">
                   <h:panelGroup>
                       <h:selectOneMenu id="WageDept"  value="#{wage_computeBB.dept}">
                          <c:selectItems value="#{wage_computeBB.deptList}"></c:selectItems>
                       </h:selectOneMenu>
                       <h:commandButton styleClass="button01"value="过滤" action="#{wage_computeBB.queryPersonByDept}"/>
                   </h:panelGroup>
                   <h:commandButton type="button" value="发放工资" rendered="#{wage_computeBB.operPayoff}" styleClass="button01"  onclick="doPayoff();"/>
               </h:panelGrid>
        </h:panelGrid>

        <h:panelGrid  columns="5" width="99%" align="center">
             <h:panelGroup>
                 <h:outputText value="编号或姓名" />
                 <h:inputText value="" id="nameStr" style="width:100px" onkeypress ="enterKeyDown('form1:queryPerson');"/>
                 <h:commandButton id="queryPerson" value="查询" action="#{wage_computeBB.queryPersonByNameStr}" styleClass="button01"/>
                 <h:commandButton value="多人查询" action="#{wage_computeBB.queryMultiPerson}" onclick="doQueryManyPerson();" styleClass="button01"/>
                 <h:commandButton value="自定义查询" styleClass="button01"
                                  action="#{wage_computeBB.queryAdvance}"
                                  onclick="return doselfQuery();"/>
             </h:panelGroup>

             <h:panelGroup>
                 <h:selectOneMenu id="sortList" value="#{wage_computeBB.sortField}">
                    <c:selectItems value="#{wage_computeBB.sortList}"></c:selectItems>
                 </h:selectOneMenu>
                 <h:outputText value="排序" ></h:outputText>
                 <h:selectBooleanCheckbox value="#{wage_computeBB.bysort}"></h:selectBooleanCheckbox>
                 <h:commandButton value="求和" type="button" styleClass="button01" onclick="return beginGroup();"/>
                 <h:commandButton value="分类" type="button" styleClass="button01" onclick="return beginClass();"/>
             </h:panelGroup>

             <h:panelGroup>
                 <h:selectOneMenu value="#{wage_computeBB.itemType}">
                     <c:selectItems value="#{wage_computeBB.itemTypeList}"></c:selectItems>
                 </h:selectOneMenu>
                 <h:commandButton value="确定" styleClass="button01" action="#{wage_computeBB.queryPersonBySetId}"/>
                 <h:commandButton value="设置显示项" rendered="#{wage_computeBB.operCompute}" styleClass="button01"
                                  action="#{wage_computeBB.saveShowItem}" onclick="return doShowItem()" />

                <h:selectOneMenu id="condition"  value="#{wage_computeBB.qryID}">
                   <c:selectItems value="#{wage_computeBB.displaySetList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value="过滤" action="#{wage_computeBB.queryByCondition}"/>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid columns="12" width="99%" align="center">
             <h:panelGroup>
                 <h:selectOneMenu id="ReportID" style="width:190px">
                     <c:selectItems value="#{wage_computeBB.reportList}"/>
                 </h:selectOneMenu>
                 <h:commandButton value="导出excel" type="button" styleClass="button01" onclick="return OpenRpt();"/>
             </h:panelGroup>

             <h:panelGroup>
                 <h:commandButton value="常量" rendered="#{wage_computeBB.canModifyData}" styleClass="button01"
                                   onclick="return doSetConst()"/>

                 <h:commandButton value="卡片" type="button" rendered="#{wage_computeBB.canShowCard}" styleClass="button01" onclick="return doViewCard();"/>
                 <h:commandButton value="修改排序" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                                  action="#{wage_computeBB.turnPageQuery}"
                                  onclick="return doOrderInput()"/>
                 <h:commandButton value="重排编号" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                                  action="#{wage_computeBB.saveNewOrder}"
                                  onclick="return doOrderCalc()"/>
             </h:panelGroup>

             <h:panelGroup>
                 <h:commandButton value="选择计算" rendered="#{wage_computeBB.canComputer}" styleClass="button01"
                                  action="#{wage_computeBB.computePart}" onclick="return doCheckSelect()"/>
                 <h:commandButton value="全部计算" rendered="#{wage_computeBB.canComputer}" styleClass="button01"
                                  action="#{wage_computeBB.computeAll}" onclick="return refreshList()"/>
                 <h:commandButton value="对比" rendered="#{wage_computeBB.canComputer}" styleClass="button01" type="button"
                                   onclick="showdiff();return false;"/>
                 <h:commandButton value="部门对比" type="button" onclick="return showDeptdiff();" styleClass="button01"/>
                 <h:commandButton value="汇总" rendered="#{wage_computeBB.canGather}" styleClass="button01" type="button"
                                   onclick="showSum();return false;"/>
                 <h:commandButton value="校验" rendered="#{wage_computeBB.canComputer}" styleClass="button01" type="button"
                                   onclick="doCheckDate();return false;"/>
                 <h:outputText value="  "/>
                 <h:commandButton value="暂停工资" styleClass="button01"    rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.deleteSet}"
                                 onclick="return doDelete();"/>
                 <h:commandButton value="恢复工资" styleClass="button01"    rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.restoreSet}"
                                 onclick="return doRestore();"/>
              </h:panelGroup>
         </h:panelGrid>
       
<c:verbatim>
        </td>
    </tr>

    <tr><td>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
        <jsp:param name="keyName" value="ID"/>
        <jsp:param name="fixcol" value="4"/>
        <jsp:param name="rowFuncName" value="forViewPerson"/>
        <jsp:param name="maskError" value="true"/>
        <jsp:param name="maskWarn" value="true"/>
        <jsp:param name="WageList" value="true"/>
    </jsp:include>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
