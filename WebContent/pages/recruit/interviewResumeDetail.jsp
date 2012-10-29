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
function forViewPost(id) {
    windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=0","aa","","900","600","no","10","100","yes");
}
function window.onunload(){   
	 window.opener.location.href=window.opener.location.href;
	 return true;
}
function viewAtt(id,type){
	 window.open('/pages/recruit/showAttFile.jsp?attachmentId='+id+'&type='+type, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
}
</script>
<x:saveState value="#{onlineviewlistBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{onlineviewlistBB.initInterviewEdit}"></h:inputHidden>
<h:inputHidden id="personcode" value="#{onlineviewlistBB.personcode}"></h:inputHidden>
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
       	<h:inputTextarea value="#{onlineviewlistBB.resultbo.ivContent}" rows="3" cols="50"></h:inputTextarea>
<f:verbatim>  </td>
</tr>
    <tr>
    <td class=td_form01 width="100">���Ե÷�</td>
    <td class=td_form02 width="20%"></f:verbatim>
              <h:inputText value="#{onlineviewlistBB.resultbo.score}"></h:inputText>
<f:verbatim></td>
    <td class=td_form01 width="100">���Խ��</td>
    <td class=td_form02 >
        </f:verbatim>
        <h:selectOneMenu value="#{onlineviewlistBB.resultbo.ivResult}">
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
		<h:commandButton value="����" action="#{onlineviewlistBB.audit}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
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
String postMode=(String)session.getAttribute("postMode");
String haveTest=(String)session.getAttribute("haveTest");
%>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
<tr>
                <td align="center" width="16%" class=activeTab><a href="interviewResumeDetail.jsf?detailId=<%=detailId%>">ӦƸ�˼���</a></td>
                <%
                    if(haveTest.equals("1")){
                %>
                <td align="center" width="16%" class=tab><a href="doRecruitGrader.jsf?detailId=<%=detailId%>">�˹��о�</a></td>
                <%
                    }
                %>
                <td align="center" width="16%" class=tab><a href="interviewMatriaList.jsf?detailId=<%=detailId%>">���Բ���</a></td>
                <td align="center" width="16%" class=tab><a href="interviwResultList.jsf?detailId=<%=detailId%>">���Թ���</a></td>
                <%
                    if(postMode.equals("0")){
                %>
                <td align="center" width="16%" class=tab><a href="#" onclick="forViewPost('<%=postid%>')">��λ����</a></td>
                <%
                    }
                %>
            </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01 td_form_required" width="100">����</td>
    <td class="td_form02">
</f:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{onlineviewlistBB.personBo.a001001}" alt="����|0|s|50||" readonly="true"/>
<f:verbatim>
    </td>
    <td width="15%" class="td_form01 ">�Ա�</td>
    <td class=td_form02 width="35%">
</f:verbatim>
        <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                     readonly="true" value="#{onlineviewlistBB.personBo.a001007}"
                     alt="�Ա�|1|s|50||"/>
<f:verbatim>
       </td>
</tr>
<tr nowrap>
    <td class="td_form01">��������</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001011" value="#{onlineviewlistBB.personBo.a001011}"
                     readonly="true" alt="��������|1|d|50||"/>
<f:verbatim>

    </td>
	  <td class="td_form01 td_form_required">���֤��</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="22"
                     value="#{onlineviewlistBB.personBo.a001077}"
                     alt="���֤��|1|s|50||" readonly="true"/>
<f:verbatim>
    </td>
</tr>
<tr>
    <td class=td_form01 width="100">�־�ס����</td>
    <td class=td_form02 width="31%">
</f:verbatim>
        <h:inputText styleClass="input" id="a080722" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{onlineviewlistBB.addressBo.a080722}"
                     alt="������|1|s|50||"/>
<f:verbatim>


    <td class=td_form01 width="100">�ƶ��绰</td>
    <td class=td_form02 >
</f:verbatim>
        <h:inputText styleClass="input" id="a080710" value="#{onlineviewlistBB.addressBo.a080710}" readonly="true"/>
<f:verbatim>
    </td>
</tr>
<tr>
    <td class=td_form01>��ͥ�绰</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080720" value="#{onlineviewlistBB.addressBo.a080720}" readonly="true"/>
<f:verbatim>
    </td>
    <td class="td_form01 td_form_required">Email</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080725" code="" dict="yes" dict_num="0105"
                      value="#{onlineviewlistBB.addressBo.a080725}" readonly="true"/>
<f:verbatim>
    </td>
</tr>
<%
	String educationStr=(String)session.getAttribute("educationStr");
	String wokeInofStr=(String)session.getAttribute("wokeInofStr");
	String languageStr=(String)session.getAttribute("languageStr");
	String computerStr=(String)session.getAttribute("computerStr");
	String specialStr=(String)session.getAttribute("specialStr");
	String articleStr=(String)session.getAttribute("articleStr");
	String keyanStr=(String)session.getAttribute("keyanStr");
	String successStr=(String)session.getAttribute("successStr");
	String materStr=(String)session.getAttribute("materStr");
%>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">�ܽ������</td>
    <td class=td_form02 colspan="3" valign="top">
		<%=educationStr%>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">��������</td>
    <td class=td_form02 colspan="3" valign="top">
		<%=wokeInofStr%>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">��������</td>
    <td class=td_form02 colspan="3" valign="top">
		<%=languageStr %>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">���������</td>
    <td class=td_form02 colspan="3" valign="top">
		<%=computerStr %>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">רҵ�����ʸ�</td>
    <td class=td_form02 colspan="3" valign="top">
		<%=specialStr%>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">�����������</td>
    <td class=td_form02 colspan="3" valign="top">
		<%=articleStr %>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">����������</td>
    <td class=td_form02 colspan="3" valign="top">
		<%=keyanStr%>
    </td>
</tr>
    <td class=td_form01 width="19%" height="80">�ɹ������������гɹ���</td>
    <td class=td_form02 colspan="3" valign="top">
		<%=successStr%>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">֤�鼰��ز��� </td>
    <td class=td_form02 colspan="3" valign="top">
		<%=materStr %>
    </td>
</tr>
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
