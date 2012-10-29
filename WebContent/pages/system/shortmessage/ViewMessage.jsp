<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


  <x:saveState value="#{sys_smListBackingBean}"/>
  <h:form id="form1">
      <h:inputHidden value="#{sys_smListBackingBean.viewMessage}"></h:inputHidden>
      <br>
      <h:panelGrid align="center" width="97%">
         <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1303", "接收人")%> 
			</f:verbatim> 
          <h:outputText id="recname" value="#{sys_smListBackingBean.sbo.receiveName}" />

          <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1304", "发送人")%>
			</f:verbatim> 
          <h:outputText id="sendname" value="#{sys_smListBackingBean.sbo.sendName}" />

           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1365", "发送时间")%>
			</f:verbatim> 
          <h:outputText id="time" value="#{sys_smListBackingBean.sbo.sendTime}" />
          
		<f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1320", "附件")%>
	   </f:verbatim> 
	 	  <h:outputLink id="link" value="/file/shortmessage/#{sys_smListBackingBean.sbo.att_file}" target="blank">
			<h:outputText id="att_file" value="#{sys_smListBackingBean.sbo.att_file}"></h:outputText>
		  </h:outputLink>
		  
           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1111", "内容")%>
			</f:verbatim> 
          <h:outputText id="content" escape="false" value="#{sys_smListBackingBean.sbo.content}" />
      </h:panelGrid>

      <h:panelGrid columns="2" align="right" cellspacing="2">
          <h:commandButton styleClass="button01" value="关闭" onclick="window.close();"/>
      </h:panelGrid>

    </h:panelGrid>
  </h:form>
