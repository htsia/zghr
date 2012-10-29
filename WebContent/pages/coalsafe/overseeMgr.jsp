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
        window.showModalDialog("/coalsafe/amerceEdit.jsf?new=new", null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyItem(id){
        window.showModalDialog("/coalsafe/amerceEdit.jsf?recordId="+id, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{coalOverseeMgrBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{coalOverseeMgrBB.pageInit}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
      	  <h:panelGrid columns="2">
      	  		<h:panelGroup>
      	  			<h:outputText value="ʱ��:"></h:outputText>
      	  			<h:inputText id="time1" value="#{coalOverseeMgrBB.time1}" readonly="true"></h:inputText>
      	  			<h:commandButton type="button" styleClass="button_select" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',el:'form1:time1'})"></h:commandButton>
      	  			<h:outputText value="-"></h:outputText>
      	  			<h:inputText id="time2" value="#{coalOverseeMgrBB.time2}" readonly="true"></h:inputText>
      	  			<h:commandButton type="button" styleClass="button_select" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',el:'form1:time2'})"></h:commandButton>
      	  			<h:outputText value=""></h:outputText>
      	  			<h:commandButton value="��ѯ" action="#{coalOverseeMgrBB.doQuery}" styleClass="button01"></h:commandButton>
      	  		</h:panelGroup>
      	  </h:panelGrid>
		  <h:panelGrid columns="2" align="right">
		  		<h:panelGroup>
		  		<h:outputText value="��¼��:#{coalOverseeMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{coalOverseeMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{coalOverseeMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{coalOverseeMgrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{coalOverseeMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{coalOverseeMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{coalOverseeMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{coalOverseeMgrBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
                <h:commandButton value="����" styleClass="button01" onclick="doAddItem();"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>

          <x:dataTable value="#{coalOverseeMgrBB.amerceList}"  id="dateList"
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
						<h:outputText value="Υ����Ա" />
					</f:facet>
                    <h:outputText value="#{briefList.personId}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="Υ������" />
					</f:facet>
                    <h:outputText value="#{briefList.typeDes}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="Υ����Ϊ" />
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="Σ�յȼ�" />
					</f:facet>
                    <h:outputText value="#{briefList.riskGrade}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="�۷�" />
					</f:facet>
                    <h:outputText value="#{briefList.score}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.amerce}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="Υ��ʱ��" />
					</f:facet>
                    <h:outputText value="#{briefList.operateTime}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="Υ���ص�" />
					</f:facet>
                    <h:outputText value="#{briefList.address}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="������Ա" />
					</f:facet>
                    <h:outputText value="#{briefList.operaterPid}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:commandButton value="�޸�" onclick="doModifyItem('#{briefList.recordId}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����');" styleClass="button01" action="#{coalOverseeMgrBB.deleteAmerce}">
                          <x:updateActionListener property="#{coalOverseeMgrBB.recordId}" value="#{briefList.recordId}"/>
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


