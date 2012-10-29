<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
</script>

<x:saveState value="#{eLearn_testBB}"/>
<h:form id="form1">

    <h:panelGrid width="98%" columns="1" align="center">
        <h:panelGrid width="100%" columns="1" align="center" styleClass="td_title">
            <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" ���߿���"/>
            </h:panelGroup>
        </h:panelGrid>

          <x:dataTable value="#{eLearn_testBB.myTestlist}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

 				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.testName}" ></h:outputText>
                </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="ʹ���Ծ�" />
                 </f:facet>
                 <h:outputText value="#{briefList.paperName}" ></h:outputText>
             </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="��ʼʱ��" style="width:100px" />
                    </f:facet>
                    <h:outputText value="#{briefList.beginTime}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="����ʱ��" style="width:100px" />
                  </f:facet>
                  <h:outputText value="#{briefList.endTime}" ></h:outputText>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="����ʱ��(����)" style="width:100px" />
                  </f:facet>
                  <h:outputText value="#{briefList.testminute}" ></h:outputText>
              </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"  style="width:200px"/>
                    </f:facet>
                    <h:commandButton value="�μ�" onclick="doTest('#{briefList.testID}');" styleClass="button01"></h:commandButton>
                </h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
    <script type="text/javascript">
       setDataTableOver("form1:setlist");
    </script>
    </h:form>


