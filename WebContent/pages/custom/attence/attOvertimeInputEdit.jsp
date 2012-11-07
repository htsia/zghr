<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
  <script type="text/javascript">
  	function selperson(){
		var ids = window.showModalDialog(
						"/custom/selPerson.jsf?",
						null,
						"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
		if(ids!=null && ids.length>0){
			document.all('form1:selectedUserIds').value=ids;
			return true;
		}else{
			return false;
		}
	}
  	function forsave(){
  		var userIds= document.all("form1:userIds").value;
  		var beginDate= document.all("form1:beginTime").value;
  		var applydays= document.all("form1:applydays").value;
  		
  		if(userIds==null || userIds==""){
  			alert("��ѡ����Ա");
  			return false;
  		}else if(beginDate==null || beginDate==""){
  			alert("��ѡ��Ӱ�����");
  			return false;
  		}else if(applydays==null || applydays==""){
  			alert("�Ӱ�ʱ�䲻��Ϊ��");
  			return false;
  		}else if(isNaN(applydays) || applydays<4){
  			alert("���ݿ����ƶȣ�С��4Сʱ��������Ӱࡣ");
  			return false;
  		}
  		return true;
  	}
  </script>
  
  <x:saveState value="#{attOvertimeApplyBB}" />
  <h:inputHidden id="initEdit" value="#{attOvertimeApplyBB.inputEditInit}"/>
  <h:form id="form1">
	  <h:inputHidden id="selectedUserIds" value="#{attOvertimeApplyBB.selectedUserIds}"/>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ���ڹ��� ->�Ӱ�¼��"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="center">
           <h:panelGrid columns="4" width="98%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             <h:outputText value="����"/>
             <h:panelGroup>
	             <h:inputTextarea id="userIds" value="#{attOvertimeApplyBB.selectPersonNames}" cols="30" rows="3" readonly="true"/>
             	 <h:commandButton onclick="return selperson();" value="" styleClass="button_select" action="#{attOvertimeApplyBB.selPerson}"/>
             </h:panelGroup>
             <h:outputText value=""/>
             <h:outputText value=""/>
           
            <h:outputText value="��ʼʱ��"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="beginTime" value="#{attOvertimeApplyBB.inputEditBeginDate}"
                             readonly="true" alt="�Ӱ�����|0|d|50||"/>
                <c:verbatim>
				    <img onclick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'form1:beginTime'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </c:verbatim>
            </h:panelGroup>
            <h:outputText value="�Ӱ�ʱ��/ʱ"/>
            <h:inputText id="applydays" value="#{attOvertimeApplyBB.inputEditApplyDays}" styleClass="input" />
            </h:panelGrid>
		   <h:panelGrid columns="2" width="98%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="ԭ��"/>
             <h:inputTextarea cols="60" rows="5" value="#{attOvertimeApplyBB.inputEditReason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01" onclick="return forsave();" action="#{attOvertimeApplyBB.saveInput}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
