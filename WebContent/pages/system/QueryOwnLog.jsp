<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<x:saveState value="#{sys_SysLogOperBackingBean}" />
<h:form id="form1">
<c:verbatim>
<table width=98% height=98% align="center" cellspanning=0 cellspacing=0>
    <tr>
        <td class=td_title height=8>
</c:verbatim>
            <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
             	 <%=LanguageSupport.getResource("XTGL-1249", "��½��־��ѯ")%>
             </f:verbatim>
<c:verbatim>
        </td>
        <td align="right" class=td_title height=8>
 </c:verbatim>
            <h:inputText styleClass="input" id="startDate" readonly="true" value="#{sys_SysLogOperBackingBean.dateFrom}"
                          alt="��ʼ����|1|d|50||"/>
                <h:commandButton styleClass="button_select" type="button"  onclick="PopUpCalendarDialog('form1:startDate')" />
                 <f:verbatim>
             	 <%=LanguageSupport.getResource("XTGL-1242", "��")%>
             </f:verbatim>
                 <h:inputText styleClass="input" id="endDate" readonly="true" value="#{sys_SysLogOperBackingBean.dateTo}"
                          alt="��������|1|d|50||"/>
                <h:commandButton styleClass="button_select" type="button"  onclick="PopUpCalendarDialog('form1:endDate')" />

            <h:commandButton id="qry" value="�� ѯ" onclick="return forsubmit(document.forms(0))" action="#{sys_SysLogOperBackingBean.queryLoginLog}" styleClass="button01" />
            <h:commandButton value="�� ��" action="#{sys_SysLogOperBackingBean.exportSysLog}" styleClass="button01" />
<c:verbatim>
        </td>
    </tr>

    <tr>
        <td height=8 align="right" align="right" colspan=2>
 </c:verbatim>
               <f:verbatim>
                     <%=LanguageSupport.getResource("COMM-1043", "��¼��")%>:
                </f:verbatim>
               <h:outputText value="#{sys_SysLogOperBackingBean.pagevo.totalRecord}"></h:outputText>
               <h:outputText value="  "></h:outputText>
               <f:verbatim>
                   <%=LanguageSupport.getResource("COMM-1044", "ҳ��")%>:
                </f:verbatim>
               <h:outputText value="#{sys_SysLogOperBackingBean.pagevo.totalPage}"></h:outputText>
               <h:outputText value="  "></h:outputText>
               <f:verbatim>
                   <%=LanguageSupport.getResource("COMM-1045", "ÿҳ��")%>:
               </f:verbatim>
               <h:outputText value="#{sys_SysLogOperBackingBean.pagevo.pageSize}"></h:outputText>
               <h:outputText value="  "></h:outputText>
               <f:verbatim>
                       <%=LanguageSupport.getResource("COMM-1046", "��ǰΪ��")%>:
               </f:verbatim>
               <h:outputText value="#{sys_SysLogOperBackingBean.pagevo.currentPage}"></h:outputText>
                <f:verbatim>
                         <%=LanguageSupport.getResource("COMM-1047", "ҳ")%>:
               </f:verbatim>
               <h:commandButton value="��ҳ" action="#{sys_SysLogOperBackingBean.loginfirst}" styleClass="button01"></h:commandButton>
               <h:commandButton value="��ҳ" action="#{sys_SysLogOperBackingBean.loginpre}" styleClass="button01"></h:commandButton>
               <h:commandButton value="��ҳ" action="#{sys_SysLogOperBackingBean.loginnext}" styleClass="button01"></h:commandButton>
               <h:commandButton value="βҳ" action="#{sys_SysLogOperBackingBean.loginlast}" styleClass="button01"></h:commandButton>
<c:verbatim>
        </td>
    </tr>

   <tr><td colspan=2>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
       <x:dataTable border="0" cellpadding="0" cellspacing="0" width="100%"
                    headerClass="td_top tr_fixrow" columnClasses="td_middle" styleClass="table03" var="loglist" rowIndexVar="index" align="left" value="#{sys_SysLogOperBackingBean.logList}">
           <h:column>
               <f:facet name="header">
                  <f:verbatim>
                         <%=LanguageSupport.getResource("XTGL-1099", "���")%>:
                  </f:verbatim>
               </f:facet>
               <h:outputText value="#{index+1}" />
           </h:column>

           <h:column>
               <f:facet name="header">
                  <f:verbatim>
                         <%=LanguageSupport.getResource("YXGL-1031", "��½ʱ��")%>:
                  </f:verbatim>
               </f:facet>
               <h:outputText value="#{loglist.timestr}" />
           </h:column>

           <h:column>
               <f:facet name="header">
                  <f:verbatim>
                         <%=LanguageSupport.getResource("XTGL-1250", "��½������")%>:
                  </f:verbatim>
               </f:facet>
               <h:outputText value="#{loglist.hostName}" />
           </h:column>

            <h:column>
               <f:facet name="header">
                   <f:verbatim>
                         <%=LanguageSupport.getResource("XTGL-1251", "��½IP")%>:
                  </f:verbatim>
               </f:facet>
               <h:outputText value="#{loglist.ip}" />
           </h:column>
       </x:dataTable>
<c:verbatim>
       </div>
    </td></tr>

 </table>
</c:verbatim>    
</h:form>