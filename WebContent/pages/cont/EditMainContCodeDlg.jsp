<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript" language="javascript">
    function forView(form, id, type) {
        window.open("/cont/ContQueryHistory.jsf?displayFlag=false&personId=" + id ,"","left=50,top=50,height=400,width=850,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes")
       }
    function listSpace(){
        window.showModalDialog("/cont/listCodeDlg.jsf", null, "dialogWidth:400px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    function viewSpace(index){
        var rtn=window.showModalDialog("/cont/viewCodeDlg.jsf", null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        if (rtn!=null && rtn!="" && rtn!=undefined){
            document.all('form1:contlist_'+index+':mainContCode').value=rtn;
        }
        return false;
    }
</script>    
<x:saveState value="#{cont_contNewSignBB}"/>
<h:form id="form1">
     <h:inputHidden value="#{cont_contNewSignBB.auditEditCode}"></h:inputHidden>

    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
        <h:panelGrid  border="0"  cellspacing="0" align="left" columns="4" >
         <h:panelGroup>
            <h:selectBooleanCheckbox value="#{cont_contNewSignBB.asPersonCode}"></h:selectBooleanCheckbox>
            <h:outputText value="ͬʱ����Ա�����"></h:outputText>
         </h:panelGroup>

         <h:panelGroup>
             <h:selectBooleanCheckbox value="#{cont_contNewSignBB.asLogin}"></h:selectBooleanCheckbox>
             <h:outputText value="ͬʱ���ڵ�¼��"></h:outputText>
         </h:panelGroup>

         <h:panelGroup>
            <h:commandButton styleClass="button01" value=" ���� " action="#{cont_contNewSignBB.save_mainContCode}" onclick="if( forsubmit(document.forms(0)) ){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" action="#{cont_contNewSignBB.forwardList}"/>
         </h:panelGroup>
     </h:panelGrid>

        <h:panelGroup>
         <h:outputText escape="false" value="<strong>��ǰʹ�õ�����ͬ��:</strong>"></h:outputText>
         <h:inputText id="maxno" value="#{cont_contNewSignBB.maxContNo}"></h:inputText>
         <h:commandButton value="��ѯ" styleClass="button01" ></h:commandButton>
         <h:commandButton styleClass="button01" type="button" value=" �г��հ׺��� " onclick="return listSpace('');"/>
     </h:panelGroup>
    </h:panelGrid>

     <x:dataTable value="#{cont_contNewSignBB.signbos}" var="list"  rowIndexVar="index" align="center"
                     headerClass="td_top"     id="contlist"
                     rowClasses="td_middle" styleClass="table03" width="98%" border="1">
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <c:verbatim escape="false"><A  href="javascript:forView('','</c:verbatim><h:outputText value="#{list.personId}"/><c:verbatim escape="false">','')" ></c:verbatim>
            <h:outputText value="#{list.personName}" />
            <c:verbatim escape="false"></A></c:verbatim>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��ͬ���"/></c:facet>
            <h:inputText styleClass="input" id="mainContCode" value="#{list.contCode}"  size = "30" maxlength="20" alt="����ͬ���|1|s" />
            <h:commandButton styleClass="button01" type="button" value=" ѡ��հ׺��� " onclick="return viewSpace('#{index}');"/>
        </h:column>
</x:dataTable>
</h:form>
