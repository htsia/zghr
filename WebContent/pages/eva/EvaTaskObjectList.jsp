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
                <h:outputText value="当前人员类别:#{evaTaskEstimateBB.personTypeDes}"></h:outputText>

                <h:panelGrid columns="3">
                    <h:panelGroup>
                        <h:outputText value="姓名或员工编号"></h:outputText>
                        <h:inputText id="condiValue" styleClass="input" value="#{evaTaskEstimateBB.condiValue}" size="20"></h:inputText>
                        <h:commandButton id="btnSearch" value="查 询"  onclick="return queryByUserName()" styleClass="button01"/>
                    </h:panelGroup>
                    <h:panelGroup>
                        <h:commandButton value="增加考核对象"  onclick="return forAddPerson();" action="#{evaTaskEstimateBB.addPerson}" styleClass="button01"/>
                        <h:commandButton value="删除"  styleClass="button01" onclick="selectDeletePerson();" action="#{evaTaskEstimateBB.deletePersons}"/>
                    </h:panelGroup>
                </h:panelGrid>

                <h:panelGrid align="right" styleClass="locked_top">
                    <h:panelGroup>
                    	<h:outputText value="考核计划：" ></h:outputText>
	                    <h:outputText value="#{evaTaskEstimateBB.planName}"></h:outputText>
	                    <h:outputText value="  "></h:outputText>
						<h:outputText value="考核模型：" ></h:outputText>
						<h:outputText value="#{evaTaskEstimateBB.planModelDes}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
                        <h:outputText value="共#{evaTaskEstimateBB.pagevo.totalPage}页"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="每页有#{evaTaskEstimateBB.pagevo.pageSize}"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="当前为第#{evaTaskEstimateBB.pagevo.currentPage}页"></h:outputText>
                        <h:commandButton value="首页" action="#{evaTaskEstimateBB.first}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="上页" action="#{evaTaskEstimateBB.pre}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="下页" action="#{evaTaskEstimateBB.next}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="尾页" action="#{evaTaskEstimateBB.last}" styleClass="button01"></h:commandButton>
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
                        <h:outputText value="姓名"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.personName}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="机构"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.orgName}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="部门"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.deptName}"/>
                </h:column>
                  
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="岗位"/>
                    </f:facet>
                    <h:commandLink value="#{list.postName}" onclick="forViewPost('#{list.postId}')"></h:commandLink>
                </h:column>
                  <h:column>
                      <f:facet name="header">
                          <h:outputText value="操作"/>
                          
                      </f:facet>
                    <h:commandButton value="查看"  styleClass="button01" onclick="doQuery('#{list.personId}')"></h:commandButton>
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
         alert('请输入查询条件');
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
