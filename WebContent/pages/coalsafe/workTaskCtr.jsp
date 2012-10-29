<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<c:verbatim>
	
</c:verbatim>
<script type="text/javascript">
    function doAddItem(){
        window.showModalDialog("/coalsafe/taskEdit.jsf?new=new", null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyItem(id){
        window.showModalDialog("/coalsafe/taskEdit.jsf?taskId="+id, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doSetPerson(id){
    	window.showModalDialog("/coalsafe/taskSetPerson.jsf?taskId="+id, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function amerce(id){
    	window.showModalDialog("/coalsafe/personAmerce.jsf?taskId="+id, null, "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{coalTaskMgrBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{coalTaskMgrBB.pageInit}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
	        <h:graphicImage value="/images/tips.gif" />
	        <h:outputText value=" ���ִ��  -> ����������"/>
	        </h:panelGroup>
       </h:panelGrid>
      <h:panelGrid width="98%" columns="1" align="center">
      	  <h:panelGrid columns="2">
      	  		<h:panelGroup>
      	  			<h:outputText value="ʱ��:"></h:outputText>
      	  			<h:inputText id="time1" value="#{coalTaskMgrBB.time1}" readonly="true"></h:inputText>
      	  			<h:commandButton type="button" styleClass="button_select" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',el:'form1:time1'})"></h:commandButton>
      	  			<h:outputText value="-"></h:outputText>
      	  			<h:inputText id="time2" value="#{coalTaskMgrBB.time2}" readonly="true"></h:inputText>
      	  			<h:commandButton type="button" styleClass="button_select" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',el:'form1:time2'})"></h:commandButton>
      	  			<h:outputText value=""></h:outputText>
      	  			<h:commandButton value="��ѯ" action="#{coalTaskMgrBB.doQuery}" styleClass="button01"></h:commandButton>
      	  		</h:panelGroup>
      	  </h:panelGrid>
		  <h:panelGrid columns="2" align="right">
		  		<h:panelGroup>
		  		<h:outputText value="��¼��:#{coalTaskMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{coalTaskMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{coalTaskMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{coalTaskMgrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{coalTaskMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{coalTaskMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{coalTaskMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{coalTaskMgrBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
                <h:commandButton value="����" styleClass="button01" onclick="doAddItem();"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>

          <x:dataTable value="#{coalTaskMgrBB.taskList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
				
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
                    <h:outputText value="#{index+1}" ></h:outputText>
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��������" />
					</f:facet>
                    <h:outputText value="#{briefList.taskContent}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="��������" />
					</f:facet>
                    <h:outputText value="#{briefList.taskTime}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="ֵ�ฺ����" />
					</f:facet>
                    <h:outputText value="#{briefList.taskMaster}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="������" />
					</f:facet>
                    <h:outputText value="#{briefList.createPid}" ></h:outputText>
                </h:column>
                 <h:column>
					<f:facet name="header">
						<h:outputText value="״̬" />
					</f:facet>
                    <h:outputText value="#{briefList.statusDes}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:commandButton value="�޸�" onclick="doModifyItem('#{briefList.taskId}');" styleClass="button01" rendered="#{briefList.status=='0'}"></h:commandButton>
                    <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����');" styleClass="button01" action="#{coalTaskMgrBB.deleteTask}" rendered="#{briefList.status=='0'}">
                          <x:updateActionListener property="#{coalTaskMgrBB.taskId}" value="#{briefList.taskId}"/>
                    </h:commandButton>
                    <h:commandButton value="��Ա����" onclick="doSetPerson('#{briefList.taskId}');" styleClass="button01" rendered="#{briefList.status=='0'}"></h:commandButton>
                    <h:commandButton value="��ʼ���"  styleClass="button01" action="#{coalTaskMgrBB.beginCtr}" rendered="#{briefList.status=='0'}">
                          <x:updateActionListener property="#{coalTaskMgrBB.taskId}" value="#{briefList.taskId}"/>
                    </h:commandButton>
                    <h:commandButton value="��ؿ۷�" onclick="amerce('#{briefList.taskId}');" styleClass="button01" rendered="#{briefList.status=='1'}"></h:commandButton>
                    <h:commandButton value="����"  styleClass="button01" action="#{coalTaskMgrBB.finishTask}" rendered="#{briefList.status=='1'}">
                          <x:updateActionListener property="#{coalTaskMgrBB.taskId}" value="#{briefList.taskId}"/>
                    </h:commandButton>
                </h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


