<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function setGrade(id){ 
        window.showModalDialog("/eva/setPlanGrade.jsf?templateId="+id+"&planId="+document.all("form1:planId").value, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doAddItem(){
    	var reval=window.showModalDialog("/eva/selEvaTemplate.jsf?planId="+document.all("form1:planId").value, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
    	 if (reval != null && reval!="") {
             var vars=reval.split("|");
             document.all("form1:templateIds").value = vars[1];
             return true;
         } else {
             return false;
         }
        return true;
    }
</script>

<x:saveState value="#{evaSetPlanGradeBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{evaSetPlanGradeBB.initItem}"></h:inputHidden>
      <h:inputHidden id="planId" value="#{evaSetPlanGradeBB.planId}"></h:inputHidden>
      <h:inputHidden id="templateIds" value="#{evaSetPlanGradeBB.templateIds}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
                <h:panelGroup>
       			<h:graphicImage value="/images/tips.gif" />
        		<h:outputText value=" 绩效管理 -> 考核模板设置"/>
        </h:panelGroup>
        </h:panelGrid>
          <h:panelGrid columns="1" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddItem();" action="#{evaSetPlanGradeBB.saveTemplates}"></h:commandButton>
          </h:panelGrid>
          
          <x:dataTable value="#{evaSetPlanGradeBB.itemList}"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="模板名称" />
					</f:facet>
                    <h:outputText value="#{briefList.templateName}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="设定总分" />
                  </f:facet>
                  <h:outputText value="#{briefList.totalscore}" ></h:outputText>
              </h:column>
              <h:column>
                  <f:facet name="header">
                      <h:outputText value="层级" />
                  </f:facet>
                  <h:outputText value="#{briefList.level}" ></h:outputText>
              </h:column>

				
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton styleClass="button01" value="设置等级比例"  onclick="return setGrade('#{briefList.templateID}')" />
                    <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{evaSetPlanGradeBB.deleteTemplate}" styleClass="button01">
                  <x:updateActionListener property="#{evaSetPlanGradeBB.templateId}" value="#{briefList.templateID}"/>
            </h:commandButton>
				</h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>


