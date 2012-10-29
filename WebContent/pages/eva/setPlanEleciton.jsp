<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddItem(id){ 
        window.showModalDialog("/eva/planElecitonCtorEdit.jsf?planId="+document.all("form1:planId").value, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{evaSetElectionContrlBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{evaSetElectionContrlBB.initItem}"></h:inputHidden>
      <h:inputHidden id="planId" value="#{evaSetElectionContrlBB.planId}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
                <h:panelGroup>
       			<h:graphicImage value="/images/tips.gif" />
        		<h:outputText value=" 绩效管理 -> 投票比例控制"/>
        </h:panelGroup>
        </h:panelGrid>
          <h:panelGrid columns="1" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddItem();"></h:commandButton>
          </h:panelGrid>
          
          <x:dataTable value="#{evaSetElectionContrlBB.itemList}"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="考核人员类型" />
					</f:facet>
                    <h:outputText value="#{briefList.masterType}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="等级" />
                  </f:facet>
                  <h:outputText value="#{briefList.gradeItem}" ></h:outputText>
              </h:column>
              <h:column>
                  <f:facet name="header">
                      <h:outputText value="控制比例（%）" />
                  </f:facet>
                  <h:outputText value="#{briefList.gradeCount}" ></h:outputText>
              </h:column>
			  <h:column>
                  <f:facet name="header">
                      <h:outputText value="部门控制人数" />
                  </f:facet>
                  <h:outputText value="#{briefList.deptCount}" ></h:outputText>
              </h:column>
				
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{evaSetElectionContrlBB.deleteItem}" styleClass="button01">
                  		<x:updateActionListener property="#{evaSetElectionContrlBB.itemId}" value="#{briefList.itemId}"/>
           			 </h:commandButton>
				</h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>


