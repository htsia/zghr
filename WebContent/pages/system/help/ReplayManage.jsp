<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
function showAnswer(ID){
    window.showModalDialog("/system/help/ShowAnswer.jsf?ansId="+ID, null, "dialogWidth:"+screen.width*0.35+"px; dialogHeight:"+screen.height*0.45+"px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function addAnswer(ID){
    window.showModalDialog("/system/help/AddAnswer.jsf?formID="+ID, null, "dialogWidth:"+screen.width*0.45+"px; dialogHeight:"+screen.height*0.35+"px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
</script>
<x:saveState value="#{sys_forumListBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{sys_forumListBB.formID}"></h:inputHidden>
<h:inputHidden value="#{sys_forumListBB.replayManageInit}"></h:inputHidden>
   <h:panelGrid align="center" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
        <h:panelGroup>
          <h:graphicImage value="/images/tips.gif" />
           <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1316","回复管理 ")%>  
           </f:verbatim>
        </h:panelGroup>

        <h:panelGrid columns="1"  cellpadding="2" align="right" 	border="0" >
              <h:panelGroup>
                  <h:commandButton value="回复" onclick="return addAnswer('#{sys_forumListBB.formID}');"  styleClass="button01" />
                  <h:commandButton type="button" styleClass="button01" value="返回" onclick="window.close();" />
             </h:panelGroup>
        </h:panelGrid>
   </h:panelGrid>
   <h:panelGrid width="98%" align="center">
   		<h:dataTable value="#{sys_forumListBB.answerList}" var="list" width="100%"  id="dateList"
                 headerClass="td_top"
                 styleClass="table03" columnClasses="td_middle_center,td_middle_left,td_middle_center,td_middle_center,td_middle_center,td_middle_center" align="center">
   		
   			<h:column>
      			<f:facet name="header">
      			    <f:verbatim>
                              <%=LanguageSupport.getResource("XTGL-1329","回复日期 ")%>  
                    </f:verbatim>
      			</f:facet>
      			<h:outputText value="#{list.ansTime}"></h:outputText>
      		</h:column>
      		
      		<h:column>
      			<f:facet name="header">
      			    <f:verbatim>
                              <%=LanguageSupport.getResource("XTGL-1114","回复内容 ")%>  
                    </f:verbatim>
      			</f:facet>
      			<h:outputText value="#{list.ansContent}"></h:outputText>
      		</h:column>
      		
      		<h:column>
      			<f:facet name="header">
      			      <f:verbatim>
                              <%=LanguageSupport.getResource("XTGL-1330","回复人 ")%>  
                    </f:verbatim>
      			</f:facet>
      			<h:outputText value="#{list.ansName}"></h:outputText>
      		</h:column>
      		
      		<h:column>
      			<f:facet name="header">
      			   <f:verbatim>
                              <%=LanguageSupport.getResource("XTGL-1015","描述 ")%>  
                    </f:verbatim>
      			</f:facet>
      			<h:outputText value="#{list.direction}"></h:outputText>
      		</h:column>
      		
      		<h:column>
      			<f:facet name="header">
      			    <f:verbatim>
                              <%=LanguageSupport.getResource("XTGL-1051","状态 ")%>  
                    </f:verbatim>
      			</f:facet>
      			<h:outputText value="#{list.transFlag}"></h:outputText>
      		</h:column>
      		
      		<h:column>
      			<f:facet name="header">
      			    <f:verbatim>	
                              <%=LanguageSupport.getResource("YXGL-1026","操作 ")%>  
                    </f:verbatim>
      			</f:facet>
      			<h:commandButton value="查看" styleClass="button01" onclick="return showAnswer('#{list.ansID}');"></h:commandButton>
      		</h:column>
   		</h:dataTable>
   </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>