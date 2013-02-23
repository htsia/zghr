<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddCource(){
        var superID=document.all('form1:superID').value;
        if (superID==null || superID==""){
            alert("����ѡ�����");
            return false;
        }
        window.showModalDialog("/train/CWFileEdit.jsf?superID="+superID, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyCource(id){
        window.showModalDialog("/train/CWFileEdit.jsf?fileID="+id, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{train_courcebb}"/>
<h:form id="form1">
      <h:inputHidden value="#{train_courcebb.pageInit}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{train_courcebb.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="����" styleClass="button01" onclick="return doAddCource();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{train_courcebb.manCourceList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="˳��" />
					</f:facet>
                    <h:outputText value="#{briefList.itemOrder}" />
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.title}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����ʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.createDate}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="��Чʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.startDate}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="ʧЧʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.endDate}" />
                </h:column>
				<h:column>
                    <f:facet name="header">
                        <h:outputText value="�Ƿ񹫹�" />
                    </f:facet>
                    <h:outputText value="#{briefList.publicDes}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
   					<h:commandButton styleClass="button01" action="#{train_courceeditbb.DeleteFile}" value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?')" >
                       <x:updateActionListener property="#{train_courceeditbb.fileID}" value="#{briefList.itemID}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="�޸�"  onclick="return doModifyCource('#{briefList.itemID}');" />
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


