<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function add(){
        	 window.showModalDialog("/employee/title/applyContentItemEdit.jsf?dirId="+document.all('form1:dirId').value, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.heigth*0.4+"px; status:0;resizable:yes");
             return true;  
         }
         function modify(itemId){
        	 window.showModalDialog("/employee/title/applyContentItemEdit.jsf?itemId="+itemId, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.heigth*0.4+"px; status:0;resizable:yes");
             return true;  
         }
 </script>

<x:saveState value="#{titleContentSetBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{titleContentSetBB.initItemList}"></h:inputHidden>
	<h:inputHidden id="dirId" value="#{titleContentSetBB.dirId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
	            			<h:commandButton value="增加" onclick="return add();" styleClass="button01" ></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{titleContentSetBB.itemList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="序号"/></c:facet>
		               <h:outputText value="#{list.seq}"/>
       				 </h:column>
       				 <h:column>
                        <f:facet name="header">
                            <h:outputText value="名称"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.itemName}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="打分模型"/>
                        </f:facet>
                        <h:selectOneMenu value="#{list.valueType}" disabled="true">
                        	<c:selectItem itemLabel="主观评断" itemValue="0"/>
               				<c:selectItem itemLabel="量化评断" itemValue="1"/>
                        </h:selectOneMenu>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="打分高限"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.hiScore}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="打分低限"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.lowScore}"/>
                    </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="关联指标集"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="编辑方式"/>
                        </f:facet>
                        <h:selectOneMenu value="#{list.allowEdit}" disabled="true">
                        	<c:selectItem itemLabel="只读" itemValue="0"/>
               				<c:selectItem itemLabel="可编辑" itemValue="1"/>
                        </h:selectOneMenu>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="过滤字段"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.filterField}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="过滤值"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.filterValue}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="评审字段"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.fields}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="描述"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.descrp}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="修改" onclick="return modify('#{list.itemId}');" styleClass="button01" ></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{titleContentSetBB.deleteItem}" styleClass="button01" >
                  	        <x:updateActionListener property="#{titleContentSetBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
					</h:column>
				</x:dataTable>
				<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
