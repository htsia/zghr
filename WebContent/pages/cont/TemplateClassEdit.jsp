<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" language="javascript">
 function checkSubmit(form1) {
        var name= form1.all("form1:ispublic").value;
         if (name == "" || name == null) {
             alert("请选择是否公用！");
             return false;
         }
         if(forsubmit(document.forms(0))){return true;}else{return false;}
    }
</script>

<x:saveState value="#{cont_contTemplateClassBB}"></x:saveState>
<h:form id="form1">
    <h:panelGrid width="100%" border="0" cellspacing="6" styleClass="td_title" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="合同模板类别维护 " ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>

    <h:inputHidden id="init" value="#{cont_contTemplateClassBB.pageInit}"/>
    <h:panelGrid width="98%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="2" columnClasses="td_form01,td_form02">
        <h:outputText styleClass="td_form_required" value="模板类别名称"></h:outputText>
        <h:inputText styleClass="input" id="templateClassName" size ="35" value="#{cont_contTemplateClassBB.bo.templateClassName}" maxlength="15" alt="模板类别名称|0|s" />

        <h:outputText styleClass="td_form_required" value="是否公用"></h:outputText>
        <h:selectOneMenu id="ispublic" value="#{cont_contTemplateClassBB.bo.isPublic}">
            <c:selectItem itemLabel="" itemValue=""></c:selectItem>
            <c:selectItem itemLabel="公用" itemValue="1"></c:selectItem>
            <c:selectItem itemLabel="不公用" itemValue="0"></c:selectItem>
        </h:selectOneMenu>
    </h:panelGrid>
    
    <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
         <h:commandButton styleClass="button01" value="保存" action="#{cont_contTemplateClassBB.save}" onclick="return checkSubmit(document.forms(0));"/>
         <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close()"/>
    </h:panelGrid>
</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
