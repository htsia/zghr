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
function exclude(id){
	window.showModalDialog("/employee/title/pesonExcEidt.jsf?edit=true&itemId="+id, "", "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px; status:0;resizable:no");
    return true; 
}
function refuse(id){
	window.showModalDialog("/employee/title/pesonRefuseEidt.jsf?edit=true&itemId="+id, "", "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px; status:0;resizable:no");
    return true; 
}
function inputScore(itemId){
	window.showModalDialog("/employee/title/deptAudit_inputScore.jsf?itemId="+itemId, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:no");
    return true; 
}
</script>

<x:saveState value="#{emptitledeptAduitmgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emptitledeptAduitmgrBB.initItemList}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			                <h:outputText value="记录数:#{emptitledeptAduitmgrBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="页数:#{emptitledeptAduitmgrBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="每页有#{emptitledeptAduitmgrBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="当前为第#{emptitledeptAduitmgrBB.mypage.currentPage}页"></h:outputText>
			           		<h:commandButton value="首页" action="#{emptitledeptAduitmgrBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="上页" action="#{emptitledeptAduitmgrBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="下页" action="#{emptitledeptAduitmgrBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="尾页" action="#{emptitledeptAduitmgrBB.last}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{emptitledeptAduitmgrBB.itemList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="序号"/></c:facet>
		               <h:outputText value="#{index+1}"/>
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
                            <h:outputText value="申请时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyTitle}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="现等级"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.preLevel}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="现专业"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.preMajor}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="现资格"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.preTitle}"/>
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
						<h:commandButton value="上报" onclick="return confirm('确定要上报人事处吗?');" action="#{emptitledeptAduitmgrBB.commitItem}" styleClass="button01" rendered="#{list.status=='1'}">
                  	        <x:updateActionListener property="#{emptitledeptAduitmgrBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
            			<h:commandButton value="排除" styleClass="button01" onclick="exclude('#{list.itemId}')" rendered="#{list.status=='1'}"></h:commandButton>
            			<h:commandButton value="退回修改" styleClass="button01" onclick="refuse('#{list.itemId}')" rendered="#{list.status=='1'}"></h:commandButton>
            			<h:commandButton value="同意修改申请" action="#{emptitledeptAduitmgrBB.modifyOK}" styleClass="button01" rendered="#{list.status=='7'&&list.refuseStatus=='1'}">
                  	        <x:updateActionListener property="#{emptitledeptAduitmgrBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
            			<h:commandButton value="退回修改申请" action="#{emptitledeptAduitmgrBB.modifyNO}" styleClass="button01" rendered="#{list.status=='7'&&list.refuseStatus=='1'}">
                  	        <x:updateActionListener property="#{emptitledeptAduitmgrBB.itemId}" value="#{list.itemId}"/>
            			</h:commandButton>
            			<h:commandButton value="申报材料" styleClass="button01" onclick="applyContent('#{list.itemId}')"></h:commandButton>
            			<h:commandButton value="打分" styleClass="button01" onclick="inputScore('#{list.itemId}')" rendered="#{list.status=='4'&&list.haveDeptAudit=='1'}"></h:commandButton>
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
