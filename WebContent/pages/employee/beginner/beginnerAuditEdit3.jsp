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
               <%=LanguageSupport.getResource("RYGL-0300","��Ա���� ")%> -> 
               <%=LanguageSupport.getResource("RYGL-2140","ת������")%>       
             </td>
        </tr>
        <tr height=30>
            <td valign="top">
		</c:verbatim>
		<h:panelGrid width="100%" columns="1">
			<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
	    	   <f:verbatim>
				 	<%=LanguageSupport.getResource( "RYGL-2023", "�������")%>  
	           </f:verbatim>
	            <h:selectOneMenu id="status" value="#{empbeginnerAuditMgrBB.beginnerbo.auditResult2}">
	                <c:selectItem itemValue="1" itemLabel="ͬ��"/>
	                <c:selectItem itemValue="0" itemLabel="��ͬ��"/>
	            </h:selectOneMenu>
	
	            <f:verbatim>
	                  <%=LanguageSupport.getResource("RYGL-2024","ԭ��")%>  
	            </f:verbatim>
	            <h:inputTextarea value="#{empbeginnerAuditMgrBB.beginnerbo.auditOption2}" rows="3" cols="60"/>
	
	            <f:verbatim>
	                  <%=LanguageSupport.getResource("YXGL-1026","����")%>  
	            </f:verbatim>
	            <h:commandButton styleClass="button01" value="����" action="#{empbeginnerAuditMgrBB.audit2}" onclick="checkData()"/>
	    	</h:panelGrid>
    	    <h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
    	    	<f:verbatim>
	                  <%=LanguageSupport.getResource("RYGL-2125","ԭ��λ����")%>  
	            </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="oldJob" value="#{empbeginnerAuditMgrBB.beginnerbo.curPost}" dict="yes" dict_num="#{empbeginnerAuditMgrBB.job}"  code=""
                            readonly="true"    alt="��ְ��|1|s|50||"/>
    	    	</h:panelGroup>
    	    	<f:verbatim>
	                  <%=LanguageSupport.getResource("RYGL-2126","ת�����λ����")%>  
	            </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="newJob" value="#{empbeginnerAuditMgrBB.beginnerbo.passPost}" dict="yes" dict_num="#{empbeginnerAuditMgrBB.job}"  code=""
                            readonly="true"    alt="��ְ��|1|s|50||"/>
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
