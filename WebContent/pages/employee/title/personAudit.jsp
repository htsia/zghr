<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
function applyContent(id){
	window.showModalDialog("/employee/title/personApplyDirIndex.jsf?showType=show&itemId="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:no");
    return true;
}
function showScore(id,templateId){
	 window.showModalDialog("/pages/employee/title/personAuditScoreShow.jsp?itemId="+id+"&templateId="+templateId, "", "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:yes");
    return true;  
}
         
</script>

<x:saveState value="#{emptitleapplyAduitMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emptitleapplyAduitMgrBB.initItemList}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td height="10" align="center" valign="top">
            	</c:verbatim>
            	<h:outputText value="�������ƣ�"></h:outputText>
			    <h:inputText value="#{emptitleapplyAduitMgrBB.queryName}" styleClass="input"></h:inputText>
			    <h:commandButton value="��ѯ" action="#{emptitleapplyAduitMgrBB.queryItemList}" styleClass="button01"></h:commandButton>
			    <c:verbatim>
            </td>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			                <h:outputText value="��¼��:#{emptitleapplyAduitMgrBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ҳ��:#{emptitleapplyAduitMgrBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ÿҳ��#{emptitleapplyAduitMgrBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="��ǰΪ��#{emptitleapplyAduitMgrBB.mypage.currentPage}ҳ"></h:outputText>
			           		<h:commandButton value="��ҳ" action="#{emptitleapplyAduitMgrBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleapplyAduitMgrBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleapplyAduitMgrBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="βҳ" action="#{emptitleapplyAduitMgrBB.last}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td colspan="2">
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{emptitleapplyAduitMgrBB.itemList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personId}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="�ⱨ�ȼ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyLevel}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ⱨרҵ"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyMajor}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ⱨ�ʸ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyTitle}"/>
                    </h:column>
                     <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ֵȼ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.preLevel}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="��רҵ"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.preMajor}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="���ʸ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.preTitle}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="���ʱ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.priTime}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="״̬"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.statusDes}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="��ֽ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.score}"/>
                    </h:column>
                    
                    <h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="�걨����" styleClass="button01" onclick="applyContent('#{list.itemId}')"></h:commandButton>
						<h:commandButton value="�ۺ�����"  action="#{emptitleapplyAduitMgrBB.colligateApprove}" styleClass="button01" rendered="#{list.status=='2'}">
                  			<x:updateActionListener property="#{emptitleapplyAduitMgrBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
						<h:commandButton value="�ۺϴ��"  action="#{emptitleapplyAduitMgrBB.colligateScore}" styleClass="button01" rendered="#{list.status=='3'}">
                  			<x:updateActionListener property="#{emptitleapplyAduitMgrBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
						<h:commandButton value="�����ܷ�"  action="#{emptitleapplyAduitMgrBB.caculate}" styleClass="button01" rendered="#{list.status=='4'}">
                  			<x:updateActionListener property="#{emptitleapplyAduitMgrBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
            			<h:commandButton value="������" styleClass="button01" onclick="showScore('#{list.itemId}','#{list.templateId}')"></h:commandButton>
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
