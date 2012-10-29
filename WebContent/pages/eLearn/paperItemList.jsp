<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddPaperItem(){
        var superID=document.all('form1:superID').value;
        window.showModalDialog("/eLearn/paperItemEdit.jsf?superId="+superID, null, "dialogWidth:500px; dialogHeight:320px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyPaperItem(id){
        window.showModalDialog("/eLearn/paperItemEdit.jsf?itemId="+id, null, "dialogWidth:500px; dialogHeight:320px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_paperLibBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eLearn_paperLibBB.inititemList}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{eLearn_paperLibBB.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddPaperItem();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{eLearn_paperLibBB.itemlist}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
              <h:column>
                 <f:facet name="header">
                     <h:outputText value="顺序" />
                 </f:facet>
                 <h:outputText value="#{briefList.showSeq}" ></h:outputText>
             </h:column>

              <h:column>
                 <f:facet name="header">
                     <h:outputText value="题目" />
                 </f:facet>
                 <h:outputText value="#{briefList.title}" ></h:outputText>
             </h:column>

 				<h:column>
					<f:facet name="header">
						<h:outputText value="分数" />
					</f:facet>
                    <h:outputText value="#{briefList.score}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作"  style="width:200px"/>
                    </f:facet>
   					<h:commandButton action="#{eLearn_paperLibBB.DeletePaperItem}" styleClass="button01" value="删除" onclick="return confirm('确定要删除吗?')" >
                       <x:updateActionListener property="#{eLearn_paperLibBB.currentID}" value="#{briefList.itemID}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="修改"  onclick="return doModifyPaperItem('#{briefList.itemID}');" />
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


