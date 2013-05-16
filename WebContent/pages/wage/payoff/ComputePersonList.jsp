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
    <tr><td><div style='width: 100%; height: 100%; overflow: auto'>
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
                   <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                   <h:outputText escape="false" value="<font color=red>多段#{wage_computeBB.manyDeptCount}</font>"/>
                   <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                   
               </h:panelGroup>

               <h:panelGrid  columns="3" align="left">
                   <h:panelGroup>
                       <h:outputText escape="false" value="<font color='red'>底限报警:</font>" style=""></h:outputText>
                       <h:commandButton action="#{wage_computeBB.queryNagetive}" image="/images/common/unvalidate.gif" rendered="#{wage_computeBB.haveNegative}"></h:commandButton>
                       <h:commandButton image="/images/common/validate.gif" rendered="#{not wage_computeBB.haveNegative}"></h:commandButton>
                   </h:panelGroup>

                   <h:panelGroup>
                       <h:selectOneMenu id="groupLevel" value="#{wage_computeBB.groupLevel}">
                           <c:selectItem itemValue="DEPT_NAME" itemLabel="最细层次"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME" itemLabel="汇总1"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME2" itemLabel="汇总2"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME3" itemLabel="汇总3"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME4" itemLabel="汇总4"></c:selectItem>
                       </h:selectOneMenu>
                       <h:commandButton value="选择" styleClass="button01" action="#{wage_computeBB.changeLevel}"></h:commandButton>
                       <h:selectOneMenu id="WageDept"  value="#{wage_computeBB.dept}">
                          <c:selectItems value="#{wage_computeBB.deptList}"></c:selectItems>
                       </h:selectOneMenu>
                       <h:commandButton styleClass="button01"value="过滤" action="#{wage_computeBB.queryPersonByDept}"></h:commandButton>
                   </h:panelGroup>

                   <h:panelGroup>
                       <h:commandButton type="button" value="申请复核" rendered="#{wage_computeBB.operApply}" styleClass="button01"  onclick="doApply();" />
                       <h:commandButton type="button" value="管控" styleClass="button01"  rendered="#{sys_commonInfoBB.wagesumControl}" onclick="viewFinish();" />
                       <h:commandButton type="button" value="发放薪酬" rendered="#{wage_computeBB.operPayoff}" styleClass="button01"  onclick="doPayoff();"/>
                   </h:panelGroup>
               </h:panelGrid>
        </h:panelGrid>

        <h:panelGrid  columns="5" width="99%" align="center">
             <h:panelGroup>
                 <h:outputText value="姓名/编号" />
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
                 <h:commandButton value="确定" styleClass="button01" action="#{wage_computeBB.queryPersonBySetId}"></h:commandButton>
                 <h:commandButton value="设置显示项" rendered="#{wage_computeBB.operCompute}" styleClass="button01"
                                  action="#{wage_computeBB.saveShowItem}" onclick="return doShowItem()" />

                <h:selectOneMenu id="condition"  value="#{wage_computeBB.qryID}">
                   <c:selectItems value="#{wage_computeBB.displaySetList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value="过滤" action="#{wage_computeBB.queryByCondition}"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid columns="12" width="99%" align="center">
             <h:panelGroup rendered="#{wage_computeBB.showRpt}">
                 <h:selectOneMenu id="ReportID" style="width:190px">
                     <c:selectItems value="#{wage_computeBB.reportList}"/>
                 </h:selectOneMenu>
                 <h:commandButton value="Excel显示" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
<%--                  <h:commandButton value="直接打开" type="button" styleClass="button01" onclick="return OpenRptByControl();"></h:commandButton> --%>
			     <h:outputText value="  "/>
                 <h:commandButton value="分部门打印" type="button" styleClass="button01" onclick="return OpenRptByDept();"></h:commandButton>
                 <h:commandButton value="薪酬变动" type="button" styleClass="button01" onclick="return openChangeRecord();"></h:commandButton>
             </h:panelGroup>

             <h:panelGroup>
                 <h:commandButton value="常量" rendered="#{wage_computeBB.canModifyData}" styleClass="button01"
                                   onclick="return doSetConst()"/>

                 <h:commandButton value="卡片" type="button" rendered="#{wage_computeBB.canShowCard}" styleClass="button01" onclick="return doViewCard();"></h:commandButton>
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
              </h:panelGroup>
         </h:panelGrid>

        <h:panelGrid columns="14" width="99%" align="center" >
            <h:panelGroup>
                <h:commandButton value="导入" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                                  action="#{wage_computeBB.turnPageQuery}"
                                  onclick="return doUploadFile()"/>
            </h:panelGroup>

            <h:panelGroup>
                <h:commandButton value="清空" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.turnPageQuery}" onclick="return doClearZero()"/>

                <h:commandButton value="选择录入" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.turnPageQuery}"
                                 onclick="return doSelectInput()"/>
                <h:commandButton value="模版录入" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.turnPageQuery}" onclick="doTemplateInput()"></h:commandButton>
                <h:commandButton value="单个修改" rendered="#{wage_computeBB.canModifyData}" styleClass="button01"
                                  action="#{wage_computeBB.turnPageQuery}" onclick="return doSingleInput();"/>
                <h:commandButton value="批量修改" rendered="#{wage_computeBB.canModifyData}" styleClass="button01"
                                 action="#{wage_computeBB.turnPageQuery}"
                                 onclick="return doBatch();"/>
           </h:panelGroup>

           <h:panelGroup>
                <h:commandButton value="部门信息" styleClass="button01" rendered="#{wage_computeBB.deptinfo}"
                                  action="#{wage_computeBB.turnPageQuery}"
                                  onclick="return doDeptInput()"/>
           </h:panelGroup>


            <h:panelGroup>

                <h:panelGroup rendered="#{wage_computeBB.makeupPay}">
                <h:commandButton value="加人" styleClass="button01"  rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.reinforce}"
                                 onclick="return doReinforce();"/>
                <h:commandButton value="补数据" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.supplyData}">
                    <x:updateActionListener property="#{wage_setInputBB.dateId}" value="#{wage_computeBB.dateId}"/>
                    <x:updateActionListener property="#{wage_setInputBB.payoffDate}" value="#{wage_computeBB.payoffDate}"/>
                    <x:updateActionListener property="#{wage_setInputBB.setId}" value="#{wage_computeBB.setId}"/>
                    <x:updateActionListener property="#{wage_setInputBB.unitId}" value="#{wage_computeBB.unitId}"/>
                    <x:updateActionListener property="#{wage_setInputBB.setName}" value="#{wage_computeBB.setName}"/>
                    <x:updateActionListener property="#{wage_setInputBB.unitName}" value="#{wage_computeBB.unitName}"/>
                    <x:updateActionListener property="#{wage_setInputBB.operRight}" value="#{wage_computeBB.operCompute}"/>
                </h:commandButton>
                <h:commandButton value="减人" styleClass="button01"    rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.delete}"
                                 onclick="return doDelete();"/>
                <h:commandButton value="暂停" styleClass="button01"    rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.deleteSet}"
                                 onclick="return doDelete();"/>
                <h:commandButton value="恢复" styleClass="button01"    rendered="#{wage_computeBB.canModifyData}"
                                 action="#{wage_computeBB.restoreSet}"
                                 onclick="return doRestore();"/>
                </h:panelGroup>
                <h:panelGroup rendered="#{wage_computeBB.multiPay}">
                    <h:commandButton value="多段发放" styleClass="button01"   rendered="#{wage_computeBB.canModifyData}"
                                     action="#{wage_computeBB.CountManyDept}"
                                     onclick="return doSelectManyDept();"/>
                    <h:commandButton value="多段增加" styleClass="button01"   rendered="#{wage_computeBB.canModifyData}"
                                     action="#{wage_computeBB.CountManyDept}"
                                     onclick="return doaddManyDept();"/>
                </h:panelGroup>
            </h:panelGroup>

            <h:commandButton value="导出" type="button" onclick="doExport('#{wage_computeBB.setId}');" styleClass="button01"/>
            <h:commandButton value="报税" type="button" onclick="doTaxExport();" styleClass="button01"/>
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
    </div></td></tr></table>
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
