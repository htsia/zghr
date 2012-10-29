<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function showDetail(id){
        arg="newsid="+id;
        window.showModalDialog("/system/NewsItemDetail.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:420px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    
</script>

<x:saveState value="#{train_courcebb}"/>
<h:form id="form1">
    <h:inputHidden value="#{train_courcebb.browMore}"></h:inputHidden>  
    <h:panelGrid width="98%" columns="1" align="center">
          <h:panelGrid align="right" columns="1" width="100%">
              <h:panelGroup>
                  <h:outputText value="��ѡ��״̬"></h:outputText>
                  <h:selectOneMenu value="#{train_courcebb.status}" onchange="submit()" valueChangeListener="#{train_courcebb.changeStatus}">
                      <c:selectItem itemValue="-1" itemLabel="ȫ��"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="��Ч"></c:selectItem>
                      <c:selectItem itemValue="0" itemLabel="ʧЧ"></c:selectItem>
                  </h:selectOneMenu>
              </h:panelGroup>
          </h:panelGrid>

			<x:dataTable value="#{train_courcebb.moreCourceList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" styleClass="table03" border="1" width="98%" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.title}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:outputText value="#{briefList.orgID}" ></h:outputText>
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
                    <h:commandButton value="�鿴" styleClass="button01" onclick="doShowCource('1','#{briefList.title}','#{briefList.fileName}')"></h:commandButton>
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

