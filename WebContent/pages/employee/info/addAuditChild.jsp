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

        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type="+type, "aa", "", "1000", "600", "no","10","1","yes");
        }
        function audit(){
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var perID = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            perID += form1.chk[i].value+",";   
                        }
                } else
                    perID = form1.chk.value;
                var url="/employee/info/ProcessAduit.jsf?perIds="+perID;

                window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:340px;center:center;resizable:no;status:no;scroll:yes;");
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
           return true;
        }
    </script>

      <x:saveState value="#{emp_personListBB}"></x:saveState>
      <h:form id="form1">
         <h:inputHidden value="#{emp_personListBB.checkingPerson_audit}"/>
         <h:inputHidden value="#{emp_personListBB.superId}"/>
         <h:inputHidden value="#{emp_personListBB.type}"/>

<f:verbatim>
         <table height="98%" width="100%">
          <tr>
            <td align="left" height=8>
 </f:verbatim>
              <h:outputText escape="false" value="<strong>当前单位:</strong>#{emp_personListBB.superName}"></h:outputText>
 <f:verbatim>
            </td>
         </tr>

         <tr>
            <td height=8 align="right">
</f:verbatim>
              <h:selectOneRadio value="#{emp_personListBB.auditStatus}" id="auditStatus" onclick="disPlayProcessBar();submit();" valueChangeListener="#{emp_personListBB.changeAuditStatus}">
                  <c:selectItem itemValue="00000" itemLabel="未审批"></c:selectItem>
                  <c:selectItem itemValue="00900" itemLabel="审批不通过"></c:selectItem>
                  <c:selectItem itemValue="00901" itemLabel="审批通过"></c:selectItem>
              </h:selectOneRadio>
            </td>
            <td>
              <h:outputText escape="false" value="<strong>输入姓名或员工编号：</strong>"></h:outputText> 
              <h:inputText id="name" value="#{emp_personListBB.name}"   size="10" styleClass="input"   />

              <h:outputText escape="false" value="<strong>输入时间：</strong>"></h:outputText>
              <h:inputText id="processDate" value="#{emp_personListBB.processDate}"   size="10" styleClass="input"   />
              <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate');"></h:commandButton>
              <h:commandButton value="查询" id="query" action="#{emp_personListBB.doQueryCheckAuditPerson}" onclick="return disPlayProcessBar();" styleClass="button01" />

             <h:commandButton styleClass="button01" onclick="return audit();" action="#{emp_personListBB.doQueryCheckAuditPerson}" value="审批"></h:commandButton>
             <h:commandButton styleClass="button01" type="button" onclick="doExport();" value="导出"></h:commandButton>
             <h:commandButton value="查看流程" id="showFlow" type="button" onclick="return showWF();" styleClass="button01" rendered="#{emp_personListBB.workFlow=='1'}"></h:commandButton>
<f:verbatim>
         </td></tr>

        <tr><td colspan="2">
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
