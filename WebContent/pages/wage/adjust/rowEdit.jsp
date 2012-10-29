<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
function forSave() {
	if(document.all("form1:seq").value==""||document.all("form1:seq").value==null){
		alert("录入完整数据！");
		return false;
	}
	if(document.all("form1:jobLevel").value==""||document.all("form1:jobLevel").value==null){
		alert("录入完整数据！");
		return false;
	}
	if(document.all("form1:title").value==""||document.all("form1:title").value==null){
		alert("录入完整数据！");
		return false;
	}
	if(document.all("form1:lowValue").value==""||document.all("form1:lowValue").value==null){
		alert("录入完整数据！");
		return false;
	}
	if(document.all("form1:highValue").value==""||document.all("form1:highValue").value==null){
		alert("录入完整数据！");
		return false;
	}
	
	forsubmit(document.forms(0)); 	
}
</script>

<x:saveState value="#{wageReformMgrBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{wageReformMgrBB.initRowEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 工作套改 ->套改年限设置 "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           	   <h:outputText value="序号"></h:outputText>
               <h:inputText value="#{wageReformMgrBB.rowBo.seq}" id="seq"></h:inputText>
               <h:outputText value="岗位级别"></h:outputText>
              	<h:panelGrid columns="2">
				<h:inputText styleClass="input" id="jobLevel" code="" dict="yes" dict_num="2215"
                     readonly="true" value="#{wageReformMgrBB.rowBo.jobLevel}"
                     alt="岗位级别|0|s|50||"/>
				 <c:verbatim>
				  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:jobLevel')">
				 </c:verbatim>
				</h:panelGrid>
				<h:outputText value="任职显示标题"></h:outputText>
               <h:inputText value="#{wageReformMgrBB.rowBo.title}" id="title"></h:inputText>
               <h:outputText value="低限"></h:outputText>
               <h:inputText value="#{wageReformMgrBB.rowBo.lowValue}" id="lowValue"></h:inputText>
               <h:outputText value="高限"></h:outputText>
               <h:inputText value="#{wageReformMgrBB.rowBo.highValue}" id="highValue"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" action="#{wageReformMgrBB.saveRow}"   styleClass="button01" onclick="javascript:return forSave()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
