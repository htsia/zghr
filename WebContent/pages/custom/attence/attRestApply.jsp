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
  		var restdays=document.all("form1:leaveday0").value
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
  			alert("加班时间不能为空");
  			return false;
  		}else if(isNaN(applydays) || applydays<=0){
  			alert("加班时间为大于0的数字");
  			return false;
  		}
  		//调休天数不能超过存休天数
  		if(restdays<applydays*8){
  			if(restdays.length==0){
  				restdays=0;
  			}
  			alert("您的存休时间不足,还有"+restdays+"小时");
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
  
  <x:saveState value="#{attRestApplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{attRestApplyBB.initEdit}"></h:inputHidden>
      <!-- 将存休的天数封装 -->
      <h:inputHidden id="leaveday0" value="#{attRestApplyBB.days.a236200}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 考勤管理 ->调休申请"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="center">
           <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             <h:outputText value="申请人"/>
             <h:outputText value="#{attRestApplyBB.personName}"/>
			<h:outputText value=""/>           
			<h:outputText value=""/>           
            <h:outputText value="开始时间"/>
            <h:inputText styleClass="input Wdate" id="beginTime" value="#{attRestApplyBB.restBo.beginTime}"
                             readonly="true" alt="开始日期|0|d|50||" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'form1:beginTime'})"/>

            <h:outputText value="结束时间"/>
            <h:inputText styleClass="input Wdate" id="endTime" value="#{attRestApplyBB.restBo.endTime}"
                             readonly="true" alt="结束日期|0|d|50||" onclick="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',el:'form1:endTime'})"/>
            <h:outputText value="调休时间/天"/>
            <h:inputText id="applydays"  value="#{attRestApplyBB.restBo.applyDays}" styleClass="input"/>
            </h:panelGrid>
		   <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="原因"/>
             <h:inputTextarea id="reason" cols="60" rows="5" value="#{attRestApplyBB.restBo.reason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01" onclick="return forsave();" action="#{attRestApplyBB.save}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
