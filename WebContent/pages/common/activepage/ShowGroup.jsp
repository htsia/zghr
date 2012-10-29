<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{sys_showstaticBB}"></x:saveState>
<h:inputHidden value="#{sys_showstaticBB.initGroup}"></h:inputHidden>
<f:verbatim>
<table  width="100%" height=98% border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
    <tr >
        <td height=8 align="left">
</f:verbatim>
           <h:outputText  escape="false" value="<strong>ÏîÄ¿Ãû³Æ£º</strong>#{sys_showstaticBB.colName}"></h:outputText>
<f:verbatim>
        </td>
    </tr>

    <tr><td>
    <jsp:include page="/pages/common/activepage/ShowTable.jsp">
        <jsp:param name="para" value="true"/>
        <jsp:param name="reverseQueryURL" value="/common/activepage/ShowGroupDetail.jsf"/>
        <jsp:param name="reverseQuery" value="true"/>
    </jsp:include>

    </td></tr>
    </table>
</f:verbatim>

