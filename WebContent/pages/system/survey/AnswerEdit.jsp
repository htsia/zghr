<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{sys_answerBB}"/>
<h:form id="form1">
    <h:inputHidden id="editAnswer" value="#{sys_answerBB.editAnswer}"/>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-1369", "对应题目 ")%>
	      </f:verbatim>
            <h:inputTextarea readonly="true" cols="70" rows="5" value="#{sys_answerBB.questionName}" />
          <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-1370", "代码 ")%>
	      </f:verbatim>
            <h:selectOneMenu value="#{sys_answerBB.answerbo.code}">
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
          <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-1111", "内容")%>
	      </f:verbatim>
            <h:inputTextarea cols="70" rows="5" value="#{sys_answerBB.answerbo.answerName}" />

             <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-1002", "类型")%>
	      </f:verbatim>
            <h:selectOneMenu id="type" rendered="#{sys_answerBB.questionType=='2' || sys_answerBB.questionType=='4'}" value="#{sys_answerBB.answerbo.type}" >
                <c:selectItems value="#{sys_answerBB.questionTypeList}"></c:selectItems>
            </h:selectOneMenu>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{sys_answerBB.Save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
