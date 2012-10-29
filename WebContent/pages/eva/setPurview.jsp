<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<script type="text/javascript">
function forSave() {
	forsubmit(document.forms(0)); 	
}
</script>
<x:saveState value="#{eva_objectBB}" />
<h:form id="form1">
	<h:inputHidden value="#{eva_objectBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="2" columnClasses="td_form01,td_form02">
		<h:outputText value="权重"/>
		<h:inputText id="purview" value="#{eva_objectBB.purview}" styleClass="input"/>
		
		<h:outputText value="考核人员类别"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="masterType" code="" dict="yes" dict_num="0652"
                             readonly="true" value="#{eva_objectBB.masterbo.masterType}"
                             alt="考核人员类别|0|s|52||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:masterType')">
                </c:verbatim>
             </h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" align="right">
        <h:panelGroup>
            <h:commandButton value="保存" styleClass="button01" action="#{eva_objectBB.getSaveTempMaster}" onclick="javascript:return forSave()"/>
            <h:commandButton value="返回" onclick="window.close();" type="button" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>			
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>