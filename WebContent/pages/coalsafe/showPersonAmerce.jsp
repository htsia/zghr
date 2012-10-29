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
      <h:inputHidden value="#{coalOverseeMgrBB.initPersonDetail}"></h:inputHidden>
       <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
	        <h:graphicImage value="/images/tips.gif" />
	        <h:outputText value=" 监督执法->监控扣分 "/>
	        </h:panelGroup>
       </h:panelGrid>
      <h:panelGrid width="98%" columns="1" align="center">
          <x:dataTable value="#{coalOverseeMgrBB.personAmerceList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
				
				<h:column>
					<f:facet name="header">
						<h:outputText value="序号" />
					</f:facet>
                    <h:outputText value="#{index+1}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="违法行为" />
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="危险等级" />
					</f:facet>
                    <h:outputText value="#{briefList.riskGrade}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="扣分" />
					</f:facet>
                    <h:outputText value="#{briefList.score}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="罚款" />
					</f:facet>
                    <h:outputText value="#{briefList.amerce}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="违法时间" />
					</f:facet>
                    <h:outputText value="#{briefList.operateTime}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="违法地点" />
					</f:facet>
                    <h:outputText value="#{briefList.address}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="操作人员" />
					</f:facet>
                    <h:outputText value="#{briefList.operaterPid}" ></h:outputText>
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


