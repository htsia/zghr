<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<html>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <head>
      <title></title>
      
      <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
      <script type="text/javascript">
      function doCheck(){
          if (document.all('form1:title').value==""){
              alert("请录入名称!");
              return false;
          }else if(document.all('form1:org').value==""){
        	  alert("选择模板样例!");
              return false;
          }
          return forsubmit(document.forms(0));
      }
      </script>
  </head>

  <body>
  <x:saveState value="#{orgTemplateBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{orgTemplateBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
                <f:verbatim>
                     <%=LanguageSupport.getResource("JGGL-0100","机构管理 ")%> ->
             		 <%=LanguageSupport.getResource("JGGL-0140","模板管理")%> 
               </f:verbatim>
              
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
                 <f:verbatim>
             		 <%=LanguageSupport.getResource("JGGL-1058","名称")%> 
                 </f:verbatim>
               <h:inputText  id="title" value="#{orgTemplateBB.templatebo.templateName}"></h:inputText>

               <f:verbatim>
             		 <%=LanguageSupport.getResource("XTGL-1015","描述")%> 
               </f:verbatim>
               <h:inputTextarea value="#{orgTemplateBB.templatebo.description}" cols="50" rows="4"></h:inputTextarea>
             
			   <h:outputText value="选择样例" rendered="#{orgTemplateBB.method=='new'}"></h:outputText>
			   <h:panelGroup rendered="#{orgTemplateBB.method=='new'}">
               <h:inputText id="org" value="#{orgTemplateBB.org}"  size="20" code="" dict = "yes" dict_num="OU"/>
               <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgDlg('form1:org',1,'#{orgTemplateBB.templatebo.templateName}')"></h:commandButton>
			   </h:panelGroup>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save"  action="#{orgTemplateBB.saveTemplate}" styleClass="button01" onclick="return doCheck();"/>
           </h:panelGrid>
      </h:panelGrid>

  </h:form>
  <script type="text/javascript">
  interpret(document.forms(0));
</script>
  </body>
</html>