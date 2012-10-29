<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    var allCount=<%=Constants.ACTIVE_PAGE_SIZE%>;
</script>
<script type="text/javascript" language="javascript" src="/pages/wage/payoff/ComputePersonList.js"></script>

<x:saveState value="#{att_computelistBB}"/>
<x:saveState value="#{wage_dateBB}"/>

<h:form id="form1">
    <h:inputHidden value="#{att_computelistBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{att_computelistBB.setId}"/>
    <h:inputHidden id="unitId" value="#{att_computelistBB.unitId}"/>
    <h:inputHidden id="setName" value="#{att_computelistBB.setName}"/>
    <h:inputHidden id="dateId" value="#{att_computelistBB.dateId}"/>
    <h:inputHidden id="str" value=""/>

    <c:verbatim>
    <table height=98% width=100% align="center" border=0>
    <tr><td height=8>
    </c:verbatim>
       <h:panelGrid columns="2" align="center" width="95%" >
       <h:panelGroup>
            <h:outputText escape="false" value="<strong>发薪单位：</strong>#{att_computelistBB.unitName}"/>
            <h:outputText value="   "></h:outputText>
            <h:outputText escape="false" value="<strong>账套：</strong>#{att_computelistBB.setName}"/>
        </h:panelGroup>
       </h:panelGrid>

        <h:panelGrid columns="11" align="center" width="95%" >
        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:150px">
                <c:selectItems value="#{att_computelistBB.bxreportList}"/>
            </h:selectOneMenu>
            <h:commandButton value="显示" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="姓名或员工编号:"/>
            <h:inputText value="" id="nameStr"/>
            <h:commandButton value="查询" action="#{att_computelistBB.queryPersonByNameStr}" styleClass="button01"/>
            <h:commandButton value="自定义查询" styleClass="button01"
                             action="#{att_computelistBB.queryAdvance}"
                             onclick="return doAdvanceQuery('A','ORG','011','Y','','','N','152','N')"/>
        </h:panelGroup>

        <h:panelGroup>
            <h:commandButton value="导入" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                              action="#{att_computelistBB.turnPageQuery}"
                              onclick="return doUploadAttFile()"/>

            <h:commandButton value="选择录入" styleClass="button01" rendered="#{wage_computeBB.canModifyData}"
                             action="#{att_computelistBB.turnPageQuery}"
                             onclick="return doAttendSelectInput()"/>
        </h:panelGroup>
        
        <h:panelGrid columns="1" align="right" cellspacing="2" >
            <h:panelGroup>
                <h:commandButton value="导出Excel" type="button" onclick="forExport();" styleClass="button01"/>
                <h:commandButton value="返回" action="#{wage_dateBB.dateList}" styleClass="button01">
                    <x:updateActionListener property="#{wage_dateBB.setId}" value="#{att_computelistBB.setId}"/>
                    <x:updateActionListener property="#{wage_dateBB.setName}" value="#{att_computelistBB.setName}"/>
                    <x:updateActionListener property="#{wage_dateBB.unitId}" value="#{att_computelistBB.unitId}"/>
                    <x:updateActionListener property="#{wage_dateBB.unitName}" value="#{att_computelistBB.unitName}"/>
                </h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
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

