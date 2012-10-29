<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.cont.web.ContNewSignBackingBean"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contNewSignBB}"/>

<script type="text/javascript" language="javascript">
    function importContact(){
        window.showModalDialog("/cont/import/PerDataUpload.jsf", "dialogWidth:750px; dialogHeight:500px; center:center; status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    }
    function clearws() {
        document.getElementById("checkSubmitFlg").value="0";
    }
    function clearStatew() {
        setInterval("clearws()",2000);
    }
    function valid(ctrlobj){
        if(!checkBatchDo('selected_ids')){  return false; }
        showx = 300 ;
        showy = 200;
        retval = window.showModalDialog("/cont/SelectValidDateForNewSign.jsf", "", "dialogWidth:350px; dialogHeight:230px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
        if (retval != null) {
               var temp =  retval.indexOf(',');
               form1.all("form1:str").value = retval.substr(0,temp);
               form1.all("form1:printFlag").value = retval.substr(temp+1);
        } else {
               return false;
        }
     }
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

    function checkDelete(selected_ids){
        var form = document.forms[0];
        var field = form(selected_ids);
        var size = field.length;
        //debugger;
        var flag=0;
        if (size == null) {
            if (!field.checked) {
                alert("��ѡ��Ҫɾ������Ŀ!");
                return false;
            }
            else{
                if (document.all('form1:data_0:status').innerText=="���ͨ��"){
                    alert("��������Ŀ����ɾ��!");
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
                alert("��ѡ��Ҫɾ������Ŀ!");
                return false;
            }
            if (flag==2){
                alert("��������Ŀ����ɾ��!");
                return false;
            }
        }

        if (confirm('ȷ��Ҫɾ����')) {
            return true;
        } else {
            return false;
        }
    }
</script>

<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_contNewSignBB.init_a}"/>
<h:inputHidden id="str" value="#{cont_contNewSignBB.validDate}"/>
<h:inputHidden id="printFlag" value="#{cont_contNewSignBB.printFlag}"/>

<h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
   <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ��ͬ���� ->  ��ͬ��ǩ"/>
    </h:panelGroup>

    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="4" >
        <h:outputText value="δǩ��ͬ�����ڵ�����Ա��#{cont_contNewSignBB.adjustCount}" rendered="#{cont_contNewSignBB.empChangeMode=='1'}"></h:outputText>
        <h:commandButton styleClass="button01" value="δǩ��ͬ����Ա���б�" action="cont_adjustPersonList_jsf" rendered="#{cont_contNewSignBB.empChangeMode=='1'}"/>
        <h:outputText value="δǩ��ͬ��Ա�����У�#{cont_contNewSignBB.newCount}"></h:outputText>
        <h:commandButton styleClass="button01" value="δǩ��ͬ��Ա���б�" action="cont_PersonList_jsf"/>
    </h:panelGrid>

</h:panelGrid>

<h:panelGrid  border="0"  align="center" columns="1" width="95%">

     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="10" >
         <h:panelGroup>
             <h:outputText value=" ������"/>
             <h:inputText styleClass="input" size="15" id="personNameQry" value="#{cont_contNewSignBB.personNameQry}"/>
             <h:outputText value="���״̬��"/>
             <h:selectOneMenu value="#{cont_contNewSignBB.approveStatusQry}" id="approveStatusQry">
                        <c:selectItem itemValue="" itemLabel="��ѡ��" />
                        <c:selectItem itemValue="201001" itemLabel="δ����" />
                        <c:selectItem itemValue="201002" itemLabel="�����" />
                        <c:selectItem itemValue="201003" itemLabel="���ͨ��" />
                        <c:selectItem itemValue="201004" itemLabel="���δ��" />
            </h:selectOneMenu>
            <h:commandButton styleClass="button01" value=" ��ѯ " action="#{cont_contNewSignBB.queryAll}"/>
        </h:panelGroup>

        <%
            ContNewSignBackingBean bb = (ContNewSignBackingBean)request.getAttribute("cont_contNewSignBB");
            bb.checkRight();
        %>
        <h:commandButton styleClass="button01" value="��ǩ��ͬ" action="#{cont_contNewSignBB.forwardAdd}"  />
        <h:commandButton styleClass="button01" value="����" onclick="importContact();" />
        <h:commandButton styleClass="button01" value="�����޸�" action="#{cont_contNewSignBB.findByIds}" onclick="return checkBatchDo('selected_ids');"/>
        <h:commandButton styleClass="button01" value="��ͬ���ά��" action="#{cont_contNewSignBB.editMainContCode}" onclick="return checkModiCode('selected_ids');"/>
        <h:commandButton styleClass="button01" value="����" action="#{cont_contNewSignBB.toApprove}" onclick="if(checkBatchDo('selected_ids')) { return doApprove(); } else {return false;}"/>
        <h:commandButton styleClass="button01" value="��������" action="#{cont_contNewSignBB.toCancelApprove}" onclick="if(checkBatchDo('selected_ids')) { return doCancelApprove(); } else {return false;}"/>
        <h:commandButton styleClass="button01" value="��Ч" action="#{cont_contNewSignBB.toValid}" onclick="javascript:return valid();"/>
        <h:commandButton styleClass="button01" value="ɾ��" action="#{cont_contNewSignBB.deleteBatch}" onclick="return checkDelete('selected_ids');" />
        <c:verbatim escape="false"><input type="button" class="button01"   name="cont_button" value="��ͬ����" onclick="javascript:downloadBatch(document.forms(0));" /> </c:verbatim>
     </h:panelGrid>

    <h:panelGrid align="right" styleClass="locked_top">
        <h:panelGroup>
            <h:outputText value="��¼��:#{cont_contNewSignBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ҳ��:#{cont_contNewSignBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{cont_contNewSignBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{cont_contNewSignBB.pagevo.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{cont_contNewSignBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{cont_contNewSignBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{cont_contNewSignBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{cont_contNewSignBB.last}" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
    
</h:panelGrid>

<x:dataTable value="#{cont_contNewSignBB.bos}" var="list"  rowIndexVar="index" id="data"
                     headerClass="td_top"   align="center"
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
                  <h:outputText value="#{list.contPersonBO.personId}"/>
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
                <h:outputText value="#{list.contPersonBO.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
                <h:outputText value="#{list.contPersonBO.personSex}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��λ���"/></c:facet>
                <h:outputText value="#{list.contPersonBO.jobType}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ͬԼ����ʼʱ��"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��ͬԼ����ֹʱ��"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���״̬"/></c:facet>
                <h:outputText id="status" value="#{list.approveStatus}" title="��鵥λ��#{list.approveOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandLink id="bnt1" value="��Ա��Ϣ�鿴" onclick="forViewPersonDetail('#{list.contPersonBO.personId}')">
                </h:commandLink>
                <h:outputText value="  "/>
                <h:commandLink id="bnt2" value="��ͬ��Ϣ" action="#{cont_contNewSignBB.findById}">
                    <c:param name="contId" value="#{list.contId}"/>
                </h:commandLink>
                <h:outputText value="  "/>
                <c:verbatim escape="false"><A  onclick="doShowCont('</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">')" taget="_blank" ></c:verbatim>
                <h:outputText value="��ͬ�鿴" />
                <c:verbatim escape="false"></A></c:verbatim>
                <h:outputText value="  "/>
                <h:commandLink id="link2" value="�����Ϣ" action="#{cont_contNewSignBB.findApproveInfoById}" >
                     <c:param name="contId" value="#{list.contId}"/>
                </h:commandLink>
            </h:column>
</x:dataTable>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:data");
</script>
