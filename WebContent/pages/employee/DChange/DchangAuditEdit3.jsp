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
             <%=LanguageSupport.getResource("RYGL-0300", "��Ա���� ")%>->
               <%=LanguageSupport.getResource("RYGL-2124", "��ϰת������ ")%>
            </td>
        </tr>
        <tr height=30>
            <td valign="top">
		</c:verbatim>
		<h:panelGrid width="100%" columns="1">
			<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
	    	 <h:outputText value="�������"/>
	            <h:selectOneMenu id="status" value="#{empDchangeAuditMgrBB.empTypeChangebo.auditResult2}">
	                <c:selectItem itemValue="1" itemLabel="ͬ��"/>
	                <c:selectItem itemValue="0" itemLabel="��ͬ��"/>
	            </h:selectOneMenu>
	
	              <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2024", " ԭ��")%>
	    	    </f:verbatim>
	            <h:inputTextarea value="#{empDchangeAuditMgrBB.empTypeChangebo.auditOption2}" rows="3" cols="60"/>
	
	              <f:verbatim>
	    	     <%=LanguageSupport.getResource("YXGL-1026", " ����")%>
	    	    </f:verbatim>
	            <h:commandButton styleClass="button01" value="����" action="#{empDchangeAuditMgrBB.audit2}" onclick="checkData()"/>
	    	</h:panelGrid>
    	    <h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
    	    	 <f:verbatim>
	    	     <%=LanguageSupport.getResource("XTGL-1055", " ��ǰ��Ա���")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
	    	    	 <h:inputText styleClass="input" id="OA001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empDchangeAuditMgrBB.empTypeChangebo.curType}"
                     alt="Ա�����|0|s|50||"/>
                </h:panelGroup>
    	    	 <f:verbatim>
	    	     <%=LanguageSupport.getResource("XTGL-1055", " ��ǰ��Ա���")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="NA001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empDchangeAuditMgrBB.empTypeChangebo.passType}"
                     alt="Ա�����|0|s|50||"/>
    	    	</h:panelGroup>
    	    	  <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2221", "��ǰ��λ")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="oldPost" value="#{empDchangeAuditMgrBB.empTypeChangebo.curPost}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="��λ|1|s|50||"/>
    	    	</h:panelGroup>
    	    	 <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2222", "ת�����λ")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
	    	    	<h:inputText styleClass="input" id="newPost" value="#{empDchangeAuditMgrBB.empTypeChangebo.passPost}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="�¸�λ|1|s|50||"/>
                </h:panelGroup>
    	    	 <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2127", "��ǰ��λ����")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		<h:inputText styleClass="input" id="oldPostType" value="#{empDchangeAuditMgrBB.empTypeChangebo.curPostType}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="�¸�λ|1|s|50||"/>
    	    	</h:panelGroup>
    	       <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2126", "ת�����λ����")%>
	    	    </f:verbatim>
    	    	<h:panelGroup>
    	    		 <h:inputText styleClass="input" id="newPostType" value="#{empDchangeAuditMgrBB.empTypeChangebo.passPostType}" dict="yes" dict_num="#{empDchangeAuditMgrBB.job}"  code=""
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
