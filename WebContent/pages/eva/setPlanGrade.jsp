<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doModify(id){ 
        window.showModalDialog("/eva/planGradeItemEdit.jsf?itemId="+id, null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doAdd(){ 
        window.showModalDialog("/eva/planGradeItemEdit.jsf?templateId="+document.all("form1:templateId").value+"&planId="+document.all("form1:planId").value, null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{evaSetPlanGradeBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{evaSetPlanGradeBB.initGradeItem}"></h:inputHidden>
      <h:inputHidden id="planId" value="#{evaSetPlanGradeBB.planId}"></h:inputHidden>
       <h:inputHidden id="templateId" value="#{evaSetPlanGradeBB.templateId}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
                <h:panelGroup>
       			<h:graphicImage value="/images/tips.gif" />
        		<h:outputText value=" ��Ч���� -> �ȼ���������"/>
        </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid columns="1" align="right">
                 <h:commandButton value="����" styleClass="button01" onclick="doAdd();" action="#{evaSetPlanGradeBB.saveTemplates}"></h:commandButton>
          </h:panelGrid>
          <x:dataTable value="#{evaSetPlanGradeBB.gradeList}"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="ȫ��������" />
					</f:facet>
                    <h:outputText value="#{briefList.gradeItem}" ></h:outputText>
                </h:column>
				<h:column>
                    <f:facet name="header">
                        <h:outputText value="����(%)" />
                    </f:facet>
                    <h:outputText value="#{briefList.gradeCount}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="���ſ�������" />
					</f:facet>
                    <h:outputText value="#{briefList.deptCount}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:commandButton styleClass="button01" value="�޸�"  onclick="return doModify('#{briefList.itemId}')" />
					<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{evaSetPlanGradeBB.deleteGrade}" styleClass="button01">
                  		<x:updateActionListener property="#{evaSetPlanGradeBB.itemId}" value="#{briefList.itemId}"/>
            		</h:commandButton>
				</h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>


