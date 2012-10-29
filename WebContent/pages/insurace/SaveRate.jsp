<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
<base target="_self">
</c:verbatim>
<x:saveState value="#{ins_computelistBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{ins_computelistBB.initSave}"></h:inputHidden>
    <h:inputHidden value="#{ins_computelistBB.setId}"></h:inputHidden>
<f:verbatim>
    <table width="98%">
        <tr>
            <td  width="40%">
</f:verbatim>
            <h:outputText value="当前状态:#{ins_computelistBB.bsb.statusDes}"></h:outputText>
<f:verbatim>
            </td>
            <td align="right">
</f:verbatim>
                <h:outputText value="同时计算缴费额" ></h:outputText>
                <h:selectBooleanCheckbox value="#{ins_computelistBB.calcFee}"></h:selectBooleanCheckbox>
                <h:commandButton value="开始生效" styleClass="button01" action="#{ins_computelistBB.SaveRate}"></h:commandButton>
                <h:commandButton value="关闭" onclick="window.close();" type="button" styleClass="button01"></h:commandButton>
<f:verbatim>
            </td>
        </tr>
    </table>
    <table width="98%">
        <tr>
            <td class="td_form01" width="40%">选择更新方式</td>
            <td class="td_form02">
</f:verbatim>
                <h:selectOneRadio value="#{ins_computelistBB.updateType}">
                    <c:selectItem itemValue="0" itemLabel="更新"></c:selectItem>
                    <c:selectItem itemValue="1" itemLabel="插入"></c:selectItem>
                </h:selectOneRadio>
<f:verbatim>
            </td>
        </tr>
        <tr>
            <td class="td_form01" width="40%">选择更新基数</td>
            <td class="td_form02">
</f:verbatim>
                <h:selectBooleanCheckbox id="A755715" value="#{ins_computelistBB.a755715}"></h:selectBooleanCheckbox>
                <h:outputText value="基本养老保险月缴费基数"></h:outputText>
                <f:verbatim><br></f:verbatim>

                <h:selectBooleanCheckbox id="A760710" value="#{ins_computelistBB.a760710}"></h:selectBooleanCheckbox>
                <h:outputText value="基本医疗保险月缴费基数"></h:outputText>
                <f:verbatim><br></f:verbatim>

                <h:selectBooleanCheckbox id="A765705" value="#{ins_computelistBB.a765705}"></h:selectBooleanCheckbox>
                <h:outputText value="工伤保险单位月缴费基数"></h:outputText>
                <f:verbatim><br></f:verbatim>

                <h:selectBooleanCheckbox id="A770710" value="#{ins_computelistBB.a770710}" ></h:selectBooleanCheckbox>
                <h:outputText value="失业保险月缴费基数"></h:outputText>
                <f:verbatim><br></f:verbatim>

                <h:selectBooleanCheckbox id="A775704" value="#{ins_computelistBB.a775704}"></h:selectBooleanCheckbox>
                <h:outputText value="生育保险单位月缴费基数"></h:outputText>
                <f:verbatim><br></f:verbatim>

                <h:selectBooleanCheckbox id="A780708" value="#{ins_computelistBB.a780708}"></h:selectBooleanCheckbox>
                <h:outputText value="住房公积金月缴费基数"></h:outputText>
                <f:verbatim><br></f:verbatim>

                <h:selectBooleanCheckbox id="a786700" value="#{ins_computelistBB.a786700}"></h:selectBooleanCheckbox>
                <h:outputText value="大额医疗互助单位月缴费基数"></h:outputText>
                <f:verbatim><br></f:verbatim>
                
                <h:selectBooleanCheckbox id="A785708" value="#{ins_computelistBB.a785708}"></h:selectBooleanCheckbox>
                <h:outputText value="企业年金月缴费基数"></h:outputText>
<f:verbatim>
            </td>
        </tr>

    </table>
</f:verbatim>
</h:form>
