<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<script type="text/javascript">
function forSave() {
	forsubmit(document.forms(0));     	
}
</script>
<x:saveState value="#{eva_objectBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{eva_objectBB.addDefaultLevelPurview}"></h:inputHidden>
    <h:inputHidden value="#{eva_objectBB.planId}"></h:inputHidden>
    <h:panelGrid columns="2" columnClasses="td_form01,td_form02">
      
      <h:outputText value="考核人员类别"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="masterType" code="" dict="yes" dict_num="0652"
                             readonly="true" value="#{eva_objectBB.defaultbo.masterType}"
                             alt="考核人员类别|0|s|52||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:masterType')">
                </c:verbatim>
             </h:panelGroup>
      <h:outputText value="权重(%)"></h:outputText>
       <h:inputText value="#{eva_objectBB.defaultbo.purview}"></h:inputText>
      </h:panelGrid>
    
    <h:panelGrid columns="1" align="right">
        <h:panelGroup>
            <h:commandButton value="保存" styleClass="button01" action="#{eva_objectBB.saveDefaultLevelPurview}" onclick="javascript:return forSave()"></h:commandButton>
            <h:commandButton value="返回" onclick="window.close();" type="button" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>