<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   
    <script type="text/javascript">
        function foradd() {
            window.showModalDialog("/wage/set/BankItemEdit.jsf?bankID="+document.all("form1:bankID").value, null, "dialogWidth:330px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModify(payItemID) {
            window.showModalDialog("/wage/set/BankItemEdit.jsf?payItemID="+payItemID, null, "dialogWidth:330px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wage_bankitemlistBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_bankitemlistBB.pageInit}"/>
    <h:inputHidden id="bankID" value="#{wage_bankitemlistBB.wcbo.bankID}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ���̸�ʽ����"/>
        </h:panelGroup>
    </h:panelGrid>


    <h:panelGrid  width="95%" border="0" cellpadding="0" cellspacing="6">
        <h:panelGrid align="center" width="100%" columns="3">
            <h:outputText value="��ʽ���ƣ�#{wage_bankitemlistBB.wcbo.bankName}"></h:outputText>
            <h:outputText value="�������ף�#{wage_bankitemlistBB.wcbo.wagesetname}"></h:outputText>
            <h:panelGrid align="right" columns="2" cellspacing="2" width="30%">
                <h:commandButton styleClass="button01" value="�½���Ŀ" onclick="foradd()" rendered="#{wage_bankitemlistBB.operRight}"/>
                <h:commandButton type="button" styleClass="button01" value="����"  onclick="window.close();" rendered="#{wage_bankitemlistBB.operRight}"/>
            </h:panelGrid>
        </h:panelGrid>

    <h:dataTable value="#{wage_bankitemlistBB.bankItemList}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="���˳��"/></c:facet>
            <h:outputText value="#{list.arrangeOrder}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��Ŀ����"/></c:facet>
            <h:outputText value="#{list.payName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�ֶ�����"/></c:facet>
            <h:outputText value="#{list.fieldName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{list.width}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�Ƿ���ʾС����"/></c:facet>
            <h:outputText value="#{list.radixPoint}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ȡ��"/></c:facet>
            <h:outputText value="#{list.roundVal}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="ǰ׺�ַ�"/></c:facet>
            <h:outputText value="#{list.beforeChar}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��׺�ַ�"/></c:facet>
            <h:outputText value="#{list.behindChar}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�ָ��ַ�"/></c:facet>
            <h:outputText value="#{list.separator}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�����ʽ"/></c:facet>
            <h:outputText value="#{list.cutStyle}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="ɾ��" styleClass="button01" rendered="true"
                                 action="#{wage_bankitemlistBB.delete}" onclick="return confirm('ȷ��ɾ����')">
                    <x:updateActionListener property="#{wage_bankitemlistBB.itemId}" value="#{list.payNameID}"/>
                </h:commandButton>
                <h:commandButton value="�޸�" onclick="forModify('#{list.payNameID}')"
                                 styleClass="button01" rendered="true">
                </h:commandButton>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
