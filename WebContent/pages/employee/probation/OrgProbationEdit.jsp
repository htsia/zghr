<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function checkform() {
	if(document.all("form1:A001054").value==""||document.all("form1:A001054").value==null){
		alert("ת������Ա�����Ϊ�գ�");
		return false;
	}
    if(document.all("form1:probation").value==""){
        alert("�����ڲ���Ϊ�գ�");
        return false;
    }
    if(document.all("form1:probation").value==""){
        alert("�����ڲ���Ϊ�գ�");
        return false;
    }
    if(isNaN(document.all("form1:probation").value)){
        alert("������ֻ�������֣�");
        return false;
    }

    return forsubmit(document.forms(0));
}

function selectInfoItem() {
	forsubmit(document.forms(0)); 
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/wage/base/FormulaInfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        //debugger;
        document.all("form1:infoItem").value = rs[0];
        return true;
    }
    return false;
}
function forCopyPersonItem(){
	forsubmit(document.forms(0)); 
    reval=window.showModalDialog("/wage/set/SetWageSet.jsf?UnitID="+document.all('form1:unitId').value+"&SetID="+document.all('form1:setId').value, null, "dialogWidth:300px; dialogHeight:150px;center:center;resizable:yes;status:yes;scroll:yes;");
    if (reval != null && reval!="") {
        form1.all("form1:copySet").value = reval;
        return true;
    } else {
        return false;
    }

}
</script>
  
  <x:saveState value="#{empprobastionmgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{empprobastionmgrBB.initEdit}"></h:inputHidden>
      <h:inputHidden value="#{empprobastionmgrBB.copySet}" id="copySet"/>
      <h:inputHidden value="#{empprobastionmgrBB.unitId}" id="unitId"/>
    <h:inputHidden value="#{empprobastionmgrBB.setId}" id="setId"/>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <f:verbatim>
               <%=LanguageSupport.getResource("RYGL-0300", "��Ա����")%>->
               <%=LanguageSupport.getResource("RYGL-2141", "����ת������")%>
              </f:verbatim>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03" width="98%">
               <f:verbatim>
                <%=LanguageSupport.getResource("JGGL-1073", "��������")%>
               </f:verbatim>
               <h:inputText value="#{empprobastionmgrBB.orgprobationbo.orgName}" readonly="true"></h:inputText>
			   <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2426", "������(��)")%>
               </f:verbatim>
               <h:inputText id="probation" value="#{empprobastionmgrBB.probation}"></h:inputText>
               <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2220", "ת������Ա���")%>
               </f:verbatim>
			   <h:panelGroup>
               <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empprobastionmgrBB.normailType}"
                     alt="Ա�����|0|s|50||"/>
               <h:commandButton styleClass="button_select" type="button" onclick="PopUpCodeDlgOneControl('form1:A001054')"></h:commandButton>
               </h:panelGroup>
                <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2143", "н�ʱ䶯���ָ����")%>
               </f:verbatim>
			        <h:panelGrid width="98%" align="center">
			        <h:panelGrid width="98%" align="right">
			            <h:inputHidden id="infoItem" value="#{empprobastionmgrBB.infoItem}"></h:inputHidden>
			            <h:panelGroup>
			               <h:commandButton value="����"  action="#{empprobastionmgrBB.addfield}" onclick="return selectInfoItem();" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			        </h:panelGrid>
			
			        <h:dataTable value="#{empprobastionmgrBB.baseFields}" var="list" align="center"
			                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
			                     styleClass="table03" width="90%" >
			            <h:column>
			                <c:facet name="header">
			                <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-1157", "˳�� ")%>
               </f:verbatim>
			                </c:facet>
			                <h:outputText value="#{list.itemSequence}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header">
			                <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2047", "��Ϣ�� ")%>
               </f:verbatim>
			                </c:facet>
			                <h:outputText value="#{list.setId}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header">
			                 <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2048", "��Ϣ�� ")%>
               </f:verbatim>
			                </c:facet>
			                <h:outputText value="#{list.itemName}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header">
			                  <f:verbatim>
                <%=LanguageSupport.getResource("YXGL-1026", "���� ")%>
               </f:verbatim>
			                </c:facet>
			                 <h:commandButton styleClass="button01" value="ɾ��" action="#{empprobastionmgrBB.delfield}" onclick="checkform()">
			                     <x:updateActionListener property="#{empprobastionmgrBB.infoItem}" value="#{list.itemId}"/>
			                 </h:commandButton>
			                 <h:commandButton styleClass="button01" value="����" action="#{empprobastionmgrBB.movePre}" onclick="checkform()">
			                     <x:updateActionListener property="#{empprobastionmgrBB.infoItem}" value="#{list.itemId}"/>
			                 </h:commandButton>
			                 <h:commandButton styleClass="button01" value="����" action="#{empprobastionmgrBB.moveNext}" onclick="checkform()">
			                     <x:updateActionListener property="#{empprobastionmgrBB.infoItem}" value="#{list.itemId}" />
			                 </h:commandButton>
			            </h:column>

			        </h:dataTable>
			        </h:panelGrid>
             </h:panelGrid>
			<h:panelGrid align="right">
              <h:commandButton value="����"  action="#{empprobastionmgrBB.saveOrgProbationBO}" styleClass="button01" onclick="return checkform();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
 <script type="text/javascript">
    interpret(document.forms(0));
</script>
