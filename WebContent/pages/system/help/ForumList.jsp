<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
    function addForum(){
        window.showModalDialog("/system/help/AddForum.jsf", null, "dialogWidth:730px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function openQuestion(ID){
        window.showModalDialog("/system/help/ShowQuestion.jsf?formID="+ID, null, "dialogWidth:"+screen.width*0.35+"px; dialogHeight:"+screen.height*0.45+"px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    function replayManage(ID){
    	window.showModalDialog("/system/help/ReplayManage.jsf?formID="+ID, null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:no;status:no;scroll:yes;");
		return true;
    }
</script>
<x:saveState value="#{sys_forumListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_forumListBB.pageInit}" />
    <h:panelGrid align="center" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
        <h:panelGroup>
          <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1321","在线提问 ")%>  
             </f:verbatim>
          <h:outputText value=""/>
        </h:panelGroup>

        <h:panelGrid columns="1"  cellpadding="2" align="right" 	border="0" >
              <h:panelGroup>
                  <h:commandButton value="提问题" onclick="return addForum();"  styleClass="button01" />
                  <h:commandButton type="button" styleClass="button01" value="返回" onclick="window.close();" />
             </h:panelGroup>
        </h:panelGrid>
   </h:panelGrid>


    <h:panelGrid width="98%" align="center">
    <h:dataTable value="#{sys_forumListBB.forumList}" var="list" width="100%"  id="dateList"
                 headerClass="td_top"
                 styleClass="table03" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center" align="center">
        <h:column>
            <f:facet name="header">
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1322","提出日期 ")%>  
             </f:verbatim>
            </f:facet>
            <h:outputText value="#{list.submitTime}" />
        </h:column>

        <h:column>
            <f:facet name="header">
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1319","问题")%>  
             </f:verbatim>
            </f:facet>
            <h:outputText value="#{list.subject}" />
        </h:column>

        <h:column>
            <f:facet name="header">
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1320","附件")%>  
             </f:verbatim>
            </f:facet>
            <h:outputLink value="/file/questions/#{list.attFile}" title="#{list.attFile}" target="blank">
          	  <h:outputText value="#{list.attFile}" />
            </h:outputLink>
        </h:column>  
		<h:column>
			<f:facet name="header">
			  <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1323","传输")%>  
             </f:verbatim>
			</f:facet>
			<h:outputText value="#{list.transFlag}" />
		</h:column>
        <h:column>
            <f:facet name="header">
                <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1026","操作")%>  
             </f:verbatim>
            </f:facet>
            <h:commandButton styleClass="button01" value="查看" onclick="return openQuestion('#{list.fomID}');"></h:commandButton>
            <h:commandButton styleClass="button01" value="回复管理" onclick="return replayManage('#{list.fomID}');"></h:commandButton>
        </h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

