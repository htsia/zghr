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
  		var date = new Date(); 
  		var d=date.getDate();
  		var m=date.getMonth()+1;
  		if(d<10){
  			d="0"+d;
  		}
  		if(m<10){
  			m="0"+m;
  		}
  		var str = date.getFullYear()+"-"+m+"-"+d;
  		if(beginDate==null || beginDate==""){
  			alert("��ѡ��ʼ����");
  			return false;
  		}else if(beginDate<str){
  			alert("���ݿ����ƶȣ�ֻ�����뵱�켰�Ժ�ġ��������Ҫ��¼������ϵ������Դ����");
  			return false;
  		}else if(beginDate>endDate){
  			alert("�������ڴ��ڿ�ʼ����");
  			return false;
  		}else if(applydays==null || applydays==""){
  			alert("�Ӱ�ʱ�䲻��Ϊ��");
  			return false;
  		}else if(isNaN(applydays) || applydays<=0){
  			alert("�Ӱ�ʱ��Ϊ����0������");
  			return false;
  		}
  		//�����������ܳ�����������
  		if(restdays<applydays*8){
  			if(restdays.length==0){
  				restdays=0;
  			}
  			alert("���Ĵ���ʱ�䲻��,ʣ��"+restdays+"Сʱ");
  			return false;
  		}
  	//�ж�ԭ���Ƿ����
		var reason = document.all("form1:reason").value;
		if (reason.length > 100) {
			alert("ԭ���ܳ���100�֡�");
			return false;
		}
  		return true;
  	}
  </script>
  
  <x:saveState value="#{attRestApplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{attRestApplyBB.initEdit}"></h:inputHidden>
      <!-- �����ݵ�������װ -->
      <h:inputHidden id="leaveday0" value="#{attRestApplyBB.days.a236200}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ���ڹ��� ->��������"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="center">
           <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             <h:outputText value="������"/>
             <h:outputText value="#{attRestApplyBB.personName}"/>
			<h:outputText value=""/>           
			<h:outputText value=""/>           
            <h:outputText value="��ʼʱ��"/>
            <h:panelGroup>
            <h:inputText styleClass="input" id="beginTime" value="#{attRestApplyBB.restBo.beginTime}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
			<f:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:beginTime');"></f:verbatim>
			</h:panelGroup>
            <h:outputText value="����ʱ��"/>
            <h:panelGroup>
            <h:inputText styleClass="input" id="endTime" value="#{attRestApplyBB.restBo.endTime}"
                             readonly="true" alt="��������|0|d|50||"/>
            <f:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:endTime');"></f:verbatim>
            </h:panelGroup>                 
            <h:outputText value="����ʱ��/��"/>
            <h:inputText id="applydays"  value="#{attRestApplyBB.restBo.applyDays}" styleClass="input"/>
            </h:panelGrid>
		   <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="ԭ��"/>
             <h:inputTextarea id="reason" cols="60" rows="5" value="#{attRestApplyBB.restBo.reason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01" onclick="return forsave();" action="#{attRestApplyBB.save}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
