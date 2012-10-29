<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="/pages/include/taglib.jsp" %>
   
      <script type="text/javascript">
      function checkDateNull(){
          if(document.all("form1:needcount").value==""||document.all("form1:needcount").value==null)
           {
         	  alert("请填写需求人数");
              return false;
           }else if(document.all("form1:postType").value==""||document.all("form1:postType").value==null){
         	  alert("岗位类别不能为空");
               return false;
           }else if(document.all("form1:majorType").value==""||document.all("form1:majorType").value==null){
         	  alert("专业不能为空");
               return false;
           }else{
           	  forsubmit(document.forms(0)); 
           }	
      }
      </script>
 <x:saveState value="#{recruit_innerBB}" />
 <h:form id="form1" >
      <h:inputHidden id="initPostEdit" value="#{recruit_innerBB.initPostEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 招聘管理 -> 增加岗位类别"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="100%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
                <h:outputText value="岗位类别"></h:outputText>
                <h:panelGroup>
				<h:inputText styleClass="input" id="postType" code="" dict="yes" dict_num="0110"
                     readonly="true" value="#{recruit_innerBB.innerRecuBo.postType}"
                     alt="岗位类别|0|s|50||"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:postType')" />
				</h:panelGroup>
               	<h:outputText value="专业"></h:outputText>
               	<h:panelGroup>
				<h:inputText styleClass="input" id="majorType" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{recruit_innerBB.innerRecuBo.majorType}"
                     alt="专业|0|s|50||"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:majorType')" />
				</h:panelGroup>
				<h:outputText value="需要人数"></h:outputText>
               	<h:inputText id="needcount" value="#{recruit_innerBB.innerRecuBo.needCount}"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" onclick="return checkDateNull();"  action="#{recruit_innerBB.savePost}"  styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
