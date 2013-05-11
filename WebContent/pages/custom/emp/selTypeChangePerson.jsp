<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>

<script type="text/javascript">
    <%
        User user = (User)session.getAttribute(Constants.USER_INFO);
    %>
    function selectPerson(){
         return  fPopUpBackPerTreeDlg('<%=user.getOrgId()%>');
    }
    function checkData(){
    	var personIds=document.getElementById("form1:personIds").value;
		if(personIds==null || personIds==''){
			alert("��ѡ����Ա");
			return false;
		}
		
		return forsubmit(document.forms(0))
	}
    function clear(){
    	document.getElementById("form1:personIds").value='';
    	document.getElementById("form1:personNames").value='';
    }
</script>
    <x:saveState value="#{empTypeChangeBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empTypeChangeBB.editInit}"/>
        <h:inputHidden id="postId" value=""></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr>
            <td class=td_form01> <%=LanguageSupport.getResource("XTGL-1352", "��Ա����")%></td>
            <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea id="personNames" value="#{empTypeChangeBB.personNames}" rows="3" cols="50" readonly="true"/>
			   <h:inputHidden id="personIds" value="#{empTypeChangeBB.personIDs}"/>
               <h:commandButton styleClass="button01" value="ѡ��" onclick="return selectPerson()" action="#{empTypeChangeBB.selPerson}" />
               <h:commandButton styleClass="button01" type="button" value="���" onclick="return clear();" />
<c:verbatim>
               </td>
            </tr>
    <tr nowrap>
        <td class="td_form01 td_form_required">����Ա���</td>
        <td class=td_form02 colspan="3">
</c:verbatim>
            <h:inputText styleClass="input" id="changeType" value="#{empTypeChangeBB.newType}" dict="yes" dict_num="0135"  code=""
                    readonly="true"  alt="����Ա���|0|s|50||"/>
<c:verbatim>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:changeType');">
        </td>
    </tr>

        </table>
        <br>
        <table width=95% align=center cellpadding=0 cellspacing=0 >
            <tr>
                 <td align="center">
</c:verbatim>                 
                      <h:commandButton id="save" styleClass="button01" value="   ��  ��    " onclick="return checkData();" action="#{empTypeChangeBB.save}" />
<c:verbatim>
                 </td>
            </tr>
            
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>