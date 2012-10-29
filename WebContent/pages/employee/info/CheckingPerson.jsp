<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String backFlag = CommonFuns.filterNull(request.getParameter("backFlag"));
%>

    <script type="text/javascript">
        function forView(form, id, type) {
            forModifyPersonDetail(id);
        }
        function reApply(){
            var ids=getAllSelectValue(form1.chk,",");
            if (ids==""){
                alert("请选择人员！");
                return false;
            }
            else{
               window.showModalDialog("/employee/info/reApplyProcess.jsf?ids="+ids, null, "dialogWidth:300px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:no;");
               return true;
            }
        }
        function showWF(){
            var ID=getFirstSelectValue(form1.chk);
            if (ID!=null && ID!=""){
               showWorkFlowLogByLinkID(ID);
            }
            else{
                alert("请选择人员!");
            }
            return false;
        }
    </script>

      <x:saveState value="#{emp_personListBB}"></x:saveState>
      <h:form id="form1">
         <h:inputHidden value="#{emp_personListBB.checkingPerson}"/>
<f:verbatim>
         <table height=96% width=100%>
          <tr><td height=8>
</f:verbatim>
            <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
             <h:panelGroup>
                  <h:graphicImage value="/images/tips.gif" />
                   <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2280","待审批入库人员")%>
                   </f:verbatim>
              </h:panelGroup>
              
              <h:panelGrid align="right" columns="3">
                  <f:verbatim>
                  <font color=red><%=LanguageSupport.getResource("RYGL-2281","注意:非法数据可以由审批人删除")%></font>
                  </f:verbatim>

                  <h:panelGroup>
                      <h:outputText escape="false" value="<strong>审批状态:</strong>"></h:outputText>
                      <h:selectOneMenu value="#{emp_personListBB.auditStatus}" onchange="disPlayProcessBar();submit();">
                          <c:selectItem itemValue="" itemLabel="未审批"></c:selectItem>
                          <c:selectItem itemValue="00900" itemLabel="审批不通过"></c:selectItem>
                          <c:selectItem itemValue="00901" itemLabel="审批通过"></c:selectItem>
                      </h:selectOneMenu>
                  </h:panelGroup>

                  <h:panelGroup>
                       <f:verbatim>
                        <%=LanguageSupport.getResource("RYGL-2282","增员时间")%>
                      </f:verbatim>
                      <h:inputText readonly="true" id="processDate" value="#{emp_personListBB.processDate}"></h:inputText>
                      <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
                      <h:commandButton value="查询" styleClass="button01"></h:commandButton>
                      <h:commandButton value="全部" styleClass="button01" onclick="document.all('form1:processDate').value='';" ></h:commandButton>
                      <h:commandButton value="导出" styleClass="button01" onclick="doExport();"  type="button"></h:commandButton>
                      <h:outputText escape="false" value="&nbsp;&nbsp;"></h:outputText>
                      <h:commandButton value="查看流程" id="showFlow" type="button" onclick="return showWF();" styleClass="button01" rendered="#{emp_personListBB.workFlow=='1' || emp_personListBB.workFlow=='2'}"></h:commandButton>
                      <h:commandButton value="重新提交" id="reApply"  onclick="return reApply();" styleClass="button01" ></h:commandButton>
                  </h:panelGroup>
              </h:panelGrid>
          </h:panelGrid>
<f:verbatim>
         </td></tr>

          <tr><td>
            <jsp:include page="../../common/activepage/ActiveList.jsp">
                <jsp:param name="hasOperSign" value="true"/>
                <jsp:param name="operSignType" value="checkbox"/>
                <jsp:param name="hasEdit" value="true"/>
                <jsp:param name="isEditList" value="false"/>
                <jsp:param name="isCheckRight" value="true"/>
                <jsp:param name="isForward" value="true"/>
                <jsp:param name="isRow" value="true"/>
                <jsp:param name="rowFuncName" value="forView"/>
                <jsp:param name="isPage" value="true"/>
            </jsp:include>
          </td></tr>
        </table>
</f:verbatim>
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>

<script type="text/javascript">
    interpret(document.forms(0));
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
