<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
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
  
  <x:saveState value="#{empDchangeWageMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{empDchangeWageMgrBB.initEdit}"></h:inputHidden>
      <f:verbatim>
    
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">
            <%=LanguageSupport.getResource("RYGL-2123", "人员调配 ")%>->
            <%=LanguageSupport.getResource("RYGL-2226", " D级员工转正")%>
        </td>
    </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01" >	<%=LanguageSupport.getResource("RYGL-2041", "指标项")%></td>
    <td class="td_form02">
	</f:verbatim>
         <h:inputText value="#{empDchangeWageMgrBB.itembo.fieldId}" readonly="true"></h:inputText>
	<f:verbatim>
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" ><%=LanguageSupport.getResource("RYGL-2042", "指标名称")%></td>
    <td class="td_form02">
	</f:verbatim>
        <h:inputText value="#{empDchangeWageMgrBB.itembo.fieldDes}" readonly="true"></h:inputText>
	<f:verbatim>
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" ><%=LanguageSupport.getResource("RYGL-2043", "原值")%></td>
   <%
  String field=(String)session.getAttribute("filed");
  InfoItemBO item= SysCacheTool.findInfoItem("",field);
  String oldValue=(String)session.getAttribute("oldValue");
  if(oldValue==null){
	  oldValue="";
  }
  String fldName1="oldValue";
  if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
      out.println("<td class='td_form02'><input name='" + fldName1 + "' type='text' value='"+oldValue+"' readonly='true' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
  }else if(InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())){
	  out.println("<td class='td_form02'><input name='" + fldName1 + "' type='text' value='"+oldValue+"' readonly='true' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
  }else if (InfoItemBO.DATA_TYPE_CODE.equals(item.getItemDataType())) {
       out.print("<td class='td_form02'>");
       out.print("<input name='" + fldName1 + "' readonly type='text' dict='yes' dict_num='"+item.getItemCodeSet()+"' code='' value='"+oldValue+"' class='input' >") ;
       out.print("<input type='button' disable='true' class='button_select' onclick=\"PopUpCodeDlgOneControl('"+fldName1+"')\">");
       out.print("</td>");
  }
%>
</tr>
<tr nowrap>
    <td class="td_form01" ><%=LanguageSupport.getResource("JGGL-1101", "新值")%></td>
<%
  String fldName="newValue";
  if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
      out.println("<td class='td_form02'><input name='" + fldName + "' type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
  }else if(InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())){
	  out.println("<td class='td_form02'><input name='" + fldName + "' type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
  }else if (InfoItemBO.DATA_TYPE_CODE.equals(item.getItemDataType())) {
       out.print("<td class='td_form02'>");
       out.print("<input name='" + fldName + "' readonly type='text' dict='yes' dict_num='"+item.getItemCodeSet()+"' code='' value='' class='input' >") ;
       out.print("<input type='button' class='button_select' onclick=\"PopUpCodeDlgOneControl('"+fldName+"')\">");
       out.print("</td>");
  }
%>
</tr>
<tr><td align="right">
</f:verbatim>
		 <h:commandButton value="保存"  action="#{empDchangeWageMgrBB.saveItem}" styleClass="button01" onclick="checkform()"/>
<f:verbatim>
</td></tr>
</table>
</f:verbatim>	
  </h:form>
 <script type="text/javascript">
    interpret(document.forms(0));
</script>
