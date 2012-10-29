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
<x:saveState value="#{interviewMariraBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{interviewMariraBB.initInterviewEdit}"></h:inputHidden>
<h:inputHidden id="personcode" value="#{interviewMariraBB.personcode}"></h:inputHidden>
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
       	<h:inputTextarea value="#{interviewMariraBB.resultbo.ivContent}" rows="3" cols="50"></h:inputTextarea>
<f:verbatim>  </td>
</tr>
    <tr>
    <td class=td_form01 width="100">面试得分</td>
    <td class=td_form02 width="20%"></f:verbatim>
              <h:inputText value="#{interviewMariraBB.resultbo.score}"></h:inputText>
<f:verbatim></td>
    <td class=td_form01 width="100">面试结果</td>
    <td class=td_form02 >
        </f:verbatim>
        <h:selectOneMenu value="#{interviewMariraBB.resultbo.ivResult}">
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
		<h:commandButton value="审批" action="#{interviewMariraBB.audit}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
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
                <td align="center" width="16%" class=activeTab><a href="interviewMatriaList.jsf?detailId=<%=detailId%>">面试材料</a></td>
                <td align="center" width="16%" class=tab><a href="interviwResultList.jsf?detailId=<%=detailId%>">面试过程</a></td>
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
       <tr><td height=8> 
</f:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
           
            <h:panelGroup>
                <h:outputText value="记录数:#{interviewMariraBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{interviewMariraBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{interviewMariraBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{interviewMariraBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{interviewMariraBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{interviewMariraBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{interviewMariraBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{interviewMariraBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>  
          </h:panelGrid>
    </h:panelGrid>
      <f:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</f:verbatim>
    <h:dataTable value="#{interviewMariraBB.materialList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="95%" >
        <h:column>
            <c:facet name="header"><h:outputText value="面试材料名称"/></c:facet>
            <h:outputText value="#{list.materiallName}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="描述"/></c:facet>
            <h:outputText value="#{list.description}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="附件"/></c:facet>
            <h:outputText value="无" rendered="#{list.isHaveAtt=='0'}"/>
            <h:commandLink value="附件"  rendered="#{list.isHaveAtt=='1'}" onclick="viewAtt('#{list.planAtt}')">
   			</h:commandLink>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="创建机构"/></c:facet>
            <h:outputText value="#{list.createOrg}"/>
        </h:column>
        
		<h:column>
            <c:facet name="header"><h:outputText value="应用范围"/></c:facet>
            <h:outputText value="#{list.orgID}"/>
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
