<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contChangeSignBB}"/>
<script type="text/javascript" language="javascript">
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
function downloadBatch(form1)
{
	if(!checkBatchDo('selected_ids')){  return false; }
    var old_action = document.form1.action;
    window.open("","downloadBatch","left=400,top=300,height=100,width=200,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes");
    document.form1.target = 'downloadBatch';
    var temp_action = "/pages/cont/DownloadBatch.jsp";
    document.form1.action = temp_action;
    //document.form1.target = '_blank';
    form1.submit();
    document.form1.action = old_action;
    document.form1.target = '_self';
}
</script>


<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_contChangeSignBB.init_a}"/>
<h:inputHidden id="str" value="#{cont_contChangeSignBB.validDate}"/>

<h:panelGrid width="100%" border="0" cellspacing="0" cellpadding="0" styleClass="td_title">
   <h:panelGroup>
       <h:graphicImage value="/images/tips.gif" />
       <h:outputText value="��ͬ���"  ></h:outputText>
    </h:panelGroup>
</h:panelGrid>

<h:panelGrid  border="0"  align="center" columns="1" width="95%">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="13" >
         <h:outputText value="������"/>
         <h:inputText styleClass="input" size="15" id="personNameQry" value="#{cont_contChangeSignBB.personNameQry}"/>
        <h:commandButton styleClass="button01" value=" ��ѯ " action="#{cont_contChangeSignBB.queryAll}"/>
        <h:commandLink id="doQuery" action="#{cont_contChangeSignBB.queryAll}"></h:commandLink>
        <h:commandButton styleClass="button01" value="��ͬ���" action="#{cont_contChangeSignBB.forwardAdd}" />
        <h:commandButton styleClass="button01" value="�����޸�" action="#{cont_contChangeSignBB.findByIds}" onclick="return checkBatchDo('selected_ids');"/>
        <h:commandButton styleClass="button01" value="��ͬ���ά��" action="#{cont_contChangeSignBB.editMainContCode}" onclick="return checkModiCode('selected_ids');"/>
         <h:commandButton styleClass="button01" value="����" action="#{cont_contChangeSignBB.toApprove}" onclick="if(checkBatchDo('selected_ids')) { return doApprove(); } else {return false;}"/>
         <h:commandButton styleClass="button01" value="��������" action="#{cont_contChangeSignBB.toCancelApprove}" onclick="if(checkBatchDo('selected_ids')) { return doCancelApprove(); } else {return false;}"/>
        <h:commandButton styleClass="button01" value=" ��Ч " action="#{cont_contChangeSignBB.toValid}" onclick="javascript:return valid();"/>
        <h:commandButton styleClass="button01" value=" ɾ�� " action="#{cont_contChangeSignBB.deleteBatch}" onclick="return checkBatchDelete('selected_ids');" />
        <c:verbatim escape="false"><input type="button" class="button01"   name="cont_button" value="��ͬ��ӡ" onclick="javascript:downloadBatch(document.forms(0));" /> </c:verbatim>
     </h:panelGrid>

    <h:panelGrid align="right" styleClass="locked_top">
        <h:panelGroup>
            <h:outputText value="��¼��:#{cont_contChangeSignBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ҳ��:#{cont_contChangeSignBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{cont_contChangeSignBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{cont_contChangeSignBB.pagevo.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{cont_contChangeSignBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{cont_contChangeSignBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{cont_contChangeSignBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{cont_contChangeSignBB.last}" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
</h:panelGrid>

    <x:dataTable value="#{cont_contChangeSignBB.bos}" var="list"  rowIndexVar="index" align="center"
                     headerClass="td_top"   id="data"
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
                <c:facet name="header"><h:outputText value="��ͬ���"/></c:facet>
                <h:outputText value="#{list.contCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.personName}"/>
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
                <c:facet name="header"><h:outputText value="���״̬"/></c:facet>
                <h:outputText id="status" value="#{list.approveStatus}" title="��鵥λ��#{list.approveOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�ù����"/></c:facet>
                <h:outputText value="#{list.contPersonBO.jobType}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��ͬ���ʱ��"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="Լ���Ͷ���ϵ��ֹʱ��"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <c:verbatim escape="false"><A  onclick="doShowCont('</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">');" taget="_blank" ></c:verbatim>
                <h:outputText value="��ͬ�鿴" />
                <c:verbatim escape="false"></A></c:verbatim>
                <h:outputText value="  "/>
                <h:commandLink id="bnt2" value="�޸�" action="#{cont_contChangeSignBB.findById}">
                    <c:param name="contId" value="#{list.contId}"/>
                </h:commandLink>
            </h:column>
</x:dataTable>
</h:form>

