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

</script>
<x:saveState value="#{doCheckInBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{doCheckInBB.initEdit}"></h:inputHidden>
<h:inputHidden id="personcode" value="#{doCheckInBB.personcode}"></h:inputHidden>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">���˲ſ�->�鿴
        </td>
        <td class="td_title" align="right">
        </td>
    </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>������Ϣ</td>
        <td class="td_form02">
		</td>
     </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01 td_form_required" width="100">����</td>
    <td class="td_form02">
</f:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{doCheckInBB.personBo.a001001}" alt="����|0|s|50||" readonly="true"/>
<f:verbatim>
    </td>
    <td width="15%" class="td_form01 ">�Ա�</td>
    <td class=td_form02 width="35%">
</f:verbatim>
        <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                     readonly="true" value="#{doCheckInBB.personBo.a001007}"
                     alt="�Ա�|1|s|50||"/>
<f:verbatim>
       </td>
</tr>
<tr nowrap>
    <td class="td_form01">��������</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001011" value="#{doCheckInBB.personBo.a001011}"
                     readonly="true" alt="��������|1|d|50||"/>
<f:verbatim>
       
    </td>
	 <td class=td_form01>����</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001021" code="" dict="yes" dict_num="0115"
                     readonly="true" value="#{doCheckInBB.personBo.a001021}"
                     alt="����|1|s|50||"/>
<f:verbatim>
     </td>
</tr>
<tr nowrap>
    <td class="td_form01 td_form_required">Email</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080725" code="" dict="yes" dict_num="0105"
                      value="#{doCheckInBB.addressBo.a080725}" readonly="true"/>
<f:verbatim>
    </td>
    <td class="td_form01 td_form_required">���֤��</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="22"
                     value="#{doCheckInBB.personBo.a001077}"
                     alt="���֤��|1|s|50||" readonly="true"/>
<f:verbatim>
    </td>
    
</tr>
</table>

<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>��ϵ��ʽ</td>
        <td class="td_form02">
		</td>
     </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr>
    <td class=td_form01 width="100">��ͥסַ</td>
    <td class=td_form02 width="31%">
</f:verbatim>
        <h:inputText styleClass="input" id="A001017" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{doCheckInBB.addressBo.a080721}"
                     alt="������|1|s|50||"/>
<f:verbatim>
        
    
    <td class=td_form01 width="100">�ƶ��绰</td>
    <td class=td_form02 >
</f:verbatim>
        <h:inputText styleClass="input" id="a080710" value="#{doCheckInBB.addressBo.a080710}" readonly="true"/>
<f:verbatim>
    </td>
</tr>
<tr>
    <td class=td_form01>��ͥ�绰</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080720" value="#{doCheckInBB.addressBo.a080720}" readonly="true"/>
<f:verbatim>
    </td>
    <td class=td_form01>��������</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080735" value="#{doCheckInBB.addressBo.a080735}" readonly="true"/></td>
<f:verbatim>
</tr>
</table>

<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>�ܽ������</td>
         <td class="td_form02">
		</td>
		<td></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{doCheckInBB.educationList}"    var="list">
        
         <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ѧ��" /></c:facet>
            <h:outputText value="#{list.a004005}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ҵԺУ" /></c:facet>
            <h:outputText value="#{list.a004035}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��ѧʱ��"/></c:facet>
            <h:outputText value="#{list.a004015}" />
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��ҵʱ��" /></c:facet>
            <h:outputText value="#{list.a004030}" />
        </h:column>
	</x:dataTable>
<f:verbatim>
    	
     	</td>
     </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>��������</td>
         <td >
		</td>
		<td></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList2"  align="center" border="0"  value="#{doCheckInBB.workInfoList}"    var="list">
        
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����" /></c:facet>
            <h:outputText value="#{list.a019015}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���¹���" /></c:facet>
            <h:outputText value="#{list.a019020}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.a019005}" />
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�뿪ʱ��" /></c:facet>
            <h:outputText value="#{list.a019010}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="֤����" /></c:facet>
            <h:outputText value="#{list.a019025}" />
        </h:column>
	</x:dataTable>
<f:verbatim>
    	
     	</td>
     </tr>
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
