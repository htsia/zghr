<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String backFlag = CommonFuns.filterNull(request.getParameter("backFlag"));
%>
    <script type="text/javascript">
        <%out.println("   var allCount="+Constants.COMMON_PAGE_SIZE);%>
        function batchAudit(){
            if (checkMutilSelect(form1.selectItem)) {
                count = form1.selectItem.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.selectItem[i].checked) {
                            str += form1.selectItem[i].value.replace("#","~") + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("���ֻ��ѡ��"+allCount+"����Ա");
                        return false;
                    }
                } else
                    str = form1.selectItem.value.replace("#","~");
                window.showModalDialog("/employee/info/doBatchReduceAudit.jsf?pIDs="+str, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
                return false;
            }
            else{
                alert("��ѡ��Ҫ��������Ա!");
                return false;
            }
        }
        function doReduceAudit(pid){
            window.showModalDialog("/employee/info/doReduceAudit.jsf?pID="+pid, null, "dialogWidth:500px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type="+type, "aa", "", "1000", "600", "no","10","1","yes");
        }
    </script>

      <x:saveState value="#{emp_personListBB}"></x:saveState>
      <h:form id="form1">
          <h:inputHidden value="#{emp_personListBB.initReduceAudit}"></h:inputHidden>
          <h:inputHidden value="#{emp_personListBB.superId}"></h:inputHidden>
          <h:inputHidden value="#{emp_personListBB.type}"></h:inputHidden>
          <c:verbatim>
          <table width="100%" height=98% align="center">
          <tr><td height=8 align="left">
               <strong><%=LanguageSupport.getResource("RYGL-2382","��ǰ����") %>:</strong>
          </c:verbatim>
              <h:outputText value="#{emp_personListBB.superName}"></h:outputText>
          <c:verbatim>
          </td>
          </tr>

          <tr>
           <td height=8>
          </c:verbatim>
                  <h:outputText value="����״̬:"></h:outputText>
                  <h:selectOneMenu value="#{emp_personListBB.auditStatus}" onchange="disPlayProcessBar();document.all('form1:doauditQuery').click();">
                      <c:selectItem itemValue="" itemLabel="δ����"></c:selectItem>
                      <c:selectItem itemValue="0" itemLabel="������ͨ��"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="����ͨ��"></c:selectItem>
                  </h:selectOneMenu>

              <h:outputText value="����������Ա����ţ�"></h:outputText>
              <h:inputText id="name" value="#{emp_personListBB.name}"
                              size="10" styleClass="input"   />

              <h:panelGroup>
                  <f:verbatim>
	               <%=LanguageSupport.getResource("XTGL-1243","ʱ��") %>
	              </f:verbatim>
                  <h:inputText readonly="true" id="processDate" value="#{emp_personListBB.processDate}"></h:inputText>
                  <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
                  <h:commandButton value="��ѯ" id="doauditQuery" styleClass="button01" action="#{emp_personListBB.doauditQuery}"></h:commandButton>
                  <h:commandButton value="ȫ��" styleClass="button01" onclick="document.all('form1:processDate').value='';" ></h:commandButton>
                  <h:commandButton value="��������" styleClass="button01"  onclick="return batchAudit();"></h:commandButton>
                  <h:commandButton value="����Excel" rendered="#{emp_personListBB.reducebos!=null}" action="#{emp_personListBB.downloadFile}" styleClass="button01"/>
              </h:panelGroup>
          <c:verbatim>
          </td></tr>

          <tr><td align="right" height=8>
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
	               <%=LanguageSupport.getResource("COMM-1045","ÿҳ��") %>
	              </f:verbatim>
                    
                    <h:outputText value="#{emp_personListBB.pagevo.pageSize}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                    <f:verbatim>
	               <%=LanguageSupport.getResource("COMM-1046","��ǰΪ��") %>
	              </f:verbatim>
                    <h:outputText value="#{emp_personListBB.pagevo.currentPage}"></h:outputText>
                    <f:verbatim>
	               <%=LanguageSupport.getResource("COMM-1047","ҳ") %>
	              </f:verbatim>
                    <h:commandButton value="��ҳ" action="#{emp_personListBB.auditfirst}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="��ҳ" action="#{emp_personListBB.auditpre}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="��ҳ" action="#{emp_personListBB.auditnext}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="βҳ" action="#{emp_personListBB.auditlast}" styleClass="button01"></h:commandButton>
          <c:verbatim>
          </td></tr>

          <tr><td>
             <div style='width:100%;height:100%;overflow:auto' id=datatable>
         </c:verbatim>
                 <x:dataTable value="#{emp_personListBB.reducebos}" var="list"  rowIndexVar="index" id="data"
                                   headerClass="td_top tr_fixrow"
                                   columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                  <h:column>
                      <c:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox" name="all" onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                      </c:facet>

                      <f:verbatim escape="false">
                          <input type="checkbox" name="selectItem" value="</f:verbatim>
                          <h:outputText value="#{list.persID}"/>
                          <f:verbatim escape="false">"/>
                      </f:verbatim>
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
		               	 <%=LanguageSupport.getResource("RYGL-2383","������λ") %>
		               </f:verbatim>
                      </c:facet>
                      <h:outputText value="#{list.orgName}"/>
                  </h:column>

                  <h:column>
                      <c:facet name="header">
                        <f:verbatim>
		               	 <%=LanguageSupport.getResource("RYGL-1016","����") %>
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
		               	 <%=LanguageSupport.getResource("RYGL-2385","����״̬") %>
		               </f:verbatim>
                      </c:facet>
                      <h:outputText value="#{list.auditResultdes}"/>
                  </h:column>

                  <h:column>
                             <c:facet name="header">
                               <f:verbatim>
		               	 <%=LanguageSupport.getResource("YXGL-1026","����") %>
		               </f:verbatim>
                             </c:facet>
                             <h:commandButton value="����" styleClass="button01" rendered="#{list.auditResult==null || list.auditResult==''}" onclick="doReduceAudit('#{list.itemID}');" action="#{emp_personListBB.doauditQuery}"></h:commandButton>
                             <h:commandButton value="�鿴����" id="showFlow" type="button" onclick="return showWorkFlowLogByLinkID('#{list.itemID}');" styleClass="button01" rendered="#{emp_personListBB.reduceWorkFlow=='1'}"></h:commandButton>
                    </h:column>
               </x:dataTable>
<c:verbatim>
             </div>
          </td></tr>
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
