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
		  		 <h:outputText value="记录数:#{eLearn_testBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{eLearn_testBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{eLearn_testBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{eLearn_testBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{eLearn_testBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{eLearn_testBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{eLearn_testBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{eLearn_testBB.last1}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
                <h:commandButton value="增加" styleClass="button01" onclick="doAddTest();"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>
	 </h:panelGrid>
	 <h:panelGrid width="98%" columns="1" align="center">
          <x:dataTable value="#{eLearn_testBB.setList}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

 				<h:column>
					<f:facet name="header">
						<h:outputText value="标题" />
					</f:facet>
                    <h:outputText value="#{briefList.testName}" ></h:outputText>
                </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="使用试卷" />
                 </f:facet>
                 <h:outputText value="#{briefList.paperName}" ></h:outputText>
             </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="人员范围" />
                 </f:facet>
                 <h:outputText value="#{briefList.scopeTypeDes}" ></h:outputText>
             </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="开始时间" style="width:100px" />
                    </f:facet>
                    <h:outputText value="#{briefList.beginTime}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="结束时间" style="width:100px" />
                  </f:facet>
                  <h:outputText value="#{briefList.endTime}" ></h:outputText>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="考试时间(分钟)" style="width:100px" />
                  </f:facet>
                  <h:outputText value="#{briefList.testminute}" ></h:outputText>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="是否启用" style="width:100px" />
                  </f:facet>
                  <h:selectOneRadio value="#{briefList.isUse}" disabled="true">
                      <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                  </h:selectOneRadio>
              </h:column>
              <h:column>
              	  <f:facet name="header">
                      <h:outputText value="考试模型" style="width:100px" />
                  </f:facet>
                  <h:outputText value="#{briefList.modeDes}" ></h:outputText>
              </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作"  style="width:200px"/>
                    </f:facet>
                    <h:commandButton value="修改属性" onclick="doModifyTest('#{briefList.testID}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="设置人员" rendered="#{briefList.scopeType=='2'&&briefList.testMode=='0'}" onclick="doSetTestPerson('#{briefList.testID}');" styleClass="button01"></h:commandButton>
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


