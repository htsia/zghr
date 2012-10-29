<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function showProcessBar() {
   x = document.body.clientWidth / 2 - 150;
   y = document.body.clientHeight / 2;
   document.all('processbar').style.top = y;
   document.all('processbar').style.left = x;
   document.all('processbar').style.display = "";
}</script>

<x:saveState value="#{wage_checkInsuraceBB}"/>
<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_checkInsuraceBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_checkInsuraceBB.setId}"/>
    <h:inputHidden id="setName" value="#{wage_checkInsuraceBB.setName}"/>
    <h:inputHidden id="unitId" value="#{wage_checkInsuraceBB.unitId}"/>
    <h:inputHidden id="dateId" value="#{wage_checkInsuraceBB.dateId}"/>

    <f:verbatim>
    <table width=100% height=98% cellspacing="0" >
       <tr>
       <td class="td_title" height=8px>
    </f:verbatim>
           <h:graphicImage value="/images/tips.gif" />
           <h:outputText value="帐套：#{wage_checkInsuraceBB.setName}"/>
           <c:verbatim>&nbsp;&nbsp;</c:verbatim>                                                                                                                         
           <h:outputText value="发薪时间：#{wage_checkInsuraceBB.payoffDate}"/>
           <c:verbatim>&nbsp;&nbsp;&nbsp;</c:verbatim>
           <h:outputText value="发薪状态：#{wage_checkInsuraceBB.stautsdes}"/>

            <h:outputText value="    "/>
            <h:selectBooleanCheckbox value="#{wage_checkInsuraceBB.showdiff}"></h:selectBooleanCheckbox>
            <h:outputText value="仅显示基数不同数据"/>
            <h:outputText value="差值："/>
            <h:inputText value="#{wage_checkInsuraceBB.absDis}"/>
            <h:commandButton value="查询" styleClass="button01" action="#{wage_checkInsuraceBB.queryPersonBySetId}"></h:commandButton>
            <h:commandButton value="导出" type="button" styleClass="button01" onclick="doExport();"></h:commandButton>
     <f:verbatim>
       </td>
       </tr>

        <tr>
            <td height=8>
    </f:verbatim>
              <h:outputText value="养老保险个人比例:#{wage_checkInsuraceBB.unitbo.endowment_person}%"></h:outputText>
              <h:outputText value="     " ></h:outputText>
              <h:outputText value="养老保险高限:#{wage_checkInsuraceBB.unitbo.maxRate_end}"></h:outputText>
              <h:outputText value="     " ></h:outputText>
              <h:outputText value="养老保险低限:#{wage_checkInsuraceBB.unitbo.minRate_end}"></h:outputText>

              <h:outputText value="     " ></h:outputText>
              <h:outputText value="住房公积金个人比例:#{wage_checkInsuraceBB.unitbo.housing_person}%"></h:outputText>
              <h:outputText value="     " ></h:outputText>
              <h:outputText value="住房公积金高限:#{wage_checkInsuraceBB.unitbo.maxRate_house}"></h:outputText>
              <h:outputText value="     " ></h:outputText>
              <h:outputText value="住房公积金低限:#{wage_checkInsuraceBB.unitbo.minRate_house}"></h:outputText>

    <f:verbatim>
            </td>
        </tr>

        <tr><td>
         <jsp:include page="/pages/common/activepage/ActiveList.jsp">
             <jsp:param name="hasOperSign" value="true"/>
             <jsp:param name="operSignType" value="checkbox"/>
             <jsp:param name="hasEdit" value="true"/>
             <jsp:param name="isEditList" value="false"/>
             <jsp:param name="isCheckRight" value="true"/>
             <jsp:param name="isForward" value="true"/>
             <jsp:param name="isRow" value="true"/>
             <jsp:param name="rowFuncName" value="forViewPerson"/>
             <jsp:param name="isPage" value="true"/>
             <jsp:param name="fixcol" value="6"/>
             <jsp:param name="maskError" value="true"/>
         </jsp:include>
         </td>
         </tr>
     </table>
     </f:verbatim>
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
