<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
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
<x:saveState value="#{empDchangeAuditMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{empDchangeAuditMgrBB.initEidt}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{empDchangeAuditMgrBB.itemId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height="10%">
            <td class="td_title"><img src="/images/tips.gif">
             <%=LanguageSupport.getResource("RYGL-0300", "人员管理 ")%>->
               <%=LanguageSupport.getResource("RYGL-2124", "见习转正审批 ")%>
            </td>
        </tr>
        <tr height=30>
            <td valign="top">
		</c:verbatim>
		<h:panelGrid width="100%" columns="1">
			<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
	    	 <h:outputText value="审批意见"/>
	            <h:selectOneMenu id="status" value="#{empDchangeAuditMgrBB.empTypeChangebo.auditResult2}">
	                <c:selectItem itemValue="1" itemLabel="同意"/>
	                <c:selectItem itemValue="0" itemLabel="不同意"/>
	            </h:selectOneMenu>
	
	              <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2024", " 原因")%>
	    	    </f:verbatim>
	            <h:inputTextarea value="#{empDchangeAuditMgrBB.empTypeChangebo.auditOption2}" rows="3" cols="60"/>
	
	              <f:verbatim>
	    	     <%=LanguageSupport.getResource("YXGL-1026", " 操作")%>
	    	    </f:verbatim>
	            <h:commandButton styleClass="button01" value="审批" action="#{empDchangeAuditMgrBB.audit2}" onclick="checkData()"/>
	    	</h:panelGrid>
    	    <h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
    	    	 <f:verbatim>
	    	     <%=LanguageSupport.getResource("XTGL-1055", " 当前人员类别")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
	    	    	 <h:inputText styleClass="input" id="OA001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empDchangeAuditMgrBB.empTypeChangebo.curType}"
                     alt="员工类别|0|s|50||"/>
                </h:panelGroup>
    	    	 <f:verbatim>
	    	     <%=LanguageSupport.getResource("XTGL-1055", " 当前人员类别")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="NA001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empDchangeAuditMgrBB.empTypeChangebo.passType}"
                     alt="员工类别|0|s|50||"/>
    	    	</h:panelGroup>
    	    	  <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2221", "当前岗位")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="oldPost" value="#{empDchangeAuditMgrBB.empTypeChangebo.curPost}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="岗位|1|s|50||"/>
    	    	</h:panelGroup>
    	    	 <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2222", "转正后岗位")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
	    	    	<h:inputText styleClass="input" id="newPost" value="#{empDchangeAuditMgrBB.empTypeChangebo.passPost}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="新岗位|1|s|50||"/>
                </h:panelGroup>
    	    	 <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2127", "当前岗位级别")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		<h:inputText styleClass="input" id="oldPostType" value="#{empDchangeAuditMgrBB.empTypeChangebo.curPostType}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="新岗位|1|s|50||"/>
    	    	</h:panelGroup>
    	       <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2126", "转正后岗位级别")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="newPostType" value="#{empDchangeAuditMgrBB.empTypeChangebo.passPostType}" dict="yes" dict_num="#{empDchangeAuditMgrBB.job}"  code=""
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
