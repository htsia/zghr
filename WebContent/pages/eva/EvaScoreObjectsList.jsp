<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
  function setScore(id){
     window.showModalDialog("/eva/InputScore.jsf?objectID="+id, null, "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:yes;scroll:yes;");
     return false;
  }
</script>

<x:saveState value="#{eva_objectBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_objectBB.pageInit}"/>
    <h:inputHidden id="orgId" value="#{eva_objectBB.orgId}"/>
    <h:inputHidden id="personType" value="#{eva_objectBB.personType}"/>
    <h:inputHidden id="personStr" value=""/>
    <h:inputHidden id="templateID" value=""/>
    <h:inputHidden id="planID" value="#{eva_objectBB.planID}"></h:inputHidden>
    <f:verbatim>
    <table width="97%" height="98%" cellpadding="0" align="center"  cellspacing="0" border="0" >
        <tr><td height=8>
</f:verbatim>
            <h:panelGrid columns="1" width="100%" cellpadding="0" align="right" border="0" >
                <h:outputText value="��ǰ��Ա���:#{eva_objectBB.personTypeDes}"></h:outputText>

                <h:panelGrid columns="3">
                   <h:panelGroup>
                        <h:outputText value="������Ա�����"></h:outputText>
                        <h:inputText id="condiValue" styleClass="input" value="#{eva_objectBB.condiValue}" size="20"></h:inputText>
                        <h:commandButton id="btnSearch" value="�� ѯ"  styleClass="button01" action="#{eva_objectBB.doQuery}"/>
                    </h:panelGroup>
                    <h:panelGroup>
                        <h:commandButton value="ɾ��"  styleClass="button01"/>
                    </h:panelGroup>
                </h:panelGrid>

                <h:panelGrid align="right" styleClass="locked_top">
                    <h:panelGroup>
                        <h:outputText value="��#{eva_objectBB.pagevo.totalPage}ҳ"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="ÿҳ��#{eva_objectBB.pagevo.pageSize}"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="��ǰΪ��#{eva_objectBB.pagevo.currentPage}ҳ"></h:outputText>
                        <h:commandButton value="��ҳ" action="#{eva_objectBB.first}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="��ҳ" action="#{eva_objectBB.pre}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="��ҳ" action="#{eva_objectBB.next}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="βҳ" action="#{eva_objectBB.last}" styleClass="button01"></h:commandButton>
                    </h:panelGroup>
                </h:panelGrid>

            </h:panelGrid>
<f:verbatim>
        </td></tr>

        <tr><td>
         <div style='width:100%;height:100%;overflow:auto' id=datatable>    
</f:verbatim>
              <h:dataTable value="#{eva_objectBB.personList}" var="list" width="100%" id="dateList"
                    styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.objectID}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.personName}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.orgid}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.deptid}"/>
                </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="����ģ��"/>
                      </f:facet>
                      <h:outputText escape="false" value="#{list.templatename}"/>
                  </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="����"/>
                      </f:facet>
                      <h:commandButton value="���" onclick="setScore('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
                  </h:column>

            </h:dataTable>
<f:verbatim>
         </div>
        </td></tr>
    </table>
</f:verbatim>
<script type="text/javascript">
 
 </script>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
