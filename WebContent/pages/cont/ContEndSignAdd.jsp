<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO"%>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript">
    function selectAdjustPerson(ctrlobj){
        showx = event.screenX - event.offsetX - 4 - 210 ;
        showy = event.screenY - event.offsetY + 18;
        retval = window.showModalDialog("/cont/SelectNoEndPerson.jsf", "", "dialogWidth:750px; dialogHeight:400px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:yes; directories:yes;scrollbars:yes;Resizable=yes; "  );
        if (retval != null) {
               form1.all("form1:str").value = retval;
               pageCodeExchange(document.forms(0));

        } else {
               return false;
        }
    }

    function checkSubmit(form1) {
            flag = true;
            var name = form1.all("form1:templateClassId").value;
            if (document.all('form1:generateDoc').checked){
                if (name == "" || name == null) {
                    alert("ģ�������Ϊ�գ�");
                     flag = false;
                     return flag;
                }
                name = form1.all("form1:templateId").value;
                if (name == "" || name == null) {
                    alert("��ͬģ�岻��Ϊ�գ�");
                     flag = false;
                     return flag;
                }
            }
            name = form1.all("form1:contRemark").value;
            if (name != "" && name != null) {
                if (name.length>50) {
                    alert("�Ͷ���ͬժҪ���������ֻ������50�����֣�");
                    flag = false;
                    return flag;
                }
            }
            name = form1.all("form1:endReason").value;
            if (name == "" || name == null) {
                alert("���ԭ����Ϊ�գ�");
                 flag = false;
                 return flag;
            }
            return flag;
    }
    function queryPerson(){
        if(doAdvanceQuery('A','ORG','110','Y','cont_selPerObjs','1=1','Y','<%=Constants.DEFAULT_QUERY_CONTRACT%>','N','','2')){
             pageCodeExchange(document.forms(0));
             return true;
        }else{
             return false;
        }
    }
    function delPerson() {
      var field = form1.all('chk');
      if (checkMutilSelect(field)) {
          pageCodeExchange(document.forms(0));
      } else{
          alert("��ѡ����Ա��");
          return false;
      }
    }
    var flag=0 ;
    function showHide(obj){
        if(flag==0){
            obj.style.display="none";
            flag=1;
        }else{
            obj.style.display="";
            flag = 0;
        }
    }
    function confirmSave(form1){
            if (confirm('ȷ��Ҫ��������')) {
                pageCodeExchange(form1);
                return true;
            } else {
                return false;
            }
    }
    function forView(form, id, type) {
        window.open("/cont/ContQueryHistory.jsf?displayFlag=false&personId=" + id ,"","left=50,top=50,height=400,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes")
    }
    function doQueryManyPerson(){
        var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null && reval !="") {
            document.all('form1:ManyPerson').value = reval;
            pageCodeExchange(document.forms(0));
            disPlayProcessBar();
            return true;
        } else {
            return false;
        }
    }
</script>

<h:form id="form1">
    <h:panelGrid width="100%" border="0" styleClass="td_title" cellspacing="6" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="��ͬ��ֹ/���ά��" ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>

<h:panelGrid  border="0"  align="center" columns="2" width="800">
    <%
        int  rowCount = 0;
        if(request.getSession().getAttribute("cont_selPerObjs")!=null){
           RecordVO[] recordVOs = ((TableVO)request.getSession().getAttribute("cont_selPerObjs")).getRowData();
           rowCount = recordVOs.length;
        }
    %>
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  ��Ա��Ϣ(��<%=rowCount%>����¼)</b></a></c:verbatim>
    </h:panelGrid>
    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="5" >
        <h:panelGroup>
            <h:inputHidden id="ManyPerson" value="#{cont_contEndSignBB.nameStrs}"></h:inputHidden>
            <h:commandButton value="���˲�ѯ" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                             action="#{cont_contEndSignBB.queryMultPerson}"/>
        </h:panelGroup>
        <h:inputHidden id="str" value="#{cont_contEndSignBB.selectNewPersonIds}"/>
        <h:commandButton id="dismiss" styleClass="button01"  value="����ϵͳ�ڵ�λ��Ա" action="#{cont_contEndSignBB.selectDismiss}" onclick="javascript:return selectAdjustPerson();"/>
        <h:commandButton id="advance1" styleClass="button01"  value="�Զ����ѯ" action="#{cont_contEndSignBB.selPerson}" onclick="return queryPerson();"/>
        <h:commandButton styleClass="button01" value="ȥ����Ա" action="#{cont_contEndSignBB.delPerson}" onclick="javascript:return delPerson();"/>
    </h:panelGrid>
</h:panelGrid>

<c:verbatim>
<table id="ryTable" width="850" border="0" align="center" height=180>
  <tr><td>
          <jsp:include page="/pages/common/activepage/ActiveList.jsp">
              <jsp:param name="target" value="cont_selPerObjs"/>
              <jsp:param name="hasOperSign" value="true"/>
              <jsp:param name="operSignType" value="checkbox"/>
              <jsp:param name="isPage" value="false"/>
          </jsp:include>
  </td></tr>
</table>
</c:verbatim>

<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="¼����Ϣ" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>
<h:inputHidden id="contId" value="#{cont_contEndSignBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_contEndSignBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_contEndSignBB.bo.personId}"/>
<h:inputHidden id="personName" value="#{cont_contEndSignBB.bo.personName}"/>
<h:inputHidden id="attachmentId" value="#{cont_contEndSignBB.bo.attachmentId}"/>
<h:inputHidden id="createOrgId" value="#{cont_contEndSignBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_contEndSignBB.bo.isValid}"/>
<h:inputHidden id="contCreateDate" value="#{cont_contEndSignBB.bo.contCreateDate}"/>

<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="��ͬ���" />
         <h:outputText value=""/>
         <h:outputText   styleClass="td_form_required" value="ģ�����" />
         <h:selectOneMenu value="#{cont_contEndSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contEndSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contEndSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText  styleClass="td_form_required" value="��ͬ�������" />
         <h:selectOneMenu value="#{cont_contEndSignBB.bo.contClass}" id="contClass">
                    <c:selectItem itemValue="022006" itemLabel="��ͬ��ֹ" />
                    <c:selectItem itemValue="022007" itemLabel="��ͬ���" />
         </h:selectOneMenu>

         <h:outputText  styleClass="td_form_required" value="��ͬģ��" />
         <h:panelGroup>
             <h:selectOneMenu value="#{cont_contEndSignBB.bo.templateId}" id="templateId" >
                     <c:selectItems value="#{cont_contEndSignBB.item_template}"/>
             </h:selectOneMenu>
             <h:selectBooleanCheckbox id="generateDoc" value="#{cont_contEndSignBB.generateDoc}"></h:selectBooleanCheckbox>
             <h:outputText value="���ɺ�ͬ�ļ�"></h:outputText>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="��ͬ��ֹ/���ʱ��" />
         <h:panelGroup>
             <h:inputText id="contEndSignDate" styleClass="input" size="10" value="#{cont_contEndSignBB.bo.contEndSignDate}" readonly="true" alt="��ͬ��ֹ/���ʱ��|0"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndSignDate')"> </c:verbatim>
         </h:panelGroup>
         <h:outputText value="��ҵ��������" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contEndSignBB.bo.jobLimitTerm}" maxlength="10" alt="��ҵ��������|1|i" />
            <h:outputText value=" ��" />
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="���ò������" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="repairMoney" value="#{cont_contEndSignBB.bo.repairMoney}" maxlength="10" alt="���ò������|0|f" />
            <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="��ͬΥԼ���" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contEndSignBB.bo.fellbackMoney}" maxlength="10" alt="��ͬΥԼ���|0|f" />
            <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="ҽ�Ʋ�����" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="medicineMoney" value="#{cont_contEndSignBB.bo.medicineMoney}" maxlength="10" alt="ҽ�Ʋ���|0|f" />
            <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText styleClass="td_form_required"  value="һ���Բ������" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="oneOffMoney" value="#{cont_contEndSignBB.bo.oneOffMoney}" maxlength="10" alt="һ���Բ������|0|f" />
            <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText styleClass="td_form_required"  value="��������" />
         <h:panelGroup>
         <h:inputText styleClass="input" id="otherMoney" value="#{cont_contEndSignBB.bo.otherMoney}" maxlength="10" alt="��������|0|f" />
         <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText styleClass="td_form_required"  value="ʵ��Ӧ�����" />
         <h:panelGroup>
         <h:inputText styleClass="input" id="factPaymentMoney" value="#{cont_contEndSignBB.bo.factPaymentMoney}" maxlength="10" alt="ʵ��Ӧ�����|0|f" />
         <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText value="�Ͷ���ͬժҪ" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_contEndSignBB.bo.contRemark}"/>
         </h:panelGroup>

         <h:outputText value="�Ƿ�ͬ���֤" />
         <h:panelGroup>
             <h:inputText value="#{cont_contEndSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="ԭ��˵��" />
        <h:panelGroup>
        <h:inputText styleClass="input" id="endReason" code="" dict="yes" dict_num="2230"
                    readonly="true" value="#{cont_contEndSignBB.bo.endReason}"                     />
        <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:endReason')" class="button_select"></c:verbatim>
       </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="ȥ��" />
        <h:panelGroup>
        <h:inputText styleClass="input" id="endPlace" code="" dict="yes" dict_num="2231"
                    readonly="true" value="#{cont_contEndSignBB.bo.endPlace}"                     />
        <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:endPlace')" class="button_select"></c:verbatim>
       </h:panelGroup>

     </h:panelGrid>


     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
            <h:commandButton styleClass="button01" value="����" action="#{cont_contEndSignBB.save_add}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" action="#{cont_contEndSignBB.forwardList}"/>
     </h:panelGrid>
</h:form>

<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>