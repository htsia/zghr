<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"  %>
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
<x:saveState value="#{deptAboardListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{deptAboardListBB.initEdit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
         <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-1330","出国管理  ")%> ->
		          <%=LanguageSupport.getResource("RYGL-2011","出访计划编辑 ")%> 
        </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
        <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
        <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2012","出访国家")%> 
        </f:verbatim>
            <h:panelGroup>
                <h:inputText styleClass="input" id="country" code="" dict="yes" dict_num="0106"
                             readonly="true" value="#{deptAboardListBB.planbo.country}"
                             alt="周期类型|0|s|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:country')">
                </c:verbatim>
             </h:panelGroup>
		   <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2003","计划类型")%> 
           </f:verbatim>
           	<h:selectOneMenu value="#{deptAboardListBB.planbo.planType}">
                <c:selectItem itemLabel="年度" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="季度" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="月度" itemValue="2"></c:selectItem>
            </h:selectOneMenu>
			 <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2010","对应时间")%> 
           </f:verbatim>
            <h:inputText id="planDate"  value="#{deptAboardListBB.planbo.planDate}" />
            <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2007","拜访客户")%> 
           </f:verbatim>
          <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2009","开始日期")%> 
           </f:verbatim>
            <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{deptAboardListBB.planbo.beginDate}"
                             readonly="true" alt="开始日期|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            </h:panelGroup>
           <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2008","结束日期")%> 
           </f:verbatim>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endDate" value="#{deptAboardListBB.planbo.endDate}"
                             readonly="true" alt="结束日期|0|d|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">
                </c:verbatim>
            </h:panelGroup>
              <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2006","预算")%> 
           </f:verbatim>
            <h:inputText id="budget"  value="#{deptAboardListBB.planbo.budget}" /> 
		</h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
              <f:verbatim>
		          <%=LanguageSupport.getResource("RYGL-2005","项目")%> 
           </f:verbatim>
            <h:inputTextarea id="project" value="#{deptAboardListBB.planbo.project}" cols="75" rows="3" />
        </h:panelGrid>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{deptAboardListBB.savePlan}"
                             onclick="return forCheck();"/>
        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>