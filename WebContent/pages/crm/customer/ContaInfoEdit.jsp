<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
function forSave(){
	if (forCheck()== true) {
        debugger;   
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
        if(document.all("form1:duty").value == ""){
            alert("职位不能为空!");
            document.all("form1:duty").focus();
            return false;
           }
        if(document.all("form1:mobile").value == ""){
            alert("手机号码不能为空!");
            document.all("form1:mobile").focus();
            return false;
           }
        else{
            return true ;
            }
        }
    
</script>
<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{customerBB.modifcontaInfo}"></h:inputHidden>
<h:inputHidden id="cuid" value="#{customerBB.cuId}"></h:inputHidden>
<f:verbatim>

    <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="联系人管理  - > 编辑联系人 " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>

<table width="95%" height="45" border="0" align="center" >
  <tr>
    <td  align="right">
      </f:verbatim>
       <h:commandButton value="保存"    onclick="return forSave();" styleClass="button01"  action="#{customerBB.saveOrUpdate}">
       </h:commandButton>
       <f:verbatim>&nbsp;</f:verbatim>
        <h:commandButton value="返回"  styleClass="button01" onclick="window.close();"/>
      <f:verbatim>
    </td>
  </tr>
  </table>
<table width="95%" height="45" border="1" align="center" class="table02">
  <tr>
    <td align="right" class="td_form01 "  ><font class="f07">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</font>：</td>
    <td width="80" align="left"></f:verbatim>
        <h:inputText  id="name"  value="#{customerBB.contactBO.person_name}" />
        <h:inputText style="display:none"  value="#{customerBB.contactBO.cu_id}" />
      <f:verbatim>
      </td>
      
    <td align="right" id="sex" class="td_form01 "><font class="f07">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</font></td>
    
     <td></f:verbatim>
          <h:inputText styleClass="inputDark" id="sex" code="" dict="yes" dict_num="0100"
                     readonly="true"  
                     value="#{customerBB.contactBO.sex}"></h:inputText>
       <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:sex')" />
      <f:verbatim>
      </td>
  </tr>
  
   <tr>
    <td align="right" class="td_form01 ">主联系人：</td>
    <td colspan="3"></f:verbatim>
         <h:inputText styleClass="inputDark" id="primaryPerson" code="" dict="yes" dict_num="0090"
                     readonly="true"  
                     value="#{customerBB.contactBO.primaryPerson}"></h:inputText>
       <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:primaryPerson')" />
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 "><font class="f07">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</font></td>
    <td ></f:verbatim>
        <h:inputText id="duty"  value="#{customerBB.contactBO.duty}" />
      <f:verbatim></td>
    <td align="right" class="td_form01 "><font class="f07">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</font></td>
    <td></f:verbatim>
        <h:inputText id="mobile"  value="#{customerBB.contactBO.mobile}" />
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">家庭电话：</td>
    <td align="left"></f:verbatim>
        <h:inputText   value="#{customerBB.contactBO.home_tel}" />
      <f:verbatim></td>
    <td align="right" class="td_form01 ">办公电话：</td>
    <td></f:verbatim>
        <h:inputText   value="#{customerBB.contactBO.office_tel}" />
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;QQ：</td>
    <td align="left"></f:verbatim>
        <h:inputText   value="#{customerBB.contactBO.qq}" />
      <f:verbatim></td>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MSN：</td>
    <td></f:verbatim>
        <h:inputText   value="#{customerBB.contactBO.msn}" />
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
    <td align="left"></f:verbatim>
        <h:inputText   value="#{customerBB.contactBO.fax}" />
      <f:verbatim></td>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;Email：</td>
    <td></f:verbatim>
        <h:inputText   value="#{customerBB.contactBO.email}" />
      <f:verbatim></td>
  </tr>
   <tr>
    <td height="17" colspan="4" class="td_form01 ">客户描述：<br>
    </f:verbatim>
        <h:inputTextarea value="#{customerBB.contactBO.remark}" rows="10" cols="82">
        </h:inputTextarea>
     <f:verbatim>
    </td>
  </tr>
</table>
</f:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
