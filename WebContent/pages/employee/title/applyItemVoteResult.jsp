<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.title.pojo.bo.*"%>
<%@ page import="com.hr319wg.title.ucc.impl.TitleContentSetUCC" %>
<%@ page import="com.hr319wg.title.ucc.impl.EmpTitleApplyUcc" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
       
</script>

<x:saveState value="#{emptitleVotingBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emptitleVotingBB.initVoteList}"></h:inputHidden>
	<c:verbatim>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 申报管理 ->评审结果 </td>
        </tr>
    </table>
		<table height=98% width=98% align="center" >
            <tr>
            <td valign="top">
            	</c:verbatim>
            		<h:selectOneRadio value="#{emptitleVotingBB.templateId}" onclick="submit();" valueChangeListener="#{emptitleVotingBB.change}">
            			<c:selectItems value="#{emptitleVotingBB.templates}"/>
            		</h:selectOneRadio>
            	<c:verbatim>
            </td>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="1">
			             <h:panelGroup>
			                <h:outputText value="记录数:#{emptitleVotingBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="页数:#{emptitleVotingBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="每页有#{emptitleVotingBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="当前为第#{emptitleVotingBB.mypage.currentPage}页"></h:outputText>
			           		<h:commandButton value="首页" action="#{emptitleVotingBB.first1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="上页" action="#{emptitleVotingBB.pre1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="下页" action="#{emptitleVotingBB.next1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="尾页" action="#{emptitleVotingBB.last1}" styleClass="button01"></h:commandButton>
				            <h:outputText value="  "></h:outputText>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td colspan="2">
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{emptitleVotingBB.personList}" rowIndexVar="index"
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
                            <h:outputText value="申报级别"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyLevel}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="类别"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.classType}"/>
                    </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="学科"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.majorClass}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="专业"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyMajor}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="资格"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyTitle}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="投票数"/>
                        </f:facet>
                         <h:outputText escape="false" value="#{list.totalVote}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="通过数"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.agreeVote}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="反对数"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.ngreeVote}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="申报状态"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.statusDes}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="申报成功" onclick="return confirm('确定（#{list.personName}）通过最好评审吗?');" action="#{emptitleVotingBB.commitItem}" styleClass="button01" rendered="#{list.status=='5'}">
                  	        <x:updateActionListener property="#{emptitleVotingBB.itemId}" value="#{list.itemId}"/>
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
