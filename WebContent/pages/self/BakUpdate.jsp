<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ include file="/pages/include/taglib.jsp" %>
<f:verbatim>
<script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
	
	<script>
		    function checkDate(){
		    var input1 = document.forms['content:form1'].elements['content:form1:t1'].value;
		    var input2 = document.forms['content:form1'].elements['content:form1:t2'].value;
		     var input3 = document.forms['content:form1'].elements['content:form1:t3'].value;
		    var input4 = document.forms['content:form1'].elements['content:form1:t4'].value;
		     var input5 = document.forms['content:form1'].elements['content:form1:t5'].value;
		    var input6 = document.forms['content:form1'].elements['content:form1:t6'].value;
		      var input7 = document.forms['content:form1'].elements['content:form1:t7'].value;
		      var input7 = document.forms['content:form1'].elements['content:form1:t8'].value;
		    if(input1.length>200 ){
		      alert("[\u4e2a\u4eba\u53d1\u5c55\u76ee\u6807]\u4e0d\u80fd\u8d85\u8fc7200\u5b57");
		      return false;
		    }else if(input2.length>200){
		      alert("[\u6839\u636e\u53d1\u5c55\u76ee\u6807\uff0c\u76ee\u524d\u5f85\u53d1\u5c55\u7684\u7d20\u8d28]\u4e0d\u80fd\u8d85\u8fc7200\u5b57");
		      return false;
		    }else if(input3.length>200){
		      alert("[\u6839\u636e\u53d1\u5c55\u76ee\u6807\uff0c\u9700\u8981\u5f97\u5230\u54ea\u4e9b\u57f9\u8bad]\u4e0d\u80fd\u8d85\u8fc7200\u5b57");
		      return false;
		    }else if(input4.length>200){
		      alert("[\u4ee5\u524d\u6240\u53c2\u52a0\u8fc7\u7684\u57f9\u8bad\u7ecf\u5386]\u4e0d\u80fd\u8d85\u8fc7200\u5b57");
		      return false;
		    }else if(input5.length>200){
		      alert("[\u6839\u636e\u53d1\u5c55\u76ee\u6807\uff0c\u76ee\u524d\u6240\u5177\u5907\u7684\u4f18\u52bf\u7d20\u8d28\u53ca\u5176\u8868\u73b0]\u4e0d\u80fd\u8d85\u8fc7200\u5b57");
		      return false;
		    }else if(input6.length>200){
		      alert("[\u7b80\u8981\u63cf\u8ff0\u81ea\u5df1\u7684\u6027\u683c\u7279\u70b9]\u4e0d\u80fd\u8d85\u8fc7200\u5b57");
		      return false;
		    }else if(input7.length>200){
		      alert("[\u6839\u636e\u81ea\u8eab\u60c5\u51b5\uff0c\u81ea\u5df1\u8ba4\u4e3a\u9002\u5408\u548c\u4e0d\u9002\u5408\u4ece\u4e8b\u7684\u5de5\u4f5c\u6216\u5c97\u4f4d]\u4e0d\u80fd\u8d85\u8fc7200\u5b57");
		      return false;
		    }else if(input8.length>200){
		      alert("[\u5bf9\u603b\u3001\u5206\u884c\u5728\u57f9\u517b\u4e0a\u8fd8\u6709\u4f55\u5176\u4ed6\u5efa\u8bae\u548c\u610f\u89c1]\u4e0d\u80fd\u8d85\u8fc7200\u5b57");
		      return false;
		    }
		    else
		      return confirm("\u786e\u8ba4\u63d0\u4ea4\u5417\uff1f");
		 }     		
		</script>
		
</f:verbatim>


<h:form id="form1">
 <h:inputHidden value="#{self_bakinfobb.initHid}"/>
	<h:panelGrid width="600" columns="1" border="0" align="center"
		cellpadding="3" >
		
		<h:panelGrid width="100%" columns="2" border="1" align="center"
			cellpadding="4" styleClass="table03"
			columnClasses="td_form01,td_form02">

			<h:outputText  value="���˷�չĿ��" />
			<h:panelGroup>
				<h:inputTextarea value="#{self_bakinfobb.trainDirection}" id="t1" rows="3"  style="width:100%">
				</h:inputTextarea>
			</h:panelGroup>

			<h:outputText value="���ݷ�չĿ�꣬Ŀǰ����չ������" />
			<h:panelGroup>
				<h:inputTextarea value="#{self_bakinfobb.making}" id="t2" rows="3" style="width:100%">
				</h:inputTextarea>
		
			</h:panelGroup>

			<h:outputText value="���ݷ�չĿ�꣬��Ҫ�õ���Щ��ѵ" />
			<h:panelGroup>
				<h:inputTextarea value="#{self_bakinfobb.neededTrain}" id="t3" rows="3" style="width:100%">
					<%--h:commonsValidator type="maxlength" arg="��󳤶�" maxlength="1000" /--%>
				</h:inputTextarea>
			
			</h:panelGroup>

			<h:outputText value="��ǰ���μӹ�����ѵ����" />
			<h:panelGroup>
				<h:inputTextarea value="#{self_bakinfobb.attendedTrain}" id="t4" rows="3" style="width:100%">
					<%--h:commonsValidator type="maxlength" arg="��󳤶�" maxlength="500" /--%>
				</h:inputTextarea>
				
			</h:panelGroup>

	<h:outputText value="���ݷ�չĿ�꣬Ŀǰ���߱����������ʼ������" />
			
			<h:panelGroup>
				<h:inputTextarea value="#{self_bakinfobb.advantage}" id="t5" rows="3" style="width:100%">
					<%--h:commonsValidator type="maxlength" arg="��󳤶�" maxlength="500" /--%>
				</h:inputTextarea>
				
			</h:panelGroup>


			<h:outputText value="��Ҫ�����Լ����Ը��ص�" />
			<h:panelGroup>
				<h:inputTextarea value="#{self_bakinfobb.characterSpecialty}" id="t6" rows="3" style="width:100%">
					<%--h:commonsValidator type="maxlength" arg="��󳤶�" maxlength="500" /--%>
				</h:inputTextarea>
				
			</h:panelGroup>

			<h:outputText value="��������������Լ���Ϊ�ʺϺͲ��ʺϴ��µĹ������λ" />
			<h:panelGroup>
				<h:inputTextarea value="#{self_bakinfobb.unsuitability}" id="t7"
					rows="3" style="width:100%">
					<%--h:commonsValidator type="maxlength" arg="��󳤶�" maxlength="1000" /--%>
				</h:inputTextarea>
				
			</h:panelGroup>

			<h:outputText value="���ܡ������������ϻ��к�������������" />
			
			<h:panelGroup>
				<h:inputTextarea value="#{self_bakinfobb.advice}" id="t8"
					rows="3" style="width:100%">
					<%--h:commonsValidator type="maxlength" arg="��󳤶�" maxlength="200" /--%>
				</h:inputTextarea>
			
			</h:panelGroup>
		</h:panelGrid>
		
		<h:panelGrid width="15%" columns="2" align="center">
			<h:commandButton  value="ȷ ��" onclick ="return checkDate();" action="#{self_bakinfobb.updateBak}" styleClass="button" />
			<h:commandButton  value="ȡ ��" action="self_BakQuery_jsf" styleClass="button" />
		</h:panelGrid>
		
	</h:panelGrid>
	<%--h:validatorScript functionName="myForm"/--%>
</h:form>
