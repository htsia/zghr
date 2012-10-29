<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script language="javascript">
    function addAnswer(){
        var url="/system/AddAnswer.jsf?fomID="+document.all('form1:fomID').value;
        //alert(url);
        window.showModalDialog(url, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>

<x:saveState value="#{self_QuestionListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{self_QuestionListBB.pageInit}" />
    <h:inputHidden id="fomID" value="#{self_QuestionListBB.fomID}" />
    <c:verbatim>
    <table width=98% height=98% align="center">
        <tr><td height=8>
</c:verbatim>
            <h:panelGrid align="center" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
                <h:panelGroup>
                  <h:graphicImage value="/images/tips.gif" />
                  <f:verbatim>
                      <%=LanguageSupport.getResource("XTGL-1310","论坛 ")%>  
                  </f:verbatim>
                </h:panelGroup>

                <h:panelGrid columns="1"  cellpadding="2" align="right" 	border="0" >
                      <h:panelGroup>
                          <h:commandButton value="回复" onclick="return addAnswer();"  styleClass="button01" />
                          <h:commandButton type="button" styleClass="button01" value="返回" onclick="window.close();" />
                     </h:panelGroup>
                </h:panelGrid>
           </h:panelGrid>
<c:verbatim>
        </td></tr>

        <tr><td height=8>
</c:verbatim>
            <h:panelGrid border="0" columns="2" align="center" cellspacing="2"    cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
                 <f:verbatim>
                      <%=LanguageSupport.getResource("XTGL-1115","作者 ")%>  
                  </f:verbatim>
                <h:outputText value="#{self_QuestionListBB.quesbo.nickName}"/>
                <f:verbatim>
                      <%=LanguageSupport.getResource("XTGL-1105","标题 ")%>  
                  </f:verbatim>
                <h:outputText value="#{self_QuestionListBB.quesbo.subject}"/>
                 <f:verbatim>
                      <%=LanguageSupport.getResource("XTGL-1111","内容 ")%>  
                  </f:verbatim>

                <h:inputTextarea id="textarea" readonly="true" rows="10" cols="80"	value="#{self_QuestionListBB.quesbo.content}"/>
            </h:panelGrid>
<c:verbatim>
        </td></tr>

        <tr><td height=8>
         <strong> <%=LanguageSupport.getResource("XTGL-1114","回复内容 ")%>  </strong>
        </td></tr>

        <tr><td >
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                <h:dataTable value="#{self_QuestionListBB.forumList}" var="list" width="100%"  id="dateList"
                         headerClass="td_top"
                         styleClass="table03" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center" align="center">
                <h:column>
                    <f:facet name="header">
                  <f:verbatim>
                      <%=LanguageSupport.getResource("XTGL-1313","楼层")%>  
                  </f:verbatim>
                        
                    </f:facet>
                    <h:outputText style="width:80px" value="#{list.levelNum}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                    <f:verbatim>
                      <%=LanguageSupport.getResource("XTGL-1105","标题")%>  
                  </f:verbatim>
                        
                    </f:facet>
                    <h:outputText style="width:80px" value="#{list.subject}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                   <f:verbatim>
                      <%=LanguageSupport.getResource("XTGL-1111","内容")%>  
                  </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{list.content}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
                      <%=LanguageSupport.getResource("XTGL-1115","作者")%>  
                  </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{list.nickName}" />
                </h:column>

            </h:dataTable>
<c:verbatim>
            </div>
        </td></tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

