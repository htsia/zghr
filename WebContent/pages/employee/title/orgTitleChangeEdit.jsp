<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function checkform() {
	return forsubmit(document.forms(0)); 	
}

function selectInfoItem() {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/wage/base/WageBaseItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        //debugger;
        document.all("form1:wageInfoItem").value = rs[0];
        return true;
    }
    return false;
}
function forCopyPersonItem(){
    reval=window.showModalDialog("/wage/set/SetWageSet.jsf?UnitID="+document.all('form1:unitId').value+"&SetID="+document.all('form1:setId').value, null, "dialogWidth:300px; dialogHeight:150px;center:center;resizable:yes;status:yes;scroll:yes;");
    if (reval != null && reval!="") {
        form1.all("form1:copySet").value = reval;
        return true;
    } else {
        return false;
    }

}
</script>
  
  <x:saveState value="#{empTitleChangeBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{empTitleChangeBB.initOrgEdit}"></h:inputHidden>
      <h:inputHidden value="#{empTitleChangeBB.copySet}" id="copySet"/>
      <h:inputHidden value="#{empTitleChangeBB.unitId}" id="unitId"/>
    <h:inputHidden value="#{empTitleChangeBB.setId}" id="setId"/>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="人员管理 -> 机构职称变动设定"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03" width="98%">
               <h:outputText value="机构名称"></h:outputText>
               <h:inputText value="#{empTitleChangeBB.orgchangebo.orgName}" readonly="true"></h:inputText>
               <h:outputText value="薪资变动相关指标项"></h:outputText>
			        <h:panelGrid width="98%" align="center">
			        <h:panelGrid width="98%" align="right">
			            <h:inputHidden id="wageInfoItem" value="#{empTitleChangeBB.wageInfoItem}"></h:inputHidden>
			            <h:panelGroup>
			               <h:commandButton value="增加"  action="#{empTitleChangeBB.addfield}" onclick="return selectInfoItem();" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			        </h:panelGrid>
			
			        <h:dataTable value="#{empTitleChangeBB.baseFields}" var="list" align="center"
			                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
			                     styleClass="table03" width="90%" >
			            <h:column>
			                <c:facet name="header"><h:outputText value="顺序"/></c:facet>
			                <h:outputText value="#{list.itemSequence}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header"><h:outputText value="信息集"/></c:facet>
			                <h:outputText value="#{list.setId}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header"><h:outputText value="信息项"/></c:facet>
			                <h:outputText value="#{list.itemName}"/>
			            </h:column>
			
			            <h:column>
			                <c:facet name="header"><h:outputText value="操作"/></c:facet>
			                 <h:commandButton styleClass="button01" value="删除" action="#{empTitleChangeBB.delfield}" onclick="checkform()">
			                     <x:updateActionListener property="#{empTitleChangeBB.wageInfoItem}" value="#{list.itemId}"/>
			                 </h:commandButton>
			                 <h:commandButton styleClass="button01" value="上移" action="#{empTitleChangeBB.movePre}" onclick="checkform()">
			                     <x:updateActionListener property="#{empTitleChangeBB.wageInfoItem}" value="#{list.itemId}"/>
			                 </h:commandButton>
			                 <h:commandButton styleClass="button01" value="下移" action="#{empTitleChangeBB.moveNext}" onclick="checkform()">
			                     <x:updateActionListener property="#{empTitleChangeBB.wageInfoItem}" value="#{list.itemId}" />
			                 </h:commandButton>
			            </h:column>

			        </h:dataTable>
			        </h:panelGrid>
             </h:panelGrid>
			<h:panelGrid align="right">
              <h:commandButton value="保存"  action="#{empTitleChangeBB.saveOrgTitleChangeBO}" styleClass="button01" onclick="checkform()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
 <script type="text/javascript">
    interpret(document.forms(0));
</script>
