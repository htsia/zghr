<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function showPerson(detailId){
        	 window.open("/recruit/interviewResumeDetail.jsf?detailId="+detailId, null, "height="+screen.height*0.8+", width="+screen.width*0.5+", toolbar= no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no,top=50,left=100");
        	 return true;
         }
         
    </script>

<x:saveState value="#{onlineviewlistBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{onlineviewlistBB.personListInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
            <td class="td_title" height="10"><img src="/images/tips.gif"> 招聘管理 ->在线面试 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </c:verbatim>
	            <h:selectBooleanCheckbox value="#{onlineviewlistBB.selectDo}" onclick="submit();" valueChangeListener="#{onlineviewlistBB.queryDo}" />
				<h:outputText value="全部人员"/>
			<c:verbatim>
			
            </td>
            </tr>
            <tr>
            <td  height="10"></td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{onlineviewlistBB.interviewPersonList}" rowIndexVar="index"
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
                            <h:outputText value="所属计划"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.planId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="应聘岗位或专业"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.postName}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="应聘时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="状态"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.statusDes}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="面试结果"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.ivResultDes}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="面试" styleClass="button01" onclick="showPerson('#{list.detailId}')" rendered="#{list.status=='2' || list.status=='3'}"></h:commandButton>
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
