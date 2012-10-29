<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <h:form id="form1">
        <h:inputHidden value="#{emp_PersonCountBB.personCountDetail}"/>
<c:verbatim>
        <table id=t1 width="100%" height="98%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
</c:verbatim>
                   <h:outputText value="#{emp_PersonCountBB.orgName}"></h:outputText>
<c:verbatim>
                </td>
                <td align="right" height=30 valign="middle">
</c:verbatim>
                    <h:commandButton value="¹Ø±Õ" onclick="window.close()" styleClass="button01" type="button"></h:commandButton>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td width="100%" colspan="2">
                    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                        <jsp:param name="hasOperSign" value="true"/>
                        <jsp:param name="operSignType" value="checkbox"/>
                        <jsp:param name="hasEdit" value="true"/>
                        <jsp:param name="isEditList" value="false"/>
                        <jsp:param name="isCheckRight" value="false"/>
                        <jsp:param name="isForward" value="true"/>
                        <jsp:param name="isRow" value="false"/>
                        <jsp:param name="isPage" value="true"/>
                    </jsp:include>
                </td>
            </tr>
        </table>
</c:verbatim>
    </h:form>
