<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
  function setMaster(id){
     window.showModalDialog("/eva/setMaster.jsf?objectID="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
	 document.all("form1:refresh1").click();
     return true;
  }
  function setLevelPurview(id){
	 window.showModalDialog("/eva/setLevelPurview.jsf?objectID="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
	 return false;
  }
  function setDefaultLevelPurview(){
	  var planid=document.all("form1:planID").value;
	  window.showModalDialog("/eva/setDefaultLevelPurview.jsf?planid="+planid, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
	  return false;
  }
  function forAddPerson() {
        window.showModalDialog("/eva/PersonQuery.jsf?planID="+document.all('form1:planID').value, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:yes;scroll:yes;");
        return true;
  }
  function setTempMaster(id){
	  var superid= document.all("form1:orgId").value;
     window.showModalDialog("/eva/setTempMaster.jsf?objectID="+id+"&superId="+superid, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
     return false;
  }
  function batchSetMaster(){
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
        	 var planid=document.all("form1:planID").value;
        	 window.showModalDialog("/eva/selEvaGroup.jsf?objectIDs="+vars[1]+"&planId="+planid, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
        	 return false;
        }
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

  function view(id,pid){
	   window.showModalDialog("/eva/workSumEdit.jsf?method=input&planID="+id+"&sumPid="+pid,"","dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");  
  }
</script>

<x:saveState value="#{eva_objectBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_objectBB.pageInit}"/>
    <h:inputHidden id="orgId" value="#{eva_objectBB.orgId}"/>
    <h:inputHidden id="personType" value="#{eva_objectBB.personType}"/>
    <h:inputHidden id="personStr" value=""/>
    <h:inputHidden id="templateID" value=""/>
    <h:inputHidden id="planID" value="#{eva_objectBB.planID}"></h:inputHidden>
    <h:commandButton id="refresh" value="ˢ��" style="display:none;" onclick="loadpopup()"></h:commandButton>
    <h:commandButton id="refresh1" value="ˢ��" style="display:none;" action="#{eva_objectBB.doQuery}"></h:commandButton>
    <f:verbatim>
     
 

 
    <table width="97%" height="98%" cellpadding="0" align="center"  cellspacing="0" border="0" >
        <tr><td height=8>
</f:verbatim>
            <h:panelGrid columns="1" width="100%" cellpadding="0" align="right" border="0" >
                <h:outputText value="��ǰ��Ա���:#{eva_objectBB.personTypeDes}"></h:outputText>

                <h:panelGrid columns="3">
                    <h:panelGroup>
                        <h:outputText value="������Ա�����"></h:outputText>
                        <h:inputText id="condiValue" styleClass="input" value="#{eva_objectBB.condiValue}" size="20"></h:inputText>
                        <h:commandButton id="btnSearch" value="�� ѯ"  styleClass="button01" action="#{eva_objectBB.doQuery}"/>
                    </h:panelGroup>
                    <h:panelGroup>
                    	<h:commandButton value="����ȱʡ�㼶Ȩ��"  onclick="setDefaultLevelPurview();"  styleClass="button01" rendered="#{eva_objectBB.isPurview=='1'}"/>
                        <h:commandButton value="���ӿ��˶���"  onclick="return forAddPerson();"  styleClass="button01"/>
                        <h:commandButton value="������������"  onclick="batchSetMaster();" styleClass="button01"/>
                        <h:commandButton value="ɾ��"  styleClass="button01" onclick="selectDeletePerson();" action="#{eva_objectBB.deletePersons}"/>
                    </h:panelGroup>
                </h:panelGrid>
						
						
					<h:panelGrid align="right" styleClass="locked_top">
	                    <h:panelGroup>
	                        <h:outputText value="���˼ƻ���" ></h:outputText>
	                        <h:outputText value="#{eva_objectBB.planName}"></h:outputText>
	                        <h:outputText value="  "></h:outputText>
						    <h:outputText value="����ģ�ͣ�" ></h:outputText>
						    <h:outputText value="#{eva_objectBB.planModelDes}"></h:outputText>
						  	<h:outputText value="  "></h:outputText>
	                        <h:outputText value="��#{eva_objectBB.pagevo.totalPage}ҳ"></h:outputText>
	                        <h:outputText value="  "></h:outputText>
	                        <h:outputText value="#{eva_objectBB.pagevo.totalRecord}����¼"></h:outputText>
	                        <h:outputText value="  "></h:outputText>
	                        <h:outputText value="ÿҳ��#{eva_objectBB.pagevo.pageSize}"></h:outputText>
	                        <h:outputText value="  "></h:outputText>
	                        <h:outputText value="��ǰΪ��#{eva_objectBB.pagevo.currentPage}ҳ"></h:outputText>
	                        <h:commandButton value="��ҳ" action="#{eva_objectBB.first}" styleClass="button01"></h:commandButton>
	                        <h:commandButton value="��ҳ" action="#{eva_objectBB.pre}" styleClass="button01"></h:commandButton>
	                        <h:commandButton value="��ҳ" action="#{eva_objectBB.next}" styleClass="button01"></h:commandButton>
	                        <h:commandButton value="βҳ" action="#{eva_objectBB.last}" styleClass="button01"></h:commandButton>
	                    </h:panelGroup>
	                </h:panelGrid>
				</h:panelGrid>
            
<f:verbatim>
        </td></tr>

        <tr><td>
         <div style='width:100%;height:100%;overflow:auto' id=datatable>    
</f:verbatim>
              <h:dataTable value="#{eva_objectBB.personList}" var="list" width="100%" id="dateList"
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
                    <h:outputText value="#{list.objectID}"/>
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
                    <h:outputText escape="false" value="#{list.orgid}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.deptid}"/>
                </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="����ģ��"/>
                      </f:facet>
                      <h:outputText escape="false" value="#{list.templatename}"/>
                  </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="�Ƿ���������"/>
                      </f:facet>
                      <h:outputText escape="false" value="#{list.isSetMaster}"/>
                  </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="����"/>
                      </f:facet>
                      <h:commandButton value="��ʱ����" onclick="setTempMaster('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
                      <h:commandButton value="��������" onclick="setMaster('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
                      <h:commandButton value="��ְ����" onclick="view('#{list.planID}','#{list.personID}');" styleClass="button01" type="button"></h:commandButton>
                      <h:commandButton value="���Ȩ��" onclick="setLevelPurview('#{list.objectID}');" styleClass="button01" type="button" rendered="#{eva_objectBB.isPurview=='1'}"></h:commandButton>
                  </h:column>
            </h:dataTable>
<f:verbatim>
         </div>
        </td></tr>
    </table>
    
</f:verbatim>
 <script type="text/javascript">

 </script>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
