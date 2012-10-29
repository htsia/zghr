<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<x:saveState value="#{sys_bulletinbriefMoreBB}"/>
<h:form id="form1">
    <c:verbatim>
    <table height=98% width=98% align="center">
      <tr><td height=8>
 </c:verbatim>
              <h:panelGrid align="right" columns="1" width="100%">
        <h:panelGroup>
             <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1293","��ѡ��״̬")%> 
             </f:verbatim>
            <h:selectOneMenu value="#{sys_bulletinbriefMoreBB.status}" onchange="submit()" valueChangeListener="#{sys_bulletinbriefMoreBB.changeStatus}">
                <c:selectItem itemValue="-1" itemLabel="ȫ��"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="��Ч"></c:selectItem>
                <c:selectItem itemValue="0" itemLabel="ʧЧ"></c:selectItem>
            </h:selectOneMenu>
        </h:panelGroup>
    </h:panelGrid>
 <c:verbatim>
      </td></tr>

      <tr><td >
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
        <x:dataTable value="#{sys_bulletinbriefMoreBB.bulletinList2}" id="dateList"
        headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle_center">

        <h:column>
            <f:facet name="header">
                <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1294","������Ϣ")%> 
                </f:verbatim>
            </f:facet>
            <h:outputText value="#{briefList.blltnTopic}" ></h:outputText>
        </h:column>

        <h:column>
            <f:facet name="header">
               <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1090","��Чʱ��")%> 
                </f:verbatim>
            </f:facet>
            <h:outputText value="#{briefList.startDate}" ></h:outputText>
        </h:column>

        <h:column>
            <f:facet name="header">
               <h:panelGroup>
                    <h:graphicImage value="/images/common/new.gif"></h:graphicImage>
                 <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1091","��ʾʧЧʱ��")%> 
                </f:verbatim>
               </h:panelGroup>
            </f:facet>
            <h:outputText value="#{briefList.newEndDate}" ></h:outputText>
        </h:column>

        <h:column>
            <f:facet name="header">
                <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1092","ʧЧʱ��")%> 
                </f:verbatim>
            </f:facet>
            <h:outputText value="#{briefList.endDate}" ></h:outputText>
        </h:column>

        <h:column>
            <f:facet name="header">
              <f:verbatim>
                     <%=LanguageSupport.getResource("YXGL-1026","����")%> 
                </f:verbatim>
            </f:facet>

            <h:commandButton value="�鿴��ϸ��Ϣ" styleClass="button01" type="button" onclick="return doShowBulletin('#{briefList.blltnId}');">
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


