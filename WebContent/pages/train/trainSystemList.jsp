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
            alert("请先选择类别！");
            return false;
        }
        window.showModalDialog("/train/trainSystemEdit.jsf?superID="+superID, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyCource(id){
        window.showModalDialog("/train/trainSystemEdit.jsf?itemID="+id, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{trainSystemBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{trainSystemBB.initItem}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{trainSystemBB.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddItem();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{trainSystemBB.systemList}" id="dateList"
				headerClass="td_top" rowIndexVar="index" var="list" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
				
				<h:column>
					<f:facet name="header">
						<h:outputText value="机构"></h:outputText>
					</f:facet>
					<h:outputText value="#{list.companyName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="部门"></h:outputText>
					</f:facet>
					<h:outputText value="#{list.orgName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="岗位名称" />
					</f:facet>
                    <h:outputText value="#{list.postId}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="培训类型" />
                    </f:facet>
                    <h:outputText value="#{list.itemType}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="关联课程" />
                    </f:facet>
                    <h:outputText value="#{list.linkCourseDes}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="课件类型" />
                    </f:facet>
                    <h:outputText value="#{list.courseTypeDes}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="课时" />
                    </f:facet>
                    <h:outputText value="#{list.period}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="学分" />
                    </f:facet>
                    <h:outputText value="#{list.score}" ></h:outputText>
                </h:column>

               <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
   					<h:commandButton styleClass="button01" action="#{trainSystemBB.deleteItem}" value="删除" onclick="return confirm('确定要删除吗?')" >
                       <x:updateActionListener property="#{trainSystemBB.itemID}" value="#{list.itemId}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="修改"  onclick="return doModifyCource('#{list.itemId}');" />
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

