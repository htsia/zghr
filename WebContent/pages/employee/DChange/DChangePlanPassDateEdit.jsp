<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function checkform() {
	return forsubmit(document.forms(0)); 	
}
</script>
  
  <x:saveState value="#{empDchangeMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{empDchangeMgrBB.initPersonEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
               <f:verbatim>
                            <%=LanguageSupport.getResource("RYGL-0300", "人员管理  ")%>->
                            <%=LanguageSupport.getResource("RYGL-2138", "调整转正日期")%>
                    </f:verbatim>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03" width="98%">
               <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-1016", "姓名")%>
			           </f:verbatim>
               <h:inputText value="#{empDchangeMgrBB.emppertypebo.name}" readonly="true"></h:inputText>
			    <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2129", "预计转正时间")%>
			           </f:verbatim>
               <h:inputText value="#{empDchangeMgrBB.planDate}"></h:inputText>
			   <f:verbatim>
				     	  <%=LanguageSupport.getResource("RYGL-2138", "调整转正日期")%>
			           </f:verbatim>
			   <h:panelGroup>
               <h:inputText styleClass="input" id="date" value="#{empDchangeMgrBB.emppertypebo.planPassDate}"
                     readonly="true" alt="日期|1|d|50||"/>
               <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:date')">
                </c:verbatim>
               </h:panelGroup>
             </h:panelGrid>
			<h:panelGrid align="right">
              <h:commandButton value="保存"  action="#{empDchangeMgrBB.saveEmpPerTypebo}" styleClass="button01" onclick="checkform()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
 <script type="text/javascript">
    interpret(document.forms(0));
</script>
