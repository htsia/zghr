<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contTemplateBB}"/>



<script type="text/javascript" language="javascript">
    function addType(){
         window.showModalDialog("/wage/payoff/AuditTypeEdit.jsf", "", "dialogWidth:430px; dialogHeight:230px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    }
    function modifyType(itemID){
         window.showModalDialog("/wage/payoff/AuditTypeEdit.jsf?itemID="+itemID, "", "dialogWidth:430px; dialogHeight:230px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    }
</script>

<h:form id="form1">
    <h:panelGrid width="100%" styleClass="td_title" border="0" cellspacing="0" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="审批项目类别设置" ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>
    

    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
        <h:panelGrid  border="0"  cellspacing="4" align="right" columns="5" >
            <h:commandButton id="add_button" styleClass="button01" value=" 增加 " onclick="addType();"/>
        </h:panelGrid>
    </h:panelGrid>

     <x:dataTable value="#{wage_aduitItemBB.typeList}" var="list"  rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="95%" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="项目名称"/></c:facet>
                <h:outputText value="#{list.itemName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton styleClass="button01"  value="删除" action="#{wage_aduitItemBB.deleteType}">
                       <x:updateActionListener property="#{wage_aduitItemBB.typeBO.itemID}" value="#{list.itemID}"/>
                </h:commandButton>
                <h:commandButton styleClass="button01"  value="修改"  action="#{wage_aduitItemBB.queryTypeList}" onclick="modifyType('#{list.itemID}');"/>
            </h:column>
</x:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
