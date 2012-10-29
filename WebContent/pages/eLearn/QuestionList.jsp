<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddQuestion(){
        var superID=document.all('form1:superID').value;
        window.showModalDialog("/eLearn/QuestionEdit.jsf?superId="+superID, null, "dialogWidth:500px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyQuestion(id){
        window.showModalDialog("/eLearn/QuestionEdit.jsf?QestionID="+id, null, "dialogWidth:500px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyData(id){
        window.showModalDialog("/eLearn/AnswerList.jsf?QestionID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doPreviwe(id){
        window.showModalDialog("/pages/eLearn/viewQuestion.jsp?QestionID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_questionLibBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eLearn_questionLibBB.initList}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{eLearn_questionLibBB.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddQuestion();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{eLearn_questionLibBB.questionList}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

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

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作"  style="width:200px"/>
                    </f:facet>
   					<h:commandButton action="#{eLearn_questionLibBB.DeleteQuestion}" styleClass="button01" value="删除" onclick="return confirm('确定要删除吗?')" >
                       <x:updateActionListener property="#{eLearn_questionLibBB.currentID}" value="#{briefList.questionID}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="修改属性"  onclick="return doModifyQuestion('#{briefList.questionID}');" />
                    <h:commandButton styleClass="button01" value="修改内容"   rendered="#{briefList.questionType!='3' && briefList.questionType!='5'}" onclick="return doModifyData('#{briefList.questionID}');" />
                    <h:commandButton styleClass="button01" value="显示效果"   type="button" onclick="return doPreviwe('#{briefList.questionID}');" />
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


