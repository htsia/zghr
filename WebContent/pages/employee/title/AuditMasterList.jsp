<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function forAddPerson() {
	 var str=" |";
	    chk=document.forms(0).selectItem;
	    if (checkMutilSelect(chk)){
	        var size = chk.length;
	        if (size == null) {
	            if (chk.checked) {
	                str+=chk.value;
	            }
	        } else {
	            for (var i = 0; i < size; i++) {
	                if (chk[i].checked) {
	                    if (i==0){
	                        str+=chk[i].value;
	                    }
	                    else{
	                        str+=","+chk[i].value;
	                    }
	                }
	            }
	        }
	       if(str != null && str!=""){
	      	 var vars=str.split("|");
	      	 document.all("form1:auditItemIds").value = vars[1];
	      }
	    }
	 //alert(document.all("form1:auditItemIds").value);
   var returnvalue=window.showModalDialog("/employee/title/selAuditGroup.jsf?applyId="+document.all('form1:applyId').value, null, "dialogWidth:300px; dialogHeight:400px;center:center;resizable:no;status:yes;scroll:no;");
   if (typeof(returnvalue) == "undefined") { 
	   return false; 
	} else{ 
	   document.all("form1:groups").value=returnvalue;
	   return true;
	}
}
function selectAllItem(){
	  var str=" |";
    chk=document.forms(0).selectItem;
    if (checkMutilSelect(chk)){
        var size = chk.length;
        if (size == null) {
            if (chk.checked) {
                str+=chk.value;
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (chk[i].checked) {
                    if (i==0){
                        str+=chk[i].value;
                    }
                    else{
                        str+=","+chk[i].value;
                    }
                }
            }
        }
       if(str != null && str!=""){
      	 var vars=str.split("|");
      	 document.all("form1:auditItemIds").value = vars[1];
      	 return true;
        }else{
           alert("����ѡ��һ������");
           return false;
        }
    }
}
</script>
<c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{emptitleauditgroupmgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emptitleauditgroupmgrBB.initItemList}"></h:inputHidden>
    <h:inputHidden id="groups" value="#{emptitleauditgroupmgrBB.groups}"></h:inputHidden>
    <h:inputHidden id="applyId" value="#{emptitleauditgroupmgrBB.applyId}"></h:inputHidden>
     <h:inputHidden id="auditItemIds" value="#{emptitleauditgroupmgrBB.auditItemIds}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr>
       <td height=8 align="center">
        </c:verbatim>
       		<h:commandButton value="��������������"  onclick="return forAddPerson();" styleClass="button01" action="#{emptitleauditgroupmgrBB.selGroup}"/>
            <h:outputText value="  "></h:outputText>
            <h:commandButton value="��������"  onclick="return selectAllItem();" styleClass="button01" action="#{emptitleauditgroupmgrBB.deptAudit}"/>
            <h:outputText value="  "></h:outputText>
            <h:commandButton value="��ʼ���"  onclick="return selectAllItem();" styleClass="button01" action="#{emptitleauditgroupmgrBB.beginScore}"/>
            <h:outputText value="  "></h:outputText>
            <h:commandButton value="ֹͣ���"  onclick="return selectAllItem();" styleClass="button01" action="#{emptitleauditgroupmgrBB.endScore}"/>
            <h:outputText value="  "></h:outputText>
    <c:verbatim>
       </td>
       <td height=8 align="center"> 
       </c:verbatim>
            <h:outputText value="��#{emptitleauditgroupmgrBB.mypage.totalPage}ҳ"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{emptitleauditgroupmgrBB.mypage.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{emptitleauditgroupmgrBB.mypage.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{emptitleauditgroupmgrBB.first2}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{emptitleauditgroupmgrBB.pre2}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{emptitleauditgroupmgrBB.next2}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{emptitleauditgroupmgrBB.last2}" styleClass="button01"></h:commandButton>
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td colspan="2">
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{emptitleauditgroupmgrBB.itemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
        <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.auditSetId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ְ�Ƽ���"/></c:facet>
            <h:outputText value="#{list.level}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="ģ������"/></c:facet>
            <h:outputText value="#{list.templateName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��Ŀ����"/></c:facet>
            <h:outputText value="#{list.tempItemName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ѧ����"/></c:facet>
            <h:outputText value="#{list.majorClass}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.auditGroup}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.auditStatusDes}"/>
        </h:column>
    </x:dataTable>

	<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
