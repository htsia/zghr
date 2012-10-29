<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.wage.pojo.vo.WageNaRuleResultFiledVO" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function forSave() {
	if(document.all("form1:scopeValues").value==""){
		alert("晋级范围不能为空！");
		return false;
	}else{
		forsubmit(document.forms(0));
	}
}
function selectScopeValue1(){
	var value=document.all("form1:scopeValues").value;
	var scopeDes=document.all("form1:scopeDes").value;
	PopUpCodeDlgOneControl('form1:A001712');
	var newvalue=document.all("form1:A001712").code;
	var newvaluedes=document.all("form1:A001712").value;
	if(value!=null&&value!=""){
		document.all("form1:scopeValues").value=value+","+newvalue;
		document.all("form1:scopeDes").value=scopeDes+","+newvaluedes;
	}else{
		document.all("form1:scopeValues").value=newvalue;
		document.all("form1:scopeDes").value=newvaluedes;
	}
}
function selectScopeValue2(){
	var value=document.all("form1:scopeValues2").value;
	var scopeDes=document.all("form1:scopeDes2").value;
	PopUpCodeDlgOneControl('form1:A0017122');
	var newvalue=document.all("form1:A0017122").code;
	var newvaluedes=document.all("form1:A0017122").value;
	if(value!=null&&value!=""){
		document.all("form1:scopeValues2").value=value+","+newvalue;
		document.all("form1:scopeDes2").value=scopeDes+","+newvaluedes;
	}else{
		document.all("form1:scopeValues2").value=newvalue;
		document.all("form1:scopeDes2").value=newvaluedes;
	}
}
</script>
  
  <x:saveState value="#{wage_nomalAdjListBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{wage_nomalAdjListBB.initRuleEdit}"></h:inputHidden>
      <f:verbatim>
    
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">晋级晋档 -> 业务规则定义
        </td>
    </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01" >
</f:verbatim>
          <h:outputText value="#{wage_nomalAdjListBB.scope}"></h:outputText>
<f:verbatim>
    </td>
    <td class="td_form02">
	</f:verbatim>
        <h:inputText styleClass="input" id="A001712" code="" dict="yes" dict_num="#{wage_nomalAdjListBB.scopeDic}"
                     readonly="true" value=""alt="岗位类别|1|s|50||" style="display:none;"/>
        <h:inputTextarea id="scopeDes" value="#{wage_nomalAdjListBB.scopeDes}" readonly="true" rows="3" cols="35"></h:inputTextarea>
        <h:inputHidden id="scopeValues" value="#{wage_nomalAdjListBB.naRuleBo.scopeValue}"></h:inputHidden>
	<f:verbatim>
	<input type="button" class="button_select" onclick="selectScopeValue1()">
	</td>
</tr>

<tr nowrap>
    <td class="td_form01" >
</f:verbatim>
          <h:outputText value="#{wage_nomalAdjListBB.scope2}"></h:outputText>
<f:verbatim>
    </td>
    <td class="td_form02">
	</f:verbatim>
        <h:inputText styleClass="input" id="A0017122" code="" dict="yes" dict_num="#{wage_nomalAdjListBB.scopeDic2}"
                     readonly="true" value=""alt="岗位类别|1|s|50||" style="display:none;"/>
        <h:inputTextarea id="scopeDes2" value="#{wage_nomalAdjListBB.scopeDes2}" readonly="true" rows="3" cols="35"></h:inputTextarea>
        <h:inputHidden id="scopeValues2" value="#{wage_nomalAdjListBB.naRuleBo.scopeValue2}"></h:inputHidden>
	<f:verbatim>
	<input type="button" class="button_select" onclick="selectScopeValue2()">
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" >晋级时间</td>
    <td class="td_form02">
	</f:verbatim>
         <h:selectOneMenu value="#{wage_nomalAdjListBB.naRuleBo.timeField}">
                      <c:selectItems value="#{wage_nomalAdjListBB.timeList}"></c:selectItems>
         </h:selectOneMenu>
	<f:verbatim>
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" >晋级时间低限</td>
    <td class="td_form02">
	</f:verbatim>
        <h:inputText value="#{wage_nomalAdjListBB.naRuleBo.timeValueLow}"></h:inputText>
	<f:verbatim>
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" >晋级时间高限</td>
    <td class="td_form02">
	</f:verbatim>
         <h:inputText value="#{wage_nomalAdjListBB.naRuleBo.timeValueHigh}"></h:inputText>
	<f:verbatim>
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" >应用范围</td>
    <td class="td_form02">
	</f:verbatim>
        <h:selectOneMenu value="#{wage_nomalAdjListBB.naRuleBo.adjOrgId}">
                      <c:selectItems value="#{wage_nomalAdjListBB.orgList}"></c:selectItems>
               </h:selectOneMenu>
	<f:verbatim>
	</td>
</tr>
<tr nowrap>
    <td class="td_form01" >晋级结果</td>
    <td class="td_form02" >
    <table width="100%" align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<%
  List volist=(ArrayList)session.getAttribute("filedList");
  if(volist!=null&&volist.size()>0){
	  for(int i=0;i<volist.size();i++){
		  WageNaRuleResultFiledVO vo=(WageNaRuleResultFiledVO)volist.get(i);
		  out.print("<tr><td class='td_form01'>"+vo.getItemFileDes()+"</td><td>");
		  out.print("<input name='" + vo.getItemVaueId() + "' readonly type='text' dict='yes' dict_num='"+vo.getItemCodeDict()+"' code='' value='"+vo.getItemFilesValue()+"' class='input' >") ;
	      out.print("<input type='button' class='button_select' onclick=\"PopUpCodeDlgOneControl('"+vo.getItemVaueId()+"')\">");
	      out.print("</td></tr>");
	  }
  }
%>
</table>
</td></tr>
<tr height="10"><td height="10"></td></tr>
<tr><td align="right" colspan="2">
</f:verbatim>
		 <h:commandButton value="保存" id="save" action="#{wage_nomalAdjListBB.saveRule}"   styleClass="button01" onclick="javascript:return forSave()"/>
<f:verbatim>
</td></tr>
</table>
</f:verbatim>	
  </h:form>
 <script type="text/javascript">
    interpret(document.forms(0));
</script>
