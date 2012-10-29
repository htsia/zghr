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
    <h:commandButton id="refresh" value="刷新" style="display:none;" onclick="loadpopup()"></h:commandButton>
    <h:commandButton id="refresh1" value="刷新" style="display:none;" action="#{eva_objectBB.doQuery}"></h:commandButton>
    <f:verbatim>
     
 

 
    <table width="97%" height="98%" cellpadding="0" align="center"  cellspacing="0" border="0" >
        <tr><td height=8>
</f:verbatim>
            <h:panelGrid columns="1" width="100%" cellpadding="0" align="right" border="0" >
                <h:outputText value="当前人员类别:#{eva_objectBB.personTypeDes}"></h:outputText>

                <h:panelGrid columns="3">
                    <h:panelGroup>
                        <h:outputText value="姓名或员工编号"></h:outputText>
                        <h:inputText id="condiValue" styleClass="input" value="#{eva_objectBB.condiValue}" size="20"></h:inputText>
                        <h:commandButton id="btnSearch" value="查 询"  styleClass="button01" action="#{eva_objectBB.doQuery}"/>
                    </h:panelGroup>
                    <h:panelGroup>
                    	<h:commandButton value="设置缺省层级权重"  onclick="setDefaultLevelPurview();"  styleClass="button01" rendered="#{eva_objectBB.isPurview=='1'}"/>
                        <h:commandButton value="增加考核对象"  onclick="return forAddPerson();"  styleClass="button01"/>
                        <h:commandButton value="批量设置主体"  onclick="batchSetMaster();" styleClass="button01"/>
                        <h:commandButton value="删除"  styleClass="button01" onclick="selectDeletePerson();" action="#{eva_objectBB.deletePersons}"/>
                    </h:panelGroup>
                </h:panelGrid>
						
						
					<h:panelGrid align="right" styleClass="locked_top">
	                    <h:panelGroup>
	                        <h:outputText value="考核计划：" ></h:outputText>
	                        <h:outputText value="#{eva_objectBB.planName}"></h:outputText>
	                        <h:outputText value="  "></h:outputText>
						    <h:outputText value="考核模型：" ></h:outputText>
						    <h:outputText value="#{eva_objectBB.planModelDes}"></h:outputText>
						  	<h:outputText value="  "></h:outputText>
	                        <h:outputText value="共#{eva_objectBB.pagevo.totalPage}页"></h:outputText>
	                        <h:outputText value="  "></h:outputText>
	                        <h:outputText value="#{eva_objectBB.pagevo.totalRecord}条记录"></h:outputText>
	                        <h:outputText value="  "></h:outputText>
	                        <h:outputText value="每页有#{eva_objectBB.pagevo.pageSize}"></h:outputText>
	                        <h:outputText value="  "></h:outputText>
	                        <h:outputText value="当前为第#{eva_objectBB.pagevo.currentPage}页"></h:outputText>
	                        <h:commandButton value="首页" action="#{eva_objectBB.first}" styleClass="button01"></h:commandButton>
	                        <h:commandButton value="上页" action="#{eva_objectBB.pre}" styleClass="button01"></h:commandButton>
	                        <h:commandButton value="下页" action="#{eva_objectBB.next}" styleClass="button01"></h:commandButton>
	                        <h:commandButton value="尾页" action="#{eva_objectBB.last}" styleClass="button01"></h:commandButton>
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
                        <h:outputText value="姓名"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.personName}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="机构"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.orgid}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="部门"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.deptid}"/>
                </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="考核模板"/>
                      </f:facet>
                      <h:outputText escape="false" value="#{list.templatename}"/>
                  </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="是否设置主体"/>
                      </f:facet>
                      <h:outputText escape="false" value="#{list.isSetMaster}"/>
                  </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="操作"/>
                      </f:facet>
                      <h:commandButton value="临时主体" onclick="setTempMaster('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
                      <h:commandButton value="设置主体" onclick="setMaster('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
                      <h:commandButton value="述职报告" onclick="view('#{list.planID}','#{list.personID}');" styleClass="button01" type="button"></h:commandButton>
                      <h:commandButton value="层次权重" onclick="setLevelPurview('#{list.objectID}');" styleClass="button01" type="button" rendered="#{eva_objectBB.isPurview=='1'}"></h:commandButton>
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
