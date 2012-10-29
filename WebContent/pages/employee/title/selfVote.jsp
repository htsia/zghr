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

function submitForm1(id){
	document.all("form1:itemId").value=id;
	document.forms(0).submit();
}
</script>

<x:saveState value="#{emptitleVotingBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emptitleVotingBB.initItemList}"></h:inputHidden>
	<h:inputHidden id="itemId" value="#{emptitleVotingBB.itemId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			                <h:outputText value="��¼��:#{emptitleVotingBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ҳ��:#{emptitleVotingBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ÿҳ��#{emptitleVotingBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="��ǰΪ��#{emptitleVotingBB.mypage.currentPage}ҳ"></h:outputText>
			           		<h:commandButton value="��ҳ" action="#{emptitleVotingBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleVotingBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleVotingBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="βҳ" action="#{emptitleVotingBB.last}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{emptitleVotingBB.itemList}" rowIndexVar="index"
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
                            <h:outputText value="�걨����"/>
                        </f:facet>
                        <h:commandLink value="�鿴" onclick="applyContent('#{list.itemId}')"></h:commandLink>
                    </h:column>
                    <h:column>
						<c:facet name="header" >
							<h:outputText value="����" />
						</c:facet>
						<h:selectOneRadio value="#{list.voteSatus}" onclick="submitForm1('#{list.itemId}');" valueChangeListener="#{emptitleVotingBB.submitVote}" rendered="#{list.status=='5'}">
							<c:selectItem itemLabel="����" itemValue="0"/>
							<c:selectItem itemLabel="ͨ��" itemValue="1"/>
						</h:selectOneRadio>
						<h:selectOneRadio value="#{list.voteSatus}" disabled="true" rendered="#{list.status=='F'}">
							<c:selectItem itemLabel="����" itemValue="0"/>
							<c:selectItem itemLabel="ͨ��" itemValue="1"/>
						</h:selectOneRadio>
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
