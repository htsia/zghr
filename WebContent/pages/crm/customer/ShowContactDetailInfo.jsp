<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<h:inputHidden value="#{customerBB.contacDetaiInfo}"></h:inputHidden>
<f:verbatim>


    <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="联系人管理  - > 联系人详细信息 " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>

<table width="95%" height="45" border="0" align="center" >
  <tr>
    <td    align="right"><div align="right">
      </f:verbatim>
        <h:commandButton value="返回"  styleClass="button01" onclick="window.close();"/>
      <f:verbatim>
    </div></td>
  </tr>
</table>
<table width="95%" height="45" border="1" align="center" class="table02">
  <tr>
    <td align="right" class="td_form01 ">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
    <td width="80" align="left"></f:verbatim>
         <h:outputText value="#{customerBB.contactBO.person_name}"   ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
    <td></f:verbatim>
    	  <h:outputText   value="#{customerBB.contactBO.sex}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</td>
    <td ></f:verbatim>
      <h:outputText    value="#{customerBB.contactBO.duty}"></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</td>
    <td></f:verbatim>
      <h:outputText    value="#{customerBB.contactBO.mobile}"></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">家庭电话：</td>
    <td align="left"></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.home_tel}"  ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">办公电话：</td>
    <td></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.office_tel}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;QQ：</td>
    <td align="left"></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.qq}" ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MSN：</td>
    <td></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.msn}"></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
    <td align="left"></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.fax}" ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;Email：</td>
    <td></f:verbatim>
      <h:outputText  value="#{customerBB.contactBO.email}"  ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">主联系人</td>
    <td align="left" colspan="3"></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.primaryPerson}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  
   <tr>
    <td height="17" colspan="4" class="td_form01 ">客户描述：<br>
    </f:verbatim>
        <h:outputText value="#{customerBB.contactBO.remark}" >
        </h:outputText>
     <f:verbatim>
    </td>
  </tr>
</table>
</f:verbatim>