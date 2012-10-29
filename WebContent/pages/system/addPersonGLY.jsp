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
    //身份证号
    var idCard = document.all("form1:A001077").value;
    if (idCard.trim() != "") {
        if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
            alert("身份证号应为15位或者18位!");
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
				<td class="td_title"><img src="/images/tips.gif"> <%=LanguageSupport.getResource("XTGL-0900", "系统管理")%>
					-> <%=LanguageSupport.getResource("XTGL-1167", "增加用户")%></td>
				<td class="td_title"><font color=red> <%
 		   if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE)) {
 				out.println(LanguageSupport.getResource("XTGL-1168", "注意：新增人员需审批后才生效"));
 			}
 			if ("1".equals(Constants.AUTO_OPEN_USER)) {
 				out.println(LanguageSupport.getResource("XTGL-1169", "自动开通用户"));
 			}
 			if ("1".equals(Constants.DEFAULT_SH_NAME_FIELD)) {
 				out.println(LanguageSupport.getResource("XTGL-1170", "默认登陆名:员工编号"));
 			} else if ("2".equals(Constants.DEFAULT_SH_NAME_FIELD)) {
 				out.println(LanguageSupport.getResource("XTGL-1171", "默认登陆名:身份证号"));
 			} else {
 				out.println(LanguageSupport.getResource("XTGL-1172", "默认登陆名:姓名简拼"));
 			}
 			if ("1".equals(Constants.DEFAULT_SH_PASSWORD_TYPE)) {
 				out.println(LanguageSupport.getResource("XTGL-1173", "默认密码")+Constants.DEFAULT_SH_PASSWORD );
 			} else {
 				out.println(LanguageSupport.getResource("XTGL-1174", "默认密码:身份证后4位")+Constants.DEFAULT_SH_PASSWORD );
 			}
 %> </font></td>
			</tr>
		</table>
		<br>


		<table width=95% align=center border=0 cellpadding=0 cellspacing=0
			class="table03">
			<tr nowrap>
				<td class="td_form01 " width="120">
				<%=LanguageSupport.getResource("XTGL-1168", "用户编号")%>
			   </td>
				<td class="td_form02"></f:verbatim> <h:inputText styleClass="input"
						id="A001735" value="#{emp_personAddBB.personvo.personCode}"
						alt="用户编号|1|s|50||" /> <f:verbatim>
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
				    <%=LanguageSupport.getResource("XTGL-1043", "身份证号")%>
			   </td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="A001077" size="22" value="#{emp_personAddBB.personvo.idNum}"
						alt="身份证号|0|s|50||" /> <f:verbatim>
				</td>

			</tr>
			<tr nowrap>
				<td class="td_form01 td_form_required" width="120">
				 <%=LanguageSupport.getResource("MSG-0010", "姓名  ")%>
				</td>
				<td class="td_form02"></f:verbatim> <h:inputText styleClass="input"
						id="A001001" value="#{emp_personAddBB.personvo.name}"
						alt="姓名|0|s|50||" /> <f:verbatim>
				</td>
				<td class="td_form01 td_form_required">
				<%=LanguageSupport.getResource("XTGL-1044", " 员工类别  ")%>
				</td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="A001054" code="" dict="yes" dict_num="0135" readonly="true"
						value="#{emp_personAddBB.personvo.personType}" alt="员工类别|0|s|50||" />
					<f:verbatim>
						<input type="button" class="button_select"
							onclick="PopUpCodeDlgOneControl('form1:A001054')">
				</td>


			</tr>

			<tr nowrap>
				<td class="td_form01 td_form_required">
				 <%=LanguageSupport.getResource("XTGL-1045", "所在部门  ")%>
			   </td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="A001705" code="" dict="yes" dict_num="OU" readonly="true"
						value="#{emp_personAddBB.personvo.deptId}" alt="所在部门|0|s|50||" />
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
				<td align="right"></f:verbatim> <h:commandButton value=" 增加 "
						onclick="javascript:return forSave()" styleClass="button01"
						action="#{emp_personAddBB.createManger}" />&nbsp;&nbsp; <h:commandButton
						value=" 取消 " styleClass="button01"
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
