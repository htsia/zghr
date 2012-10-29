<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contEndSignBB}"/>
<script type="text/javascript" language="javascript">
    function doApprove(){
       if (confirm(' ȷ��Ҫ��������')) {
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

<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_contEndSignBB.init_a}"/>
<h:inputHidden id="str" value="#{cont_contEndSignBB.validDate}"/>
<f:verbatim>
<table height=98% width=100% align="center">
       <tr><td height=8>
</f:verbatim>
           <h:panelGrid width="100%" border="0" styleClass="td_title" cellspacing="0" cellpadding="0" >
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="��ͬ��ֹ/���" ></h:outputText>
           </h:panelGroup>
        </h:panelGrid>
<f:verbatim>
       </td></tr>
       
        <tr><td height=8>
</f:verbatim>
            <h:panelGrid  border="0"  align="center" columns="1" width="95%">
               <h:panelGrid  border="0"  cellspacing="0" align="left" columns="15" >
                 <h:outputText value="������"/>
                 <h:inputText styleClass="input" size="15" id="personNameQry" value="#{cont_contEndSignBB.personNameQry}"/>
                 <h:outputText value="��ͬ�������"/>
                 <h:selectOneMenu value="#{cont_contEndSignBB.contClassQry}" id="contClassQry">
                            <c:selectItem itemValue="" itemLabel="��ѡ��" />
                            <c:selectItem itemValue="022006" itemLabel="��ͬ��ֹ" />
                            <c:selectItem itemValue="022007" itemLabel="��ͬ���" />
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value=" ��ѯ " action="#{cont_contEndSignBB.queryAll}"/>
                <h:commandLink id="doQuery" action="#{cont_contEndSignBB.queryAll}"></h:commandLink>
                <h:commandButton styleClass="button01" value="��ֹ/���" action="#{cont_contEndSignBB.forwardAdd}" />
                <h:commandButton styleClass="button01" value="�����޸�" action="#{cont_contEndSignBB.findByIds}" onclick="return checkBatchDo('selected_ids');"/>
                <h:commandButton styleClass="button01" value="��ͬ���ά��" action="#{cont_contEndSignBB.editMainContCode}" onclick="return checkModiCode('selected_ids');"/>
                <h:commandButton styleClass="button01" value="����" action="#{cont_contEndSignBB.toApprove}" onclick="if(checkBatchDo('selected_ids')) { return doApprove(); } else {return false;}"/>
                <h:commandButton styleClass="button01" value="��������" action="#{cont_contEndSignBB.toCancelApprove}" onclick="if(checkBatchDo('selected_ids')) { return doCancelApprove(); } else {return false;}"/>
                <h:commandButton styleClass="button01" value=" ��Ч " action="#{cont_contEndSignBB.toValid}" onclick="javascript:return valid();"/>
                <h:commandButton styleClass="button01" value=" ɾ�� " action="#{cont_contEndSignBB.deleteBatch}" onclick="return checkBatchDelete('selected_ids');" />
                <c:verbatim escape="false"><input type="button" class="button01"   name="cont_button" value="��ͬ��ӡ" onclick="javascript:downloadBatch(document.forms(0));" /> </c:verbatim>
             </h:panelGrid>

               <h:panelGrid align="right" styleClass="locked_top">
                <h:panelGroup>
                    <h:outputText value="��¼��:#{cont_contEndSignBB.pagevo.totalRecord}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                    <h:outputText value="ҳ��:#{cont_contEndSignBB.pagevo.totalPage}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                    <h:outputText value="ÿҳ��#{cont_contEndSignBB.pagevo.pageSize}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                    <h:outputText value="��ǰΪ��#{cont_contEndSignBB.pagevo.currentPage}ҳ"></h:outputText>
                    <h:commandButton value="��ҳ" action="#{cont_contEndSignBB.first}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="��ҳ" action="#{cont_contEndSignBB.pre}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="��ҳ" action="#{cont_contEndSignBB.next}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="βҳ" action="#{cont_contEndSignBB.last}" styleClass="button01"></h:commandButton>
                </h:panelGroup>
            </h:panelGrid>
           </h:panelGrid>
<f:verbatim>
        </td></tr>

       <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
                <x:dataTable value="#{cont_contEndSignBB.bos}" var="list"  rowIndexVar="index"
                                     headerClass="td_top"  id="data" align="center"
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
                                <c:facet name="header"><h:outputText value="ԭ��˵��"/></c:facet>
                                <h:outputText value="#{list.endReason}"/>
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
                                <c:facet name="header"><h:outputText value="���״̬"/></c:facet>
                                <h:outputText id="status" value="#{list.approveStatus}" title="��鵥λ��#{list.approveOrgId}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="��ͬ��ֹ���ʱ��"/></c:facet>
                                <h:outputText value="#{list.contEndSignDate}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="��ͬ�������"/></c:facet>
                                <h:outputText value="#{list.contClass}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="����"/></c:facet>
                                <c:verbatim escape="false"><A  onclick="doShowCont('</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">')" taget="_blank" ></c:verbatim>
                                <h:outputText value="��ͬ�鿴" />
                                <c:verbatim escape="false"></A></c:verbatim>
                                <h:outputText value="  "/>
                                <h:commandLink id="bnt2" value="�޸�" action="#{cont_contEndSignBB.findById}">
                                    <c:param name="contId" value="#{list.contId}"/>
                                </h:commandLink>

                            </h:column>
                </x:dataTable>
<f:verbatim>
            </div>
       </td></tr>
   </table>
</f:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:data");
</script>