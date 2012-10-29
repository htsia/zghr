<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddItem(){
        var setID=document.all('form1:setID').value;
        if (setID==null || setID==""){
            alert("请先选择类别！");
            return false;
        }
        window.showModalDialog("/eva/templateItemEdit.jsf?templateID="+document.all('form1:templateID').value+"&SetID="+setID, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyItem(id){
        window.showModalDialog("/eva/templateItemEdit.jsf?itemID="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eva_templateBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eva_templateBB.initItemList}"></h:inputHidden>
      <h:inputHidden id="setID" value="#{eva_templateBB.itemSet}"></h:inputHidden>
      <h:inputHidden id="templateID" value="#{eva_templateBB.templateID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddItem();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{eva_templateBB.evaitems}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="指标名称" />
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="权重%" />
                  </f:facet>
                  <h:outputText value="#{briefList.score}" ></h:outputText>
              </h:column>

              <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton value="修改" onclick="doModifyItem('#{briefList.itemID}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="删除" onclick="return confirm('确定要删除吗？')" styleClass="button01" action="#{eva_templateBB.deleteItem1}">
                          <x:updateActionListener property="#{eva_templateBB.itemID}" value="#{briefList.itemID}"/>
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


