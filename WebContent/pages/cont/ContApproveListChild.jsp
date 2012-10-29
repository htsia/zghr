<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" language="javascript">
    function checkBatchDo(){
        if (checkMutilSelect(document.all('selected_ids'))) {
            count = document.all('selected_ids').length;
            var str = "";
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (document.all('selected_ids')[i].checked) {
                        str += document.all('selected_ids')[i].value + ",";
                        num++;
                    }
            } else
                str = document.all('selected_ids').value;
            str=str.replace("#","~");  // #���ܳ���
            if (num>60){
                alert('ѡ����Ա���࣬����ϵͳ����(60),�������Ա�ٲ���.');
                return false;
            }
            else{
                window.showModalDialog("/cont/ContApproveAdd.jsf?selected_ids=" + str, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
                return true;
            }
        }
        else{
            alert("��ѡ����Ա!");
            return false;
        }
    }
    function forView(id) {
        windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&type=0", "aa", "", "1000", "600", "no","10","1","yes");
    }
    function editContCode(){
        if (checkMutilSelect(document.all('selected_ids'))) {
            count = document.all('selected_ids').length;
            var str = "";
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (document.all('selected_ids')[i].checked) {
                        str += document.all('selected_ids')[i].value + ",";
                        num++;
                    }
            } else
                str = document.all('selected_ids').value;
            str=str.replace("#","~");  // #���ܳ���
            if (num>60){
                alert('ѡ����Ա���࣬����ϵͳ����(60),�������Ա�ٲ���.');
                return false;
            }
            else{
                window.showModalDialog("/cont/EditMainContCodeDlg.jsf?selected_ids=" + str, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
                return true;
            }
        }
        else{
            alert("��ѡ����Ա!");
            return false;
        }
    }
</script>

<x:saveState value="#{cont_contApproveBB}"/>
<h:form id="form1">
      <h:inputHidden id="init_a" value="#{cont_contApproveBB.init_a}"/>
      <h:inputHidden id="superId" value="#{cont_contApproveBB.superId}"/>
      <f:verbatim>
      <table width=98% height=98%>
         <tr><td colspan=3 height=8>
      </f:verbatim>
             <h:outputText value="  "/>
             <h:outputText value="��¼��:#{cont_contApproveBB.pagevo.totalRecord}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ҳ��:#{cont_contApproveBB.pagevo.totalPage}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ÿҳ��#{cont_contApproveBB.pagevo.pageSize}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="��ǰΪ��#{cont_contApproveBB.pagevo.currentPage}ҳ"></h:outputText>
             <h:commandButton value="��ҳ" action="#{cont_contApproveBB.first}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{cont_contApproveBB.pre}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{cont_contApproveBB.next}" styleClass="button01"></h:commandButton>
             <h:commandButton value="βҳ" action="#{cont_contApproveBB.last}" styleClass="button01"></h:commandButton>
<f:verbatim>
         </td></tr>

         <tr><td height=8>
</f:verbatim>
             <h:outputText value="������"/>
             <h:inputText styleClass="input" size="15" id="personNameQry" value="#{cont_contApproveBB.personNameQry}"/>
             <h:commandButton styleClass="button01" value=" ��ѯ " onclick="return disPlayProcessBar();" action="#{cont_contApproveBB.queryAll}"/>

             <h:commandLink id="doQuery" action="#{cont_contApproveBB.queryAll}"></h:commandLink>
              <h:outputText value="��������"></h:outputText>
              <h:selectOneMenu value="#{cont_contApproveBB.contOper}" onchange="disPlayProcessBar();submit();" valueChangeListener="#{cont_contApproveBB.changeOper}">
                  <c:selectItems value="#{cont_contApproveBB.contOperList}"></c:selectItems>
              </h:selectOneMenu>
  <f:verbatim>
             </td>
             <td height=8>
</f:verbatim>
                 <h:selectOneRadio value="#{cont_contApproveBB.personMode}" onclick="disPlayProcessBar();submit();" valueChangeListener="#{cont_contApproveBB.changeMode}">
                     <c:selectItem itemValue="201002" itemLabel="������Ա"></c:selectItem>
                     <c:selectItem itemValue="201003" itemLabel="����δ��Ч��Ա"></c:selectItem>
                 </h:selectOneRadio>
  <f:verbatim>
             </td>
             <td height=8>
</f:verbatim>
                 <h:outputText value="  "/>
                 <h:commandButton styleClass="button01" value=" ��� " action="#{cont_contApproveBB.queryAll}" onclick="return checkBatchDo();"/>
                 <h:commandButton styleClass="button01" value=" �޸ĺ�ͬ��� "  action="#{cont_contApproveBB.queryAll}" onclick="return editContCode();"/>
<f:verbatim>
             </td>
             </tr>

         <tr><td colspan=3 valign=top>
             <div style='width:100%;height:100%;overflow:auto' id='datatable'>
</f:verbatim>
                 <x:dataTable value="#{cont_contApproveBB.bos}" var="list"  rowIndexVar="index"
                                      headerClass="td_fixtop"   id="dateList"
                                      columnClasses="td_middle,td_middle,td_middle,td_middle,td_middle" styleClass="table03"  border="0">

                              <h:column>
                                   <c:facet name="header">
                                       <c:verbatim escape="false">
                                       <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                                       </c:verbatim>
                                   </c:facet>
                                   <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                                   <h:outputText value="#{list.contId}"/>
                                <c:verbatim>"></c:verbatim>
                               </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="����" style="width:60px"/></c:facet>
                                 <h:commandLink id="bnt1" value="��Ա��Ϣ" onclick="forView('#{list.contPersonBO.personId}')">
                                 </h:commandLink>

                                 <c:verbatim escape="false"><br><A  onclick="doShowCont('</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">')" taget="_blank" ></c:verbatim>
                                 <h:outputText value="��ͬ�鿴" />
                                 <c:verbatim escape="false"></A></c:verbatim>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="�ϱ�����" style="width:130px"/></c:facet>
                                 <h:outputText value="#{list.contPersonBO.enterOrgId}"/>
                             </h:column>

                         <h:column>
                             <c:facet name="header"><h:outputText value="������" style="width:130px"/></c:facet>
                             <h:outputText value="#{list.operator}"/>
                         </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="��ͬ���" style="width:80px"/></c:facet>
                                 <h:outputText value="#{list.contCode}"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="�������" style="width:60px"/></c:facet>
                                 <h:outputText value="#{list.contTermClass}" style="width:60px"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="����" style="width:60px" /></c:facet>
                                 <h:outputText value="#{list.contPersonBO.personName}" style="width:60px"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="���빫˾ʱ��" style="width:80px" /></c:facet>
                                 <h:outputText value="#{list.contPersonBO.unitTime}" style="width:80px"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="�Ա�" style="width:40px"  /></c:facet>
                                 <h:outputText value="#{list.contPersonBO.personSex}"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="ѧ��" style="width:60px" /></c:facet>
                                 <h:outputText value="#{list.contPersonBO.personEducation}"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="��ͬԼ����ʼʱ��" style="width:80px" /></c:facet>
                                 <h:outputText value="#{list.contStartDate}"/>
                             </h:column>
                             <h:column>
                                 <c:facet name="header"><h:outputText value="��ͬԼ������ʱ��" style="width:80px"/></c:facet>
                                 <h:outputText value="#{list.contEndDate}"/>
                             </h:column>

                         <h:column>
                             <c:facet name="header"><h:outputText value="ԭ��˵��" style="width:120px"/></c:facet>
                             <h:outputText value="#{list.endReason}"/>
                         </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="��λ���" style="width:80px"/></c:facet>
                                 <h:outputText value="#{list.contPersonBO.jobType}"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="��Ч����" style="width:80px"/></c:facet>
                                 <h:outputText value="#{list.validOverdue}"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="���״̬" style="width:80px"/></c:facet>
                                 <h:outputText value="#{list.approveStatus}"/>
                             </h:column>

                             <h:column>
                                 <c:facet name="header"><h:outputText value="��Ա��������" style="width:80px"/></c:facet>
                                 <h:outputText value="#{list.contPersonBO.auditoperid}"/>
                             </h:column>


                 </x:dataTable>
<f:verbatim>
             </div>
         <td></tr>
     </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
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