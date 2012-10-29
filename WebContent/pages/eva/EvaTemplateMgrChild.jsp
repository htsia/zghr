<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doModifyContent(id){
        window.showModalDialog("/eva/templateDefine.jsf?templateID="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function doAddItem(){
        var setID=document.all('form1:setID').value;
        if (setID==null || setID==""){
            alert("����ѡ�����");
            return false;
        }
        window.showModalDialog("/eva/templateEdit.jsf?setID="+setID, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyItem(id){
        window.showModalDialog("/eva/templateEdit.jsf?itemID="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function showPreview(id){
        window.showModalDialog("/pages/eva/previewTemplate.jsp?templateID="+id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }

     function exportCvs(id){
		window.open("/pages/eva/previewTemplateExcel.jsp?templateID="+id, "", "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:yes;scroll:yes;");
        return true;
	}
</script>

<x:saveState value="#{eva_templateBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eva_templateBB.initList}"></h:inputHidden>
      <h:inputHidden id="setID" value="#{eva_templateBB.setID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="����" styleClass="button01" onclick="doAddItem();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{eva_templateBB.itemList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="ģ������" />
					</f:facet>
                    <h:outputText value="#{briefList.templateName}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="�趨�ܷ�" />
                  </f:facet>
                  <h:outputText value="#{briefList.totalscore}" ></h:outputText>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="��ǰ�ܷ�" />
                  </f:facet>
                  <h:outputText value="#{briefList.curscore}" ></h:outputText>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="�Ƿ�����" />
                  </f:facet>
                  <h:selectOneRadio value="#{briefList.isUse}" disabled="true">
                      <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                  </h:selectOneRadio>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="ʹ�÷�Χ" />
                  </f:facet>
                  <h:selectOneMenu id="orgID" value="#{briefList.orguid}" disabled="true">
                      <c:selectItems value="#{eva_templateBB.orgList}"></c:selectItems>
                  </h:selectOneMenu>
              </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="�㼶" />
                  </f:facet>
                  <h:outputText value="#{briefList.level}" ></h:outputText>
              </h:column>

              <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:commandButton value="����ģ��" styleClass="button01" action="#{eva_templateBB.copyTemplate}">
                          <x:updateActionListener property="#{eva_templateBB.itemID}" value="#{briefList.templateID}"/>
                    </h:commandButton>
                    <h:commandButton value="�޸�����" onclick="doModifyItem('#{briefList.templateID}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="�޸�����" type="button" onclick="doModifyContent('#{briefList.templateID}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="ģ����ʾ" type="button" onclick="showPreview('#{briefList.templateID}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="����EXCEl" type="button" onclick="exportCvs('#{briefList.templateID}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����');" styleClass="button01" action="#{eva_templateBB.deleteItem}">
                          <x:updateActionListener property="#{eva_templateBB.itemID}" value="#{briefList.templateID}"/>
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


