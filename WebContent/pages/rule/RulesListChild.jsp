<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
</script>

<x:saveState value="#{rule_browbb}"/>
<h:form id="form1">
     <h:inputHidden value="#{rule_browbb.pageInit}"></h:inputHidden>

    <f:verbatim>
        <table width=100% height=98%>
        <tr><td height=8>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </f:verbatim>
        <x:dataTable value="#{rule_browbb.rulelist}" id="dateList"
            headerClass="td_top tr_fixrow" rowIndexVar="index" var="briefList" 	styleClass="table03" border="0" width="1000" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
            <h:column>
                <f:facet name="header">
                    <h:outputText value="����" />
                </f:facet>

                <h:commandButton value="�鿴��ϸ��Ϣ" styleClass="button01" type="button" onclick="return doShowRule('#{briefList.fileID}');">
                </h:commandButton>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�ļ����" />
                </f:facet>
                <h:outputText value="#{briefList.docno}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="����" />
                </f:facet>
                <h:outputText value="#{briefList.title}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="����ʱ��" />
                </f:facet>
                <h:outputText value="#{briefList.publicDate}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="��Чʱ��" />
                </f:facet>
                <h:outputText value="#{briefList.actDate}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="ʧЧʱ��" />
                </f:facet>
                <h:outputText value="#{briefList.invalidDate}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�ؼ���" />
                </f:facet>
                <h:outputText value="#{briefList.keyWords}" ></h:outputText>
            </h:column>


        </x:dataTable>
    <f:verbatim>
        </div>
        </td></tr>
        </table>
    </f:verbatim>

    </h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


