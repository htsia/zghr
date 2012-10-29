<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forSelSource() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:sourceField").value,'');
            return false;
        }

        function doCheck() {
            if (document.all("form1:name").value==""){
                alert("请录入名称!");
                return false;
            }
            if (document.all("form1:desc").value==""){
                alert("请录入描述!");
                return false;
            }
            if (document.all("form1:fileExtent").value==""){
                alert("请选择文件格式!");
                return false;
            }
            //debugger;
            if (!(document.all("form1:showTitle")[1].checked || document.all("form1:showTitle")[2].checked)){
                alert("请选择是否显示标题!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{wage_bankeditBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_bankeditBB.pageInit}"/>

      <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_bankeditBB.save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="名称"/>
            <h:inputText id="name" value="#{wage_bankeditBB.wcbo.bankName}" />

            <h:outputText value="描述"/>
            <h:inputTextarea id="desc" value="#{wage_bankeditBB.wcbo.description}" cols="35" rows="5"/>

            <h:outputText value="所属帐套" />
            <h:selectOneMenu value="#{wage_bankeditBB.wcbo.wagesetid}">
                <c:selectItems value="#{wage_bankeditBB.setList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="文件格式" />
            <h:selectOneMenu id="fileExtent" value="#{wage_bankeditBB.wcbo.fileSuffix}">
                <c:selectItem itemValue="" itemLabel=""></c:selectItem>
                <c:selectItem itemValue=".TXT" itemLabel="文本文件(*.TXT)"></c:selectItem>
                <c:selectItem itemValue=".XLS" itemLabel="EXCEL(*.XLS)"></c:selectItem>
            </h:selectOneMenu>

             <h:outputText value="是否显示标题" />
             <h:selectOneRadio id="showTitle" value="#{wage_bankeditBB.wcbo.showTitle}">
                 <c:selectItem itemValue="1" itemLabel="显示"></c:selectItem>
                 <c:selectItem itemValue="0" itemLabel="不显示"></c:selectItem>
             </h:selectOneRadio>

            <h:outputText value="是否合并同一卡号" />
            <h:selectOneRadio id="merge" value="#{wage_bankeditBB.wcbo.mergeCard}">
                <c:selectItem itemValue="1" itemLabel="合并"></c:selectItem>
                <c:selectItem itemValue="0" itemLabel="不合并"></c:selectItem>
            </h:selectOneRadio>

            <h:outputText value="排序字段" />
            <h:selectOneMenu value="#{wage_bankeditBB.wcbo.sortField}">
                <c:selectItems value="#{wage_bankeditBB.fieldList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="过滤字段" />
            <h:selectOneMenu id="sourceField" value="#{wage_bankeditBB.wcbo.filterField}">
                <c:selectItems value="#{wage_bankeditBB.filterfieldList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="过滤值" />
            <h:panelGroup>
                <h:inputText readonly="true"  style="width:300px" id="classvaluedes" value="#{wage_bankeditBB.wcbo.filterValuesDes}"/>
                <h:inputHidden id="classvalue" value="#{wage_bankeditBB.wcbo.filterValues}"/>
                <h:commandButton id="source" type="button" styleClass="button01" value="选择"  onclick="forSelSource();"/>
            </h:panelGroup>

        </h:panelGrid>

    </h:panelGrid>
</h:form>
