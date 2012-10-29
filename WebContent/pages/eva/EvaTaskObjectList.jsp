<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
  function doQuery(pid){
		 var id=document.all("form1:planID").value;
		 window.showModalDialog("/eva/ShowSelfTaskDetailQuery.jsf?planID="+id+"&PersonID="+pid, null,"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
	     return false;
  }
  function forAddPerson() {
        var reval = window.showModalDialog("/eva/taskPersonQuery.jsf?personType="+document.all('form1:personType').value+"&planID="+document.all('form1:planID').value+"&orgId="+document.all('form1:orgId').value, null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
		if (reval != null && reval!="") {
        	var vars=reval.split("|");
        	document.all("form1:personStr").value = vars[1];
            return true;
        } else {
            return false;
        }
   }
  function selectDeletePerson(){
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
        	 document.all("form1:personStr").value = vars[1];
        }
      }
  }
  function forViewPost(id) {
      windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=0","aa","","900","600","no","10","100","yes");
  }

</script>

<x:saveState value="#{evaTaskEstimateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{evaTaskEstimateBB.pageInit}"/>
    <h:inputHidden id="orgId" value="#{evaTaskEstimateBB.orgId}"/>
    <h:inputHidden id="personType" value="#{evaTaskEstimateBB.personType}"/>
    <h:inputHidden id="personStr" value=""/>
    <h:inputHidden id="planID" value="#{evaTaskEstimateBB.planID}"></h:inputHidden>
    <f:verbatim>
    <table width="97%" height="98%" cellpadding="0" align="center"  cellspacing="0" border="0" >
        <tr><td height=8>
</f:verbatim>
            <h:panelGrid columns="1" width="100%" cellpadding="0" align="right" border="0" >
                <h:outputText value="��ǰ��Ա���:#{evaTaskEstimateBB.personTypeDes}"></h:outputText>

                <h:panelGrid columns="3">
                    <h:panelGroup>
                        <h:outputText value="������Ա�����"></h:outputText>
                        <h:inputText id="condiValue" styleClass="input" value="#{evaTaskEstimateBB.condiValue}" size="20"></h:inputText>
                        <h:commandButton id="btnSearch" value="�� ѯ"  onclick="return queryByUserName()" styleClass="button01"/>
                    </h:panelGroup>
                    <h:panelGroup>
                        <h:commandButton value="���ӿ��˶���"  onclick="return forAddPerson();" action="#{evaTaskEstimateBB.addPerson}" styleClass="button01"/>
                        <h:commandButton value="ɾ��"  styleClass="button01" onclick="selectDeletePerson();" action="#{evaTaskEstimateBB.deletePersons}"/>
                    </h:panelGroup>
                </h:panelGrid>

                <h:panelGrid align="right" styleClass="locked_top">
                    <h:panelGroup>
                    	<h:outputText value="���˼ƻ���" ></h:outputText>
	                    <h:outputText value="#{evaTaskEstimateBB.planName}"></h:outputText>
	                    <h:outputText value="  "></h:outputText>
						<h:outputText value="����ģ�ͣ�" ></h:outputText>
						<h:outputText value="#{evaTaskEstimateBB.planModelDes}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
                        <h:outputText value="��#{evaTaskEstimateBB.pagevo.totalPage}ҳ"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="ÿҳ��#{evaTaskEstimateBB.pagevo.pageSize}"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="��ǰΪ��#{evaTaskEstimateBB.pagevo.currentPage}ҳ"></h:outputText>
                        <h:commandButton value="��ҳ" action="#{evaTaskEstimateBB.first}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="��ҳ" action="#{evaTaskEstimateBB.pre}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="��ҳ" action="#{evaTaskEstimateBB.next}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="βҳ" action="#{evaTaskEstimateBB.last}" styleClass="button01"></h:commandButton>
                    </h:panelGroup>
                </h:panelGrid>

            </h:panelGrid>
<f:verbatim>
        </td></tr>

        <tr><td>
         <div style='width:100%;height:100%;overflow:auto' id=datatable>    
</f:verbatim>
              <h:dataTable value="#{evaTaskEstimateBB.personList}" var="list" width="100%" id="dateList"
                    styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.masterId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.personName}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.orgName}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.deptName}"/>
                </h:column>
                  
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="��λ"/>
                    </f:facet>
                    <h:commandLink value="#{list.postName}" onclick="forViewPost('#{list.postId}')"></h:commandLink>
                </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="����"/>
                          
                      </f:facet>
                    <h:commandButton value="�鿴"  styleClass="button01" onclick="doQuery('#{list.personId}')"></h:commandButton>
                   </h:column>

            </h:dataTable>
<f:verbatim>
         </div>
        </td></tr>
    </table>
</f:verbatim>
<script type="text/javascript">
 function queryByUserName(){
     var personName = document.all("form1:condiValue").value;
     if(personName==null || personName==""){
         alert('�������ѯ����');
         return false;
     }
     parent.document.main.location.href="/eva/EvaTaskObjectList.jsf?condiValue1="+personName;
     return true;
 }
 </script>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
