<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
function sel(code,value){
	window.returnValue = code + "," + value;
    window.close();
}
</script>

<x:saveState value="#{eLearn_queryQuestionBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eLearn_queryQuestionBB.initList}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{eLearn_queryQuestionBB.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
                
          </h:panelGrid>

          <x:dataTable value="#{eLearn_queryQuestionBB.questionList}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
				<h:column>
                    <c:facet name="header"><h:outputText value="操作"/></c:facet>
                    <c:verbatim><a class="cursor:hand" onclick="sel('</c:verbatim><h:outputText value="#{briefList.title}"/><c:verbatim>','</c:verbatim><h:outputText value="#{briefList.questionID}"/><c:verbatim>')">选择</a></c:verbatim>
               </h:column>
 				<h:column>
					<f:facet name="header">
						<h:outputText value="标题" />
					</f:facet>
                    <h:outputText value="#{briefList.titleEx}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="题目类型" style="width:100px" />
                    </f:facet>
                    <h:outputText value="#{briefList.typeDes}" ></h:outputText>
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


