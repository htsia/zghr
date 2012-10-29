<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    var allCount=<%=Constants.ACTIVE_PAGE_SIZE%>;
    function showHisData(){
        window.showModalDialog("/wage/payoff/showDataInfo.jsf?dateID="+document.all("form1:dateId").value, null, "dialogWidth:650px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function showAudit(){
        window.showModalDialog("/wage/payoff/showInputAudit.jsf?setID="+document.all("form1:setId").value+"&dateID="+document.all("form1:dateId").value, null, "dialogWidth:650px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function doQueryManyPerson(){
        var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null && reval !="") {
            document.all('form1:ManyPerson').value = reval;
            return true;
        } else {
            return false;
        }
    }
</script>
<script type="text/javascript" language="javascript" src="/pages/wage/payoff/ComputePersonList.js"></script>

<x:saveState value="#{wage_inputManagerBB}"/>
<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_inputManagerBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_inputManagerBB.setId}"/>
    <h:inputHidden id="unitId" value="#{wage_inputManagerBB.unitId}"/>
    <h:inputHidden id="setName" value="#{wage_inputManagerBB.setName}"/>
    <h:inputHidden id="unitName" value="#{wage_inputManagerBB.unitName}"/>
    <h:inputHidden id="dateId" value="#{wage_inputManagerBB.dateId}"/>
    <h:inputHidden id="str" value=""/>
    <h:inputHidden id="addPerson" value=""/>
    <h:inputHidden id="deletePerson" value=""/>
    <h:inputHidden id="ManyPerson" value="#{wage_inputManagerBB.manyPerson}"/>

    <c:verbatim>
    <table width=100% height=100% border=0>
    <tr><td height=8px>
    </c:verbatim>
        <h:panelGrid styleClass="td_title" columns="2" width="98%" align="center">
               <h:panelGroup>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="帐套：#{wage_inputManagerBB.setName}"/>
                   <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                   <h:outputText value="发薪时间：#{wage_inputManagerBB.payoffDate}"/>
                   <h:outputText escape="false"  value="&nbsp;<strong>最后计算时间:</strong>#{wage_inputManagerBB.datebo.calcDate}"/>
                   <c:verbatim>&nbsp;&nbsp;&nbsp;</c:verbatim>
                   <h:outputText escape="false" value="<font color=red>多部门发放人员：#{wage_inputManagerBB.manyDeptCount}</font>"/>
                   <c:verbatim>&nbsp;&nbsp;&nbsp;</c:verbatim>
                   <h:outputText escape="false" value="<font color=red>录入状态：#{wage_inputManagerBB.inputStatus}</font>"/>
               </h:panelGroup>

               <h:panelGrid  columns="2" align="right">
                   <h:commandButton value="导出Excel" type="button" onclick="doExport();" styleClass="button01"/>
                   <h:commandButton value="返回" action="#{wage_dateBB.dateList}" styleClass="button01">
                            <x:updateActionListener property="#{wage_dateBB.setId}" value="#{wage_inputManagerBB.setId}"/>
                            <x:updateActionListener property="#{wage_dateBB.setName}" value="#{wage_inputManagerBB.setName}"/>
                            <x:updateActionListener property="#{wage_dateBB.unitId}" value="#{wage_inputManagerBB.unitId}"/>
                            <x:updateActionListener property="#{wage_dateBB.unitName}" value="#{wage_inputManagerBB.unitName}"/>
                   </h:commandButton>
               </h:panelGrid>
        </h:panelGrid>

        <h:panelGrid  columns="5" width="98%" align="center">
             <h:panelGroup>
                 <h:outputText value="姓名或编号:" />
                 <h:inputText value="" id="nameStr" style="width:100px"/>
                 <h:commandButton value="查询" action="#{wage_inputManagerBB.queryPersonByNameStr}" styleClass="button01"/>
                 <h:commandButton value="多人查询" action="#{wage_inputManagerBB.queryMultiPerson}" onclick="doQueryManyPerson();" styleClass="button01"/>
             </h:panelGroup>

             <h:panelGroup>
                 <h:outputText value="选择信息项" />
                 <h:selectOneMenu id="sortList" value="#{wage_inputManagerBB.sortField}">
                    <c:selectItems value="#{wage_inputManagerBB.sortList}"></c:selectItems>
                 </h:selectOneMenu>
                 <h:outputText value="排序" ></h:outputText>
                 <h:selectBooleanCheckbox value="#{wage_inputManagerBB.bysort}"></h:selectBooleanCheckbox>
                 <h:commandButton value="汇总" type="button" styleClass="button01" onclick="return beginGroup();"/>
             </h:panelGroup>

             <h:panelGroup>
                 <h:selectOneMenu id="WageDept"  value="#{wage_inputManagerBB.dept}">
                    <c:selectItems value="#{wage_inputManagerBB.deptList}"></c:selectItems>
                 </h:selectOneMenu>
                 <h:commandButton styleClass="button01"value="部门过滤" action="#{wage_inputManagerBB.queryPersonByDept}"></h:commandButton>
                 <h:outputText value="   "></h:outputText>
                <h:selectOneMenu id="condition"  value="#{wage_inputManagerBB.qryID}">
                   <c:selectItems value="#{wage_inputManagerBB.displaySetList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value="条件过滤" onclick="return disPlayProcessBar();" action="#{wage_inputManagerBB.queryByCondition}"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid columns="12" width="98%" align="center">
             <h:panelGroup>
                 <h:selectOneMenu id="ReportID" style="width:140">
                     <c:selectItems value="#{wage_inputManagerBB.inputReportList}"/>
                 </h:selectOneMenu>
                 <h:commandButton value="Excel显示" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                 <h:commandButton value="直接打开" styleClass="button01" onclick="return OpenRptByControl();"></h:commandButton>
             </h:panelGroup>

            <h:panelGroup>
                <h:commandButton value="禁止录入" styleClass="button01" rendered="#{wage_inputManagerBB.canChangeStatus}"
                                 action="#{wage_inputManagerBB.Lock}" >
                </h:commandButton>
                <h:commandButton value="允许录入" styleClass="button01" rendered="#{wage_inputManagerBB.canChangeStatus}"
                                 action="#{wage_inputManagerBB.UnLock}" >
                </h:commandButton>
           </h:panelGroup>

            <h:panelGroup>
                <h:commandButton value="清空输入" styleClass="button01"
                                 action="#{wage_inputManagerBB.turnPageQuery}" onclick="return doClearZero()" rendered="#{wage_inputManagerBB.canChangeStatus || wage_inputManagerBB.inputStatus=='允许'}"/>

                <h:commandButton value="选择录入" styleClass="button01" rendered="#{wage_inputManagerBB.canChangeStatus || wage_inputManagerBB.inputStatus=='允许'}"
                                 action="#{wage_inputManagerBB.turnPageQuery}"
                                 onclick="return doSelectInput()"/>
                <h:commandButton value="导入" styleClass="button01"        action="#{wage_inputManagerBB.turnPageQuery}"
                                  onclick="return doUploadFileOnlyInput()"/>
                 <h:commandButton value="计算" styleClass="button01"    rendered="#{wage_inputManagerBB.canComputer}"    action="#{wage_inputManagerBB.computeAll}"/>
                 <h:commandButton value="查看数据变动" rendered="#{wage_inputManagerBB.operAuditInput}" onclick="showHisData();" styleClass="button01"></h:commandButton>
                 <h:commandButton value="审核" rendered="#{wage_inputManagerBB.operAuditInput}" onclick="showAudit();" styleClass="button01"></h:commandButton>
           </h:panelGroup>

         </h:panelGrid>
<c:verbatim>
    </td></tr>
     
    <tr><td>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
            <jsp:param name="keyName" value="ID"/>
            <jsp:param name="fixcol" value="4"/>
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
