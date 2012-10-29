<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddAnswer(){
        var superID=document.all('form1:currentID').value;
        window.showModalDialog("/eLearn/AnswerEdit.jsf?QestionID="+superID, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyAnswer(id){
        window.showModalDialog("/eLearn/AnswerEdit.jsf?answerID="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_questionLibBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eLearn_questionLibBB.initAnswerList}"></h:inputHidden>
      <h:inputHidden id="currentID" value="#{eLearn_questionLibBB.qestionID}"></h:inputHidden>
      <c:verbatim>
       <table height=98% width=98% align="center">
          <tr><td align="right" height=8px>
</c:verbatim>
              <h:commandButton value="增加" styleClass="button01" onclick="return doAddAnswer();"></h:commandButton>
              <h:commandButton value="返回" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
<c:verbatim>
          </td></tr>

          <tr>
              <td align="left" height=8px>
 </c:verbatim>
                 <h:outputText escape="false" value="<strong>题目:#{eLearn_questionLibBB.questionName}</strong>" ></h:outputText>
<c:verbatim>
              </td>
          </tr>
          <tr><td>
              <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
              <x:dataTable value="#{eLearn_questionLibBB.answerList}"      id="setlist"
                    headerClass="td_top tr_fixrow" rowIndexVar="index" var="briefList" 	styleClass="table03" border="0" width="98%"
                    columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="代码" />
                      </f:facet>
                      <h:outputText value="#{briefList.answerCode}" ></h:outputText>
                  </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="内容" />
                        </f:facet>
                        <h:outputText value="#{briefList.answerName}" ></h:outputText>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="类型" />
                        </f:facet>
                        <h:outputText value="#{briefList.typeDes}" ></h:outputText>
                    </h:column>

                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="是否正确" />
                      </f:facet>
                      <h:selectOneRadio value="#{briefList.isRight}" disabled="true" rendered="#{briefList.answerType=='0' || briefList.answerType==null || briefList.answerType==''}">
                          <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                          <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                      </h:selectOneRadio>
                  </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="操作" />
                        </f:facet>
                   <h:commandButton action="#{eLearn_questionLibBB.DeleteAnswer}" styleClass="button01" value="删除" onclick="return confirm('确定要删除吗?')" >
                           <x:updateActionListener property="#{eLearn_questionLibBB.answerID}" value="#{briefList.answerID}"/>
                        </h:commandButton>
                        <h:commandButton value="修改"  styleClass="button01" onclick="return doModifyAnswer('#{briefList.answerID}');" />
                    </h:column>
                </x:dataTable>
<c:verbatim>
              </div>
          </td></tr>
        </table>
</c:verbatim>
    <script type="text/javascript">
       setDataTableOver("form1:setlist");
    </script>
    </h:form>


