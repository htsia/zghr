<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function forCheck() {
    //���֤��
    var idCard = document.all("form1:A001077").value;
    if (idCard.trim() != "") {
        if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
            alert("���֤��ӦΪ15λ����18λ!");
            return false;
        }
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
	<h:inputHidden id="type" value="#{emp_personAddBB.type}"></h:inputHidden>
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="td_title"><img src="/images/tips.gif"> <%=LanguageSupport.getResource("XTGL-0900", "ϵͳ����")%>
					-> <%=LanguageSupport.getResource("XTGL-1167", "�����û�")%></td>
				<td class="td_title"><font color=red> <%
 		   if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE)) {
 				out.println(LanguageSupport.getResource("XTGL-1168", "ע�⣺������Ա�����������Ч"));
 			}
 			if ("1".equals(Constants.AUTO_OPEN_USER)) {
 				out.println(LanguageSupport.getResource("XTGL-1169", "�Զ���ͨ�û�"));
 			}
 			if ("1".equals(Constants.DEFAULT_SH_NAME_FIELD)) {
 				out.println(LanguageSupport.getResource("XTGL-1170", "Ĭ�ϵ�½��:Ա�����"));
 			} else if ("2".equals(Constants.DEFAULT_SH_NAME_FIELD)) {
 				out.println(LanguageSupport.getResource("XTGL-1171", "Ĭ�ϵ�½��:���֤��"));
 			} else {
 				out.println(LanguageSupport.getResource("XTGL-1172", "Ĭ�ϵ�½��:������ƴ"));
 			}
 			if ("1".equals(Constants.DEFAULT_SH_PASSWORD_TYPE)) {
 				out.println(LanguageSupport.getResource("XTGL-1173", "Ĭ������")+Constants.DEFAULT_SH_PASSWORD );
 			} else {
 				out.println(LanguageSupport.getResource("XTGL-1174", "Ĭ������:���֤��4λ")+Constants.DEFAULT_SH_PASSWORD );
 			}
 %> </font></td>
			</tr>
		</table>
		<br>


		<table width=95% align=center border=0 cellpadding=0 cellspacing=0
			class="table03">
			<tr nowrap>
				<td class="td_form01 " width="120">
				<%=LanguageSupport.getResource("XTGL-1168", "�û����")%>
			   </td>
				<td class="td_form02"></f:verbatim> <h:inputText styleClass="input"
						id="A001735" value="#{emp_personAddBB.personvo.personCode}"
						alt="�û����|1|s|50||" /> <f:verbatim>
				</td>
				<%
					try {
								IPersonUCC uu = (IPersonUCC) SysContext
										.getBean("emp_personUCC");
								User user = (User) session
										.getAttribute(Constants.USER_INFO);
								out.print("<script type=\"text/javascript\">");
								out.print("     document.all('form1:A001735').value=\""
										+ uu.getNextPersonCode(user.getOrgId()) + "\"");
								out.print("</script>");
							} catch (Exception e) {

							}
				%>
				<td class="td_form01 td_form_required">
				    <%=LanguageSupport.getResource("XTGL-1043", "���֤��")%>
			   </td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="A001077" size="22" value="#{emp_personAddBB.personvo.idNum}"
						alt="���֤��|0|s|50||" /> <f:verbatim>
				</td>

			</tr>
			<tr nowrap>
				<td class="td_form01 td_form_required" width="120">
				 <%=LanguageSupport.getResource("MSG-0010", "����  ")%>
				</td>
				<td class="td_form02"></f:verbatim> <h:inputText styleClass="input"
						id="A001001" value="#{emp_personAddBB.personvo.name}"
						alt="����|0|s|50||" /> <f:verbatim>
				</td>
				<td class="td_form01 td_form_required">
				<%=LanguageSupport.getResource("XTGL-1044", " Ա�����  ")%>
				</td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="A001054" code="" dict="yes" dict_num="0135" readonly="true"
						value="#{emp_personAddBB.personvo.personType}" alt="Ա�����|0|s|50||" />
					<f:verbatim>
						<input type="button" class="button_select"
							onclick="PopUpCodeDlgOneControl('form1:A001054')">
				</td>


			</tr>

			<tr nowrap>
				<td class="td_form01 td_form_required">
				 <%=LanguageSupport.getResource("XTGL-1045", "���ڲ���  ")%>
			   </td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="A001705" code="" dict="yes" dict_num="OU" readonly="true"
						value="#{emp_personAddBB.personvo.deptId}" alt="���ڲ���|0|s|50||" />
					<f:verbatim>
						<input type="button" class="button_select"
							onclick="PopUpOrgDlg('form1:A001705',2)">
				</td>
			</tr>
		</table>
		<br>


		<br>
		<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
			<tr>
				<td align="right"></f:verbatim> <h:commandButton value=" ���� "
						onclick="javascript:return forSave()" styleClass="button01"
						action="#{emp_personAddBB.createManger}" />&nbsp;&nbsp; <h:commandButton
						value=" ȡ�� " styleClass="button01"
						action="#{emp_personAddBB.cancelPerson}"></h:commandButton> <f:verbatim>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>

<script type="text/javascript">
    document.all('form1:A001054').value="<%=Constants.MANAGER_PERSONTYPE%>";
    interpret(document.forms(0));
</script>
