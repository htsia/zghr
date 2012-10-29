<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
function doAddItem(){
	var str=" |";
    chk=document.forms(0).selectItem;
    if (checkMutilSelect(chk)){
        var size = chk.length;
        if (size == null) {
            if (chk.checked) {
                str+=chk.value;
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (chk[i].checked) {
                    if (i==0){
                        str+=chk[i].value;
                    }
                    else{
                        str+=","+chk[i].value;
                    }
                }
            }
        }
    }
    window.returnValue=str;
  	window.close();
}
    
</script>

<x:saveState value="#{evaSetPlanGradeBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{evaSetPlanGradeBB.inintTemplateList}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="确定" styleClass="button01" onclick="doAddItem();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{evaSetPlanGradeBB.templateList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
		        <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{briefList.templateID}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>
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

			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


