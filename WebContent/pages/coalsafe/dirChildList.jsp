<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddItem(){
        var dirId=document.all('form1:dirId').value;
        if (dirId==null || dirId==""){
            alert("����ѡ��Ŀ¼��");
            return false;
        }
        window.showModalDialog("/coalsafe/amerceStdEdit.jsf?dirId="+dirId, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyItem(id){
        window.showModalDialog("/coalsafe/amerceStdEdit.jsf?itemId="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    
</script>

<x:saveState value="#{cocalAmerceStdSetBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{cocalAmerceStdSetBB.pageInit}"></h:inputHidden>
      <h:inputHidden id="dirId" value="#{cocalAmerceStdSetBB.dirId}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
		  		<h:panelGroup>
		  		<h:outputText value="��¼��:#{cocalAmerceStdSetBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{cocalAmerceStdSetBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{cocalAmerceStdSetBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{cocalAmerceStdSetBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{cocalAmerceStdSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{cocalAmerceStdSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{cocalAmerceStdSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{cocalAmerceStdSetBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
                <h:commandButton value="����" styleClass="button01" onclick="doAddItem();"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>

          <x:dataTable value="#{cocalAmerceStdSetBB.dirItemList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
                    <h:outputText value="#{briefList.itemNum}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="Υ����Ŀ" />
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="�۷ֱ�׼" />
					</f:facet>
                    <h:outputText value="#{briefList.itemScore}" ></h:outputText>
                </h:column>
                 <h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.amerce}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:commandButton value="�޸�" onclick="doModifyItem('#{briefList.itemId}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����');" styleClass="button01" action="#{cocalAmerceStdSetBB.deleteItem}">
                          <x:updateActionListener property="#{cocalAmerceStdSetBB.itemId}" value="#{briefList.itemId}"/>
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


