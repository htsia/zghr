<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
     function selectPost(){
          var reval = window.showModalDialog("/recruit/selRecuPostList.jsf", null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
			
			if (reval != null && reval!="") {
             	var vars=reval.split("|");
             	//document.all("form1:personStr").value = vars[1];
             	var itemnames=vars[1].split(",");
             	var names="";
             	var itmes="";
             	for(var i=0;i<itemnames.length;i++){
                 	if(null!=itemnames[i]&&itemnames[i]!=""){
	                 	var itemname=itemnames[i].split(":");
	                 	itmes+=itemname[0]+",";
	                 	names+=itemname[1]+",";
                 	}
             	}
             	document.all("form1:postNames").value = names;
             	document.all("form1:itemIds").value = itmes;
                return true;
             } else {
                 return false;
             }
     }
     
</script>  
  <x:saveState value="#{resumeemaillistBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{resumeemaillistBB.initEdit}"></h:inputHidden>
      <h:inputHidden value="#{resumeemaillistBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 招聘管理 -> 简历导入"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="选用模版"></h:outputText>
               <h:selectOneMenu value="#{resumeemaillistBB.templateId}">
                     <c:selectItems value="#{resumeemaillistBB.templateList}"></c:selectItems>
               </h:selectOneMenu>
               <h:outputText value="选择岗位"></h:outputText>
               <h:panelGroup>
               		<h:inputHidden id="itemIds"></h:inputHidden>
               		<h:inputText id="postNames"></h:inputText>
               		<h:commandButton type="button" styleClass="button_select" onclick="selectPost()"></h:commandButton>
               </h:panelGroup>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" styleClass="button01"  action="#{resumeemaillistBB.saveResume}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
