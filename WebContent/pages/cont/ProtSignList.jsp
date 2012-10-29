<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript" language="javascript">
    function doApprove(){
       if (confirm(' ȷ��Ҫ��������')) {
           return true;
       } else {
           return false;
       }
    }
    function doCancelApprove(){
       if (confirm(' ȷ��Ҫ����������')) {
           return true;
       } else {
           return false;
       }
    }

    function checkModiCode(selected_ids){
        var form = document.forms[0];
        var field = form(selected_ids);
        var size = field.length;
        //debugger;
        var flag=0;
        if (size == null) {
            if (!field.checked) {
                alert("��ѡ��Ҫ�޸ĵ���Ŀ!");
                return false;
            }
            else{
                if (document.all('form1:data_0:status').innerText=="���ͨ��"){
                    alert("��������Ŀ�����޸�!");
                    return false;
                }
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (field[i].checked) {
                    if (document.all('form1:data_'+i+':status').innerText=="���ͨ��"){
                        flag=2;
                        break;
                    }
                    else{
                       flag=3;
                    }
                }
            }
            if (flag==0) {
                alert("��ѡ��Ҫ�޸ĵ���Ŀ!");
                return false;
            }
            if (flag==2){
                alert("��������Ŀ�����޸�!");
                return false;
            }
        }
        return true;
    }

function valid(ctrlobj){
	if(!checkBatchDo('selected_ids')){  return false; }
    showx = 300 ;
	showy = 200;
	retval = window.showModalDialog("/pages/cont/SelectValidDate.jsf", "", "dialogWidth:350px; dialogHeight:230px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    if (retval != null) {
           form1.all("form1:str").value = retval;
    } else {
           return false;
    }
}
//�������
function downloadBatch(form1){
	if(!checkBatchDo('selected_ids')){  return false; }
    var old_action = document.form1.action;
    window.open("","downloadBatch","left=400,top=300,height=100,width=200,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes");
    document.form1.target = 'downloadBatch';
    var temp_action = "/pages/cont/DownloadBatch.jsp";
    document.form1.action = temp_action;
    form1.submit();
    document.form1.action = old_action;
    document.form1.target = '_self';
}
</script>

<x:saveState value="#{cont_protSignBB}"/>
<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_protSignBB.init_a}"/>
<h:inputHidden id="str" value="#{cont_protSignBB.validDate}"/>

    <h:panelGrid width="100%" border="0" styleClass="td_title" cellspacing="0" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="Э��ǩ��" ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>

<h:panelGrid  border="0"  align="center" columns="1" width="95%">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="16" >
         <h:outputText value="������"/>
         <h:inputText styleClass="input" size="15" id="personNameQry" value="#{cont_protSignBB.personNameQry}"/>
         <h:outputText value="Э�����"/>
         <h:selectOneMenu value="#{cont_protSignBB.protClassQry}" id="approveStatusQry">
                    <c:selectItem itemValue="" itemLabel="��ѡ��" />
                    <c:selectItem itemValue="022211" itemLabel="��ҵ����Э��" />
                    <c:selectItem itemValue="022212" itemLabel="��ѵЭ��" />
                    <c:selectItem itemValue="022213" itemLabel="����Э��" />
                    <c:selectItem itemValue="022214" itemLabel="����Э��" />
                    <c:selectItem itemValue="022219" itemLabel="����Э��" />
        </h:selectOneMenu>
        <h:commandButton styleClass="button01" value=" ��ѯ " action="#{cont_protSignBB.queryAll}"/>
        <h:commandLink id="doQuery" action="#{cont_protSignBB.queryAll}"></h:commandLink>
        <h:commandButton styleClass="button01" value="Э��ǩ��" action="#{cont_protSignBB.forwardAdd}" />
        <h:commandButton styleClass="button01" value="�����޸�" action="#{cont_protSignBB.findByIds}" onclick="return checkBatchDo('selected_ids');"/>
         <h:commandButton styleClass="button01" value="����" action="#{cont_protSignBB.toApprove}" onclick="if(checkBatchDo('selected_ids')) { return doApprove(); } else {return false;}"/>
         <h:commandButton styleClass="button01" value="��������" action="#{cont_protSignBB.toCancelApprove}" onclick="if(checkBatchDo('selected_ids')) { return doCancelApprove(); } else {return false;}"/>
        <h:commandButton styleClass="button01" value="��ͬ���ά��" action="#{cont_protSignBB.editMainContCode}" onclick="return checkModiCode('selected_ids');"/>
        <h:commandButton styleClass="button01" value=" ��Ч " action="#{cont_protSignBB.toValid}" onclick="javascript:return valid();"/>
        <h:commandButton styleClass="button01" value=" ɾ�� " action="#{cont_protSignBB.deleteBatch}" onclick="return checkBatchDelete('selected_ids');" />
        <c:verbatim escape="false"><input type="button" class="button01"   name="cont_button" value="Э���ӡ" onclick="javascript:downloadBatch(document.forms(0));" /> </c:verbatim>
     </h:panelGrid>

    <h:panelGrid align="right" styleClass="locked_top">
        <h:panelGroup>
            <h:outputText value="��¼��:#{cont_protSignBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ҳ��:#{cont_protSignBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{cont_protSignBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{cont_protSignBB.pagevo.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{cont_protSignBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{cont_protSignBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{cont_protSignBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{cont_protSignBB.last}" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>

</h:panelGrid>
<x:dataTable value="#{cont_protSignBB.bos}" var="list"  rowIndexVar="index" align="center"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="95%" border="1">
             <h:column>
                  <c:facet name="header">
                      <c:verbatim escape="false">
                      <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                      </c:verbatim>
                      </c:facet>
                  <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                  <h:outputText value="#{list.contId}"/>
                  <h:outputText value=","/>
                  <h:outputText value="#{list.personId}"/>
                  <h:outputText value=","/>
                  <h:outputText value="#{list.attachmentId}"/>
                  <c:verbatim>"></c:verbatim>
              </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="Э����"/></c:facet>
                <h:outputText value="#{list.contCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���״̬"/></c:facet>
                <h:outputText id="status" value="#{list.approveStatus}" title="��鵥λ��#{list.approveOrgId}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
                <h:outputText value="#{list.contPersonBO.personSex}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="���֤����"/></c:facet>
                <h:outputText value="#{list.contPersonBO.idCard}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�ù����"/></c:facet>
                <h:outputText value="#{list.contPersonBO.jobType}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="Э�����"/></c:facet>
                <h:outputText value="#{list.protClass}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="Э��Լ���Ͷ���ϵ��ֹʱ��"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>
    
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <c:verbatim escape="false"><A  href="/pages/cont/Download.jsp?attachmentId=</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">" taget="_blank" ></c:verbatim>
                <h:outputText value="Э��鿴" />
                <c:verbatim escape="false"></A></c:verbatim>
                <h:outputText value="  "/>
                <h:commandLink id="bnt2" value="�޸�" action="#{cont_protSignBB.findById}">
                    <c:param name="contId" value="#{list.contId}"/>
                </h:commandLink>
            </h:column>
     </x:dataTable>
</h:form>
