<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<base target="_self">
<script language="javascript">
    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("����ѡ������ʽ��");
            return false;
        }

        if (checkMutilSelect(form1.chk)) {
            count = form1.chk.length;
            var perID = "";
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        perID = form1.chk[i].value;   // ȡ��һ��
                        break;
                    }
            } else
                perID = form1.chk.value;
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID=&Parameter=&Title=";
            window.open(url);
        } else {
            alert("��ѡ����Ա");
        }
       return false;
   }
    
    function checkSubmit(form1) {
        flag = true;
        //�������
        var approveStatus = form1.all("form1:approveStatus").value;
        //������Ч����
        var uptoValidDate = form1.all("form1:uptoValidDate").value;
        if (approveStatus == "201003") {
            if (uptoValidDate == "" || uptoValidDate == null) {
                alert("��������Ϊ���ͨ��ʱ��������Ч����ʱ�䲻��Ϊ�գ�");
                flag = false;
                return flag;
             }
        }else if(approveStatus == "201004"){
            if (uptoValidDate != "" && uptoValidDate != null) {
                alert("��������Ϊ���δ��ʱ��������Ч����ʱ�䲻����д��");
                flag = false;
                return flag;
            }
        }
        //��������
        var approveDate = form1.all("form1:approveDate").value;

        if (uptoValidDate.trim() != "" && approveDate.trim() != "") {
            var sT = uptoValidDate.split("-");
            var stemp = new Date(sT[0], sT[1],  sT[2],"01");
            var wT = approveDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2],"01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("������Ч����ʱ���������������!");
                flag = false;
                return flag;
            }
        }
        var approveRemark = form1.all("form1:approveRemark").value;
        if (approveRemark != "" && approveRemark != null) {
            if (approveRemark.length>50) {
                alert("��ע���ֻ������50�����֣�");
                flag = false;
                return flag;
            }
        }

       return flag;
}
function confirmSave(form1){
        if (confirm('ȷ��Ҫ�ύ�������')) {
            pageCodeExchange(form1);
            return true;
        } else {
            return false;
        }
}

</script>
<x:saveState value="#{cont_contApproveBB}"/>

<h:form id="form1">
<h:inputHidden id="str" value="#{cont_contApproveBB.initAudit}"/>
<h:inputHidden id="str" value="#{cont_contApproveBB.selectContIds}"/>

<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" styleClass="td_title">
   <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="����ͬ " ></h:outputText>
   </h:panelGroup> 
</h:panelGrid>


<h:panelGrid  border="0"  align="center" columns="1" width="98%">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="�������Ա��ͬ��Ϣ" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>


<x:dataTable value="#{cont_contApproveBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top"  align="center"
                     rowClasses="td_middle" styleClass="table03" width="98%" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="ѡ��"/></c:facet>
                <c:verbatim escape="false"><input type="checkbox" name="chk" value="</c:verbatim>
                <h:outputText value="#{list.contPersonBO.personId}"/>
              <c:verbatim>"></c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�ϱ�����"/></c:facet>
                <h:outputText value="#{list.createOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="������"/></c:facet>
                <h:outputText value="#{list.operatorName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.contTermClass}"/>
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
                <c:facet name="header"><h:outputText value="��ͬԼ����ʼʱ��"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��ͬԼ������ʱ��"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ͬ���ʱ��"/></c:facet>
                <h:outputText value="#{list.contEndSignDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�ù����"/></c:facet>
                <h:outputText value="#{list.contPersonBO.jobType}"/>
            </h:column>
    
            <h:column>
                <c:facet name="header"><h:outputText value="��Ч����"/></c:facet>
                <h:outputText value="#{list.validOverdue}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="ԭ��˵��"/></c:facet>
                <h:outputText value="#{list.endReason}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���״̬"/></c:facet>
                <h:outputText value="#{list.approveStatus}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <c:verbatim escape="false"><A  href="/pages/cont/Download.jsp?attachmentId=</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">" taget="_blank" ></c:verbatim>
                <h:outputText value="��ͬ�鿴" />
                <c:verbatim escape="false"></A></c:verbatim>
            </h:column>
</x:dataTable>


<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="600">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="¼����Ϣ" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>

<h:panelGrid width="600" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="2" columnClasses="td_form01,td_form02">
        <h:outputText styleClass="td_form_required" value="��ر��"/>
        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{cont_contApproveBB.contReportList}"/>
            </h:selectOneMenu>
            <h:commandButton value="��ʾ" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
        </h:panelGroup>

        <h:outputText styleClass="td_form_required" value="������"/>
         <h:selectOneMenu value="#{cont_contApproveBB.vo.approveStatus}" id="approveStatus">
                    <c:selectItem itemValue="201003" itemLabel="���ͨ��" />
                    <c:selectItem itemValue="201004" itemLabel="���δ��" />
        </h:selectOneMenu>

        <h:outputText value="������Ч����ʱ��" />
        <h:panelGroup>
             <h:inputText id="uptoValidDate" styleClass="input" size="10" value="#{cont_contApproveBB.vo.uptoValidDate}" readonly="true" />
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:uptoValidDate')"> </c:verbatim>
        </h:panelGroup>

         <h:outputText value="��ע" />
         <h:panelGroup>
             <h:inputTextarea id="approveRemark" rows="4" cols="40"  value="#{cont_contApproveBB.vo.approveRemark}"/>
         </h:panelGroup>

         <h:outputText value="֪ͨ" />
          <h:panelGroup>
              <h:panelGroup>
                <h:selectBooleanCheckbox value="#{cont_contApproveBB.send}"></h:selectBooleanCheckbox>
                <h:outputText value="�Զ�����"></h:outputText>
              </h:panelGroup>
              <c:verbatim><br></c:verbatim>
              <h:inputTextarea rows="4" cols="40" value="#{cont_contApproveBB.message}"></h:inputTextarea>
          </h:panelGroup>

         <h:outputText styleClass="td_form_required" value="�����"></h:outputText>
         <h:inputText styleClass="input" value="#{cont_contApproveBB.vo.approvePersonId}" id="approvePersonId"  code="" dict="yes" dict_num="PE" readonly="true" alt="�����|0"/>

         <h:outputText styleClass="td_form_required" value="�������"></h:outputText>
         <h:panelGroup>
              <h:outputText value="#{cont_contApproveBB.vo.approveDate}" />
              <h:inputHidden id="approveDate" value="#{cont_contApproveBB.vo.approveDate}"/>
         </h:panelGroup>

</h:panelGrid>
     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="�ύ�����" action="#{cont_contApproveBB.save}"  onclick="if( checkSubmit(document.forms(0)) && checkAll(document.forms(0)) ){return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" type="button" value="����" onclick="window.close();"/>
     </h:panelGrid>

</h:form>

<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
