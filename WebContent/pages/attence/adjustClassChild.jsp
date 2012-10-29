<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
function doBatchWork() {
	var flag = 0;
	var perIds = "id";
    if (checkMutilSelect(document.forms(0).selected_ids)) {
        var obj = document.forms(0).selected_ids;
        var size = obj.length;
        if (size == null) {
            if (obj.checked) {
                perIds +=","+obj.value;
            }
        }else {
            for (var i = 0; i < size; i++) {
                   if (obj[i].checked) {
                       perIds +=","+obj[i].value;
                   }
            }

        }
        window.showModalDialog("/attence/adjustClassChildEdit.jsf?name="+perIds, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    } else {
        alert("����ѡ����Ա");
        return false;
    }
}
function doWork() {
	var flag = 0;
	var perIds = "";
    if (checkMutilSelect(document.forms(0).selected_ids)) {
        var obj = document.forms(0).selected_ids;
        var size = obj.length;
        if (size == null) {
            if (obj.checked) {
                perIds = obj.value;
            }
        }else {
            for (var i = 0; i < size; i++) {
                if (obj[i].checked) {
                    flag = flag + 1;
                    if (flag == 1)
                      perIds = obj[i].value ;
                    if (flag > 1)
                        break;
                }
            }

        }
        if (flag > 1) {
            alert("ֻ�ܽ��е��˵��������");
            return false;
        }
        window.showModalDialog("/attence/adjustClassChildEdit.jsf?name="+perIds, null, "dialogWidth:500px; dialogHeight:170px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    } else {
        alert("����ѡ����Ա");
        return false;
    }
}
function forUploadFile(id) {
	window.showModalDialog("/attence/adjustClassChildEditMessage.jsf?ids="+id, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
}
</script>

<x:saveState value="#{adjustClassChildBB}" />
<h:form id="form1">
	<h:inputHidden id="superID" value="#{adjustClassChildBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId1" value="#{adjustClassChildBB.superId}"></h:inputHidden>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="5" align="left">
			<h:panelGroup>
				<h:outputText value="��¼��:#{adjustClassChildBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{adjustClassChildBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{adjustClassChildBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="��ǰΪ��#{adjustClassChildBB.mypage.currentPage}ҳ"></h:outputText>

				<h:commandButton value="��ҳ" action="#{adjustClassChildBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{adjustClassChildBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{adjustClassChildBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{adjustClassChildBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
			<h:outputText value="������Ա����ţ�"></h:outputText>
			<h:inputText id="classnamevalue"
				value="#{adjustClassChildBB.findSeeValue}"></h:inputText>
			<h:commandButton value="��ѯ" styleClass="button01"
				action="#{adjustClassChildBB.findSee}"></h:commandButton>
			<h:commandButton styleClass="button01" value="���� "
				onclick="return doBatchWork();" />
		</h:panelGrid>

		<x:dataTable value="#{adjustClassChildBB.itemList}" id="dateList"
			headerClass="td_top" rowIndexVar="index" var="list"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);" />
					</c:verbatim>
				</c:facet>
				<c:verbatim escape="false">
					<input type="checkbox" name="selected_ids"
						value="</c:verbatim>
                  <h:outputText value="#{list.id}"/>
                  <c:verbatim>">
				</c:verbatim>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ա���" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.personSeq}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.name}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.groupName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.orgName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="���ڲ���" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:commandButton value="���˵����ѯ" styleClass="button01"
					onclick="forUploadFile('#{list.id}');"></h:commandButton>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>



