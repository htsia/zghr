<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>



<x:saveState value="#{eLearn_questionLibBB}"/>
<h:form id="form1">
    <h:inputHidden id="editAnswer" value="#{eLearn_questionLibBB.editAnswer}"/>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="对应题目" style="width:100px"/>
            <h:inputTextarea readonly="true" cols="70" rows="5" value="#{eLearn_questionLibBB.questionName}" />

            <h:outputText value="代码" style="width:100px"/>
            <h:selectOneMenu value="#{eLearn_questionLibBB.answerbo.answerCode}">
                <c:selectItem itemValue="A" itemLabel="A"></c:selectItem>
                <c:selectItem itemValue="B" itemLabel="B"></c:selectItem>
                <c:selectItem itemValue="C" itemLabel="C"></c:selectItem>
                <c:selectItem itemValue="D" itemLabel="D"></c:selectItem>
                <c:selectItem itemValue="E" itemLabel="E"></c:selectItem>
                <c:selectItem itemValue="F" itemLabel="F"></c:selectItem>
                <c:selectItem itemValue="G" itemLabel="G"></c:selectItem>
                <c:selectItem itemValue="H" itemLabel="H"></c:selectItem>
                <c:selectItem itemValue="I" itemLabel="I"></c:selectItem>
                <c:selectItem itemValue="J" itemLabel="J"></c:selectItem>
                <c:selectItem itemValue="K" itemLabel="K"></c:selectItem>
                <c:selectItem itemValue="L" itemLabel="L"></c:selectItem>
                <c:selectItem itemValue="M" itemLabel="M"></c:selectItem>
                <c:selectItem itemValue="N" itemLabel="N"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="内容" style="width:100px"/>
            <h:inputTextarea cols="70" rows="5" value="#{eLearn_questionLibBB.answerbo.answerName}" />

            <h:outputText value="类型" style="width:100px" />
            <h:selectOneMenu  disabled="#{!(eLearn_questionLibBB.questionType=='2' || eLearn_questionLibBB.questionType=='4')}" value="#{eLearn_questionLibBB.answerbo.answerType}" >
                <c:selectItems value="#{eLearn_questionLibBB.questionTypeList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="是否正确选择" style="width:100px"/>
            <h:selectOneRadio value="#{eLearn_questionLibBB.answerbo.isRight}" disabled="#{!(eLearn_questionLibBB.questionType=='0' || eLearn_questionLibBB.questionType=='1' || eLearn_questionLibBB.questionType=='2')}" >
                <c:selectItem itemValue='0' itemLabel='否'></c:selectItem>
                <c:selectItem itemValue='1' itemLabel='是'></c:selectItem>
            </h:selectOneRadio>

            <h:outputText value="参考答案" style="width:100px"/>
            <h:inputTextarea value="#{eLearn_questionLibBB.answerbo.referKey}" disabled="#{eLearn_questionLibBB.questionType!='3'}" cols="60" rows="5"></h:inputTextarea>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eLearn_questionLibBB.SaveAnswer}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
