<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
    <script type="text/javascript">
       function showDetail(id,msg){
           arg="remindid="+id+"&remindmsg="+msg;
           windowOpen("/system/RemResultDetail.jsf?" + arg, "aa", "", "900", "600", "no","10","1","yes");
           return false;
       }
   </script>

<x:saveState value="#{sys_RemindResultBackingBean}" />
<h:form id="form134">
<h:inputHidden value="#{sys_RemindResultBackingBean.pageInit}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
            <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1127", "提醒信息列表")%>
			</f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
    <br>
    <h:panelGrid width="98%" columns="1" align="center" >
        <x:dataTable value="#{sys_RemindResultBackingBean.remBriefList2}"  id="setlist"
			rowIndexVar="index" var="briefList" width="95%"  headerClass="td_top"  styleClass="table03"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<f:facet name="header">
			  <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1127", "序号")%>
			 </f:verbatim>
				</f:facet>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column rendered="false">
				<h:outputText escape="false" value="#{briefList.remId}" />
			</h:column>
			<h:column>
				<f:facet name="header">
				     <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1128", "提醒列表")%>
			 </f:verbatim>
				</f:facet>
                <h:outputText value="#{briefList.remMsg}" ></h:outputText>
            </h:column>
            <h:column>
                <f:facet name="header">
                   <f:verbatim>
		                 <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
		               </f:verbatim>
                </f:facet>
                <h:commandButton value="查看详细信息" styleClass="button01" onclick="return showDetail('#{briefList.remId}','#{briefList.remMsg}')">
				</h:commandButton>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form134:setlist");
</script>



