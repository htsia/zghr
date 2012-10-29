<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
		function checkItem(itemId){
			window.returnValue=itemId;
			window.close();
		}    
</script>

<x:saveState value="#{xys_evaPlanCaclBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{xys_evaPlanCaclBB.initGrade}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
          <x:dataTable value="#{xys_evaPlanCaclBB.itemList}"
				headerClass="td_top" rowIndexVar="index" var="list" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="名称" />
					</f:facet>
                    <h:outputText value="#{list.itemName}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="下限" />
                    </f:facet>
                    <h:outputText value="#{list.lowValue}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="上限" />
                    </f:facet>
                    <h:outputText value="#{list.highValue}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton styleClass="button01" value="选择"  onclick="checkItem('#{list.itemID}')" type="button"/>
				</h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>


