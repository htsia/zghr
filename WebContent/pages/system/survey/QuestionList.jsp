<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function showpaper(){
        var superID=document.all('form1:superID').value;
        showSurvey(superID);
    }
    function doAddQuestion(){
        var superID=document.all('form1:superID').value;
        if (superID==null || superID==""){
            alert("请选择问卷！");
            return false;
        }
        else{
            window.showModalDialog("/system/survey/QuestionEdit.jsf?superId="+superID, null, "dialogWidth:500px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
    }
    function doModifyQuestion(id){
        window.showModalDialog("/system/survey/QuestionEdit.jsf?QestionID="+id, null, "dialogWidth:500px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyData(id){
        window.showModalDialog("/system/survey/AnswerList.jsf?QestionID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{sys_questionBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{sys_questionBB.initList}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{sys_questionBB.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddQuestion();"></h:commandButton>
                 <h:commandButton value="模拟显示" styleClass="button01" type="button" onclick="showpaper();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{sys_questionBB.questionList}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

              <h:column>
                  <f:facet name="header">
                   <f:verbatim>
					    <%=LanguageSupport.getResource( "XTGL-1005", "显示顺序")%>
			       </f:verbatim>
                  </f:facet>
                  <h:outputText value="#{briefList.showSeq}" ></h:outputText>
              </h:column>

				<h:column>
					<f:facet name="header">
				    <f:verbatim>
					    <%=LanguageSupport.getResource( "XTGL-1105", "标题")%>
			       </f:verbatim>
					</f:facet>
                    <h:outputText value="#{briefList.titleEx}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
					        <%=LanguageSupport.getResource( "XTGL-1395", "题目类型")%>
			            </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{briefList.typeDes}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
					        <%=LanguageSupport.getResource( "YXGL-1026", "操作")%>
			            </f:verbatim>
                    </f:facet>
   					<h:commandButton action="#{sys_questionBB.Delete}" styleClass="button01" value="删除" onclick="return confirm('确定要删除吗?')" >
                       <x:updateActionListener property="#{sys_questionBB.currentID}" value="#{briefList.questionID}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="修改属性"  onclick="return doModifyQuestion('#{briefList.questionID}');" />
                    <h:commandButton styleClass="button01" value="修改内容"  rendered="#{briefList.type!='3'}" onclick="return doModifyData('#{briefList.questionID}');" />
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


