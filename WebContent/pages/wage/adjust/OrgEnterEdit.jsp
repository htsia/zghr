<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function selectInfoItem() {
	forsubmit(document.forms(0)); 
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/wage/base/WageBaseItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
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
  
  <x:saveState value="#{wage_setOrgEnterBB}" />
  <h:form id="form1">
      <h:inputHidden value="#{wage_setOrgEnterBB.pageInit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" /><h:outputText value="入职关联项目"></h:outputText>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
			        <h:panelGrid width="98%" align="right">
			            <h:inputHidden id="infoItem" value="#{wage_setOrgEnterBB.infoItem}"></h:inputHidden>
			            <h:panelGroup>
			               <h:commandButton value="增加"  action="#{wage_setOrgEnterBB.addfield}" onclick="return selectInfoItem();" styleClass="button01"></h:commandButton>
                           <h:commandButton value="保存"  action="#{wage_setOrgEnterBB.save}" styleClass="button01" />
                        </h:panelGroup>
			        </h:panelGrid>
			
			        <h:dataTable value="#{wage_setOrgEnterBB.baseFields}" var="list" align="center"
			                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
			                     styleClass="table03" width="90%" >
			            <h:column>
			                <c:facet name="header">
			                <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-1157", "顺序")%>
               </f:verbatim>
			                </c:facet>
			                <h:outputText value="#{list.itemSequence}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header">
			                <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2047", "信息集")%>
               </f:verbatim>
			                </c:facet>
			                <h:outputText value="#{list.setId}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header">
			                 <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2048", "信息项")%>
               </f:verbatim>
			                </c:facet>
			                <h:outputText value="#{list.itemName}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header">
			                  <f:verbatim>
                <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
               </f:verbatim>
			                </c:facet>
			                 <h:commandButton styleClass="button01" value="删除" action="#{wage_setOrgEnterBB.delfield}" >
			                     <x:updateActionListener property="#{wage_setOrgEnterBB.infoItem}" value="#{list.itemId}"/>
			                 </h:commandButton>
			                 <h:commandButton styleClass="button01" value="上移" action="#{wage_setOrgEnterBB.movePre}" >
			                     <x:updateActionListener property="#{wage_setOrgEnterBB.infoItem}" value="#{list.itemId}"/>
			                 </h:commandButton>
			                 <h:commandButton styleClass="button01" value="下移" action="#{wage_setOrgEnterBB.moveNext}" >
			                     <x:updateActionListener property="#{wage_setOrgEnterBB.infoItem}" value="#{list.itemId}" />
			                 </h:commandButton>
			            </h:column>

			        </h:dataTable>

      </h:panelGrid>
  </h:form>
