<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
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
        window.showModalDialog(url, null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>
<x:saveState value="#{sys_QuestionListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_QuestionListBB.pageInit}" />
    <h:inputHidden id="fomID" value="#{sys_QuestionListBB.fomID}" />
    <h:panelGrid align="center" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
        <h:panelGroup>
          <h:graphicImage value="/images/tips.gif" />
            <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1324","使用答疑 ")%>  
             </f:verbatim>
        </h:panelGroup>

        <h:panelGrid columns="1"  cellpadding="2" align="right" 	border="0" >
              <h:panelGroup>
                  <h:commandButton value="回复" onclick="return addAnswer();"  styleClass="button" />
                  <h:commandButton type="button" styleClass="button" value="返回" onclick="window.close();" />
             </h:panelGroup>
        </h:panelGrid>
   </h:panelGrid>


    <h:panelGrid width="98%" align="center" columns="1">
        <h:panelGrid border="0" columns="2" align="center" cellspacing="2"    cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1325","提出人 ")%>  
             </f:verbatim>
            <h:outputText value="#{sys_QuestionListBB.quesbo.personName}"/>

             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1326","所在单位 ")%>  
             </f:verbatim>
            <h:outputText value="#{sys_QuestionListBB.quesbo.orgName}"/>

            <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1327","联系电话 ")%>  
             </f:verbatim>
            <h:outputText value="#{sys_QuestionListBB.quesbo.officeTel}"/>

             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1105","标题 ")%>  
             </f:verbatim>
			<h:outputText value="#{sys_QuestionListBB.quesbo.subject}"/>

			 <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1111","内容 ")%>  
             </f:verbatim>
			<h:inputTextarea id="textarea" readonly="true" rows="10" cols="80"	value="#{sys_QuestionListBB.quesbo.content}"/>
		</h:panelGrid>
        
      <f:verbatim>
             <strong><%=LanguageSupport.getResource("XTGL-1114","回复内容 ")%>  </strong>
       </f:verbatim>

        <h:dataTable value="#{sys_QuestionListBB.forumList}" var="list" width="100%"
                     headerClass="td_top"
                     styleClass="table03" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center" align="center">
            <h:column>
                <f:facet name="header">
                  <f:verbatim>
			             <%=LanguageSupport.getResource("XTGL-1313","楼层 ")%> 
			     </f:verbatim>
                </f:facet>
                <h:outputText style="width:80px" value="#{list.levelNum}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                 <f:verbatim>
			             <%=LanguageSupport.getResource("XTGL-1328","回答者 ")%> 
			     </f:verbatim>
                </f:facet>
                <h:outputText value="#{list.personName}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                  <f:verbatim>
			             <%=LanguageSupport.getResource("XTGL-1326","所在单位 ")%> 
			     </f:verbatim>
                </f:facet>
                <h:outputText value="#{list.orgName }" />
            </h:column>

            <h:column>
                <f:facet name="header">
                 <f:verbatim>
			             <%=LanguageSupport.getResource("XTGL-1327","联系电话 ")%> 
			     </f:verbatim>
                </f:facet>
                <h:outputText value="#{list.officeTel }" />
            </h:column>

            <h:column>
                <f:facet name="header">
                 <f:verbatim>
			             <%=LanguageSupport.getResource("XTGL-1105","标题 ")%> 
			     </f:verbatim>
                </f:facet>
                <h:outputText style="width:80px" value="#{list.subject}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                  <f:verbatim>
			             <%=LanguageSupport.getResource("XTGL-1111","内容 ")%> 
			     </f:verbatim>
                </f:facet>
                <h:outputText value="#{list.content}" />
            </h:column>

        </h:dataTable>
    </h:panelGrid>
</h:form>

