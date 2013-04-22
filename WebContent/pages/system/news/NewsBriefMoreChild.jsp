<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<c:verbatim><base target="_self"></c:verbatim>
<x:saveState value="#{sys_NewsBriefMoreBB}"/>
<h:form id="form1">
     <c:verbatim>
      <table height=98% width=98% align="center">
          <tr><td height=8>
</c:verbatim>
          <h:panelGrid align="right" columns="1" width="100%">
              <h:panelGroup>
                  <h:outputText value="��ѡ��״̬"></h:outputText>
                  <h:selectOneMenu value="#{sys_NewsBriefMoreBB.status}" onchange="submit()" valueChangeListener="#{sys_NewsBriefMoreBB.changeStatus}">
                      <c:selectItem itemValue="1" itemLabel="��Ч"></c:selectItem>
                      <c:selectItem itemValue="0" itemLabel="ʧЧ"></c:selectItem>
                  </h:selectOneMenu>
              </h:panelGroup>
          </h:panelGrid>
<c:verbatim>
          </td></tr>

          <tr><td >
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
			<x:dataTable value="#{sys_NewsBriefMoreBB.newsList}"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="������Ϣ" />
					</f:facet>
                    <h:outputText value="#{briefList.newTopic}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="��Чʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.startDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                       <h:panelGroup>
                            <h:graphicImage value="/images/common/new.gif"></h:graphicImage>
                            <h:outputText value="��ʾʧЧʱ��" />
                       </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{briefList.newEndDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="ʧЧʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.endDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>

					<h:commandButton value="�鿴��ϸ��Ϣ" type="button" styleClass="button01" onclick="doShowNews('#{briefList.newId}');">
					</h:commandButton>
				</h:column>
			</x:dataTable>
<c:verbatim>
            </div>
          </td></tr>
		</table>
</c:verbatim>
    </h:form>


