<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function checkSubmit() {
            var value = form1.all('form1:type').value;
            if (value == "") {
                alert("薪资项类别不能为空！")
                return false;
            } else if (value == 0) {//standard
                if (form1.all('form1:stdId').value == "") {
                    alert("标准表不能为空！")
                    return false;
                }
            } else if (value == 1) {// formula
                if (form1.all('form1:formulaId').value == "") {
                    alert("公式不能为空！")
                    return false;
                }
            } else if (value == 2) {// input
                if (form1.all('form1:field').value == "") {
                    alert("指标项不能为空！")
                    return false;
                } else {
                    // element, discript, type, length, nullflag, maxs, mins
                    if (checkValidate(form1.all('form1:defaultValue'), '默认输入值', 'f')) {
                        pageCodeExchange(form1);
                        return true;
                    } else {
                        return false;
                    }
                }
            }
            return true;
        }
        function forcostchage() {
            var oldvalue = form1.all('form1:cost').value;
            PopUpCodeDlgOneControl('form1:cost', '', '0');
            if (form1.all('form1:cost').value != oldvalue) {
                form1.all('form1:cost').value = form1.all('form1:cost').code;
                return true;
            }
            return false;
        }
    </script>

<x:saveState value="#{wage_setItemBB}"/>
<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" width="100%" styleClass="table03">
            <h:outputText value="薪资项类别"/>
            <h:panelGroup>
                <h:selectOneMenu id="type" value="#{wage_setItemBB.item.type}" style="width:150"
                                 onchange="forWageTypeChange()">
                    <c:selectItems value="#{wage_setItemBB.itemtypeList}"></c:selectItems>
                </h:selectOneMenu>
                <h:selectBooleanCheckbox id="orderByName" value="#{wage_setItemBB.orderByName}" onclick="form1.all('form1:cost').value = form1.all('form1:cost').code;submit();"  valueChangeListener="#{wage_setItemBB.outputByName}" ></h:selectBooleanCheckbox>
                <h:outputText value="按项目名称排序"></h:outputText>
            </h:panelGroup>

            <h:outputText value="人力成本类别"/>
            <h:panelGroup>
                <h:inputText id="cost" value="#{wage_setItemBB.item.cost}"
                             code="" dict="yes" dict_num="0280" readonly="true" alt="人力成本类别|1"/>
                <h:outputText value=" "/>
                <h:commandButton styleClass="button_select" onclick="return forcostchage();" value=" "
                              id="codebnt"   actionListener="#{wage_setItemBB.changeCost}"/>
            </h:panelGroup>

            <h:outputText value="选择指标项"/>
            <h:selectOneMenu id="field" value="#{wage_setItemBB.item.field}" style="width:250px">
                <c:selectItems value="#{wage_setItemBB.rsInfoItemList}"/>
            </h:selectOneMenu>

            <h:outputText value="默认输入值"/>
            <h:panelGroup>
                <h:inputText id="defaultValue" value="#{wage_setItemBB.item.defaultValue}"/>
                <h:outputText value=" "/>
                <h:outputText value="元"/>
            </h:panelGroup>

            <h:outputText value="选择公式"/>
            <h:selectOneMenu id="formulaId" value="#{wage_setItemBB.item.formulaId}" style="width:250px">
                <c:selectItems value="#{wage_setItemBB.formulaList}"/>
            </h:selectOneMenu>

            <h:outputText value="选择标准表"/>
            <h:selectOneMenu id="stdId" value="#{wage_setItemBB.item.stdId}" style="width:250px">
                <c:selectItems value="#{wage_setItemBB.standardList}"/>
            </h:selectOneMenu>

        </h:panelGrid>
                              
        <h:panelGrid columns="2" align="center" cellspacing="2">

            <h:commandButton styleClass="button01" value="保存" action="#{wage_setItemBB.save}"
                             onclick="if(checkSubmit()){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" action="#{wage_setItemBB.list}"/>

        </h:panelGrid>
    </h:panelGrid>
</h:form>
<c:verbatim escape="false">
    <script type="text/javascript" language="javascript">
        function forWageTypeChange() {
            var value = form1.all('form1:type').value;
            if (value == 0) {//standard
                form1.all('form1:field').disabled = true;
                form1.all('form1:defaultValue').disabled = true;
                form1.all('form1:stdId').disabled = false;
                form1.all('form1:formulaId').disabled = true;
                form1.all('form1:cost').value = "";
                form1.all('form1:cost').code = "";
                form1.all('form1:codebnt').disabled = true;
            } else if (value == 1) {// formula
                form1.all('form1:field').disabled = true;
                form1.all('form1:defaultValue').disabled = true;
                form1.all('form1:stdId').disabled = true;
                form1.all('form1:formulaId').disabled = false;
                form1.all('form1:cost').value = "";
                form1.all('form1:cost').code = "";
                form1.all('form1:codebnt').disabled = true;
            } else if (value == 2) {// input
                form1.all('form1:field').disabled = false;
                form1.all('form1:defaultValue').disabled = false;
                form1.all('form1:stdId').disabled = true;
                form1.all('form1:formulaId').disabled = true;
                form1.all('form1:codebnt').disabled = false;
            }
        }
        
        interpret(document.forms(0));
        var typeValue = form1.all('form1:type').value;
        if (typeValue == 2) {
            form1.all('form1:defaultValue').disabled = false;
        }else
            form1.all('form1:defaultValue').disabled = true;

        form1.all('form1:stdId').disabled = true;
        form1.all('form1:formulaId').disabled = true;
        form1.all('form1:codebnt').disabled = true;

        forWageTypeChange();
        interpret(document.forms(0));
    </script>
</c:verbatim>
