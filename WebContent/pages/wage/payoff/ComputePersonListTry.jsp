<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    var allCount=120;
</script>

<script type="text/javascript" language="javascript" src="/pages/wage/payoff/ComputePersonListTry.js"></script>

<x:saveState value="#{wage_trycomputeBB}"/>
<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_trycomputeBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_trycomputeBB.setId}"/>
    <h:inputHidden id="unitId" value="#{wage_trycomputeBB.unitId}"/>
    <h:inputHidden id="setName" value="#{wage_trycomputeBB.setName}"/>
    <h:inputHidden id="unitName" value="#{wage_trycomputeBB.unitName}"/>
    <h:inputHidden id="dateId" value="#{wage_trycomputeBB.dateId}"/>
    <h:inputHidden id="str" value=""/>
    <h:inputHidden id="ManyPerson" value="#{wage_trycomputeBB.manyPerson}"/>
    <h:inputHidden id="addPerson" value=""/>
    <h:inputHidden id="deletePerson" value=""/>

    <c:verbatim>
    <table width=100% height=98% border=0 >
    <tr><td height=8px>
    </c:verbatim>
        <h:panelGrid styleClass="td_title" columns="5" width="99%" align="center" style="height:20px">
               <h:panelGroup>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="帐套：#{wage_trycomputeBB.setName}"/>
                   <c:verbatim>&nbsp;&nbsp;</c:verbatim>
               </h:panelGroup>

               <h:panelGroup>
                   <h:outputText value="试算时间"></h:outputText>
                   <h:inputText readonly="true" id="processDate" value="#{wage_trycomputeBB.payoffDate}"></h:inputText>
                   <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
               </h:panelGroup>

                   <h:panelGroup>
                       <h:outputText escape="false" value="<font color='red'>负值:</font>" style=""></h:outputText>
                       <h:commandButton action="#{wage_trycomputeBB.queryNagetive}" image="/images/common/unvalidate.gif" rendered="#{wage_trycomputeBB.haveNegative}"></h:commandButton>
                       <h:commandButton image="/images/common/validate.gif" rendered="#{not wage_trycomputeBB.haveNegative}"></h:commandButton>
                   </h:panelGroup>

                   <h:panelGroup>
                       <h:selectOneMenu id="groupLevel" value="#{wage_trycomputeBB.groupLevel}">
                           <c:selectItem itemValue="DEPT_NAME" itemLabel="最细层次"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME" itemLabel="汇总1"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME2" itemLabel="汇总2"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME3" itemLabel="汇总3"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME4" itemLabel="汇总4"></c:selectItem>
                       </h:selectOneMenu>
                       <h:commandButton value="选择" styleClass="button01" action="#{wage_trycomputeBB.changeLevel}"></h:commandButton>
                       <h:selectOneMenu id="WageDept"  value="#{wage_trycomputeBB.dept}">
                          <c:selectItems value="#{wage_trycomputeBB.deptList}"></c:selectItems>
                       </h:selectOneMenu>
                       <h:commandButton styleClass="button01"value="过滤" action="#{wage_trycomputeBB.queryPersonByDept}"></h:commandButton>
                   </h:panelGroup>

                   <h:panelGroup>
                       <h:commandButton value="返回" onclick="window.close();" type="button" styleClass="button01">
                       </h:commandButton>
                   </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid  columns="5" width="99%" align="center">
             <h:panelGroup>
                 <h:outputText value="姓名或编号:" />
                 <h:inputText value="" id="nameStr" style="width:100px" onkeypress ="enterKeyDown('form1:queryPerson');"/>
                 <h:commandButton id="queryPerson" value="查询" action="#{wage_trycomputeBB.queryPersonByNameStr}" styleClass="button01"/>
                 <h:commandButton value="多人查询" action="#{wage_trycomputeBB.queryMultiPerson}" onclick="doQueryManyPerson();" styleClass="button01"/>
                 <h:commandButton value="自定义查询" styleClass="button01"
                                  action="#{wage_trycomputeBB.queryAdvance}"
                                  onclick="return doselfQuery();"/>
             </h:panelGroup>


             <h:panelGroup>
                 <h:selectOneMenu id="sortList" value="#{wage_trycomputeBB.sortField}">
                    <c:selectItems value="#{wage_trycomputeBB.sortList}"></c:selectItems>
                 </h:selectOneMenu>
                 <h:outputText value="排序" ></h:outputText>
                 <h:selectBooleanCheckbox value="#{wage_trycomputeBB.bysort}"></h:selectBooleanCheckbox>
                 <h:commandButton value="汇总" type="button" styleClass="button01" onclick="return beginGroup();"/>
             </h:panelGroup>

             <h:panelGroup>
                 <h:selectOneMenu value="#{wage_trycomputeBB.itemType}">
                     <c:selectItems value="#{wage_trycomputeBB.itemTypeList}"></c:selectItems>
                 </h:selectOneMenu>
                 <h:commandButton value="确定" styleClass="button01" action="#{wage_trycomputeBB.queryPersonBySetId}"></h:commandButton>
                 <h:commandButton value="设置显示项" rendered="#{wage_trycomputeBB.operCompute}" styleClass="button01"
                                  action="#{wage_trycomputeBB.saveShowItem}" onclick="return doShowItem()" />

                <h:selectOneMenu id="condition"  value="#{wage_trycomputeBB.qryID}">
                   <c:selectItems value="#{wage_trycomputeBB.displaySetList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value="过滤" action="#{wage_trycomputeBB.queryByCondition}"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid columns="12" width="99%" align="center">
             <h:panelGroup>
                 <h:selectOneMenu id="ReportID" style="width:190px">
                     <c:selectItems value="#{wage_trycomputeBB.reportList}"/>
                 </h:selectOneMenu>
                 <h:commandButton value="Excel显示" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                 <h:commandButton value="直接打开" type="button" styleClass="button01" onclick="return OpenRptByControl();"></h:commandButton>
                 <h:commandButton value="打印工资条" type="button" styleClass="button01" onclick="return OpenRptByDept();"></h:commandButton>
             </h:panelGroup>

             <h:panelGroup>
                 <h:commandButton value="常量赋值"  styleClass="button01"
                                   onclick="return doSetConst()"/>

                 <h:commandButton value="显示卡片" type="button" styleClass="button01" onclick="return doViewCard();"></h:commandButton>

             </h:panelGroup>

            <h:panelGroup>
                <h:commandButton value="部门信息" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                                  action="#{wage_computeBB.turnPageQuery}"
                                  onclick="return doDeptInput()"/>
           </h:panelGroup>

             <h:panelGroup>
                 <h:commandButton value="选择计算" styleClass="button01"
                                  action="#{wage_trycomputeBB.computePart}" onclick="return doCheckSelect()"/>
                 <h:commandButton value="全部计算"  styleClass="button01"
                                  action="#{wage_trycomputeBB.computeAll}" onclick="return refreshList()"/>
                 <h:commandButton value="对比"  styleClass="button01" type="button"
                                   onclick="showdiff();return false;"/>

              </h:panelGroup>
         </h:panelGrid>

        <h:panelGrid columns="14" width="99%" align="center" >
            <h:panelGroup>
                <h:commandButton value="导入数据" styleClass="button01"
                                  action="#{wage_trycomputeBB.turnPageQuery}"
                                  onclick="return doUploadFile()"/>
            </h:panelGroup>

            <h:panelGroup>
                <h:commandButton value="清空" styleClass="button01"
                                 action="#{wage_trycomputeBB.turnPageQuery}" onclick="return doClearZero()"/>
                <h:commandButton value="基础信息" type="button" styleClass="button01"
                                 onclick="return doBaseInfoInput()"/>
                <h:commandButton value="定标准" styleClass="button01"
                                 action="#{wage_trycomputeBB.turnPageQuery}"
                                 onclick="return doSetStandard()"/>

                <h:commandButton value="选择录入" styleClass="button01"
                                 action="#{wage_trycomputeBB.turnPageQuery}"
                                 onclick="return doSelectInput()"/>
                <h:commandButton value="模版录入" styleClass="button01"
                                 action="#{wage_trycomputeBB.turnPageQuery}" onclick="doTemplateInput()"></h:commandButton>
                <h:commandButton value="批量修改"  styleClass="button01"
                                 action="#{wage_trycomputeBB.turnPageQuery}"
                                 onclick="return doBatch()"/>
           </h:panelGroup>

            <h:panelGroup>
               <h:outputText value="银行报盘"/>
                <h:selectOneMenu id="bankSet" value="#{wage_trycomputeBB.bankSet}">
                    <c:selectItems value="#{wage_trycomputeBB.bankSetList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton value="生成报盘文件" styleClass="button01" type="button" onclick="return CreateBankFile();"/>
            </h:panelGroup>

            <h:commandButton value="导出" type="button" onclick="doExport();" styleClass="button01"/>
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
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr>
    </table>
</marquee>
