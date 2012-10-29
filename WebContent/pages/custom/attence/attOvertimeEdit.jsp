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
  			alert("��ѡ��ʼ����");
  			return false;
  		}else if(endDate==null || endDate==""){
  			alert("��ѡ���������");
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
  		return true;
  	}
  </script>
  
  <x:saveState value="#{attOvertimeApplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{attOvertimeApplyBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ���ڹ��� ->�Ӱ�����"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="center">
           <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             <h:outputText value="������"/>
             <h:outputText value="#{attOvertimeApplyBB.personName}"/>
		     <h:outputText value=""/>           
		     <h:outputText value=""/>           
            <h:outputText value="��ʼʱ��"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="beginTime" value="#{attOvertimeApplyBB.overtimeBo.beginTime}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <c:verbatim>
				    <img onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'form1:beginTime'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </c:verbatim>
            </h:panelGroup>

            <h:outputText value="����ʱ��"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endTime" value="#{attOvertimeApplyBB.overtimeBo.endTime}"
                             readonly="true" alt="��������|0|d|50||"/>
                <c:verbatim>
                <img onclick="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',el:'form1:endTime'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </c:verbatim>
            </h:panelGroup>
            <h:outputText value="�Ӱ�ʱ��/ʱ"/>
            <h:inputText id="applydays" value="#{attOvertimeApplyBB.overtimeBo.applyDays}" styleClass="input"/>
            </h:panelGrid>
		   <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="ԭ��"/>
             <h:inputTextarea cols="60" rows="5" value="#{attOvertimeApplyBB.overtimeBo.reason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01" onclick="return forsave();" action="#{attOvertimeApplyBB.save}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>