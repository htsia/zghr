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
                    <h:outputText value="操作" />
                </f:facet>

                <h:commandButton value="查看详细信息" styleClass="button01" type="button" onclick="return doShowRule('#{briefList.fileID}');">
                </h:commandButton>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="文件编号" />
                </f:facet>
                <h:outputText value="#{briefList.docno}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="标题" />
                </f:facet>
                <h:outputText value="#{briefList.title}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="发布时间" />
                </f:facet>
                <h:outputText value="#{briefList.publicDate}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="生效时间" />
                </f:facet>
                <h:outputText value="#{briefList.actDate}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="失效时间" />
                </f:facet>
                <h:outputText value="#{briefList.invalidDate}" ></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="关键字" />
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


