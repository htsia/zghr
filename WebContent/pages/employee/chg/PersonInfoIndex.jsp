<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function doReceive(cont,wageset,chgId) {
         if (cont=="δ���"){
             alert("ԭ��λ��ͬδ��������ܽ��գ�");
             return false;
         }
         <%
         if ("1".equals(Constants.EMP_CHANGE_CHECKWAGESET)){
             out.println("  if (wageset!='���˳�ԭ��λ����'){");
             out.println("     alert('δ����ԭ�������ף����ܽ��գ�');");
             out.println("     return false;");
             out.println("  }");
         }
         %>
         var ret=window.showModalDialog("/employee/chg/Receive.jsf?chgId="+chgId, null, "dialogWidth:730px; dialogHeight:450px;center:center;resizable:no;status:no;");
          return true;
    }
</script>

<x:saveState value="#{emp_PersonChgListBB}"/>
<h:form id="form1">
    <h:inputHidden id="Receive" value="#{emp_PersonChgListBB.receive}"/>
    <table height=98% width=98% >
    <tr><td height=8>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-2179", " �������")%>->
                  <%=LanguageSupport.getResource("RYGL-2212", " ��������")%>
             </f:verbatim>
            </h:panelGroup>
        </h:panelGrid>
     </td></tr>

    <tr><td height=8>
        <h:panelGrid columns="2" width="99%" align="center">
           <h:panelGroup>
                <c:verbatim>&nbsp;&nbsp;</c:verbatim>
                <h:selectBooleanCheckbox value="#{emp_PersonChgListBB.onlyNotApprove}" id="selectNotApprove" onclick="submit()" valueChangeListener="#{emp_PersonChgListBB.changeReceive}" />  <h:outputText value="����ʾ������"/>
           </h:panelGroup>
            <h:panelGroup>
                 <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-2190", "����ʱ��")%>
                </f:verbatim>
                <h:outputText value="����ʱ��"></h:outputText>
                <h:inputText readonly="true" id="processDate" value="#{emp_PersonChgListBB.processDate}"></h:inputText>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
                <h:commandButton value="��ѯ" styleClass="button01" action="#{emp_PersonChgListBB.getReceive}"></h:commandButton>
                <h:commandButton value="ȫ��" styleClass="button01" onclick="document.all('form1:processDate').value='';" action="#{emp_PersonChgListBB.getReceive}"></h:commandButton>
            </h:panelGroup>

       </h:panelGrid>
     </td></tr>

    <tr><td>
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
        <h:dataTable value="#{emp_PersonChgListBB.receivePerson}" var="list" align="center"    id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="100%" >
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="����"  styleClass="button01" type="button" rendered="#{list.managerOpinion=='1' && list.letterNo!='' && list.letterNo!=null && list.applyStatus!='4'}" onclick="return doReceive('#{list.cont_old_end}','#{list.oldOrgWageSet}','#{list.chgId}');"></h:commandButton>
            </h:column>

            <h:column>
                <c:facet name="header">
                <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-2213", "������")%>
                </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.letterNo}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
               <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1042", "Ա�����")%>
                </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
                  <%=LanguageSupport.getResource("MSG-0010", "����")%>
                </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
                      <%=LanguageSupport.getResource("RYGL-2146", "ԭ��λ")%>
                </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.fromOrgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2175", "������λ")%>
                </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.toOrgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2165", "ԭ��λ���")%>
                </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.fromOpinion}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                    <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2172", "ԭ��λ����ԭ��")%>
                    </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.fromReason}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                   <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2172", "ԭ��λ����ʱ��")%>
                    </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.fromDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                    <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2170", "ԭ��λ��ͬ���")%>
                    </f:verbatim>
                </c:facet>
                <h:outputText escape="false" value="<font color=red>#{list.cont_old_end}</font>"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                      <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2191", "ԭ��λ�������")%>
                      </f:verbatim>
                </c:facet>
                <h:outputText  escape="false" value="<font color=red>#{list.oldOrgWageSet}</font>"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                     <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2169", "���뵥λ���")%>
                      </f:verbatim>
                </c:facet>
            <h:outputText value="#{list.toOpinion}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                     <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2168", "���뵥λ����ԭ��")%>
                      </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.toReason}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                       <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2167", "���뵥λ����ʱ��")%>
                      </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.toDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                      <f:verbatim>
                       <%=LanguageSupport.getResource("RRYGL-2214", "���ܲ������")%>
                      </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.managerOpinionDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                       <f:verbatim>
                       <%=LanguageSupport.getResource("RRYGL-2151", "����״̬")%>
                      </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.applyStatusDes}"/>
            </h:column>

        </h:dataTable>
    </div>
    </td></tr>
    </table>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>