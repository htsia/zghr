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
            <td class="td_title"><img src="/images/tips.gif"> �걨���� ->������ </td>
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
			                <h:outputText value="��¼��:#{emptitleVotingBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ҳ��:#{emptitleVotingBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ÿҳ��#{emptitleVotingBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="��ǰΪ��#{emptitleVotingBB.mypage.currentPage}ҳ"></h:outputText>
			           		<h:commandButton value="��ҳ" action="#{emptitleVotingBB.first1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleVotingBB.pre1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleVotingBB.next1}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="βҳ" action="#{emptitleVotingBB.last1}" styleClass="button01"></h:commandButton>
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
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
       				 <h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personName}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�걨����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyLevel}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="���"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.classType}"/>
                    </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="ѧ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.majorClass}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="רҵ"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyMajor}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ʸ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyTitle}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="ͶƱ��"/>
                        </f:facet>
                         <h:outputText escape="false" value="#{list.totalVote}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="ͨ����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.agreeVote}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="������"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.ngreeVote}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�걨״̬"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.statusDes}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="�걨�ɹ�" onclick="return confirm('ȷ����#{list.personName}��ͨ�����������?');" action="#{emptitleVotingBB.commitItem}" styleClass="button01" rendered="#{list.status=='5'}">
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
