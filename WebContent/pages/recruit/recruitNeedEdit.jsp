<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
    
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
              if(document.all("form1:needcount").value=="")
              {
            	  alert("请填写需求人数");
                  return false;
              }
              return true;
           }
          
      </script>
 <x:saveState value="#{recu_need_collectBB}" />
 <h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{recu_need_collectBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 招聘管理 -> 招聘需求征集"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="100%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
                <h:outputText value="岗位名称"></h:outputText>
               <h:panelGroup>
                <h:inputHidden id="postId" value="#{recu_need_collectBB.bo.postId}"></h:inputHidden>
                <h:inputText readonly="true" id="postName" styleClass="input" value="#{recu_need_collectBB.bo.postName}"/>
                <h:commandButton type="button" styleClass="button_select"  onclick="fPopUpPostDlg('form1:postId','form1:postName');"></h:commandButton>
                </h:panelGroup>
               <h:outputText value="发布时间"></h:outputText>
               <h:inputText value="#{recu_need_collectBB.bo.publishDate}"></h:inputText>

               <h:outputText value="填报人"></h:outputText>
               <h:inputText value="#{recu_need_collectBB.bo.publishPersonName}"></h:inputText>
               
               <h:outputText value="需要人数"></h:outputText>
               <h:inputText id="needcount" value="#{recu_need_collectBB.bo.needCount}"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" onclick="return checkDateNull();"  action="#{recu_need_collectBB.save}"  styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>


