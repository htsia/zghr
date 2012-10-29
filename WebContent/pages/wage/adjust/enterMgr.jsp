<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
%>
<script type="text/javascript">
    function setWageItem(){
        window.showModalDialog("/wage/adjust/OrgEnterEdit.jsf?OrgID=<%=user.getOrgId()%>", null, "dialogWidth:480px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
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
    function enterWageSet(){
        if (!checkMutilSelect(form1.chk)) {
            alert("请选择人员!");
            return false;
        }
        document.all('form1:ids').value=getFirstSelectValue(form1.chk,"|");
        
        var ret=window.showModalDialog("/wage/adjust/selectWageSet.jsf?PersonID="+document.all('form1:ids').value, null, "dialogWidth:300px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
        if (ret==null || ret==""){
            return false;
        }
        else{
            document.all('form1:setId').value=ret;
            return true;
        }
    }
    function doViewPerson(){
        var ID=getFirstSelectValue(form1.chk);
        if (ID!=null && ID!=""){
            var arg = "id=" + ID;
            window.open("/pages/wage/base/PersonInfoFrame.jsf?" + arg, null, "left=100,top=50,height=600,width=900,status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
        }
        else{
            alert("请选择人员!");
        }
        return false;
    }
</script>

  <x:saveState value="#{wage_enterPersonSetBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{wage_enterPersonSetBB.listEnterPerson}"/>

  <f:verbatim>
  <table width="98%" height="98%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title" height=8>
   </f:verbatim>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="#{wage_enterPersonSetBB.unitName}入职定级"/>
<f:verbatim>
        </td>
        
        <td class="td_title" align="right"  height=8>
</f:verbatim>
            <h:commandButton value="设定" styleClass="button01" onclick="return setWageItem();" type="button"></h:commandButton>
            <h:outputText value="输入查询时间"></h:outputText>
            <h:inputText  id="inputDate" readonly="true" value="#{wage_enterPersonSetBB.inputDate}"></h:inputText>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:inputDate')"/>
            <h:commandButton value="修改薪资信息" styleClass="button01" type="button" onclick="doViewPerson();"></h:commandButton>
            <h:commandButton value="查询" styleClass="button01" action="#{wage_enterPersonSetBB.queryEnter}"></h:commandButton>
            <h:inputHidden id="ids" value="#{wage_enterPersonSetBB.ids}"/>
            <h:commandButton value="加入帐套" styleClass="button01" onclick="return enterWageSet();" action="#{wage_enterPersonSetBB.saveEnter}"></h:commandButton>
            <h:inputHidden id="setId" value="#{wage_enterPersonSetBB.setId}"/>
            <h:commandButton value="导出" styleClass="button01" type="button" onclick="doExport();"></h:commandButton>
            <h:commandButton value="查看流程" id="showFlow" type="button" onclick="return showWF();" styleClass="button01" rendered="#{emp_personListBB.workFlow=='1'}"></h:commandButton>
            <h:selectOneMenu id="ReportID" style="width:190px">
               		<c:selectItems value="#{wage_enterPersonSetBB.regTableList}"/>
           	</h:selectOneMenu>
<f:verbatim>
        </td>
    </tr>
     <tr><td colspan="2" height=8></td></tr>
     <tr><td colspan="2">
         <jsp:include page="/pages/common/activepage/ActiveList.jsp">
             <jsp:param name="hasOperSign" value="true"/>
             <jsp:param name="operSignType" value="checkbox"/>
             <jsp:param name="hasEdit" value="true"/>
             <jsp:param name="isEditList" value="false"/>
             <jsp:param name="isCheckRight" value="false"/>
         </jsp:include>
     </td>
     </tr>
  </table>
</f:verbatim>       
</h:form>
