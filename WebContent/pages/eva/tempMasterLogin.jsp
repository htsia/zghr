<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	var name=document.all("form1:loginName").value;
	 var pwd=document.all("form1:password").value;
	  if(name!=null && name!="" && pwd!=null && pwd!=""){
	       
	        return true;
		  }else{
			  alert("������û���������Ϊ�գ�");
			  return false;
	 }
	 }
  </script>
<h:form id="form1">
<h:inputHidden id="initPage" value="#{user_loginBB.initPage}"></h:inputHidden>
	<f:verbatim>
		<table width="100%" height="100%" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td height='100%' width='100%'><img alt=""
					src='../images/maininterface/login_backgroud.jpg' width=100%
					height=100%
					style='position: absolute; top: 0; left: 0; z-index: -1'></td>
			</tr>
		</table>

		<table id="center" style='POSITION: absolute;' width='400'
			cellspacing=0 cellpadding=0 border=0>
			<tr height="35">
				<td></td>
				<td></td>
				<td width="54" rowspan="2"></td>
			</tr>
			<tr height="35">
				<td></td>
				<td></td>
				<td width="54" rowspan="2"></td>
			</tr>
			<tr height="20">
				<td></td>
				<td></td>
				<td width="54" rowspan="2"></td>
			</tr>
			<tr>
				<td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;�û�����</font></td>
				<td></f:verbatim> <h:inputText id="loginName" styleClass="inputDark"
					alt="�û���|0|s|50" value="#{user_loginBB.loginName}" size="22"
					tabindex="1" /> <f:verbatim>
					</f:verbatim>
				<h:commandButton
					onclick="return test()" styleClass="button01"
					value="#{user_loginBB.loginButton}"
					action="#{user_loginBB.tempMasterLogin}" tabindex="3" rendered="#{user_loginBB.isExist==false}"/>
				<f:verbatim>
					</td>
				<td width="54" rowspan="2">
				
				</td>
			</tr>
			<tr height="50">
			
			</tr>
			<tr>
				<td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;��
				�룺</font></td>
				<td></f:verbatim> <h:inputSecret id="password" styleClass="inputDark"
					alt="����|0|s|50" value="#{user_loginBB.password}" size="22"
					tabindex="2" /> <f:verbatim></td>
				<td width="54" rowspan="2"></td>
			</tr>
			<tr height="10">
				<td align="right"></td>
				<td></td>
				<td width="54" rowspan="2"></td>
			</tr>
			

			<tr>
				<td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;</f:verbatim>
				 <h:outputLabel value="ȷ������:" rendered="#{user_loginBB.isExist==true}"/>
				<f:verbatim>
				</font></td>
				<td></f:verbatim> <h:inputSecret id="repassword" styleClass="inputDark" rendered="#{user_loginBB.isExist==true}"
					alt="����|0|s|50"  value="#{user_loginBB.repassword}" size="22"
					tabindex="2" /> <f:verbatim></td>
				<td width="20" rowspan="2"></td>
			</tr>
			<tr height="10">
				<td></td>
				<td rowspan="1"></td>
				<td width="5" rowspan="2"></td>
			</tr>
			
			
			<tr>
				<td align="right"><font color="red">&nbsp;</f:verbatim>
				 <h:outputLabel value="��ʾ��Ϣ:" rendered="#{user_loginBB.isExist==true}"/>
				<f:verbatim>
				</font></td>
				<td><font color="red">&nbsp;</f:verbatim><h:outputText value="��Ϊ�״ε�¼��������������ٵ�¼��" rendered="#{user_loginBB.isExist==true}"></h:outputText><f:verbatim></font></td>
				<td width="20" rowspan="2"></td>
			</tr>
			<tr height="0">
				<td></td>
				<td rowspan="1"></td>
				<td width="7" rowspan="2"></td>
			</tr>
			
			
			
			<tr>
				<td align="right"></td>
				<td align="center"></f:verbatim>  
					 <h:commandButton onclick="return test()"
					styleClass="button01" value="��������" rendered="#{user_loginBB.isExist==true}"
					action="#{user_loginBB.tempMasterSave}" tabindex="3" /> <f:verbatim></td>
				<td width="54" rowspan="2"></td>
			</tr>
			<tr>
				<td></td>
				<td align="right"></td>
			</tr>
		</table>
		<table id=bottom style='POSITION: absolute;' width='99%' cellspacing=0
			cellpadding=0 border=0>
			<tr>
				<td align="right"><script type="text/javascript">
            document.write("��ϵͳ�Զ���Ӧ�ֱ��ʣ������ڵķֱ�����:"+screen.width+"*"+screen.height);
         </script></td>
			<tr>
			<tr>
				<td align="right">
				<%
					out.println(CommonFuns.filterNull(Constants.COMPANY_NAME));
				%>
				</td>
			<tr>
		</table>
		<script type="text/javascript">
        var logintop=document.body.clientHeight/2*1-30;
        var loginleft=document.body.clientWidth /2*1;
        document.all("center").style.top=logintop;
        document.all("center").style.left=loginleft;

        logintop=document.body.clientHeight*0.86;
        document.all("bottom").style.top=logintop;
    </script>

	</f:verbatim>
</h:form>

