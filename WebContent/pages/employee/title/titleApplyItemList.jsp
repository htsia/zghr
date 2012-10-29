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
			                <h:outputText value="姓名或简称："></h:outputText>
			                <h:inputText value="#{emptitleapplyBB.queryValue}" styleClass="input"></h:inputText>
				            <h:commandButton value="查询" action="#{emptitleapplyBB.queryItemList}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            </td>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			          	 <h:commandButton value="批量打印"  styleClass="button01" onclick="selectPerson()"></h:commandButton>
			             <h:panelGroup>
			                <h:outputText value="记录数:#{emptitleapplyBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="页数:#{emptitleapplyBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="每页有#{emptitleapplyBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="当前为第#{emptitleapplyBB.mypage.currentPage}页"></h:outputText>
			           		<h:commandButton value="首页" action="#{emptitleapplyBB.first1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="上页" action="#{emptitleapplyBB.pre1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="下页" action="#{emptitleapplyBB.next1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="尾页" action="#{emptitleapplyBB.last1}" styleClass="button01"></h:commandButton>
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
                            <h:outputText value="序号"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{index+1}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="姓名"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personName}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="拟报等级"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyLevel}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="类别"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.classTypeDes}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="专业类别"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.majorClass}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="拟报专业"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyMajor}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="拟报资格"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyTitle}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="申报时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="现职称资格"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.preLevel} #{list.preMajor} #{list.preTitle}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="获得时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.priTime}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="状态"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.statusDes}"/>
                    </h:column>
                    
                    <h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="格式化材料" action="#{emptitleapplyBB.refreashPersonMatiro}" styleClass="button01" rendered="#{list.status=='0'||list.status=='1'||list.status=='2'}">
                  	        <x:updateActionListener property="#{emptitleapplyBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
						<h:commandButton value="申报材料" styleClass="button01" onclick="applyContent1('#{list.itemId }')"></h:commandButton>
						<h:commandButton value="分配学科" styleClass="button01" onclick="setMajorClass('#{list.itemId }')"></h:commandButton>
						<h:commandButton value="退回修改" styleClass="button01" onclick="refuse('#{list.itemId}')" rendered="#{list.status=='2'||list.status=='1'}"></h:commandButton>
						<h:commandButton value="排除" styleClass="button01" onclick="exclude('#{list.itemId}')" rendered="#{list.status=='2'}"></h:commandButton>
						<h:commandButton value="同意修改申请" action="#{emptitleapplyBB.modifyOK}" styleClass="button01" rendered="#{list.status=='7'&&list.refuseStatus=='2'}">
                  	        <x:updateActionListener property="#{emptitleapplyBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
            			<h:commandButton value="退回修改申请" action="#{emptitleapplyBB.modifyNO}" styleClass="button01" rendered="#{list.status=='7' &&list.refuseStatus=='2'}">
                  	        <x:updateActionListener property="#{emptitleapplyBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
            			<h:commandButton value="预览" styleClass="button01" onclick="scanf('#{list.itemId}')"></h:commandButton>
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
