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
        <h:commandButton value="返回"  styleClass="button01" onclick="window.close();"/>
      <f:verbatim>
   </td>
  </tr>
</table>
<table width="95%" height="45" border="1" align="center" class="table02">
  <tr>
    <td class="td_form01 " >客户名称：</td>
    <td width="80" align="left"></f:verbatim>
         <h:outputText value="#{customerBB.customerBO.cu_name}"   ></h:outputText>
      <f:verbatim></td>
    <td  align="right" class="td_form01 ">国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;籍：</td>
    <td  width="80" ></f:verbatim>
    	  <h:outputText   value="#{customerBB.customerBO.cu_nation}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：</td>
    <td ></f:verbatim>
      <h:outputText    value="#{customerBB.customerBO.cu_city}"></h:outputText>
      <f:verbatim></td>
    <td  align="right" class="td_form01 ">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编：</td>
    <td></f:verbatim>
      <h:outputText    value="#{customerBB.customerBO.zip}"></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">创建人员：</td>
    <td align="left"></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.createor}"  ></h:outputText>
      <f:verbatim></td>
    <td align="right" class="td_form01 " >创建时间：</td>
    <td></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.create_date}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">客户类型：</td>
    <td align="left" colspan="3"></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.cu_type}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">客户地址：</td>
    <td align="left" colspan="3"></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.cu_addr}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td class="td_form01 ">客户网站：</td>
    <td align="left" colspan="3"></f:verbatim>
      <h:outputText   value="#{customerBB.customerBO.web_url}" ></h:outputText>
      <f:verbatim></td>
  </tr>
   <tr>
    <td align="left"  headers="50"    colspan="4" ><font class="td_form01">客户描述：</font><br><br>
       &nbsp; &nbsp; &nbsp;
      </f:verbatim>
      <h:outputText  styleClass="f08"  value="#{customerBB.customerBO.description}" ></h:outputText>
      <f:verbatim></td>
  </tr>
  <tr>
    <td colspan="4">
    </f:verbatim>
          <h:outputLabel value="客户联系人："  styleClass="td_form01"></h:outputLabel>
        <x:dataTable value="#{customerBB.conactList}" id="dateList1"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_left,td_middle_center,td_middle_center,td_middle_center,td_middle_left,
					td_middle_left,td_middle_left,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.person_name}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="性别" />
						</c:facet>
						<h:outputText value="#{list.sex}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="手机" />
						</c:facet>
						<h:outputText value="#{list.mobile}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="办公电话" />
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
							<h:outputText value="传真" />
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
          <h:outputLabel value="客户活动列表："  styleClass="td_form01"></h:outputLabel>
        <x:dataTable value="#{customerBB.activeList}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="活动名称" />
						</c:facet>
						<h:outputText value="#{list.act_name}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="方式" />
						</c:facet>
						<h:outputText value="#{list.act_method}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="联系人" />
						</c:facet>
						<h:outputText value="#{list.conectionName}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="优先级" />
						</c:facet>
						<h:outputText value="#{list.level}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="状态" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="开始日期" />
						</c:facet>
						<h:outputText value="#{list.begin_date}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="开始时间" />
						</c:facet>
						<h:outputText value="#{list.begin_time}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="结束日期" />
						</c:facet>
						<h:outputText value="#{list.end_date}" />
					</h:column>
					
				<h:column>
						<c:facet name="header">
							<h:outputText value="结束时间" />
						</c:facet>
						<h:outputText value="#{list.end_time}" />
					</h:column>
					
						
				<h:column>
						<c:facet name="header">
							<h:outputText value="提前提醒" />
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












