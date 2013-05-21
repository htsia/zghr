<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doViewPerson(){
        var ID=getFirstSelectValue(form1.chk);
        //debugger;
        if (ID!=null && ID!=""){
           forModifyPersonDetail(ID);
        }
        else{
            alert("请选择人员!");
        }
        return false;
    }
</script>

  <x:saveState value="#{emp_PersonAdjustBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{emp_PersonAdjustBB.pageInit}"/>

  <f:verbatim>
  <table width="98%" height=98% border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title" height=8>
   </f:verbatim>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="当前机构：#{emp_PersonAdjustBB.unitName}"/>
   <f:verbatim>
        </td>
        <td class="td_title" align="right" height=8>
   </f:verbatim>
            <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-2417","输入查询时间 ")%> 
            </f:verbatim>
            <h:inputText  id="inputDate" readonly="true" value="#{emp_PersonAdjustBB.inputDate}"></h:inputText>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:inputDate')"/>
            <h:commandButton value="查看人员信息" styleClass="button01" type="button" onclick="doViewPerson();"></h:commandButton>
            <h:commandButton value="查询" styleClass="button01" action="#{emp_PersonAdjustBB.query}"></h:commandButton>
            <h:commandButton value="导出" styleClass="button01" type="button" onclick="doExport();"></h:commandButton>
    <f:verbatim>             
        </td>
    </tr>
     <tr> <td colspan=2 height=8></td></tr>
    <tr> <td colspan=2>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
        </jsp:include>
        </td>
    </tr>
  </f:verbatim>
  </table>
</h:form>
