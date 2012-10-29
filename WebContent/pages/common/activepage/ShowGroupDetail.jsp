<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{sys_showstaticBB}"></x:saveState>

<h:form id="form1">
<h:inputHidden value="#{sys_showstaticBB.initGroupDetail}"></h:inputHidden>
<h:inputHidden value="#{sys_showstaticBB.itemID}"></h:inputHidden>

<f:verbatim>
  <table width="98%" align="center" height="98%">
    <tr><td height="8">
</f:verbatim>
    <h:outputText value="#{sys_showstaticBB.title}"></h:outputText>
<f:verbatim>
    </td></tr>
    <tr><td align="top">
        <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
        </jsp:include>
    </td></tr>
 </table>
</f:verbatim>

 </h:form>