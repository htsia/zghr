<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
         function EditWageOut(chgId){
             var url="/wage/relation/SalaryOutEdit.jsf?chgId="+chgId;
             window.showModalDialog(url, null, "dialogWidth:750px; dialogHeight:550px;center:center;resizable:no;status:no;");
             return false;
         }
         function ProcessFamily(chgId){
             var url="/wage/relation/ProcessFamily.jsf?chgId="+chgId;
             window.showModalDialog(url, null, "dialogWidth:750px; dialogHeight:350px;center:center;resizable:no;status:no;");
             return false;
         }
         function OpenRpt(perID){
            if (document.all("form1:ReportID").value=="-1"){
                alert("����ѡ������ʽ��");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID=&Parameter=&Title=";
            window.open(url);
            return false;
        }
         function doWorkLetter() {
              var ret=window.showModalDialog("/employee/chg/BasicWorkLetterList.jsf", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:no;status:no;");
              return true;
         }
         function doCadresLetter() {
              var ret=window.showModalDialog("/employee/chg/BasicCadresLetterList.jsf", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:no;status:no;");
              return true;
         }
         function doShowPerson(id) {
             windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type=1", "aa", "", "1000", "600", "no","10","1","yes");
         }
    </script>

<x:saveState value="#{emp_PersonChgListBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrg" value="#{emp_PersonChgListBB.fromOrgProcess}"/>

    <f:verbatim>
    <table height=98% width=98% align="center">
    <tr><td height=8>
    </f:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="3">
           <h:panelGroup>
               <h:graphicImage value="/images/tips.gif" />
               <h:outputText value=" ������� ->  ����ҵ�����"/>
            </h:panelGroup>

            <h:outputText escape="false" value=" <font color=red>����ʱ�����ķǷ����ݿ����ɱ���λ������Ա��ɾ������</font>" />

            <h:panelGroup>
                <h:commandButton value="��ӡ���˵���������" styleClass="button01" type="button" onclick="doWorkLetter()" ></h:commandButton>
                <h:commandButton value="��ӡ�ɲ�����������" styleClass="button01" type="button" onclick="doCadresLetter()"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
    <f:verbatim>
    </td></tr>

    <tr><td height=8>
    </f:verbatim>
        <h:panelGrid columns="4" width="95%" align="left">
           <h:panelGroup>
                <h:selectBooleanCheckbox value="#{emp_PersonChgListBB.onlyNotApprove}" id="selectNotApprove" onclick="submit()" valueChangeListener="#{emp_PersonChgListBB.changeFrom}" />  <h:outputText value="����������Ա"/>
           </h:panelGroup>

           <h:panelGroup>
               <h:outputText value="����ʱ��"></h:outputText>
               <h:inputText readonly="true" id="processDate" value="#{emp_PersonChgListBB.processDate}"></h:inputText>
               <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
               <h:outputText value="    ��������:"></h:outputText>
               <h:inputText value="#{emp_PersonChgListBB.name}"></h:inputText>
               <h:commandButton value="��ѯ" styleClass="button01" action="#{emp_PersonChgListBB.getFromOrgProcess}"></h:commandButton>
               <h:commandButton value="ȫ��" styleClass="button01" onclick="document.all('form1:processDate').value='';" action="#{emp_PersonChgListBB.getFromOrgProcess}"></h:commandButton>
           </h:panelGroup>

           <h:panelGrid columns="4" align="right">
              <h:selectOneMenu id="ReportID" style="width:140px">
                 <c:selectItems value="#{emp_PersonChgListBB.reportList}"/>
              </h:selectOneMenu>
           </h:panelGrid>

       </h:panelGrid>
    <f:verbatim>
    </td></tr>

    <tr><td align="right" height=8>
    </f:verbatim>
            <h:outputText value="��¼��:#{emp_PersonChgListBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ҳ��:#{emp_PersonChgListBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{emp_PersonChgListBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{emp_PersonChgListBB.pagevo.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{emp_PersonChgListBB.outprefirst}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{emp_PersonChgListBB.outprepre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{emp_PersonChgListBB.outprenext}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{emp_PersonChgListBB.outprelast}" styleClass="button01"></h:commandButton>
    <f:verbatim>
    </td></tr>

    <tr><td >
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </f:verbatim>
            <h:dataTable value="#{emp_PersonChgListBB.fromOrgPerson}" var="list" align="center"  id="dateList"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                         styleClass="table03">
                <h:column>
                    <c:facet name="header">
                        <c:verbatim escape="false">
                            <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>
                            <h:outputText value="ȫѡ" style="width:60px"></h:outputText>
                        </c:verbatim>
                    </c:facet>
                    <c:verbatim escape="false">
                        <input type="checkbox" name="selectItem"    value="</c:verbatim><h:outputText value="#{list.chgId}"/><c:verbatim>">
                    </c:verbatim>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����" style="width:140px"/></c:facet>
                    <h:panelGrid columns="3">
                        <h:commandButton styleClass="button01"  value="�鿴��Ϣ"  onclick="doShowPerson('#{list.personId}')"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="���°���" rendered="#{list.managerOpinion=='0'}" action="#{emp_PersonChgListBB.redo}">
                                <x:updateActionListener property="#{emp_PersonChgListBB.chgid}" value="#{list.chgId}"/>
                        </h:commandButton>
                        <h:commandButton styleClass="button01"  value="����н��ת��" rendered="#{list.applyStatus=='0'}" onclick="EditWageOut('#{list.chgId}')"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="������Ǩ�˿�" rendered="#{list.applyStatus=='0'}" onclick="ProcessFamily('#{list.chgId}')"></h:commandButton>
                        <h:commandButton value="��ӡ���" styleClass="button01" rendered="#{list.applyStatus=='0'}" onclick="return OpenRpt('#{list.personId}');"></h:commandButton>
                    </h:panelGrid>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="��������" style="width:80px"/></c:facet>
                    <h:outputText value="#{list.applyDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="Ա�����" style="width:80px"/></c:facet>
                    <h:outputText value="#{list.personCode}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����" style="width:80px"/></c:facet>
                    <h:outputText value="#{list.name}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="���" style="width:120px"/></c:facet>
                    <h:outputText value="#{list.degree}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="ԭ��λ" style="width:120px"/></c:facet>
                    <h:outputText value="#{list.fromOrgName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="������λ" style="width:120px"/></c:facet>
                    <h:outputText value="#{list.toOrgName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="�����������" style="width:120px"/></c:facet>
                    <h:outputText value="#{list.oldOrgWageSet}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:100px" value="ԭ��λ���" /></c:facet>
                    <h:outputText value="#{list.fromOpinionDes}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:100px" value="ԭ��λ����ԭ��" /></c:facet>
                    <h:outputText value="#{list.fromReason}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:100px" value="ԭ��λ����ʱ��" /></c:facet>
                    <h:outputText value="#{list.fromDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:100px"  value="ԭ��λ��ͬ���" /></c:facet>
                    <h:outputText value="#{list.cont_old_end}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:100px" value="���뵥λ���" /></c:facet>
                    <h:outputText value="#{list.toOpinionDes}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:120px" value="���뵥λ����ԭ��" /></c:facet>
                    <h:outputText value="#{list.toReason}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:120px" value="���뵥λ����ʱ��" /></c:facet>
                    <h:outputText value="#{list.toDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:120px"  value="���뵥λ��ͬ���" /></c:facet>
                    <h:outputText value="#{list.cont_new_begin}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:120px"  value="���ܵ�λ���" /></c:facet>
                    <h:outputText value="#{list.managerOpinionDes}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����״̬" style="width:130px"/></c:facet>
                    <h:outputText value="#{list.applyStatusDes}" />
                </h:column>

            </h:dataTable>
    <f:verbatim>
        </div>
     </td></tr>
   </table>
    </f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
