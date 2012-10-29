<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.title.pojo.bo.*" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleTempItemBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.*" %>
<%@ page import="com.hr319wg.title.ucc.impl.TitleContentSetUCC" %>
<%@ page import="com.hr319wg.title.ucc.impl.EmpTitleApplyUcc" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function saveScore() {
	if(document.all("form1:score").value==null||document.all("form1:score").value==""){
		alert("必须录入打分分数!");
		return false;
	}else{
		var score=document.all("form1:score").value;
		var reg=/^\d+(\.\d+)?$/;
		var dscroe1=true;
		dscroe1=reg.test(score);
		if(dscroe1==false){
			alert("打分分数必须是数字!");
			return false;
		}else{
			var dscroe=parseFloat(score);
			var resultHi=parseFloat(document.all("form1:hiScore").value);
	    	var resultLow=parseFloat(document.all("form1:lowScore").value);
	    	if(dscroe<=resultHi&&dscroe>=resultLow){
				return true;
	    	}else{
	    		alert("请在打分区间("+resultLow+"-"+resultHi+")内打分");
		    	return false;
	    	}
		}
	}
}
function clickSubmit(){
	document.all("form1:score").value=document.getElementById('score').value;
	document.all("form1:submit").click();
}
</script>
  
  <x:saveState value="#{emptitleAduitBB}" />
  <h:form id="form1">
<h:inputHidden id="initEdit" value="#{emptitleAduitBB.initInputScore}"></h:inputHidden>
<h:inputHidden id="hiScore" value="#{emptitleAduitBB.hiScore}"></h:inputHidden>
<h:inputHidden id="lowScore" value="#{emptitleAduitBB.lowScore}"></h:inputHidden>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">职称评审->部门打分
        </td>
    </tr>
</table>
<br>
<table width=95%><tr><td align="center">
</f:verbatim>
            <h:outputText value="录入分数:" style="display:none"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:inputText id="score" value="#{emptitleAduitBB.scoreBo.score}" style="display:none"></h:inputText>
            <h:outputText value="  "></h:outputText>
            <h:commandButton value="打分" id="submit"  onclick="saveScore();" action="#{emptitleAduitBB.saveScore}" style="display:none"></h:commandButton>
<f:verbatim>
</td></tr></table>
<br>

<%
TitleContentSetUCC setUcc=(TitleContentSetUCC)SysContext.getBean("titleContentSetUcc");
EmpTitleApplyUcc applyUcc=(EmpTitleApplyUcc)SysContext.getBean("empTitleApplayUcc");
String scoreId=(String)session.getAttribute("scoreId");
List selfItemList=(List)session.getAttribute("selfItemList");
EmpTitleApplyScoreBO scorebo=(EmpTitleApplyScoreBO)session.getAttribute("scoreBo");
EmpTitleTempItemBO itembo=setUcc.findEmpTitleTempItemBO(scorebo.getTempItemId());
EmpTitleApplayItemBO applyItembo=applyUcc.findEmpTitleApplayItemBOById(scorebo.getApplyItemId());
EmpTitleAuditSetBO setbo=setUcc.getEqualsEmpTitleAuditSetBO(itembo.getItemId(),applyItembo.getMajorClass());
%>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
            <tr>
<% 
if(selfItemList!=null&&selfItemList.size()>0){
		for(int i=0;i<selfItemList.size();i++){
			EmpTitleApplyScoreBO score=(EmpTitleApplyScoreBO)selfItemList.get(i);
			EmpTitleTempItemBO temItem=setUcc.findEmpTitleTempItemBO(score.getTempItemId());
			if(score.getScoreId().equals(scoreId)){

%>
	<td align="center" width="16%" class=activeTab><a href="selfAudit_inputScore.jsf?scoreId=<%=score.getScoreId()%>"><%=temItem.getItemName() %></a></td>
 <%
			}else{
				%>
	<td align="center" width="16%" class=tab><a href="selfAudit_inputScore.jsf?scoreId=<%=score.getScoreId()%>"><%=temItem.getItemName() %></a></td>
				<%
			}
	}
}
 %>   
           </tr>
</table>
<br>

<%
if(setbo!=null&&setbo.getAuditStatus()!=null&&setbo.getAuditStatus().equals("1")){
if(itembo.getValueType().equals("0")){
%>
<table width=95%><tr><td align="center">
录入分数：<input type="text" class="input" id="score" value="<%=CommonFuns.filterNull(scorebo.getScore())%>"/><input type="button" class="button01" value="打分" onclick="clickSubmit();"/>
</td></tr></table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
<tr><td colspan=2 height=100% align="center">
          <b>请录入评审对象该项内容的主观得分</b>
     </td></tr>
</table>
<%
}else{
%>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr><td colspan=2 height=100%>
          <iframe name="main" height="100%"  frameborder="0" scrolling="auto" marginheight="0" marginwidth="0"  width="100%" 
               src="/pages/employee/title/deptAuditShow.jsp?scoreId=<%=scoreId%>" height="300px"></iframe>
     </td></tr>
</table>
<%
}
}else{
%>
<br><br><br><br><br><br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
<tr><td colspan=2 height=100% align="center">
          <b>该项内容处于(<%=setbo.getAuditStatusDes() %>)状态不能打分</b>
     </td></tr>
</table>
<% }%>
</f:verbatim>
</h:form>

