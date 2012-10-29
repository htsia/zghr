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
function doGradePerson(id){
    window.showModalDialog("/eLearn/doGraderPerson.jsf?itemID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}
function window.onunload(){   
	 window.opener.location.href=window.opener.location.href;
	 return true;
}
</script>
<x:saveState value="#{doRecruitGraderBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{doRecruitGraderBB.initInterviewEdit}"></h:inputHidden>
<h:inputHidden id="personcode" value="#{doRecruitGraderBB.personcode}"></h:inputHidden>
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
       	<h:inputTextarea value="#{doRecruitGraderBB.resultbo.ivContent}" rows="3" cols="50"></h:inputTextarea>
<f:verbatim>  </td>
</tr>
    <tr>
    <td class=td_form01 width="100">面试得分</td>
    <td class=td_form02 width="20%"></f:verbatim>
              <h:inputText value="#{doRecruitGraderBB.resultbo.score}"></h:inputText>
<f:verbatim></td>
    <td class=td_form01 width="100">面试结果</td>
    <td class=td_form02 >
        </f:verbatim>
        <h:selectOneMenu value="#{doRecruitGraderBB.resultbo.ivResult}">
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
		<h:commandButton value="审批" action="#{doRecruitGraderBB.audit}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
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
%>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
<tr>
                <td align="center" width="16%" class=tab><a href="interviewResumeDetail.jsf?detailId=<%=detailId%>">应聘人简历</a></td>
                <td align="center" width="16%" class=activeTab><a href="doRecruitGrader.jsf?detailId=<%=detailId%>">人工判卷</a></td>
                <td align="center" width="16%" class=tab><a href="interviewMatriaList.jsf?detailId=<%=detailId%>">面试材料</a></td>
                <td align="center" width="16%" class=tab><a href="interviwResultList.jsf?detailId=<%=detailId%>">面试过程</a></td>
                <td align="center" width="16%" class=tab><a href="#" onclick="forViewPost('<%=postid%>')">岗位描述</a></td>
            </tr>
</table>
<br>
 <table height=97% width=98% align="center">
          <tr><td height=8 ></td></tr>
      
          <tr><td height=8>
      </f:verbatim>
              <h:outputText value="记录数:#{doRecruitGraderBB.mypage.totalRecord}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="页数:#{doRecruitGraderBB.mypage.totalPage}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="每页有#{doRecruitGraderBB.mypage.pageSize}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="当前为第#{doRecruitGraderBB.mypage.currentPage}页"></h:outputText>

              <h:commandButton value="首页" action="#{doRecruitGraderBB.first}" styleClass="button01"></h:commandButton>
              <h:commandButton value="上页" action="#{doRecruitGraderBB.pre}" styleClass="button01"></h:commandButton>
              <h:commandButton value="下页" action="#{doRecruitGraderBB.next}" styleClass="button01"></h:commandButton>
              <h:commandButton value="尾页" action="#{doRecruitGraderBB.last}" styleClass="button01"></h:commandButton>
              <h:outputText value="  "></h:outputText>
<f:verbatim>
          </td></tr>

          <tr><td>
              <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
                   <x:dataTable value="#{doRecruitGraderBB.personList}" var="list" align="center" id="dateList"  rowIndexVar="index"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="90%" >

            <h:column>
                <f:facet name="header">
                    <h:outputText value=""  />
                </f:facet>
                <h:outputText value="#{index+1}"   />
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

                       <h:column>
                           <c:facet name="header"><h:outputText value="分数"/></c:facet>
                           <h:outputText value="#{list.score}"/>
                       </h:column>

               <h:column>
                   <f:facet name="header">
                       <h:outputText value="是否考完" style="width:100px" />
                   </f:facet>
                   <h:selectOneRadio value="#{list.isfinish}" disabled="true">
                       <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                       <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                   </h:selectOneRadio>
               </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="评判"   styleClass="button01"  rendered="#{list.isfinish=='1' && list.score==null}" onclick="doGradePerson('#{list.itemID}');"/>
            </h:column>
        </x:dataTable>
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
