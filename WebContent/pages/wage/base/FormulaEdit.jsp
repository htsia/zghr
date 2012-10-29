<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.wage.web.WageFormulaBackingBean" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String rsTableName = SysCacheTool.findInfoSet("A815").getSetName();
%>
<script type="text/javascript">
    <%
            User user = (User) session.getAttribute(Constants.USER_INFO);
            out.print("      var useID='"+user.getUserId()+"';");
            out.print("      var rsTableName='"+rsTableName+"';");
    %>
</script>


<c:verbatim>
<script type="text/javascript" language="javascript" src="/pages/wage/base/FormulaEdit.js"></script>
</c:verbatim>


<x:saveState value="#{wage_formulaBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="popEdit" value="#{wage_formulaBB.popEdit}"/>
    <h:inputHidden id="formulaId" value="#{wage_formulaBB.formula.formulaId}"/>
    <h:inputHidden id="unitId" value="#{wage_formulaBB.formula.unitId}"/>
    <h:panelGrid width="95%" align="center">
        <h:panelGrid align="right" columns="4" cellspacing="2">
            <h:outputText id="status" value="编辑状态:添加"></h:outputText>
            <h:commandButton styleClass="button01" value="保存"
                             action="#{wage_formulaBB.save}" onclick="if(checkSubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" rendered="#{wage_formulaBB.popEdit!='1'}" action="#{wage_formulaBB.list}"/>
            <h:commandButton styleClass="button01" value="返回" rendered="#{wage_formulaBB.popEdit=='1'}" onclick="window.close();"/>
        </h:panelGrid>

    <h:panelGrid width="100%" align="center" columns="2" styleClass="table03" columnClasses="td_form01,td_form02">
    <h:outputText value="公式名称"/>
    <h:inputText id="name" value="#{wage_formulaBB.formula.name}" size="40" maxlength="100"/>

    <h:outputText value="公式描述"/>
    <h:inputText id="desc" value="#{wage_formulaBB.formula.desc}" size="80" maxlength="200"/>

    <h:outputText value="是否通用公式"/>
    <h:selectOneRadio value="#{wage_formulaBB.formula.usualFlag}" id="usualFlag" onclick="forUsualChange()" >
        <c:selectItem itemValue="1" itemLabel="是"/>
        <c:selectItem itemValue="0" itemLabel="否"/>
    </h:selectOneRadio>

    <h:outputText value="适用月份"/>
    <h:selectManyCheckbox value="#{wage_formulaBB.formula.applyMonthList}" id="month"  >
        <c:selectItem itemValue="-1" itemLabel="全部月份"/>
        <c:selectItem itemValue="01" itemLabel="1"/>
        <c:selectItem itemValue="02" itemLabel="2"/>
        <c:selectItem itemValue="03" itemLabel="3"/>
        <c:selectItem itemValue="04" itemLabel="4"/>
        <c:selectItem itemValue="05" itemLabel="5"/>
        <c:selectItem itemValue="06" itemLabel="6"/>
        <c:selectItem itemValue="07" itemLabel="7"/>
        <c:selectItem itemValue="08" itemLabel="8"/>
        <c:selectItem itemValue="09" itemLabel="9"/>
        <c:selectItem itemValue="10" itemLabel="10"/>
        <c:selectItem itemValue="11" itemLabel="11"/>
        <c:selectItem itemValue="12" itemLabel="12"/>
    </h:selectManyCheckbox>

    <h:outputText value="所属账套"/>
    <h:selectOneMenu value="#{wage_formulaBB.formula.setId}" id="setId" style="width:250px">
        <c:selectItems value="#{wage_formulaBB.setList}"/>
    </h:selectOneMenu>

    <h:outputText value="结果指标项"/>
    <h:panelGroup>
        <h:inputText readonly="true" alt="公式结果指标项|0|s" id="rsField" code="" dict="yes" dict_num="INFOITEM"
                     style="width:250" value="#{wage_formulaBB.formula.rsField}"/>
        <h:outputText value=" "/>
        <h:commandButton styleClass="button_select" onclick="PopUpWageItemDlg('form1:rsField');return false;" value=" "
                         id="codebnt"/>
        <h:commandButton type="button" styleClass="button01" onclick="selectRsFieldOperation('form1:rsField')"
                         value="加入公式"/>
    </h:panelGroup>

    <h:outputText value="关联信息"/>
    <h:panelGroup>
        <c:verbatim escape="false">
            备选薪资项目1
            <input name="wageItem" type="text" readonly code='' size="40" dict_num="INFOITEM" code=""/>
            <input type="button" class="button_select" onclick="PopUpWageItemDlg('wageItem');">
            <input type="button" class="button01" onclick="selectRsFieldOperation('wageItem')"
                   value="加入公式">
            <br>
            备选薪资项目2
            <input name="wageItem2" type="text" readonly code='' size="40" dict_num="INFOITEM" code=""/>
            <input type="button" class="button_select" onclick="PopUpWageItemDlg('wageItem2');">
            <input type="button" class="button01" onclick="selectRsFieldOperation('wageItem2')"
                   value="加入公式">
            <br>
            <br>
            备选指标项1
            <input name="infoItem" type="text" readonly code='' value='' datatype='' codeSet='' size="40">
            <input type="button" class="button_select" onclick="selectInfoItem();">
            <input type="button" class="button01" onclick="spanOperation(form1.infoItem.code,form1.infoItem.value)"
                   value="加入公式">
            <br>
            备选代码值1
            <input name="condValue" type="text" readonly dict_num='' code='' value=''>
            <input type="button" class="button_select" onclick="forSelCode(form1.infoItem);">
            <input type="button" class="button01" onclick="selectCodeOperation()" value="加入公式">
            <br>
            备选指标项2
            <input name="infoItem2" type="text" readonly code='' value='' datatype='' codeSet='' size="40">
            <input type="button" class="button_select" onclick="selectInfoItem2();">
            <input type="button" class="button01" onclick="spanOperation(form1.infoItem2.code,form1.infoItem2.value)"
                   value="加入公式">
            <br>
            备选代码值2
            <input name="condValue2" type="text" readonly dict_num='' code='' value=''>
            <input type="button" class="button_select" onclick="forSelCode2(form1.infoItem2);">
            <input type="button" class="button01" onclick="selectCodeOperation2()" value="加入公式">
            <br>
            <br>
            备选薪资常量
            <input name="wageConst" type="text" readonly code='' value='' datatype='' codeSet='' size="40">
            <input type="button" class="button_select" onclick="selectConst();">
            <input type="button" class="button01" onclick="spanOperation(form1.wageConst.code,form1.wageConst.value)"  value="加入公式">

        </c:verbatim>
    </h:panelGroup>
    <h:outputText value="公式内容"/>
    <h:panelGroup>
        <h:inputHidden id="chnDesc" value="#{wage_formulaBB.formula.chnDesc}"/>
        <c:verbatim>
            <div id="show" style="white-space:normal; width:600px; height:100px ;overflow:auto;border:1px">
                <%
                WageFormulaBackingBean wbb = (WageFormulaBackingBean) request.getAttribute("wage_formulaBB");
                out.print(CommonFuns.filterNull(wbb.getFormula().getChnDesc()));
                %>
            </div>
        </c:verbatim>
    </h:panelGroup>

    <h:outputText value="运算符号"/>
    <h:panelGrid width="100%" columns="3">
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" value="7" onclick="spanOperation('7','7');">
                <input type="button" class="button01" style="width:50px" value="8" onclick="spanOperation('8','8');">
                <input type="button" class="button01" style="width:50px" value="9" onclick="spanOperation('9','9');">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('+','+');" value="+">
            </c:verbatim>
        </h:panelGroup>
        <c:verbatim>&nbsp;&nbsp;
            <input type="button" class="button01" style="width:50px" onclick="setActStatus('insert');" value="插入">
            &nbsp;&nbsp; &nbsp;
        </c:verbatim>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('>',' > ');" value=">">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('<',' < ');" value="<">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('>=',' >= ');" value=">=">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('<=',' <= ');" value="<=">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('==',' == ');" value="==">
            </c:verbatim>
        </h:panelGroup>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" value="4" onclick="spanOperation('4','4');">
                <input type="button" class="button01" style="width:50px" value="5" onclick="spanOperation('5','5');">
                <input type="button" class="button01" style="width:50px" value="6" onclick="spanOperation('6','6');">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('-','-');" value="-">
            </c:verbatim>
        </h:panelGroup>
        <c:verbatim> &nbsp;&nbsp;
            <input type="button" class="button01" style="width:50px" onclick="setActStatus('replace');" value="替换">
            &nbsp;&nbsp; &nbsp;
        </c:verbatim>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('!=',' 不等于 ');" value="!=">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation(' && ',' 并且 ');" value="并且">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation(' || ',' 或者 ');" value="或者">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('(','(');" value="(">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation(')',')');" value=")">
            </c:verbatim>
        </h:panelGroup>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" value="1" onclick="spanOperation('1','1');">
                <input type="button" class="button01" style="width:50px" value="2" onclick="spanOperation('2','2');">
                <input type="button" class="button01" style="width:50px" value="3" onclick="spanOperation('3','3');">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('*','*');" value="*">
            </c:verbatim>
        </h:panelGroup>
        <c:verbatim>&nbsp;&nbsp;
            <input type="button" class="button01" style="width:50px" onclick="removeSpan();" value="删除">&nbsp;&nbsp; &nbsp;
        </c:verbatim>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('if(','假如(<br>');" value="假如">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('else{','否则{<br>');"     value="否则">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('else if(','另外假如(<br>');"  value="另外假如">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('{','<br>{<br>');" value="{">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('}','<br>}');" value="}">
            </c:verbatim>
        </h:panelGroup>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" value="0" onclick="spanOperation('0','0');">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('.','.');" value=".">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('=',' = ','true');"
                       value="=">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('/','/');" value="/">
            </c:verbatim>
        </h:panelGroup>
        <h:panelGroup>
            <c:verbatim>&nbsp;&nbsp;
                <input type="button" class="button01" style="width:50px" onclick="clearText();" value="清除">
                &nbsp;&nbsp; &nbsp;
            </c:verbatim>
        </h:panelGroup>

        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation(',',',');" value="，">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation(';',';');" value="；">
                <input type="button" class="button01" style="width:50px" onclick="spanOperation('~','~');" value="~">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>

        <h:outputText value="函数"/>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:80px" value="Round" onclick="spanOperation('Round(','Round(');">
                &nbsp;&nbsp;
                <input type="button" class="button01" style="width:80px" value="GetYear" onclick="spanOperation('GetYear(','GetYear(');">
                &nbsp;&nbsp;
                <input type="button" class="button01" style="width:80px" value="GetMonth" onclick="spanOperation('GetMonth(','GetMonth(');">
                &nbsp;&nbsp;
                <input type="button" class="button01" style="width:100px" value="GetSumByYear" onclick="spanOperation('GetSumByYear(','GetSumByYear(');">
                &nbsp;&nbsp;
                <input type="button" class="button01"  style="width:100px" value="MonthDiff" onclick="spanOperation('MonthDiff(','MonthDiff(');"><br><br>
                <input type="button" class="button01"  style="width:120px" value="GetSumByMonth" onclick="spanOperation('GetSumByMonth(','GetSumByMonth(');">
                &nbsp;&nbsp;
                <input type="button" class="button01"  style="width:160px" value="GetSumByMonth_LAST" onclick="spanOperation('GetSumByMonth_LAST(','GetSumByMonth_LAST(');"><br>
           </c:verbatim>
        </h:panelGroup>

        <h:outputText value="公式表达式"/>
        <h:panelGroup>
            <h:inputHidden id="express" value="#{wage_formulaBB.formula.express}"/>
            <h:inputHidden id="htmlDesc" value="#{wage_formulaBB.formula.htmlDesc}"/>
            <c:verbatim escape="false">
                <div id="exp" style="white-space:normal; width:600px; height:100px ;overflow:auto;border:1px">
                    <%
                        WageFormulaBackingBean wbb = (WageFormulaBackingBean) request.getAttribute("wage_formulaBB");
                        out.print(CommonFuns.filterNull(wbb.getFormula().getHtmlDesc()));
                    %>
                </div>
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>

</h:panelGrid>
</h:form>
<c:verbatim escape="false">
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</c:verbatim>
