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
    function showProgressBar(){
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
        return true;
    }
    function selectNew(){
        PopUpCalendarDialog('form1:newTime');
        showProgressBar();
        return true;
    }
    function dorefresh(){
        showProgressBar();
        document.all('form1').submit();
    }
</script>

<script type="text/javascript" language="javascript" src="/pages/wage/payoff/ComputePersonListTry.js"></script>

<x:saveState value="#{wage_ageSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_ageSetBB.pageInit}"/>

    <c:verbatim>
    <table width=100% height=98% border=0 >
    <tr><td height=8px>
    </c:verbatim>
        <h:outputText escape="false" value="<strong>发薪单位：</strong>#{wage_ageSetBB.unitName}"/>
        <h:outputText escape="false" value="<strong>薪资账套：</strong>"></h:outputText>
        <h:selectOneMenu id = "setId" value="#{wage_ageSetBB.setId}"  onchange="dorefresh();"  valueChangeListener="#{wage_ageSetBB.changeSetList}">
             <c:selectItems value="#{wage_ageSetBB.setList}"/>
        </h:selectOneMenu>
        <h:selectOneMenu id = "baseTime" value="#{wage_ageSetBB.baseTime}"  onchange="dorefresh();"  valueChangeListener="#{wage_ageSetBB.changeTimeList}">
             <c:selectItems value="#{wage_ageSetBB.timeList}"/>
        </h:selectOneMenu>
         <h:inputHidden id="newTime" value="#{wage_ageSetBB.newTime}"></h:inputHidden>
        <h:commandButton value="开始新周期" styleClass="button01" onclick="return selectNew();" action="#{wage_ageSetBB.beginNew}"></h:commandButton>
        <h:commandButton value="计算" styleClass="button01" onclick="return showProgressBar();" action="#{wage_ageSetBB.calc}"></h:commandButton>
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
