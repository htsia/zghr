<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="../include/taglib.jsp" %>
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
          if (document.all('form1:org').value==""){
              alert("ѡ�����ܻ���!");
              return false;
          }
          return forsubmit(document.forms(0));
      }
      function selTemplat(){
    	  var reval = window.showModalDialog("/org/selTemplate.jsf", null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
          if (reval != null && reval!="") {
        	  var vars=reval.split(":");
              document.all("form1:orgName").value = vars[0];
              document.all("form1:orgid").value = vars[1];
              return true;
          	return true;
          } else {
              return false;
          }
      }
      </script>
  </head>

  <body>
  <x:saveState value="#{fastcreatorgBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{fastcreatorgBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
                <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-0100","�������� ")+"->"%> 
                 <%=LanguageSupport.getResource("JGGL-0141","���ٽ�����֧����")%> 
              </f:verbatim>
          </h:panelGroup>
      </h:panelGrid>
	  <c:verbatim>
	  	<table width="98%" align="left"><tr><td>
	  </c:verbatim>
           <h:panelGrid columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03" width="80%">
               <f:verbatim>
                     <%=LanguageSupport.getResource("JGGL-1002","��������")%> 
               </f:verbatim>
           	   <h:inputText value="#{fastcreatorgBB.orgRootName}"></h:inputText>
           	   <h:outputText value=""></h:outputText>
           	   <h:outputText value=""></h:outputText>
           	    <f:verbatim>
                     <%=LanguageSupport.getResource("JGGL-1004","���ܻ���")%> 
               </f:verbatim>
			   <h:panelGroup>
	               <h:inputText styleClass="input" id="org" code="" dict="yes" dict_num="OU"
                         readonly="true" value="#{fastcreatorgBB.org}"
                         alt="���ܻ���|0|s|50||"/>
	               <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgDlg('form1:org',2,'')"></h:commandButton>
			   </h:panelGroup>
			   <f:verbatim>
                     <%=LanguageSupport.getResource("JGGL-1031","ѡ��ģ��")%> 
               </f:verbatim>
			   <h:panelGroup>
	               <h:inputHidden id="orgid" value="#{fastcreatorgBB.orgId}"></h:inputHidden>
	               <h:inputText id="orgName" value="#{fastcreatorgBB.orgName}"></h:inputText>
	               <h:commandButton type="button" styleClass="button_select" onclick="selTemplat()"></h:commandButton>
			   </h:panelGroup>
           </h:panelGrid>
    <c:verbatim>
	  	</td></tr><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	   
	  	  <%=LanguageSupport.getResource("JGGL-1005","����������Ϣ")%> 
	  	 </td></tr><tr><td>
	  </c:verbatim>
           <h:panelGrid columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03" width="80%">
            <f:verbatim>
             <%=LanguageSupport.getResource("JGGL-1006","��������ʱ��")%> 
            </f:verbatim>
			   <h:panelGroup>
	               <h:inputText styleClass="input" readonly="true" id="B004005" value="#{fastcreatorgBB.orgsetvo.setupTime}"
                         alt="��������ʱ��|0|s|7||"/>
	               <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:B004005')"></h:commandButton>
			   </h:panelGroup>
			     <f:verbatim>
             <%=LanguageSupport.getResource("JGGL-1007","�����������")%> 
            </f:verbatim>
			   <h:panelGroup>
	                <h:inputText styleClass="input" id="B004201" code="" dict="yes" dict_num="0896" readonly="true"
                         value="#{fastcreatorgBB.orgsetvo.setupType}" alt="�����������|0|s|50||"/>
	               <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B004201')"></h:commandButton>
			   </h:panelGroup>
			    <f:verbatim>
             <%=LanguageSupport.getResource("JGGL-1008","��׼�����ĺ�")%> 
               </f:verbatim>
	           <h:inputText styleClass="input" id="B004010" value="#{fastcreatorgBB.orgsetvo.setupNo}" alt="��׼�����ĺ�|1|s|20||"/>
	               <f:verbatim>
             <%=LanguageSupport.getResource("JGGL-1009","��׼������λ")%> 
               </f:verbatim>
	           <h:inputText styleClass="input" id="B004025" value="#{fastcreatorgBB.orgsetvo.setupUnit}"
                         alt="��׼������λ|1|s|25||"/>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save"  action="#{fastcreatorgBB.saveOrg}" styleClass="button01" onclick="return doCheck();"/>
           </h:panelGrid>
 		<c:verbatim>
	  	</td></tr></table>
	  </c:verbatim>
  </h:form>
  <script type="text/javascript">
  setDataTableOver("form1:data");
</script>
  </body>
</html>