<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
function inputScore(itemId){
	window.showModalDialog("/employee/title/selfAudit_inputScore.jsf?itemId="+itemId, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:no");
    return true; 
}
</script>

<x:saveState value="#{emptitleAduitBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emptitleAduitBB.initItemList}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			                <h:outputText value="记录数:#{emptitleAduitBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="页数:#{emptitleAduitBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="每页有#{emptitleAduitBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="当前为第#{emptitleAduitBB.mypage.currentPage}页"></h:outputText>
			           		<h:commandButton value="首页" action="#{emptitleAduitBB.first1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="上页" action="#{emptitleAduitBB.pre1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="下页" action="#{emptitleAduitBB.next1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="尾页" action="#{emptitleAduitBB.last1}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{emptitleAduitBB.itemList}" rowIndexVar="index"
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
                        <h:outputText escape="false" value="#{list.personId}"/>
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
						<h:commandButton value="打分" styleClass="button01" onclick="inputScore('#{list.itemId}')" rendered="#{list.status=='4'}"></h:commandButton>
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
