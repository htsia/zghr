<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddAnswer(){
        var superID=document.all('form1:currentID').value;
        window.showModalDialog("/system/survey/AnswerEdit.jsf?QestionID="+superID, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyAnswer(id){
        window.showModalDialog("/system/survey/AnswerEdit.jsf?answerID="+id, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{sys_answerBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{sys_answerBB.pageInit}"></h:inputHidden>
      <h:inputHidden id="currentID" value="#{sys_answerBB.currentID}"></h:inputHidden>
      <h:inputHidden id="questionName" value="#{sys_answerBB.questionName}"></h:inputHidden>
      <c:verbatim>
       <table height=98% width=98% align="center">
          <tr><td align="right" height=8px>
</c:verbatim>
              <h:commandButton value="增加" styleClass="button01" onclick="doAddAnswer();"></h:commandButton>
              <h:commandButton value="返回" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
<c:verbatim>
          </td></tr>

          <tr>
              <td align="left" height=8px>
              <f:verbatim>
               	 <%=LanguageSupport.getResource("XTGL-1371", "题目 ")%>:
	          </f:verbatim>
 </c:verbatim>
                 <h:outputText escape="false" value="<strong>#{sys_answerBB.questionName}</strong>" ></h:outputText>
<c:verbatim>
              </td>
          </tr>
          <tr><td>
              <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
              <x:dataTable value="#{sys_answerBB.answerList}"      id="setlist"
                    headerClass="td_top tr_fixrow" rowIndexVar="index" var="briefList" 	styleClass="table03" border="0" width="98%"
                    columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

                  <h:column>
                      <f:facet name="header">
		               <f:verbatim>
		               	 <%=LanguageSupport.getResource("XTGL-1370", "代码 ")%>:
			          </f:verbatim>
                      </f:facet>
                      <h:outputText value="#{briefList.code}" ></h:outputText>
                  </h:column>

                    <h:column>
                        <f:facet name="header">
                      <f:verbatim>
		               	 <%=LanguageSupport.getResource("XTGL-1111", "内容")%>:
			          </f:verbatim>
                        </f:facet>
                        <h:outputText value="#{briefList.answerName}" ></h:outputText>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                       <f:verbatim>
		               	 <%=LanguageSupport.getResource("XTGL-1002", "类型")%>:
			          </f:verbatim>
                        </f:facet>
                        <h:outputText value="#{briefList.typeDes}" ></h:outputText>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
		               	 <%=LanguageSupport.getResource("XTGL-1026", "操作")%>:
			          </f:verbatim>
                        </f:facet>
                   <h:commandButton action="#{sys_answerBB.Delete}" styleClass="button01" value="删除" onclick="return confirm('确定要删除吗?')" >
                           <x:updateActionListener property="#{sys_answerBB.answerID}" value="#{briefList.answerID}"/>
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


