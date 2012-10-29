<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
  <script type="text/javascript">
  	function forsave(){
  		var beginDate= document.all("form1:beginTime").value;
  		var endDate= document.all("form1:endTime").value;
  		var applydays= document.all("form1:applydays").value;
  		
  		if(beginDate==null || beginDate==""){
  			alert("请选择开始日期");
  			return false;
  		}else if(endDate==null || endDate==""){
  			alert("请选择结束日期");
  			return false;
  		}else if(beginDate>endDate){
  			alert("结束日期大于开始日期");
  			return false;
  		}else if(applydays==null || applydays==""){
  			alert("公休时间不能为空");
  			return false;
  		}else if(isNaN(applydays) || applydays<=0){
  			alert("公休时间为大于0的数字");
  			return false;
  		}
  	//判断原因是否过长
		var reason = document.all("form1:reason").value;
		if (reason.length > 100) {
			alert("原因不能超过100字。");
			return false;
		}
  		return true;
  	}
  </script>
  
  <x:saveState value="#{attOutApplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{attOutApplyBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 考勤管理 ->公出申请"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="center">
           <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             <h:outputText value="申请人"/>
             <h:outputText value="#{attOutApplyBB.personName}"/>
             <h:outputText value=""/>
             <h:outputText value=""/>
           
            <h:outputText value="开始时间"/>
            <h:inputText styleClass="input Wdate" id="beginTime" value="#{attOutApplyBB.outBo.beginTime}"
                             readonly="true" alt="开始日期|0|d|50||" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'form1:beginTime'})"/>

            <h:outputText value="结束时间"/>
            <h:inputText styleClass="input Wdate" id="endTime" value="#{attOutApplyBB.outBo.endTime}"
                             readonly="true" alt="结束日期|0|d|50||" onclick="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',el:'form1:endTime'})"/>
            <h:outputText value="公出时间/天"/>
            <h:inputText id="applydays" value="#{attOutApplyBB.outBo.applyDays}" styleClass="input" />
            </h:panelGrid>
		   <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="原因"/>
             <h:inputTextarea id="reason" cols="60" rows="5" value="#{attOutApplyBB.outBo.reason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" onclick="return forsave();" styleClass="button01"  action="#{attOutApplyBB.save}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>