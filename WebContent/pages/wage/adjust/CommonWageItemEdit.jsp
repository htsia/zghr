<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.sys.ucc.IInfoItemUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.OrgCodeRelationBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    IInfoItemUCC itemucc = (IInfoItemUCC) SysContext.getBean("sys_infoItemUccImpl");

%>

<script type="text/javascript">
function checkform() {
	forsubmit(document.forms(0)); 	
}

function selectInfoItem() {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/wage/base/WageBaseItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        //debugger;
        document.all("form1:infoItem").value = rs[0];
        return true;
    }
    return false;
}
function forCopyPersonItem(){
    reval=window.showModalDialog("/wage/set/SetWageSet.jsf?UnitID="+document.all('form1:unitId').value+"&SetID="+document.all('form1:setId').value, null, "dialogWidth:300px; dialogHeight:150px;center:center;resizable:yes;status:yes;scroll:yes;");
    if (reval != null && reval!="") {
        form1.all("form1:copySet").value = reval;
        return true;
    } else {
        return false;
    }

}
</script>
  
<x:saveState value="#{wage_commonAdjustBB}" />
<h:form id="form1">
      <h:inputHidden id="initEdit" value="#{wage_commonAdjustBB.initEdit}"></h:inputHidden>
      <f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">录入新值
        </td>
    </tr>
</table>
<br>          
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01" > <%=LanguageSupport.getResource("RYGL-2041", "指标项")%>    </td>
    <td class="td_form02">
	</f:verbatim>
         <h:outputText value="#{wage_commonAdjustBB.detailbo.fieldID}"></h:outputText>
	<f:verbatim>
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" > <%=LanguageSupport.getResource("RYGL-2042", "指标名称")%>    </td>
    <td class="td_form02">
	</f:verbatim>
        <h:outputText value="#{wage_commonAdjustBB.detailbo.fieldName}" ></h:outputText>
	<f:verbatim>
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" > <%=LanguageSupport.getResource("RYGL-2043", "原值")%>   </td>
   <%
       String field = (String) session.getAttribute("filed");
       InfoItemBO item = SysCacheTool.findInfoItem("", field);
       String oldValue = (String) session.getAttribute("oldValue");
       if (oldValue == null) {
           oldValue = "";
       }
       if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType()) 
    			|| InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())
    			|| InfoItemBO.DATA_TYPE_INT.equals(item.getItemDataType())
    			|| InfoItemBO.DATA_TYPE_DATE.equals(item.getItemDataType())
    			|| InfoItemBO.DATA_TYPE_DATE6.equals(item.getItemDataType())
    			) {
           out.println("<td class='td_form02'>" + oldValue + "</td>");
       } else if (InfoItemBO.DATA_TYPE_CODE.equals(item.getItemDataType())) {
           out.println("<td class='td_form02'>" + CodeUtil.interpertCode(oldValue)+ "</td>");
       }
   %>
</tr>
        
<tr nowrap>
    <td class="td_form01" ><%=LanguageSupport.getResource("JGGL-1101", "新值")%></td>
<%
    String fldName = "newValue";
    if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
        out.println("<td class='td_form02'><input name='" + fldName + "' type='text' value='' class='input' size=20 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
    } else if (InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())) {
        out.println("<td class='td_form02'><input name='" + fldName + "' type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
    } else if (InfoItemBO.DATA_TYPE_CODE.equals(item.getItemDataType())) {
        OrgCodeRelationBO orgcode = itemucc.getOrgCodeRelationBO(user.getOrgId(), item.getItemCodeSet());
        out.print("<td class='td_form02'>");
        out.print("<input name='" + fldName + "' readonly type='text' dict='yes' dict_num='" + item.getItemCodeSet() + "' code='' value='' class='input' >");
        if (orgcode != null && orgcode.getRootID() != null && !"".equals(orgcode.getRootID())) {
           out.print("<input type='button' class='button_select' onclick=\"PopUpCodeDlgOneControl('" + fldName + "','"+orgcode.getRootID()+"')\">");
        }
        else{
            out.print("<input type='button' class='button_select' onclick=\"PopUpCodeDlgOneControl('" + fldName + "')\">");
        }
        out.print("</td>");
    } else if (InfoItemBO.DATA_TYPE_DATE6.equals(item.getItemDataType()) || InfoItemBO.DATA_TYPE_DATE.equals(item.getItemDataType())) {
        out.println("<td class='td_form02'><input name='" + fldName + "' type='text' value='' class='input' size=20 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'>");
        %>
        	<img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM<%=(InfoItemBO.DATA_TYPE_DATE.equals(item.getItemDataType())?"-dd":"") %>',alwaysUseStartDate:true,el:'<%=fldName %>'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
        <%
        out.print("</td>");
    }
%>
</tr>
</table>
<table width=95%>        
<tr><td align="right">
</f:verbatim>
		 <h:commandButton value="保存"  action="#{wage_commonAdjustBB.saveDetailItem}" styleClass="button01" onclick="checkform()"/>
<f:verbatim>
</td></tr>
</table>
</f:verbatim>	
  </h:form>
 <script type="text/javascript">
    interpret(document.forms(0));
</script>
