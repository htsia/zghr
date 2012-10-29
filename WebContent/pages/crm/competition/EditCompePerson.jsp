<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function forSave(){
	 if (forCheck()== true) {
       forsubmit(document.forms(0));
       return true ;
   }
	 else {
		  return false ;
       }
	   }

function forCheck(){

   if(document.all("form1:name").value == ""){
           alert("名字不能为空!");
           document.all("form1:name").focus();
           return false;
          }
   if(document.all("form1:sex").value == ""){
       alert("性别不能为空!");
       document.all("form1:sex").focus();
       return false;
      }
   else{
       return true ;
       }  
       true ;
   }

</script>
<x:saveState value="#{compPersonBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{compPersonBB.editInit}"></h:inputHidden>
	<h:inputHidden value="#{compPersonBB.compeId}"></h:inputHidden>
	<f:verbatim>
		<table id="tree" width="100%" border="0" align="center">
		    <tr>
		      <td class="td_title" width="100%" colspan="4"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif" />
			   <h:outputText value="人员管理  -> 编辑"></h:outputText></td>
		      <f:verbatim>
		    </tr>
		
			<tr>
				<td colspan="4" align="right"></f:verbatim> <h:commandButton value="保存"
					onclick="return forSave();" styleClass="button01"
					action="#{compPersonBB.saveOrUpdateCompPersonBO}" /> <f:verbatim>&nbsp;</f:verbatim>
				<h:commandButton value="返回" styleClass="button01"
					onclick="window.close();" /> <f:verbatim></td>
			</tr>
		</table>

		<table  width="98%" border="1" align="center" class="table02">

			<tr>
				<td class="td_form01 td_form_required">姓名：</td>
				<td></f:verbatim> <h:inputText id="name" styleClass="inputDark"
					value="#{compPersonBB.compPersonBO.personName}"></h:inputText> <f:verbatim></td>

				<td class="td_form01 td_form_required">性别：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark" id="sex" code=""
					dict="yes" dict_num="0100" readonly="true"
					value="#{compPersonBB.compPersonBO.sex}"></h:inputText> <h:commandButton
					type="button" styleClass="button_select"
					onclick="PopUpCodeDlgOneControl('form1:sex')" /> <f:verbatim></td>
			</tr>

			<tr>
				<td class="td_form01 ">手机：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark" id="mobile"
					value="#{compPersonBB.compPersonBO.mobile}"></h:inputText> <f:verbatim></td>
				<td class="td_form01 ">办公电话：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark"
					value="#{compPersonBB.compPersonBO.officeTel}"></h:inputText> <f:verbatim></td>
			</tr>

			<tr>
				<td class="td_form01 ">家庭电话：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark"
					value="#{compPersonBB.compPersonBO.homeTel}"  ></h:inputText>
				<f:verbatim></td>
				<td class="td_form01 ">QQ：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark"
					value="#{compPersonBB.compPersonBO.qq}"  ></h:inputText> <f:verbatim></td>
			</tr>

			<tr>
				<td class="td_form01 ">eMail：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark"
					value="#{compPersonBB.compPersonBO.email}"  ></h:inputText>
				<f:verbatim></td>
				<td class="td_form01 ">MSN：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark"
					value="#{compPersonBB.compPersonBO.msn}"  ></h:inputText> <f:verbatim></td>
			</tr>

			<tr>
				<td class="td_form01 ">传真：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark"
					value="#{compPersonBB.compPersonBO.fax}"  ></h:inputText> <f:verbatim></td>
				<td class="td_form01 ">职务：</td>
				<td></f:verbatim> <h:inputText styleClass="inputDark"
					value="#{compPersonBB.compPersonBO.duty}"  ></h:inputText>
				<f:verbatim></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>

















