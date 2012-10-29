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
function viewAtt(id){
	 window.open('/pages/recruit/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
}
function window.onunload(){   
	 window.opener.location.href=window.opener.location.href;
	 return true;
}
</script>
<x:saveState value="#{interviewResultListBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{interviewResultListBB.initInterviewEdit}"></h:inputHidden>
<h:inputHidden id="personcode" value="#{interviewResultListBB.personcode}"></h:inputHidden>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">在线面试->面试
        </td>
        <td class="td_title" align="right">
        </td>
    </tr>
</table>
<br>
    <%
    String result=(String)session.getAttribute("result");
    String haveTest2=(String)session.getAttribute("haveTest");
%>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<%
    if(haveTest2.equals("1")){
%>
<tr>
    <td class=td_form01 width="150">考试结果</td>
    <td class=td_form02  colspan="3"><%=result%></td>
</td>
</tr>
<%
    }
%>
    <tr>
    <td class=td_form01>结果说明</td>
    <td class=td_form02 colspan="3">
</f:verbatim>
       	<h:inputTextarea value="#{interviewResultListBB.resultbo.ivContent}" rows="3" cols="50"></h:inputTextarea>
<f:verbatim>  </td>
</tr>
    <tr>
    <td class=td_form01 width="100">面试得分</td>
    <td class=td_form02 width="20%"></f:verbatim>
              <h:inputText value="#{interviewResultListBB.resultbo.score}"></h:inputText>
<f:verbatim></td>
    <td class=td_form01 width="100">面试结果</td>
    <td class=td_form02 >
        </f:verbatim>
        <h:selectOneMenu value="#{interviewResultListBB.resultbo.ivResult}">
                    <c:selectItem itemLabel="不通过" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="通过" itemValue="1"></c:selectItem>
        </h:selectOneMenu>
<f:verbatim>
    </td>
</tr>
</table>
<br><br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
</f:verbatim>
		<h:commandButton value="审批" action="#{interviewResultListBB.audit}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
		<h:outputText value="  "></h:outputText>
		<h:commandButton value="取消" styleClass="button01" onclick="window.close()"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
<br>
<%
String detailId=(String)session.getAttribute("detailId");
String postid=(String)session.getAttribute("postid");
String postMode=(String)session.getAttribute("postMode");
String haveTest=(String)session.getAttribute("haveTest");
%>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
<tr>
                <td align="center" width="16%" class=tab><a href="interviewResumeDetail.jsf?detailId=<%=detailId%>">应聘人简历</a></td>
                <%
                    if(haveTest.equals("1")){
                %>
                <td align="center" width="16%" class=tab><a href="doRecruitGrader.jsf?detailId=<%=detailId%>">人工判卷</a></td>
                <%
                    }
                %>
                <td align="center" width="16%" class=tab><a href="interviewMatriaList.jsf?detailId=<%=detailId%>">面试材料</a></td>
                <td align="center" width="16%" class=activeTab><a href="interviwResultList.jsf?detailId=<%=detailId%>">面试过程</a></td>
               <%
                    if(postMode.equals("0")){
                %>
                <td align="center" width="16%" class=tab><a href="#" onclick="forViewPost('<%=postid%>')">岗位描述</a></td>
                <%
                    }
                %>
            </tr>
</table>
<br>
 <table height=98% width=98% align="center">
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</f:verbatim>
    <h:dataTable value="#{interviewResultListBB.resultBolist}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="95%" >
        <h:column>
            <c:facet name="header"><h:outputText value="面试人"/></c:facet>
            <h:outputText value="#{list.viewer}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="面试时间"/></c:facet>
            <h:outputText value="#{list.ivDate}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="面试结果"/></c:facet>
            <h:outputText value="#{list.ivResultDes}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="面试得分"/></c:facet>
            <h:outputText value="#{list.score}"/>
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusdes}"/>
        </h:column>
</h:dataTable>
    <f:verbatim>
	</div>
	</td></tr>
	</table>
<br>
</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
