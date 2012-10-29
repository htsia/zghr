<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function applyContent1(id){
        	 window.showModalDialog("/employee/title/personApplyDirIndex.jsf?showType=edit&itemId="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:no");
             return true;
         }
         function setMajorClass(id){
        	 window.showModalDialog("/employee/title/setMajorClassEdit.jsf?itemId="+id, "", "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.4+"px; status:0;resizable:no");
             return true;
         }
         function exclude(id){
        		window.showModalDialog("/employee/title/pesonExcEidt.jsf?edit=true&itemId="+id, "", "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px; status:0;resizable:no");
        	    return true; 
         }
         function refuse(id){
        		window.showModalDialog("/employee/title/pesonRefuseEidt.jsf?edit=true&itemId="+id, "", "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px; status:0;resizable:no");
        	    return true; 
         }
         function scanf(id){
        	 window.open("/pages/employee/title/displayReport.jsp?itemId="+id, null, "height="+screen.height*0.8+", width="+screen.width*0.8+", top=100,left=200, toolbar=yes, menubar=no, location=no, resizable=yes,status=no");
             return true;
         }
         function selectPerson(){
        	 window.open("/pages/employee/title/displayReport.jsp?applyId="+document.all("form1:applyId").value, null, "height="+screen.height*0.8+", width="+screen.width*0.8+", top=100,left=200, toolbar=yes, menubar=no, location=no, resizable=yes,status=no");
             return true;
         }
</script>

<x:saveState value="#{emptitleapplyBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emptitleapplyBB.initItemList}"></h:inputHidden>
	<h:inputHidden id="applyId" value="#{emptitleapplyBB.applayId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td>
            	</c:verbatim>
			          <h:panelGrid align="right" columns="1">
			             <h:panelGroup>
			                <h:outputText value="�������ƣ�"></h:outputText>
			                <h:inputText value="#{emptitleapplyBB.queryValue}" styleClass="input"></h:inputText>
				            <h:commandButton value="��ѯ" action="#{emptitleapplyBB.queryItemList}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            </td>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			          	 <h:commandButton value="������ӡ"  styleClass="button01" onclick="selectPerson()"></h:commandButton>
			             <h:panelGroup>
			                <h:outputText value="��¼��:#{emptitleapplyBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ҳ��:#{emptitleapplyBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ÿҳ��#{emptitleapplyBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="��ǰΪ��#{emptitleapplyBB.mypage.currentPage}ҳ"></h:outputText>
			           		<h:commandButton value="��ҳ" action="#{emptitleapplyBB.first1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleapplyBB.pre1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleapplyBB.next1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="βҳ" action="#{emptitleapplyBB.last1}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td colspan="2">
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{emptitleapplyBB.itemList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="���"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{index+1}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personName}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="�ⱨ�ȼ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyLevel}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="���"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.classTypeDes}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="רҵ���"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.majorClass}"/>
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
                            <h:outputText value="�걨ʱ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="��ְ���ʸ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.preLevel} #{list.preMajor} #{list.preTitle}"/>
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
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="��ʽ������" action="#{emptitleapplyBB.refreashPersonMatiro}" styleClass="button01" rendered="#{list.status=='0'||list.status=='1'||list.status=='2'}">
                  	        <x:updateActionListener property="#{emptitleapplyBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
						<h:commandButton value="�걨����" styleClass="button01" onclick="applyContent1('#{list.itemId }')"></h:commandButton>
						<h:commandButton value="����ѧ��" styleClass="button01" onclick="setMajorClass('#{list.itemId }')"></h:commandButton>
						<h:commandButton value="�˻��޸�" styleClass="button01" onclick="refuse('#{list.itemId}')" rendered="#{list.status=='2'||list.status=='1'}"></h:commandButton>
						<h:commandButton value="�ų�" styleClass="button01" onclick="exclude('#{list.itemId}')" rendered="#{list.status=='2'}"></h:commandButton>
						<h:commandButton value="ͬ���޸�����" action="#{emptitleapplyBB.modifyOK}" styleClass="button01" rendered="#{list.status=='7'&&list.refuseStatus=='2'}">
                  	        <x:updateActionListener property="#{emptitleapplyBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
            			<h:commandButton value="�˻��޸�����" action="#{emptitleapplyBB.modifyNO}" styleClass="button01" rendered="#{list.status=='7' &&list.refuseStatus=='2'}">
                  	        <x:updateActionListener property="#{emptitleapplyBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
            			<h:commandButton value="Ԥ��" styleClass="button01" onclick="scanf('#{list.itemId}')"></h:commandButton>
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
