<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
 function selectGroup(shareCuId){
	 window.showModalDialog("/crm/customer/SelectPersonItem.jsf?cuId="+shareCuId, null, "dialogWidth:150px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
	     return true;
	 }
 function group(){
	 document.all("group").className="activeTab";
	 document.all("person").className="tab";
	 document.all("dept").className="tab";
}

function person(){
	 document.all("group").className="tab";
	 document.all("person").className="activeTab";
	 document.all("dept").className="tab";
	 document.all("tree").src="/service/HandBookInfo.jsf?act=2";     
}

function dept(){
	 document.all("person").className="tab";
  	 document.all("group").className="tab";
  	 document.all("dept").className="activeTab";
  	 document.all("tree").src="/service/ProjectManager.jsf?act=3";     
   }
 </script>
<f:verbatim>
<br>
<table width="95%" align="center">
	<tr>
		<td id="group" align="center" width="10%" class="activeTab" onclick="group()">�Ŷӹ���</td>

		<td id="person" align="center" width="10%" onclick="person()" class=tab>��Ա����</td>

		<td  id="dept" align="center" width="10%" onclick="dept()" class=tab>���Ź���</td>
	</tr>
	</table>
 </f:verbatim>
<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{customerBB.shareInit}"></h:inputHidden>
<f:verbatim>
   <br>
   <table width="95%" border="0" align="center"  class="table01">
    <tr>
    <td colspan="4" class="f08">
     </f:verbatim>
            <h:outputLabel style="f141" value="#{customerBB.customerBO.cu_name}��������"></h:outputLabel>
     <f:verbatim> 
    <br>
     <hr color="blue" size="1" width="100%" align="left">
     </td>
  </tr>
  <tr>
    <td colspan="3" align="right"> 
      </f:verbatim>
         <h:selectOneRadio  value="#{customerBB.customerBO.power}" >
				<f:selectItem itemLabel="ֻ��" itemValue="1" />
				<f:selectItem itemLabel="��д" itemValue="2" />
	     </h:selectOneRadio>
     <f:verbatim>
    </td>
      <td colspan="1" align="right"> 
        </f:verbatim>  
            <h:commandButton  styleClass="button01"  value="ѡ�����Ŷ�"  onclick="return selectGroup('#{customerBB.customerBO.cu_id}') ;" />
            <h:commandButton value="����"  styleClass="button01"  onclick="return window.close();"/>
     <f:verbatim>
      </td>
  </tr>
  <tr>
    <td colspan="4"> 
      </f:verbatim>    
  <x:dataTable value="#{customerBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_left,td_middle_center,td_middle_center,td_middle_center,td_middle_left,
					td_middle_left,td_middle_left,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ŷ�����" />
						</c:facet>
						<h:outputText value="#{list.groupName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" />
						</f:facet>
						<h:commandButton   styleClass="button01" value="ȡ������" action="#{customerBB.cancleGroupShare}"  >
						   <x:updateActionListener value="#{list.groupId}" property="#{customerBB.shareBO.itemId}"></x:updateActionListener>
						</h:commandButton>
					</h:column>
				</x:dataTable>
 <f:verbatim>
     </td>
  </tr>
</table>
</f:verbatim>
</h:form>