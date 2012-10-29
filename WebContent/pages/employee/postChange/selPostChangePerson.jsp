<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>

<script type="text/javascript">
    <%
        User user = (User)session.getAttribute(Constants.USER_INFO);
    %>
    function selectDept(){
        PopUpOrgDlgShowGroup('form1:A016030',2,'<%=user.getOrgId()%>');
        return false
    }
    function selectPerson(){
         return  fPopUpBackPerTreeDlg('<%=user.getOrgId()%>');
    }
    function checkData(){
    	var personIds=document.all("form1:personIds").value;
		if(personIds==null || personIds==''){
			alert("��ѡ����Ա");
			return false;
		}
		if(document.all("form1:A016030").value==""){
			alert("�»�������Ϊ��");
			return false;
		}else{
			if(document.all("form1:postId").value!=null&&document.all("form1:postId").value!=""){
				document.all("form1:A001715").value=document.all("form1:postId").value;
			}
			return forsubmit(document.forms(0))
		}
	}
	function selPost(){
		var deptId=document.all("form1:A016030").code;
		if(deptId==null || deptId==''){
			alert("��ѡ�����");
			return false;
		}
		PopUpPostDlgByDept(document.all("form1:postId"),document.all("form1:A001715"),deptId);
	}
    function selAfterPost(){
        var deptId=document.all("form1:A016030").code;
        PopUpPostDlgByDept(document.all("form1:AfterA001715"),null,deptId);
    }

</script>
    <x:saveState value="#{emppostChangeMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emppostChangeMgrBB.initEdit}"/>
        <h:inputHidden id="postId" value=""></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr>
            <td class=td_form01> <%=LanguageSupport.getResource("XTGL-1352", "��Ա����")%></td>
            <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{emppostChangeMgrBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden id="personIds" value="#{emppostChangeMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="ѡ��" rendered="#{emppostChangeMgrBB.enableSelect}" onclick="return selectPerson()" action="#{emppostChangeMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>

            <tr nowrap>
                <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2421", "�»���")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A016030" value="#{emppostChangeMgrBB.emppostchangbo.newDept}" dict="yes" dict_num="OU"  code=""
                            readonly="true"    alt="���벿��|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_org" onclick="return selectDept();">
                    <font color=red><strong>��ѡ����ײ㲿�Ż����</strong></font>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2020", "�¸�λ")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A001715" value="#{emppostChangeMgrBB.emppostchangbo.newPost}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="�¸�λ|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_post" onclick="return selPost()">
                    <h:outputText escape="false" value="<strong>��ְ��</strong>" rendered="#{sys_commonInfoBB.postChangeUseTitle}"></h:outputText>
</c:verbatim>
                    <h:inputText styleClass="input" rendered="#{sys_commonInfoBB.postChangeUseTitle}" id="A705705" value="#{emppostChangeMgrBB.emppostchangbo.newJob}" dict="yes" dict_num="0160"  code=""
                            readonly="true"    alt="��ְ��|1|s|50||"/>
                    <h:commandButton type="button" styleClass="button_post" rendered="#{sys_commonInfoBB.postChangeUseTitle}" onclick="PopUpCodeDlgOneControl('form1:A705705')"/>
<c:verbatim>
                </td>
            </tr>

    <tr nowrap>
        <td class=td_form01>�䶯���</td>
        <td class=td_form02 colspan="3">
</c:verbatim>
            <h:inputText styleClass="input" id="changeType" value="#{emppostChangeMgrBB.emppostchangbo.changeType}" dict="yes" dict_num="0205"  code=""
                    readonly="true"    alt="�䶯���|1|s|50||"/>
<c:verbatim>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:changeType');">
        </td>
    </tr>

    <tr nowrap>
        <td class=td_form01>�䶯ԭ��</td>
        <td class=td_form02 colspan="3">
</c:verbatim>
            <h:inputText styleClass="input" id="changeReason" value="#{emppostChangeMgrBB.emppostchangbo.changeReason}" dict="yes" dict_num="0210"  code=""
                    readonly="true"    alt="�䶯ԭ��|1|s|50||"/>
<c:verbatim>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:changeReason');">
        </td>
    </tr>

    <tr nowrap>
        <td class=td_form01>�䶯����</td>
        <td class=td_form02 colspan="3">
</c:verbatim>
            <h:inputText styleClass="input" value="#{emppostChangeMgrBB.emppostchangbo.changeBase}" alt="�䶯����|1|s|50||"/>
<c:verbatim>
        </td>
    </tr>

    <tr nowrap>
        <td class=td_form01>�䶯�ĺ�</td>
        <td class=td_form02 colspan="3">
</c:verbatim>
            <h:inputText styleClass="input" value="#{emppostChangeMgrBB.emppostchangbo.changeLetterNO}" alt="�䶯�ĺ�|1|s|50||"/>
<c:verbatim>
        </td>
    </tr>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 >
            <tr>
                <td align="left">
</c:verbatim>
                      <h:selectBooleanCheckbox rendered="#{sys_commonInfoBB.enablePostBeginLink}" value="#{emppostChangeMgrBB.enableBegin}"></h:selectBooleanCheckbox>
                      <h:outputText value="ͬʱ������ϰ����" rendered="#{sys_commonInfoBB.enablePostBeginLink}"></h:outputText>
                </td>
                 <td align="right">
                      <h:commandButton id="save" styleClass="button01" value="����" onclick="return checkData();" action="#{emppostChangeMgrBB.save}" />
                 </td>
<c:verbatim>
            </tr>
            <tr>
                <td colspan="2" align="left">
   </c:verbatim>
                    <h:outputText value="��ϰ���λ����" rendered="#{sys_commonInfoBB.enablePostBeginLink}"></h:outputText>
                    <h:inputText rendered="#{sys_commonInfoBB.enablePostBeginLink}" styleClass="input" id="AfterA001715" value="#{emppostChangeMgrBB.emppostchangbo.passPost}" dict="yes" dict_num="PO"  code=""       readonly="true"    alt="ת�����λ|1|s|50||"/>
                    <h:commandButton styleClass="button_post" rendered="#{sys_commonInfoBB.enablePostBeginLink}" type="button" onclick="selAfterPost();"></h:commandButton>

                    <h:outputText value="��ϰ���λ����" rendered="#{sys_commonInfoBB.enablePostBeginLink}"></h:outputText>
                    <h:inputText rendered="#{sys_commonInfoBB.enablePostBeginLink}" styleClass="input" id="AfterA001716" value="#{emppostChangeMgrBB.emppostchangbo.passPostLevel}" dict="yes" dict_num="2238"  code=""           readonly="true"    alt="ת�����λ����|1|s|50||"/>

                    <h:commandButton styleClass="button_select" rendered="#{sys_commonInfoBB.enablePostBeginLink}" type="button" onclick="PopUpCodeDlgOneControl('form1:AfterA001716');"></h:commandButton>
<c:verbatim>
                </td>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>