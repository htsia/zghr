<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<c:verbatim><base target="_self"></c:verbatim>
<h:form id="from1">
    <h:inputHidden value="#{gridget.initGroupShowDetail}"></h:inputHidden>
    <c:verbatim>
    <table height=98% width=98%>
    <tr>
        <td height=8px>
    </c:verbatim>
            <h:outputText value="       开始时间" />
            <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|d" value="#{gridget.beginDate}" readonly="true"/>
            <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTime')"></f:verbatim>

            <h:outputText value="       结束时间" />
            <h:inputText styleClass="input" id="endTime" alt="结束时间|0|d" size="12" value="#{gridget.endDate}" readonly="true"/>
            <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:endTime')"></f:verbatim>
            <h:commandButton value="查询" styleClass="button01" action="#{gridget.queryDetail}"></h:commandButton>  
<c:verbatim>
         </td>
        <td height=8px align="right">
            <input type="button" class="button01" value="关闭" onclick="window.close();">
         </td>
    </tr>

    <tr><td height=4px colspan=2></td></tr>

    <tr><td colspan=2>
        <jsp:include page="/pages/common/activepage/ShowTable.jsp">
            <jsp:param name="para" value="true"/>
        </jsp:include>
    </td></tr>
    </table>
    </c:verbatim>
</h:form>
