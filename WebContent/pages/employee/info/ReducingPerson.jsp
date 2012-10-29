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
        function resumeAudit(pid){
            window.showModalDialog("/employee/info/ResumeReduceAudit.jsf?pID="+pid, null, "dialogWidth:550px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
    </script>

      <x:saveState value="#{emp_personListBB}"></x:saveState>
      <h:form id="form1">
<c:verbatim>
         <table height=96% width=98% align="center">
          <tr><td height=8>
</c:verbatim>
          <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
             <h:panelGroup>
                  <h:graphicImage value="/images/tips.gif" />
                  <f:verbatim>
                          <%=LanguageSupport.getResource("RYGL-2387","��Ա���� ������������Ա") %> 
                  </f:verbatim>
              </h:panelGroup>
              
              <h:panelGrid align="right" columns="2">
                  <h:panelGroup>
                  <h:outputText value="����״̬:"></h:outputText>
                  <h:selectOneMenu value="#{emp_personListBB.auditStatus}" onchange="disPlayProcessBar();document.all('form1:doQuery').click();">
                      <c:selectItem itemValue="" itemLabel="δ����"></c:selectItem>
                      <c:selectItem itemValue="0" itemLabel="������ͨ��"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="����ͨ��"></c:selectItem>
                  </h:selectOneMenu>
                  </h:panelGroup>

                  <h:panelGroup>
                      <f:verbatim>
	               <%=LanguageSupport.getResource("XTGL-1243","ʱ��") %>
	              </f:verbatim>
                      <h:inputText readonly="true" id="processDate" value="#{emp_personListBB.processDate}"></h:inputText>
                      <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
                      <h:commandButton value="��ѯ" styleClass="button01" id="doQuery" action="#{emp_personListBB.doQuery}"></h:commandButton>
                      <h:commandButton value="ȫ��" styleClass="button01" onclick="document.all('form1:processDate').value='';"  action="#{emp_personListBB.doQuery}"></h:commandButton>
                      <h:commandButton value="����" styleClass="button01" onclick="doExport();"  type="button"></h:commandButton>
                  </h:panelGroup>
              </h:panelGrid>
          </h:panelGrid>
<c:verbatim>
         </td></tr>

          <tr><td height=8>
</c:verbatim>
                   <f:verbatim>
	               <%=LanguageSupport.getResource("COMM-1043","��¼��") %>:
	              </f:verbatim>
                    <h:outputText value="#{emp_personListBB.pagevo.totalRecord}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                     <f:verbatim>
	               <%=LanguageSupport.getResource("COMM-1044","ҳ��") %>:
	              </f:verbatim>
                    <h:outputText value="#{emp_personListBB.pagevo.totalPage}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                       <f:verbatim>
	               <%=LanguageSupport.getResource("COMM-1045","ÿҳ��") %>:
	              </f:verbatim>
                    <h:outputText value="#{emp_personListBB.pagevo.pageSize}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                     <f:verbatim>
	               <%=LanguageSupport.getResource("COMM-1046","��ǰΪ��") %>:
	              </f:verbatim>
                    <h:outputText value="#{emp_personListBB.pagevo.currentPage}"></h:outputText>
                     <f:verbatim>
	               <%=LanguageSupport.getResource("COMM-1047","ҳ") %>
	              </f:verbatim>
                    <h:commandButton value="#{sys_buttonBB.btnTop}" action="#{emp_personListBB.first}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="#{sys_buttonBB.btnLast}" action="#{emp_personListBB.pre}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="#{sys_buttonBB.btnNext}" action="#{emp_personListBB.next}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="#{sys_buttonBB.btnBottom}" action="#{emp_personListBB.last}" styleClass="button01"></h:commandButton>
<c:verbatim>
          </td></tr>

          <tr>
              <td>
                  <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                      <x:dataTable value="#{emp_personListBB.reducingbos}" var="list"  rowIndexVar="index" id="data"
                                           headerClass="td_top tr_fixrow"
                                           columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                          <h:column>
                              <c:facet name="header">
                              <f:verbatim>
		               	 <%=LanguageSupport.getResource("YXGL-1035","���") %>
		               </f:verbatim>
                              </c:facet>
                              <h:outputText value="#{index+1}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header">
                                 <f:verbatim>
		               	 <%=LanguageSupport.getResource("RYGL-2190","����ʱ��") %>
		               </f:verbatim>
                              </c:facet>
                              <h:outputText value="#{list.applyDate}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header">
                                 <f:verbatim>
		               	 <%=LanguageSupport.getResource("RRYGL-1016","����") %>
		               </f:verbatim>
                              </c:facet>
                              <h:outputText value="#{list.persName}"/>
                          </h:column>

                        <h:column>
                          <c:facet name="header">
                             <f:verbatim>
		               	 <%=LanguageSupport.getResource("RYGL-2176","���") %>
		               </f:verbatim>
                          </c:facet>
                          <h:outputText value="#{list.degreeName}"/>
                        </h:column>

                        <h:column>
                          <c:facet name="header">
                             <f:verbatim>
		               	 <%=LanguageSupport.getResource("RYGL-2384","�������") %>
		               </f:verbatim>
                          </c:facet>
                          <h:outputText value="#{list.a016010des}"/>
                        </h:column>

                        <h:column>
                          <c:facet name="header">
                            <f:verbatim>
		               	 <%=LanguageSupport.getResource("RYGL-2298","��������") %>
		               </f:verbatim>
                          </c:facet>
                          <h:outputText value="#{list.a001054des}"/>
                        </h:column>

                        <h:column>
                          <c:facet name="header">
                             <f:verbatim>
		               	 <%=LanguageSupport.getResource("RYGL-2300","�����״̬") %>
		               </f:verbatim>
                          </c:facet>
                          <h:outputText value="#{list.a001725des}"/>
                        </h:column>

                          <h:column>
                            <c:facet name="header">
                             <f:verbatim>
                              ��ְԭ��
                             </f:verbatim>
                            </c:facet>
                            <h:outputText value="#{list.a016060des}"/>
                          </h:column>

                        <h:column>
                          <c:facet name="header">
                              <f:verbatim>
		               	 <%=LanguageSupport.getResource("RYGL-2385","����״̬") %>
		               </f:verbatim>
                          </c:facet>
                          <h:outputText value="#{list.statusDes}"/>
                        </h:column>

                          <h:column>
                            <c:facet name="header">
                         <f:verbatim>
                              ����˵��
                         </f:verbatim>
                            </c:facet>
                            <h:outputText value="#{list.auditOption}"/>
                          </h:column>

                        <h:column>
                            <c:facet name="header">
                                <f:verbatim>
		               	 <%=LanguageSupport.getResource("YXGL-1026","����") %>
		               </f:verbatim>
                            </c:facet>
                            <h:commandButton value="��������" styleClass="button01" rendered="#{list.auditResult=='0'}" onclick="return resumeAudit('#{list.itemID}');"></h:commandButton>
                            <h:commandButton value="�鿴����" id="showFlow" type="button" onclick="return showWorkFlowLogByLinkID('#{list.itemID}');" styleClass="button01" rendered="#{emp_personListBB.reduceWorkFlow=='1'}"></h:commandButton>
                        </h:column>
                  </x:dataTable>
<c:verbatim>
                  </div>
              </td>
          </tr>
        </table>
</c:verbatim>
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>
<c:verbatim>
<script type="text/javascript">
    interpret(document.forms(0));
    setDataTableOver("form1:data");
</script>
</c:verbatim>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
