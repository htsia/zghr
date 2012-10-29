<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddItem(){
        var superID=document.all('form1:superID').value;
        if (superID==null || superID==""){
            alert("����ѡ�����");
            return false;
        }
        window.showModalDialog("/eva/GradeItemEdit.jsf?superID="+superID, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyCource(id){
        window.showModalDialog("/eva/GradeItemEdit.jsf?itemID="+id, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eva_gradeBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eva_gradeBB.initItem}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{eva_gradeBB.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="����" styleClass="button01" onclick="doAddItem();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{eva_gradeBB.itemList}"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="˵��" />
                    </f:facet>
                    <h:outputText value="#{briefList.itemDes}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:outputText value="#{briefList.lowValue}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:outputText value="#{briefList.highValue}" ></h:outputText>
                </h:column>
				<h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:outputText value="#{briefList.flagChar}" ></h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="˳��" />
                    </f:facet>
                    <h:outputText value="#{briefList.showSeq}" ></h:outputText>
                </h:column>
                

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
   					<h:commandButton styleClass="button01" action="#{eva_gradeBB.DeleteItem}" value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?')" >
                       <x:updateActionListener property="#{eva_gradeBB.gradeitembo.itemID}" value="#{briefList.itemID}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="�޸�"  onclick="return doModifyCource('#{briefList.itemID}');" />
				</h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>


