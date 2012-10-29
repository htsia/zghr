<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>
<x:saveState value="#{aboradtaskMannageBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{aboradtaskMannageBB.initEdit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-1330","出国管理  ")%> ->
		          <%=LanguageSupport.getResource("RYGL-2018","出访计划管理")%> 
        </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
        <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="出访国家"/>
             <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2012","出访国家")%> 
            </f:verbatim>
            <h:panelGroup>
                <h:inputText styleClass="input" id="country" code="" dict="yes" dict_num="0106"
                             readonly="true" value="#{aboradtaskMannageBB.aboradTaskbo.county}"
                             alt="周期类型|0|s|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:country')" disabled="true">
                </c:verbatim>
             </h:panelGroup>
              <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2002","出访目的")%> 
            </f:verbatim>
            <h:panelGroup>
                <h:inputText styleClass="input" id="aim" code="" dict="yes" dict_num="0385"
                             readonly="true" value="#{aboradtaskMannageBB.aboradTaskbo.aim}"
                             alt="周期类型|0|s|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:aim')" disabled="true">
                </c:verbatim>
             </h:panelGroup>
             <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2009","开始日期")%> 
           </f:verbatim>
            <h:inputText  value="#{aboradtaskMannageBB.aboradTaskbo.beginDate}" readonly="true" />

            <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2008","结束日期")%> 
           </f:verbatim>
            <h:inputText value="#{aboradtaskMannageBB.aboradTaskbo.endDate}" readonly="true" />
            <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2007","拜访客户")%> 
           </f:verbatim>
            <h:inputText  value="#{aboradtaskMannageBB.aboradTaskbo.costomer}" readonly="true"/>
               <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2006","预算")%> 
           </f:verbatim>
            <h:inputText  value="#{aboradtaskMannageBB.aboradTaskbo.budget}" readonly="true"/> 
		</h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2005","项目")%> 
        </f:verbatim>
            <h:inputTextarea id="project" value="#{aboradtaskMannageBB.aboradTaskbo.project}" cols="75" rows="3" readonly="true"/>
             <h:outputText value="出访任务"/>
            <h:inputTextarea id="task" value="#{aboradtaskMannageBB.aboradTaskbo.task}" cols="75" rows="3" readonly="true"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
