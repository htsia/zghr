<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden  value="#{customerBB.detailInit}"/>
<f:verbatim>
<table width="95%" height="45" border="0" align="center"  >

 <tr>
    <td   align="right" >
      </f:verbatim>
        <h:commandButton value="����"  styleClass="button01" onclick="window.close();"/>
      <f:verbatim>
   </td>
  </tr>
</table>
<table width="95%" height="45" border="1" align="center" class="table02">
  <tr>
    <td class="td_form01 " >�ͻ����ƣ�</td>
    <td width="80" align="left"></f:verbatim>
         <h:outputText value="#{customerBB.customerBO.cu_name}"   ></h:outputText>
      <f:verbatim></td>
    <td  align="right" class="td_form01 ">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����</td>
    <td  width="80" ></f:verbatim>
    	  <h:outputText   value="#{customerBB.customerBO.cu_nation}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�У�</td>
    <td ></f:verbatim>
      <h:outputText    value="#{customerBB.customerBO.cu_city}"></h:outputText>
      <f:verbatim></td>
    <td  align="right" class="td_form01 ">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ࣺ</td>
    <td></f:verbatim>
      <h:outputText    value="#{customerBB.customerBO.zip}"></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">������Ա��</td>
    <td align="left"></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.createor}"  ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 " >����ʱ�䣺</td>
    <td></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.create_date}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">�ͻ����ͣ�</td>
    <td align="left" colspan="3"></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.cu_type}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">�ͻ���ַ��</td>
    <td align="left" colspan="3"></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.cu_addr}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">�ͻ���վ��</td>
    <td align="left" colspan="3"></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.web_url}" ></h:outputText>
      <f:verbatim></td>
  </tr>
   <tr>
    <td align="left"  headers="50"    colspan="4" ><font class="td_form01">�ͻ�������</font><br><br>
       &nbsp; &nbsp; &nbsp;
      </f:verbatim>
      <h:outputText  styleClass="f08"  value="#{customerBB.customerBO.description}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td colspan="4">
    </f:verbatim>
          <h:outputLabel value="�ͻ���ϵ�ˣ�"  styleClass="td_form01"></h:outputLabel>
        <x:dataTable value="#{customerBB.conactList}" id="dateList1"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_left,td_middle_center,td_middle_center,td_middle_center,td_middle_left,
					td_middle_left,td_middle_left,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.person_name}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ա�" />
						</c:facet>
						<h:outputText value="#{list.sex}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="�ֻ�" />
						</c:facet>
						<h:outputText value="#{list.mobile}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="�칫�绰" />
						</c:facet>
						<h:outputText value="#{list.office_tel}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="Email" />
						</c:facet>
						<h:outputText value="#{list.email}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="MSN" />
						</c:facet>
						<h:outputText value="#{list.msn}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.fax}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="QQ" />
						</c:facet>
						<h:outputText value="#{list.qq}" />
					</h:column>
					
			
				</x:dataTable>	
    <f:verbatim>
    </td>
  </tr>
  
  <tr>
    <td colspan="4">
    </f:verbatim>
          <h:outputLabel value="�ͻ���б�"  styleClass="td_form01"></h:outputLabel>
        <x:dataTable value="#{customerBB.activeList}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="�����" />
						</c:facet>
						<h:outputText value="#{list.act_name}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="��ʽ" />
						</c:facet>
						<h:outputText value="#{list.act_method}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="��ϵ��" />
						</c:facet>
						<h:outputText value="#{list.conectionName}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="���ȼ�" />
						</c:facet>
						<h:outputText value="#{list.level}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="״̬" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="��ʼ����" />
						</c:facet>
						<h:outputText value="#{list.begin_date}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="��ʼʱ��" />
						</c:facet>
						<h:outputText value="#{list.begin_time}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.end_date}" />
					</h:column>
					
				<h:column>
						<c:facet name="header">
							<h:outputText value="����ʱ��" />
						</c:facet>
						<h:outputText value="#{list.end_time}" />
					</h:column>
					
						
				<h:column>
						<c:facet name="header">
							<h:outputText value="��ǰ����" />
						</c:facet>
						<h:outputText value="#{list.alert_day}" />
					</h:column>
					
				</x:dataTable>	
    <f:verbatim>
    </td>
  </tr>
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
	setDataTableOver("form1:dateList");
	setDataTableOver("form1:dateList1");
</script>












