<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<h:inputHidden value="#{customerBB.contacDetaiInfo}"></h:inputHidden>
<f:verbatim>


    <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="��ϵ�˹���  - > ��ϵ����ϸ��Ϣ " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>

<table width="95%" height="45" border="0" align="center" >
  <tr>
    <td    align="right"><div align="right">
      </f:verbatim>
        <h:commandButton value="����"  styleClass="button01" onclick="window.close();"/>
      <f:verbatim>
    </div></td>
  </tr>
</table>
<table width="95%" height="45" border="1" align="center" class="table02">
  <tr>
    <td align="right" class="td_form01 ">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����</td>
    <td width="80" align="left"></f:verbatim>
         <h:outputText value="#{customerBB.contactBO.person_name}"   ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
    <td></f:verbatim>
    	  <h:outputText   value="#{customerBB.contactBO.sex}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">ְ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;λ��</td>
    <td ></f:verbatim>
      <h:outputText    value="#{customerBB.contactBO.duty}"></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����</td>
    <td></f:verbatim>
      <h:outputText    value="#{customerBB.contactBO.mobile}"></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">��ͥ�绰��</td>
    <td align="left"></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.home_tel}"  ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">�칫�绰��</td>
    <td></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.office_tel}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;QQ��</td>
    <td align="left"></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.qq}" ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MSN��</td>
    <td></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.msn}"></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�棺</td>
    <td align="left"></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.fax}" ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 ">&nbsp;&nbsp;&nbsp;&nbsp;Email��</td>
    <td></f:verbatim>
      <h:outputText  value="#{customerBB.contactBO.email}"  ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td align="right" class="td_form01 ">����ϵ��</td>
    <td align="left" colspan="3"></f:verbatim>
      <h:outputText   value="#{customerBB.contactBO.primaryPerson}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  
   <tr>
    <td height="17" colspan="4" class="td_form01 ">�ͻ�������<br>
    </f:verbatim>
        <h:outputText value="#{customerBB.contactBO.remark}" >
        </h:outputText>
     <f:verbatim>
    </td>
  </tr>
</table>
</f:verbatim>