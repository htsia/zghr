<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doModify(id){ 
        window.showModalDialog("/eva/evaGroupEdit.jsf?groupId="+id, null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doAdd(){ 
        window.showModalDialog("/eva/evaGroupEdit.jsf?planId="+document.all("form1:planId").value, null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function setMaster(id){
    	window.showModalDialog("/eva/GroupPersonList.jsf?groupId="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{evaauitGroupMgrBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{evaauitGroupMgrBB.pageInit}"></h:inputHidden>
      <h:inputHidden id="planId" value="#{evaauitGroupMgrBB.planId}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
                <h:panelGroup>
       			<h:graphicImage value="/images/tips.gif" />
        		<h:outputText value=" ��Ч���� -> �����Ź���"/>
        </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid columns="1" align="right">
                 <h:commandButton value="����" styleClass="button01" onclick="doAdd();"></h:commandButton>
          </h:panelGrid>
          <x:dataTable value="#{evaauitGroupMgrBB.groupList}"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.groupName}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:commandButton styleClass="button01" value="�޸�"  onclick="return doModify('#{briefList.groupId}')" />
					<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{evaauitGroupMgrBB.deleteGroup}" styleClass="button01">
                  		<x:updateActionListener property="#{evaauitGroupMgrBB.groupId}" value="#{briefList.groupId}"/>
            		</h:commandButton>
            		<h:commandButton styleClass="button01" value="��������"  onclick="return setMaster('#{briefList.groupId}')" />
				</h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>


