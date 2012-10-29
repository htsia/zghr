<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
    function doAddAnswer(){
        var superID=document.all('form1:currentID').value;
        window.showModalDialog("/eLearn/AnswerEdit.jsf?QestionID="+superID, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyAnswer(id){
        window.showModalDialog("/eLearn/AnswerEdit.jsf?answerID="+id, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_learnInfoBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eLearn_learnInfoBB.initQueryOneBulletin}"></h:inputHidden>
      <c:verbatim>
       <table height=98% width=98% align="center">
          <tr><td align="right" height=8px>
</c:verbatim>
              <h:commandButton value="返回" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
<c:verbatim>
          </td></tr>

          <tr><td>
              <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
              <x:dataTable value="#{eLearn_learnInfoBB.morenewsList}"      id="bulist"
                    headerClass="td_top tr_fixrow" rowIndexVar="index" var="bulist" 	styleClass="table03" border="0" width="98%"
                    columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="公告标题" />
                      </f:facet>
                      <h:outputText style="width:180px" value="#{bulist.blltnTopic}" />
                  </h:column>

                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="生效时间" />
                      </f:facet>
                          <h:outputText style="width:80px" value="#{bulist.startDate}" />
                  </h:column>

                  <h:column>
                      <f:facet name="header">
                          <h:panelGroup>
                              <h:graphicImage value="/images/common/new.gif"></h:graphicImage>
                              <h:outputText value="标示失效时间" />
                          </h:panelGroup>
                      </f:facet>
                      <h:outputText style="width:110px" value="#{bulist.newEndDate}" />
                  </h:column>

                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="失效时间" />
                      </f:facet>
                      <h:outputText style="width:80px" value="#{bulist.endDate}" />
                  </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="操作" />
                        </f:facet>
                        <h:commandButton value="查看"  styleClass="button01" onclick="return doShowElearnBulletin('#{briefList.blltnId}');" />
                    </h:column>
                </x:dataTable>
<c:verbatim>
              </div>
          </td></tr>
        </table>
</c:verbatim>
    <script type="text/javascript">
       setDataTableOver("form1:bulist");
    </script>
    </h:form>


