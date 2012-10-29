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
        <td class="td_title"><img src="/images/tips.gif">��������->����
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
    <td class=td_form01 width="150">���Խ��</td>
    <td class=td_form02  colspan="3"><%=result%></td>
</td>
</tr>
<%
    }
%>
    <tr>
    <td class=td_form01>���˵��</td>
    <td class=td_form02 colspan="3">
</f:verbatim>
       	<h:inputTextarea value="#{doRecruitGraderBB.resultbo.ivContent}" rows="3" cols="50"></h:inputTextarea>
<f:verbatim>  </td>
</tr>
    <tr>
    <td class=td_form01 width="100">���Ե÷�</td>
    <td class=td_form02 width="20%"></f:verbatim>
              <h:inputText value="#{doRecruitGraderBB.resultbo.score}"></h:inputText>
<f:verbatim></td>
    <td class=td_form01 width="100">���Խ��</td>
    <td class=td_form02 >
        </f:verbatim>
        <h:selectOneMenu value="#{doRecruitGraderBB.resultbo.ivResult}">
                    <c:selectItem itemLabel="��ͨ��" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="ͨ��" itemValue="1"></c:selectItem>
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
		<h:commandButton value="����" action="#{doRecruitGraderBB.audit}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
		<h:outputText value="  "></h:outputText>
		<h:commandButton value="ȡ��" styleClass="button01" onclick="window.close()"></h:commandButton>
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
                <td align="center" width="16%" class=tab><a href="interviewResumeDetail.jsf?detailId=<%=detailId%>">ӦƸ�˼���</a></td>
                <td align="center" width="16%" class=activeTab><a href="doRecruitGrader.jsf?detailId=<%=detailId%>">�˹��о�</a></td>
                <td align="center" width="16%" class=tab><a href="interviewMatriaList.jsf?detailId=<%=detailId%>">���Բ���</a></td>
                <td align="center" width="16%" class=tab><a href="interviwResultList.jsf?detailId=<%=detailId%>">���Թ���</a></td>
                <td align="center" width="16%" class=tab><a href="#" onclick="forViewPost('<%=postid%>')">��λ����</a></td>
            </tr>
</table>
<br>
 <table height=97% width=98% align="center">
          <tr><td height=8 ></td></tr>
      
          <tr><td height=8>
      </f:verbatim>
              <h:outputText value="��¼��:#{doRecruitGraderBB.mypage.totalRecord}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="ҳ��:#{doRecruitGraderBB.mypage.totalPage}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="ÿҳ��#{doRecruitGraderBB.mypage.pageSize}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="��ǰΪ��#{doRecruitGraderBB.mypage.currentPage}ҳ"></h:outputText>

              <h:commandButton value="��ҳ" action="#{doRecruitGraderBB.first}" styleClass="button01"></h:commandButton>
              <h:commandButton value="��ҳ" action="#{doRecruitGraderBB.pre}" styleClass="button01"></h:commandButton>
              <h:commandButton value="��ҳ" action="#{doRecruitGraderBB.next}" styleClass="button01"></h:commandButton>
              <h:commandButton value="βҳ" action="#{doRecruitGraderBB.last}" styleClass="button01"></h:commandButton>
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
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

                       <h:column>
                           <c:facet name="header"><h:outputText value="����"/></c:facet>
                           <h:outputText value="#{list.score}"/>
                       </h:column>

               <h:column>
                   <f:facet name="header">
                       <h:outputText value="�Ƿ���" style="width:100px" />
                   </f:facet>
                   <h:selectOneRadio value="#{list.isfinish}" disabled="true">
                       <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                       <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                   </h:selectOneRadio>
               </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="����"   styleClass="button01"  rendered="#{list.isfinish=='1' && list.score==null}" onclick="doGradePerson('#{list.itemID}');"/>
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
