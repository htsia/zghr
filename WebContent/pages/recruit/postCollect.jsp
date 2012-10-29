<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
<c:verbatim><base target="_self"></c:verbatim>      
      <script type="text/javascript">
          function forsave(form){
             document.all("form1:save").click(); 
          }
          function forBack(form){
             window.close();
          }

          function checkDateNull(){
              if(document.all("form1:postName").value=="")
              {
                  alert("请选择岗位");
                   return false;
              }
              return true;
           }
          
      </script>
 <x:saveState value="#{recu_outterRecruitBB}" />
 <h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{recu_outterRecruitBB.initPlanId}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 招聘管理 -> 外部招聘需求征集"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="100%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
                <h:outputText value="岗位名称"></h:outputText>
                <h:panelGrid columns="1"  width="100%" align="left">
                <h:inputHidden id="postId" value="#{recu_outterRecruitBB.bo.postId}"></h:inputHidden>
                  <h:inputText readonly="true" id="postName" styleClass="input" value="#{recu_outterRecruitBB.bo.postName}"/>
                <h:commandButton value="选岗" styleClass="button01"  onclick="fPopUpPostDlg('form1:postName','form1:postId');"></h:commandButton>
                 </h:panelGrid>
               
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" onclick="return checkDateNull();"  action="#{recu_outterRecruitBB.savePost}"  styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>


