<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<x:saveState value="#{emp_d2AnaBB}"/>
    <script type="text/javascript">
        function doCheck(){
            if  (document.all("form1:name").value==""){
                alert("请录入名称！");
                return false;
            }

            if  (document.all("form1:codevalues").value==""){
                alert("请选择代码！");
                return false;
            }
            if  (document.all("form1:op").value==""){
                alert("请选择关系符号！");
                return false;
            }

            return true;
        }
        // 选择指标项
        function selectInfoItem() {
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;

            retval = window.showModalDialog("/pages/employee/info/SelectD2InfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                rs = retval.split("|");
                document.all("form1:fieldName").value= rs[1];
                vals=rs[0].split(".");
                document.all("form1:andField").value = vals[1];
            }
        }
        function forSel() {
            if (document.all('form1:op').value=='0'){
               PopUpMutilCodeDlgNoSubmit('form1:codevalues','form1:des',document.all('form1:codeSetID').value,'');
            }
            else{
                PopUpCodeDlgTwoControl(document.all('form1:codevalues'),document.all('form1:des'),document.all('form1:codeSetID').value,'');
            }
            return false;
        }

       </script>
<x:saveState value="#{emp_d2AnaBB}"></x:saveState>
<h:form id="form1">
    <h:panelGrid align="center" width="98%">
        <h:inputHidden value="#{emp_d2AnaBB.editDetail}"></h:inputHidden>
        <h:inputHidden value="#{emp_d2AnaBB.currentID}"></h:inputHidden>
        <h:inputHidden id="codeSetID" value="#{emp_d2AnaBB.codeSetID}"></h:inputHidden>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{emp_d2AnaBB.saveDetail}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="#{emp_d2AnaBB.seqName}"/>
            <h:inputText id="seq" value="#{emp_d2AnaBB.anditembo.seq}" />

            <h:outputText value="#{emp_d2AnaBB.itemTitle}"/>
            <h:inputText id="name" value="#{emp_d2AnaBB.anditembo.itemName}" />

            <h:outputText value="关系符号"/>
            <h:selectOneRadio id="op" value="#{emp_d2AnaBB.anditembo.op}">
                <c:selectItem itemValue="0" itemLabel="等于"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="属于"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="不等于"></c:selectItem>
            </h:selectOneRadio>

            <h:outputText value="#{emp_d2AnaBB.codeTitle}"/>
            <h:panelGroup>
                <h:inputText id="des"  value="#{emp_d2AnaBB.anditembo.codeDes}" readonly="true"/>
                <h:inputHidden id="codevalues" value="#{emp_d2AnaBB.anditembo.codevalues}"></h:inputHidden>
                <h:commandButton styleClass="button_select" type="button" onclick="return forSel();"></h:commandButton>
             </h:panelGroup>

        </h:panelGrid>
    </h:panelGrid>
</h:form>
