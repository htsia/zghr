<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>
<script type="text/javascript">
function forSave() {
	forsubmit(document.forms(0));    	
}
</script>
<h:form id="form1">
    <h:inputHidden value="#{eva_objectBB.addLevelPurview}"></h:inputHidden>
    <h:inputHidden value="#{eva_objectBB.objectID}"></h:inputHidden>
    <h:inputHidden value="#{eva_objectBB.method}"></h:inputHidden>
    <h:panelGrid columns="2" columnClasses="td_form01,td_form02">
      
      <h:outputText value="������Ա���"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="masterType" code="" dict="yes" dict_num="0652"
                             readonly="true" value="#{eva_objectBB.levelPurviewbo.masterType}"
                             alt="������Ա���|0|s|52||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:masterType')">
                </c:verbatim>
             </h:panelGroup>
      <h:outputText value="Ȩ��"></h:outputText>
       <h:inputText value="#{eva_objectBB.levelPurviewbo.purview}"></h:inputText>
      </h:panelGrid>
    
    <h:panelGrid columns="1" align="right">
        <h:panelGroup>
            <h:commandButton value="����" styleClass="button01" action="#{eva_objectBB.saveLevelPurview}" onclick="javascript:return forSave()"></h:commandButton>
            <h:commandButton value="����" onclick="window.close();" type="button" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>