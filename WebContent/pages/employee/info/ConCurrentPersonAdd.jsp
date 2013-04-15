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
          document.all('form1:query').click();
      }
  }
  function forpost(){
	  var dept=document.getElementById("form1:deptid").code;
	  if(dept==''){
		  alert("请选择部门");
		  return false;
	  }
	  PopUpPostDlgByDept(document.getElementById("form1:A001715"),null,dept);
	  return true;
  }
</script>

  <x:saveState value="#{emp_ConPostEditBB}" />
  <h:form id="form1">
      <h:inputHidden id="personID" value="#{emp_ConPostEditBB.cpvo.personID}"></h:inputHidden>
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
                  <h:inputText readonly="true" id="personName" value="#{emp_ConPostEditBB.cpvo.personName}" style="width:140"/>
                     <h:commandButton value="选择人员" styleClass="button01" type="button" onclick="doQuery();"></h:commandButton>
                     <h:commandButton value="查询" id="query" action="#{emp_ConPostEditBB.doFind}" style="display:none"></h:commandButton>
                 </h:panelGroup>

                 <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1042","员工编号")%>
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cpvo.personCode}"></h:outputText>

                 <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2284","主单位")%>
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cpvo.mainOrgName}"></h:outputText>

                <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2286","主部门")%>
               </f:verbatim>
               <h:outputText value="#{emp_ConPostEditBB.cpvo.mainDeptName}"></h:outputText>
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2285","兼职部门")%>
               </f:verbatim>
               <h:panelGroup>
                   <h:inputText  styleClass="input" id="deptid" code="" dict="yes" dict_num="OU"
                         readonly="true" value="#{emp_ConPostEditBB.deptid}"
                         alt="兼职部门|0|s|50||"></h:inputText>
                   <c:verbatim>
                     <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:deptid',0)">
                   </c:verbatim>
               </h:panelGroup>
               <h:outputText value="兼职岗位"/>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="A001715" value="#{emp_ConPostEditBB.postID}" dict="yes" dict_num="PO"  code=""
                            readonly="true"/>
                   <c:verbatim>
                     <input type="button" class="button_select" onclick="return forpost();">
                   </c:verbatim>
               </h:panelGroup>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存" styleClass="button01" id="save" onclick="return forsubmit(document.forms(0))" action="#{emp_ConPostEditBB.save}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
