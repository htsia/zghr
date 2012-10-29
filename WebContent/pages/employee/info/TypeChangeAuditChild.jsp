<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String backFlag = CommonFuns.filterNull(request.getParameter("backFlag"));
%>

    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type="+type, "aa", "", "1000", "600", "no","10","1","yes");
        }
    </script>

      <x:saveState value="#{emp_typeChangeBB}"></x:saveState>
      <h:form id="form1">
          <h:inputHidden value="#{emp_typeChangeBB.changingAudit}"></h:inputHidden>
          <h:inputHidden value="#{emp_typeChangeBB.superId}"></h:inputHidden>
          <h:inputHidden value="#{emp_typeChangeBB.type}"></h:inputHidden>
         <c:verbatim>
         <table width="98%" align="center" height=96%>
          <tr><td height=8 align="left">
         </c:verbatim>
                 <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1042","当前选择机构") %>:
                 </f:verbatim>
                  <h:outputText value="#{emp_typeChangeBB.superName}"></h:outputText>

                  <h:panelGroup>
                      <h:selectBooleanCheckbox value="#{emp_typeChangeBB.onlyAuditing}" ></h:selectBooleanCheckbox>
                         <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1042","仅显示待审批") %>
                 </f:verbatim>
                  </h:panelGroup>

                  <h:panelGroup>
                <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2401","时间") %>
                 </f:verbatim>
                      <h:inputText readonly="true" id="processDate" value="#{emp_typeChangeBB.processDate}"></h:inputText>
                      <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
                      <h:commandButton value="查询" styleClass="button01"></h:commandButton>
                      <h:commandButton value="全部" styleClass="button01" onclick="document.all('form1:processDate').value='';" ></h:commandButton>
                  </h:panelGroup>
          <c:verbatim>
          </td></tr>
         </c:verbatim>

          <c:verbatim>
          <tr><td align="right" height=8>
          </c:verbatim>
                              <f:verbatim>
                                 <%=LanguageSupport.getResource("COMM-1043|","记录数") %>:
                              </f:verbatim>
                               <h:outputText value="#{emp_typeChangeBB.pagevo.totalRecord}"></h:outputText>
                                <h:outputText value="  "></h:outputText>
                                   <f:verbatim>
                                 <%=LanguageSupport.getResource("RYGL-2381","页数") %>:
                              </f:verbatim>
                                <h:outputText value="#{emp_typeChangeBB.pagevo.totalPage}"></h:outputText>
                                <h:outputText value="  "></h:outputText>
                                   <f:verbatim>
                                 <%=LanguageSupport.getResource("COMM-1045","每页有") %>:
                              </f:verbatim>
                                <h:outputText value="#{emp_typeChangeBB.pagevo.pageSize}"></h:outputText>
                                <h:outputText value="  "></h:outputText>
                                   <f:verbatim>
                                 <%=LanguageSupport.getResource("COMM-1046","当前为第") %>:
                              </f:verbatim>
                                <h:outputText value="#{emp_typeChangeBB.pagevo.currentPage}"></h:outputText>
                                   <f:verbatim>
                                 <%=LanguageSupport.getResource("COMM-1047","页") %>:
                              </f:verbatim>
                                <h:commandButton value="首页" action="#{emp_typeChangeBB.auditfirst}" styleClass="button01"></h:commandButton>
                                <h:commandButton value="上页" action="#{emp_typeChangeBB.auditpre}" styleClass="button01"></h:commandButton>
                                <h:commandButton value="下页" action="#{emp_typeChangeBB.auditnext}" styleClass="button01"></h:commandButton>
                                <h:commandButton value="尾页" action="#{emp_typeChangeBB.auditlast}" styleClass="button01"></h:commandButton>
 <c:verbatim>
          </td></tr>

          <tr><td height=8></td></tr>
          <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
            <x:dataTable value="#{emp_typeChangeBB.personList}" var="list"  rowIndexVar="index" id="data"
                                   headerClass="td_top"    align="center"
                                   rowClasses="td_middle" styleClass="table03" width="95%" border="1">

             <h:column>
                  <c:facet name="header">
                    <f:verbatim>
                                 <%=LanguageSupport.getResource("YXGL-1026","操作") %>
                              </f:verbatim>
                  </c:facet>
                   <h:commandButton value="同意" styleClass="button01" action="#{emp_typeChangeBB.auditOK}" rendered="#{list.auditResult==null || list.auditResult==''}">
                        <x:updateActionListener property="#{emp_typeChangeBB.chgID}" value="#{list.chgID}"/>
                   </h:commandButton>
                   <h:commandButton value="不同意" styleClass="button01" action="#{emp_typeChangeBB.auditCancel}" rendered="#{list.auditResult==null || list.auditResult==''}">
                        <x:updateActionListener property="#{emp_typeChangeBB.chgID}" value="#{list.chgID}"/>
                   </h:commandButton>
             </h:column>

              <h:column>
                  <c:facet name="header">
                  <f:verbatim>
                                 <%=LanguageSupport.getResource("RYGL-2190","申请时间") %>
                              </f:verbatim>
                  </c:facet>
                  <h:outputText value="#{list.applyDate}"/>
              </h:column>

                <h:column>
                    <c:facet name="header">
                     <f:verbatim>
                                 <%=LanguageSupport.getResource("XTGL-1326","所在单位") %>
                              </f:verbatim>
                    </c:facet>
                    <h:outputText value="#{list.orgName}"/>
                </h:column>

              <h:column>
                  <c:facet name="header">
                   <f:verbatim>
                                 <%=LanguageSupport.getResource("MSG-0010","姓名") %>
                              </f:verbatim>
                  </c:facet>
                  <h:outputText value="#{list.persName}"/>
              </h:column>

          <h:column>
              <c:facet name="header">
               <f:verbatim>
                                 <%=LanguageSupport.getResource("RYGL-2306","原类别") %>
                              </f:verbatim>
              </c:facet>
              <h:outputText value="#{list.oldTypeDes}"/>
          </h:column>

          <h:column>
              <c:facet name="header">
               <f:verbatim>
                                 <%=LanguageSupport.getResource("RYGL-2402","新类别") %>
                              </f:verbatim>
              </c:facet>
              <h:outputText value="#{list.newTypeDes}"/>
          </h:column>


          <h:column>
              <c:facet name="header">
               <f:verbatim>
                                 <%=LanguageSupport.getResource("RYGL-2385","审批状态") %>
                              </f:verbatim>
              </c:facet>
              <h:outputText value="#{list.auditResultDes}"/>
          </h:column>

          </x:dataTable>
 <c:verbatim>
            </div>
          </td><tr>
        </table>
 </c:verbatim>

          
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>

<script type="text/javascript">
    interpret(document.forms(0));
    setDataTableOver("form1:data");
</script>
