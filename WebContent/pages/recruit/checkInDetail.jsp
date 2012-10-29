<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function forSave() {
	return forsubmit(document.forms(0)); 	
}
function selectTypeFun(){
	   PopUpCodeDlgOneControl('form1:A016010','0200110001');
	}
function selAddTime() {
    <%
       InfoItemBO addTime=SysCacheTool.findInfoItem("A016","A016020");
       if (InfoItemBO.DATA_TYPE_DATE6.equals(addTime.getItemDataType())){
    %>
        PopUpCalendarDlg_OnlyMonth('form1:A016020')
    <%
       }
       else{
     %>
         PopUpCalendarDialog("form1:A016020");
    <%
     }
    %>
}
</script>
<x:saveState value="#{doCheckInBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{doCheckInBB.initEdit}"></h:inputHidden>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">报到处理->报到
        </td>
        <td class="td_title" align="right">
        </td>
    </tr>
</table>

<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
<td class="td_form01 td_form_required">员工编号</td>
 <td class=td_form02>
</f:verbatim>
 <h:inputText styleClass="input" id="A001735" value="#{doCheckInBB.personvo.personCode}" alt="员工编号|1|s|50||"/>
<f:verbatim>
 </td>
 <td class="td_form01 td_form_required">员工身份</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001031" code="" dict="yes" dict_num="0140"
                     readonly="true" value="#{doCheckInBB.personvo.personIdentity}"
                     alt="员工身份|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001031')">
    </td>
</tr>
<tr nowrap>
     <td class="td_form01 td_form_required">所在部门</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{doCheckInBB.personvo.deptId}"
                     alt="所在部门|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A001705',2)">
       </td>
    <td class="td_form01 td_form_required">员工类别</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{doCheckInBB.personvo.personType}"
                     alt="员工类别|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')">
  </td>

</tr>
    <tr nowrap>
        <td class="td_form01 td_form_required" >增员类别</td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                         readonly="true" value="#{doCheckInBB.personchangevo.changeType}"
                         alt="增员类别|0|s|50||"/>
            <h:outputText value="  "></h:outputText>
            <h:commandButton type="button" styleClass="button_select"  id="selectType" />
<f:verbatim>
		</td>
        <td class="td_form01 td_form_required"><%=addTime.getItemName()%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A016020" value="#{doCheckInBB.personchangevo.changeDate}"  readonly="true" alt="增员时间|0|d6|50||"/>
            <h:outputText value="  "></h:outputText>
            <h:commandButton type="button" styleClass="button_select" onclick="selAddTime();"/>
<f:verbatim>
    <script type="text/javascript">
        document.all('form1:A016020').alt = "<%=addTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(addTime.getItemDataType())%>|50||";
    </script>

        </td>
    </tr>
</table>
<br>
<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
</f:verbatim>
		<h:commandButton value="保存" action="#{doCheckInBB.savePerson}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
		<h:outputText value="  "></h:outputText>
		<h:commandButton value="取消" styleClass="button01" onclick="window.close()"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
   	document.all('form1:selectType').onclick=selectTypeFun;
</script>
