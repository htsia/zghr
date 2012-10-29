<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function forSave(){
        if(document.all("form1:actDate").value == ""){
                alert("活动时间不能为空 !");
                document.all("form1:actDate").focus();
                return false;
               }
        if(document.all("form1:actContent").value == ""){
            alert("活动内容不能为空 !");
            document.all("form1:actContent").focus();
            return false;
           }
        }
    
</script>
<x:saveState value="#{competitionBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{competitionBB.compActionInit}"></h:inputHidden>
	<h:inputHidden value="#{competitionBB.compeId}"></h:inputHidden>
	<h:inputHidden value="#{competitionBB.cuId}"></h:inputHidden>
	<h:inputHidden value="#{competitionBB.actId}"></h:inputHidden>
    <h:inputHidden value="#{competitionBB.itemId}"></h:inputHidden>
    
    <h:panelGrid columns="1" styleClass="td_title" width="102%"
		align="center">
		<h:panelGroup >
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="对手活动管理 - > 编辑活动 "></h:outputText>
		</h:panelGroup>
	</h:panelGrid>
    
	<h:panelGrid columns="1" align="center">

		<h:panelGroup>
			<h:panelGrid columns="2" align="right">
				<h:commandButton value="保存" onclick="return forSave();" rendered="#{competitionBB.flag == '1'}"
					styleClass="button01" action="#{competitionBB.saveCompetionAction}" />
				<h:commandButton value="返回" styleClass="button01"
					onclick="window.close();" />
			</h:panelGrid>
		</h:panelGroup>

		<h:panelGroup>
			<h:panelGrid columns="1" columnClasses="table02" align="center">
				<h:panelGroup >
					<h:panelGrid columns="2" align="center" styleClass="td_form01">
						<h:outputText value=" 活动时间 " />
						<h:panelGroup>
							<h:inputText value="#{competitionBB.competionActionBO.actDate}"
								readonly="#{competitionBB.flag == '0'}" id="actDate"></h:inputText>
							<h:commandButton type="button" styleClass="button_select"  
								rendered="#{competitionBB.flag == '1'}"
								onclick="PopUpCalendarDialog('form1:actDate')"></h:commandButton>
						</h:panelGroup>

						<h:outputText value=" 活动内容 " />
						<h:inputTextarea id="actContent"
						    readonly="#{competitionBB.flag == '0'}"
							value="#{competitionBB.competionActionBO.actContent}" rows="10"
							cols="55">
						</h:inputTextarea>

					</h:panelGrid>
				</h:panelGroup>

			</h:panelGrid>
		</h:panelGroup>

	</h:panelGrid>
</h:form>
