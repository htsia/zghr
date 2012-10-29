<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddPaper(){
        var superID=document.all('form1:superID').value;
        window.showModalDialog("/eLearn/paperEdit.jsf?LibID="+superID, null, "dialogWidth:500px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyPaper(id){
        window.showModalDialog("/eLearn/paperEdit.jsf?PaperID="+id, null, "dialogWidth:500px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyData(id){
        window.showModalDialog("/eLearn/paperContentLib.jsf?PaperID="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.width*0.85+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doShowPaper(id) {
        window.showModalDialog("/pages/eLearn/viewPaper.jsp?PaperID="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.width*0.85+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_paperLibBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eLearn_paperLibBB.initList}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{eLearn_paperLibBB.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
                 <h:commandButton value="����" styleClass="button01" onclick="doAddPaper();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{eLearn_paperLibBB.paperList}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

 				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.name}" ></h:outputText>
                </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="�ܷ�" />
                 </f:facet>
                 <h:outputText value="#{briefList.totalscore}" ></h:outputText>
             </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="�Ծ�����" />
                 </f:facet>
                  <h:selectOneRadio  value="#{briefList.paperType}" disabled="true">
                      <c:selectItem itemValue="0" itemLabel="�̶��Ծ�"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="�������"></c:selectItem>
                  </h:selectOneRadio>
             </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="�Ƿ�����" />
                 </f:facet>
                  <h:selectOneRadio disabled="true" value="#{briefList.isUse}">
                      <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                  </h:selectOneRadio>
             </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"  style="width:200px"/>
                    </f:facet>
   					<h:commandButton action="#{eLearn_paperLibBB.DeletePaper}" styleClass="button01" value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?')" >
                       <x:updateActionListener property="#{eLearn_paperLibBB.currentID}" value="#{briefList.paperID}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="�޸�����"  onclick="return doModifyPaper('#{briefList.paperID}');" />
                    <h:commandButton styleClass="button01" value="�޸�����"   onclick="return doModifyData('#{briefList.paperID}');" />
                    <h:commandButton styleClass="button01" value="Ԥ��"   onclick="return doShowPaper('#{briefList.paperID}');" />
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


