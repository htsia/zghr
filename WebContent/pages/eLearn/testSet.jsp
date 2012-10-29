<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddTest(){
        window.showModalDialog("/eLearn/TestEdit.jsf?testMode=0", null, "dialogWidth:500px; dialogHeight:320px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyTest(id){
        window.showModalDialog("/eLearn/TestEdit.jsf?TestID="+id, null, "dialogWidth:500px; dialogHeight:320px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyData(id){
        window.showModalDialog("/eLearn/AnswerList.jsf?QestionID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doSetTestPerson(id){
        window.showModalDialog("/eLearn/TestPersonList.jsf?TestID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_testBB}"/>
<h:form id="form1">
	  <h:inputHidden value="#{eLearn_testBB.initTestList}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
		  		<h:panelGroup>
		  		 <h:outputText value="��¼��:#{eLearn_testBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{eLearn_testBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{eLearn_testBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{eLearn_testBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{eLearn_testBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{eLearn_testBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{eLearn_testBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{eLearn_testBB.last1}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
                <h:commandButton value="����" styleClass="button01" onclick="doAddTest();"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>
	 </h:panelGrid>
	 <h:panelGrid width="98%" columns="1" align="center">
          <x:dataTable value="#{eLearn_testBB.setList}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

 				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.testName}" ></h:outputText>
                </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="ʹ���Ծ�" />
                 </f:facet>
                 <h:outputText value="#{briefList.paperName}" ></h:outputText>
             </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="��Ա��Χ" />
                 </f:facet>
                 <h:outputText value="#{briefList.scopeTypeDes}" ></h:outputText>
             </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="��ʼʱ��" style="width:100px" />
                    </f:facet>
                    <h:outputText value="#{briefList.beginTime}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="����ʱ��" style="width:100px" />
                  </f:facet>
                  <h:outputText value="#{briefList.endTime}" ></h:outputText>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="����ʱ��(����)" style="width:100px" />
                  </f:facet>
                  <h:outputText value="#{briefList.testminute}" ></h:outputText>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="�Ƿ�����" style="width:100px" />
                  </f:facet>
                  <h:selectOneRadio value="#{briefList.isUse}" disabled="true">
                      <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                  </h:selectOneRadio>
              </h:column>
              <h:column>
              	  <f:facet name="header">
                      <h:outputText value="����ģ��" style="width:100px" />
                  </f:facet>
                  <h:outputText value="#{briefList.modeDes}" ></h:outputText>
              </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"  style="width:200px"/>
                    </f:facet>
                    <h:commandButton value="�޸�����" onclick="doModifyTest('#{briefList.testID}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="������Ա" rendered="#{briefList.scopeType=='2'&&briefList.testMode=='0'}" onclick="doSetTestPerson('#{briefList.testID}');" styleClass="button01"></h:commandButton>
                </h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
    <script type="text/javascript">
       setDataTableOver("form1:setlist");
    </script>
    </h:form>


