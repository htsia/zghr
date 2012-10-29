<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function checkData(){
		return forsubmit(document.forms(0))
	}
</script>	
<x:saveState value="#{empbeginnerAuditMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{empbeginnerAuditMgrBB.initEidt}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{empbeginnerAuditMgrBB.itemId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height="10%">
            <td class="td_title"><img src="/images/tips.gif"> 
               <%=LanguageSupport.getResource("RYGL-0300","人员管理 ")%> -> 
               <%=LanguageSupport.getResource("RYGL-2140","转岗审批")%>       
             </td>
        </tr>
        <tr height=30>
            <td valign="top">
		</c:verbatim>
		<h:panelGrid width="100%" columns="1">
			<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
	    	   <f:verbatim>
				 	<%=LanguageSupport.getResource( "RYGL-2023", "审批意见")%>  
	           </f:verbatim>
	            <h:selectOneMenu id="status" value="#{empbeginnerAuditMgrBB.beginnerbo.auditResult2}">
	                <c:selectItem itemValue="1" itemLabel="同意"/>
	                <c:selectItem itemValue="0" itemLabel="不同意"/>
	            </h:selectOneMenu>
	
	            <f:verbatim>
	                  <%=LanguageSupport.getResource("RYGL-2024","原因")%>  
	            </f:verbatim>
	            <h:inputTextarea value="#{empbeginnerAuditMgrBB.beginnerbo.auditOption2}" rows="3" cols="60"/>
	
	            <f:verbatim>
	                  <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
	            </f:verbatim>
	            <h:commandButton styleClass="button01" value="审批" action="#{empbeginnerAuditMgrBB.audit2}" onclick="checkData()"/>
	    	</h:panelGrid>
    	    <h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
    	    	<f:verbatim>
	                  <%=LanguageSupport.getResource("RYGL-2125","原岗位级别")%>  
	            </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="oldJob" value="#{empbeginnerAuditMgrBB.beginnerbo.curPost}" dict="yes" dict_num="#{empbeginnerAuditMgrBB.job}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
    	    	</h:panelGroup>
    	    	<f:verbatim>
	                  <%=LanguageSupport.getResource("RYGL-2126","转正后岗位级别")%>  
	            </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="newJob" value="#{empbeginnerAuditMgrBB.beginnerbo.passPost}" dict="yes" dict_num="#{empbeginnerAuditMgrBB.job}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
    	    	</h:panelGroup>
    	    </h:panelGrid>
    	</h:panelGrid>
    	
    <c:verbatim>
			</td>
        </tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
