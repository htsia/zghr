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

function forCheck() {
   	var idCard = document.all("form1:A001077").value;
  	var email=document.all("form1:a080725").value;
	var name=document.all("form1:A001001").value;
	var tel=document.all("form1:a080720").value;
	var pho=document.all("form1:a080710").value;

	if(tel==""||pho==""){
		alert("��ɫ�ֶ����ݱ�����д!");
		return false;
	}
	
	if(idCard==""||name==""){
		alert("��ɫ�ֶ����ݱ�����д!");
		return false;
	}
	if(!( /^[^@]+@[^@]+\.[^@]+$/.test(email))){
        alert("�ʼ���ʽ����ȷ�밴(***@**.**)��ʽ����!");
        return false;
    }
    if (idCard.trim() != "") {
        if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
            alert("���֤��ӦΪ15λ����18λ!");
            return false;
        }
    }
    if (document.all('form1:password1').value==""){
        alert("���벻��Ϊ��");
        return false;
    }
    if (document.all('form1:password2').value==""){
        alert("���ٴ���������");
        return false;
    }
    if (document.all('form1:password2').value!=document.all('form1:password1').value){
        alert("������������벻һ��");
        return false;
    }
    
    return true;
	}

	function forSave() {
	    if (forCheck()) {
	        return forsubmit(document.forms(0));
	    }
    return false;
}
</script>

<h:form id="form1">
<h:inputHidden id="pageInit" value="#{ResumeManageRecuitBB.pageInit}"> </h:inputHidden>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan=2>
                <table  border="0" cellspacing="0" cellpadding="0" width="100%" background="/images/maininterface/hd_top.jpg">
                   <tr>
                    <td width="260" height=62 background="../images/maininterface/logo.jpg"></td>
                    <td width="279" align="left" height=62></td>
                    <td align="right" >
                     	<a href="/recruit/ResumeLogin.jsf" style="color:#ffffff;">��¼ҳ��</a>&nbsp;&nbsp;&nbsp;&nbsp;
                  	</td>
                   </tr>
                </table>
            </td>
        </tr>
		<tr>
            <td width="78%" height="22" background="../images/maininterface/hd_nav_unsel.gif">
			</td>
            <td  height="22" align="left" background="../images/maininterface/hd_nav_unsel.gif">
             </td>
        </tr>
 </table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
    <tr>
        <td class="td_title"><img src="/images/tips.gif"> �ⲿ��Ƹ ->ע��
        </td>
        <td class="td_title" align="right">
        </td>
    </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>������Ϣ</td>
       	<td>
		</td>
     </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01 td_form_required" width="15%">����</td>
    <td class="td_form02" width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{ResumeManageRecuitBB.personBo.a001001}" alt="����|0|s|50||"/>
<f:verbatim>
    </td>
    <td class="td_form01 td_form_required">���֤��</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="22"
                     value="#{ResumeManageRecuitBB.personBo.a001077}"
                     alt="���֤��|1|s|50||"/>
<f:verbatim>
    </td>
</tr>
<tr nowrap>
    <td class="td_form01 td_form_required">����</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputSecret styleClass="input" id="password1" value="#{ResumeManageRecuitBB.personBo.password}"/>
<f:verbatim>
    </td>
   
    <td class="td_form01 td_form_required">ȷ������</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputSecret styleClass="input" id="password2" value="#{ResumeManageRecuitBB.personBo.password}"/></td>
<f:verbatim>
</tr>

</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>��ϵ��ʽ</td>
        
        <td>
		</td>
     </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01 td_form_required" width="15%">Email</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="a080725" code="" dict="yes" dict_num="0105"
                      value="#{ResumeManageRecuitBB.addressBo.a080725}"/>
<f:verbatim>
    </td>
   
    <td class=td_form01></td>
    <td class=td_form02>
</tr>

<tr>
     <td class="td_form01 td_form_required">��ͥ�绰</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080720" value="#{ResumeManageRecuitBB.addressBo.a080720}"/>
<f:verbatim>
    </td>
    
    <td class="td_form01 td_form_required">�ƶ��绰</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080710" value="#{ResumeManageRecuitBB.addressBo.a080710}"/>
<f:verbatim>
    </td>
</tr>

</table>
<br>
<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
        <font color="red">**�����ֶ����ݱ�����д** </font>
</f:verbatim>
			<h:commandButton value="ע��" action="#{ResumeManageRecuitBB.register}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>

</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
