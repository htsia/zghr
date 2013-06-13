<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<html>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
  function doQuery(){
      if (fPopUpPerDlg('form1:personName', 'form1:personID','','2')){
      }
      return false;
  }
  function forpost(){
	  var dept=document.getElementById("form1:deptID").value;
	  if(dept==''){
		  alert("请选择部门");
		  return false;
	  }
	  var v= PopUpPostDlgByDept_1(dept);
	  if(v!=','){
		  var v1=v.split(",");
		  document.getElementById("form1:postID").value=v1[0];
		  document.getElementById("form1:a001715").value=v1[1];
	  }
	  return true;
  }
  function fordept(){
	  var v=PopUpOrgDlg_1('form1:deptid',0);
	  if(v!=','){
		  var v1=v.split(",");
		  document.getElementById("form1:deptID").value=v1[0];
		  document.getElementById("form1:a001705").value=v1[1];
	  }
	  return false;
  }
</script>

  <x:saveState value="#{emp_conPostBB}" />
  <h:form id="form1">
      <h:inputHidden id="personID" value="#{emp_conPostBB.personID}"></h:inputHidden>
      <h:inputHidden id="deptID" value="#{emp_conPostBB.deptID}"></h:inputHidden>
      <h:inputHidden id="postID" value="#{emp_conPostBB.postID}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2260","员工管理 ")%>->
                   <%=LanguageSupport.getResource("RYGL-2283","兼职情况")%>
               </f:verbatim>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-1016","姓名")%>
               </f:verbatim>
              <h:panelGroup>
                  <h:inputText readonly="true" id="personName" style="width:140"/>
                     <h:commandButton value="选择人员" styleClass="button01" type="button" onclick="return doQuery();"></h:commandButton>
                 </h:panelGroup>

               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2285","兼职部门")%>
               </f:verbatim>
               <h:panelGroup>
                   <h:inputText styleClass="input" id="a001705" 
                         readonly="true" alt="兼职部门|0|s|50||"></h:inputText>
                   <c:verbatim>
                     <input type="button" class="button_select" onclick="return fordept();">
                   </c:verbatim>
               </h:panelGroup>
               <h:outputText value="兼职岗位"/>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="A001715" readonly="true"/>
                   <c:verbatim>
                     <input type="button" class="button_select" onclick="return forpost();">
                   </c:verbatim>
               </h:panelGroup>
           </h:panelGrid>

		   <f:verbatim>
		   	<br/>
		   </f:verbatim>
           <h:panelGrid align="center">
              <h:commandButton value="  保  存  " styleClass="button01" id="save" onclick="return forsubmit(document.forms(0))" action="#{emp_conPostBB.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
