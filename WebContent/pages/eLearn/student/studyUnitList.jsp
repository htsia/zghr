<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">

</script>

<x:saveState value="#{eLearn_studyBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eLearn_studyBB.initStudyUnit}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
          <x:dataTable value="#{eLearn_studyBB.studyUnitList}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>
              
              <h:column>
                 <f:facet name="header">
                     <h:outputText value="题目" />
                 </f:facet>
                 <h:outputText value="#{briefList.unitName}" ></h:outputText>
             </h:column>

 				<h:column>
					<f:facet name="header">
						<h:outputText value="开始学习时间" />
					</f:facet>
                    <h:outputText value="#{briefList.firstTime}" ></h:outputText>
                </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="学习时间" />
                 </f:facet>
                 <h:outputText value="#{briefList.sessionTime}" ></h:outputText>
             </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="状态" />
                 </f:facet>
                 <h:outputText value="#{briefList.lessonStatusCHN}" ></h:outputText>
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


