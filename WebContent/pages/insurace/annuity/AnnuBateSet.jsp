<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doEdit(){
            window.showModalDialog("/insurace/annuity/AnnuBateSetEdit.jsf?SubID="+document.all('form1:subid').value, null, "dialogWidth:500px; dialogHeight:180px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }

        function doNewYear(){
            window.showModalDialog("/insurace/annuity/AnnuBateSetEdit.jsf", null, "dialogWidth:500px; dialogHeight:180px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{annu_BaseBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{annu_BaseBB.pageInit}"/>
    <c:verbatim>
    <table align="center" height=100% width=600>
        <tr><td height=8>
    </c:verbatim>
            <h:inputHidden id="subid" value="#{annu_BaseBB.organnubo.subid}"></h:inputHidden>
            <h:outputText escape="false" value="<strong>��ǰ���:</strong>#{annu_BaseBB.organnubo.b742701}"/>
            <h:outputText escape="false" value="&nbsp;&nbsp;<strong>�����ܶ�:</strong>#{annu_BaseBB.organnubo.b742702}"/>
            <h:outputText escape="false" value="&nbsp;&nbsp;<strong>��λ�����ܶ�:</strong>#{annu_BaseBB.organnubo.b742703}"/>
            <h:outputText escape="false" value="&nbsp;&nbsp;<strong>���ϵ��:</strong>#{annu_BaseBB.organnubo.b742704}"/>
    <c:verbatim>
         </td></tr>

          <tr><td align="right" height=8>
     </c:verbatim>
            <h:commandButton styleClass="button01" rendered="#{annu_BaseBB.canEdit}" value="�༭"    onclick="return doEdit();"/>
            <h:commandButton styleClass="button01" value="��ʼ�����"    onclick="return doNewYear();"/>
            <h:commandButton styleClass="button01" value="�鿴��ʷ��Ϣ"  onclick=""/>
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
        </jsp:include>
        </td></tr>

    </table>
    </c:verbatim>
</h:form>
