<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forEdit(form, id, right) {
            var arg = "superID="+document.all("form1:superID").value+"&personID=" + id;
            showModalDialog("/employee/info/teamSelectNo.jsf?"+arg, null, "dialogWidth:300px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
            document.all("form1:doRefresh").click();
        }

    	function deletePerson() {
    		var perIds = "";
            if (checkMutilSelect(document.forms(0).chk)) {
                var obj = document.forms(0).chk;
                var size = obj.length;
                if (size == null) {
                    if (obj.checked) {
                        perIds = obj.value;
                    }
                } else {
                    for (var i = 0; i < size; i++) {
                        if (obj[i].checked) {
                            perIds += obj[i].value+"," ;
                        }
                    }

                }
                document.all('form1:personId').value= perIds;
            } else {
                alert("请先选择人员");
                return false;
            }
        }
        function addPerson(){
         	var superID=document.all('form1:superID').value;
        	 if(superID==""){
            	 alert("请选择团队");
            	 return false;
        	 }else{
        		 return fPopUpBackPerTreeDlg('');
        	 }
     	 }

    </script>
<x:saveState value="#{teamMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden id="personList" value="#{teamMgrBB.personList}"/>
        <h:inputHidden id="personId" value=""/>
        <h:inputHidden id="personStr" value=""/>
        <h:inputHidden id="superID" value="#{teamMgrBB.superID}"></h:inputHidden>
     <f:verbatim>
        <input type="hidden" name="sessionFlag" value="2">
        <table id=t1 height=98% width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_page" height=8 align="left">
     </f:verbatim>
                    <h:outputText escape="false" value="<strong>名称:</strong>#{teamMgrBB.viewInfoBo.teamName}"></h:outputText>
                    <h:outputText  value="  "></h:outputText>
                    <h:outputText escape="false" value="<strong>项目额:</strong>#{teamMgrBB.viewInfoBo.teamBudget}"></h:outputText>
                    <h:outputText  value="  "></h:outputText>
                    <h:outputText escape="false" value="<strong>项目级别:</strong>#{teamMgrBB.viewInfoBo.teamLevel}"></h:outputText>
                    <h:outputText  value="  "></h:outputText>
                    <h:outputText escape="false" value="<strong>项目档次:</strong>#{teamMgrBB.viewInfoBo.teamStep}"></h:outputText>

      <f:verbatim>
                </td>

                <td class="td_page" height=8 align="right">
       </f:verbatim>
                    <h:commandButton value="增加" onclick="addPerson('')" styleClass="button01" action="#{teamMgrBB.addPerson}"/>
                    <h:outputText value="  "></h:outputText>
                    <h:commandButton value="删除" onclick="deletePerson();" action="#{teamMgrBB.deletePerson}" styleClass="button01" />
                    <h:outputText value="  "></h:outputText>
                    <h:commandButton value="导出" onclick="doExport();"  styleClass="button01" />
                    <h:commandButton id="doRefresh" action="#{teamMgrBB.doRefresh}" style="display:none"></h:commandButton>
       <f:verbatim>
                </td>
            </tr>
            <tr><td colspan=2 height=8></td></tr>
            <tr><td colspan=2>
                <jsp:include page="../../common/activepage/ActiveList.jsp">
                    <jsp:param name="hasOperSign" value="true"/>
                    <jsp:param name="operSignType" value="checkbox"/>
                    <jsp:param name="hasEdit" value="true"/>
                    <jsp:param name="isEditList" value="false"/>
                    <jsp:param name="isCheckRight" value="true"/>
                    <jsp:param name="isForward" value="true"/>
                    <jsp:param name="isRow" value="false"/>
                    <jsp:param name="isPage" value="true"/>
                    <jsp:param name="editName" value="任职书"/>
                    <jsp:param name="editFuncName" value="forEdit"/>
                </jsp:include>
            </td></tr>
        </table>
       </f:verbatim>
    </h:form>
  

<script type="text/javascript">

</script>
