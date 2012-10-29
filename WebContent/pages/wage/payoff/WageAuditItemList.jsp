<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{wage_aduitItemBB}"/>

<script type="text/javascript" language="javascript">
    function  check(){
        if (document.all('form1:fieldID').value=="-1" || document.all('form1:typeID').value=="-1") {
            alert("请选择项目与类别！");
            return false;
        }
        return true;
    }

    function doSortItem( ){
        window.showModalDialog("/wage/payoff/WageAuditItemSort.jsf", "", "dialogWidth:580px; dialogHeight:530px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
        return true;
    }
</script>

<h:form id="form1">
    <h:panelGrid width="100%" styleClass="td_title" border="0" cellspacing="0" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="审批项目层次设置" ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>
    

    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
        <h:panelGrid  border="0"  cellspacing="4" align="right" columns="5" >
            <h:selectOneMenu id="fieldID" value="#{wage_aduitItemBB.itemBO.fieldID}">
                <c:selectItems value="#{wage_aduitItemBB.sourceList}"></c:selectItems>
            </h:selectOneMenu>
            <h:selectOneMenu id="typeID" value="#{wage_aduitItemBB.itemBO.typeID}">
                <c:selectItems value="#{wage_aduitItemBB.itemtypeList}"></c:selectItems>
            </h:selectOneMenu>

            <h:commandButton id="add_button" styleClass="button01" value=" 增加 " onclick="return check();" action="#{wage_aduitItemBB.addItem}"/>
            <h:commandButton id="sort_button" styleClass="button01" value=" 修改排序 " onclick="return doSortItem();" action="#{wage_aduitItemBB.queryItemList}"/>
        </h:panelGrid>
    </h:panelGrid>

         <x:dataTable value="#{wage_aduitItemBB.itemList}" var="list"  rowIndexVar="index" id="dateList"
                     headerClass="td_top"   align="center"
                     rowClasses="td_middle" styleClass="table03" width="95%" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="顺序号"/></c:facet>
               <h:outputText value="#{list.showSeq}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="项目名称"/></c:facet>
                <h:outputText value="#{list.fieldName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="项目类别"/></c:facet>
                <h:outputText value="#{list.typeName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton styleClass="button01"   value="删除" action="#{wage_aduitItemBB.deleteItem}">
                    <x:updateActionListener property="#{wage_aduitItemBB.itemBO.itemID}" value="#{list.itemID}"/>
                </h:commandButton>
            </h:column>
     </x:dataTable>
</h:form>
