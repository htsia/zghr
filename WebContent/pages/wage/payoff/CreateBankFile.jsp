<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function doViewGroupPayoff(){
    window.showModalDialog("/wage/payoff/GroupPayoffView.jsf?dateID="+document.all('form1:dateId').value, "", "dialogWidth:580px; dialogHeight:380px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    return false;
}
</script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden id="unitId" value="#{wage_flowBB.initBankFile}"/>
    <h:inputHidden id="dateId" value="#{wage_flowBB.dateId}"/>
    <f:verbatim>
    <table width=98% cellspacing=0>
       <tr><td align="left" class="td_title">
    </f:verbatim>
         <h:graphicImage value="/images/tips.gif" />
         <h:outputText value="���ɱ���"/>
<f:verbatim>
       </td>
    <td align="right" class="td_title">
</f:verbatim>
        <h:commandButton value="�ر�" onclick="window.close()" type="button" styleClass="button01"></h:commandButton>
<f:verbatim>
        </td></tr>
    </table>

    <table width=98%>
        <tr>
            <td align="right" height=8>
            </td>
        </tr>
        <tr>
        <td align="center">
     </f:verbatim>
            <h:panelGrid columns="2" styleClass="table03" columnClasses="td_form01,td_form02">
                <h:outputText value="�����ˣ�"></h:outputText>
                <h:outputText value="#{wage_flowBB.disk.operateName}"></h:outputText>

                <h:outputText value="����ʱ�䣺"></h:outputText>
                <h:outputText value="#{wage_flowBB.disk.operateDate}"></h:outputText>

                <h:outputText value="������ʷ"></h:outputText>
                <h:commandButton  value="�鿴"  type="button" styleClass="button01" onclick="doViewGroupPayoff();"></h:commandButton>

                 <h:outputText value="�������"></h:outputText>
                 <h:outputText value="#{wage_flowBB.disk.sumInfo}"></h:outputText>

                <h:outputText value="����"></h:outputText>
                <h:outputText escape="false" value="<a target='_blank' href='#{wage_flowBB.bankFileUrl}'>����򿪱����ļ�</a>"  />
           </h:panelGrid>
<f:verbatim>
        </td>
        </tr>
    </table>
</f:verbatim>
</h:form>

