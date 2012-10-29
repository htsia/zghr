<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function addWorkLog(){
        window.showModalDialog("/OA/WorkLogEdit.jsf", null, "dialogWidth:700px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function ModifyWorkLog(logID){
        window.showModalDialog("/OA/WorkLogEdit.jsf?logID="+logID, null, "dialogWidth:700px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doApply(Msg){
        sendMessage(document.all('form1:leader').value,Msg);
    }
</script>

<x:saveState id="oa_worklogBB" value="#{oa_worklogBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{oa_worklogBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="leader" value="#{oa_worklogBB.leader}"></h:inputHidden>
    <c:verbatim>
        <table width=98% height=98% align="center">
        <tr><td height=8 class="td_title">
    </c:verbatim>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="��������¼" />
    <c:verbatim>
        </td></tr>

        <tr><td height=8 align="right">
    </c:verbatim>
           <h:outputText value="ѡ���·�"></h:outputText>
            <h:inputText readonly="true" id="processDate" value="#{oa_worklogBB.month}"></h:inputText>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:processDate')"/>
            <h:commandButton value="��ѯ" styleClass="button01"></h:commandButton>
            <h:commandButton value="ȫ��" styleClass="button01" onclick="document.all('form1:processDate').value='';" ></h:commandButton>
            <h:commandButton value="����" styleClass="button01" onclick="return addWorkLog();"></h:commandButton>
    <c:verbatim>
        </td></tr>


        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <x:dataTable value="#{oa_worklogBB.logList}" var="filelist" id="dateList" headerClass="td_top" rowIndexVar="index"  
                     columnClasses="td_middle_center,td_middle,td_middle_left,td_middle,td_middle,td_middle_center" width="1800"
                       align="center" border="1" styleClass="table03" >
            <h:column>
                <f:facet name="header">
                         <h:outputText value="�� ��" style="width:100px"/>
                </f:facet>
                <h:commandButton value="�޸�" styleClass="button01" onclick="return ModifyWorkLog('#{filelist.logID}')"></h:commandButton>
                <h:commandButton value="��ʾ�ϼ�" styleClass="button01" type="button" onclick="doApply('#{filelist.content}');"></h:commandButton>
           </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���" style="width:50px"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�����̶�" style="width:80px"/>
                </f:facet>
                <h:outputText value="#{filelist.emgLevelDes}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="���ʱ��" style="width:90px"/>
                </f:facet>
                <h:outputText value="#{filelist.logDate}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="����" style="width:200px"/>
                </f:facet>
                <h:outputText value="#{filelist.content}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�����" style="width:100px"/>
                </f:facet>
                <h:outputText value="#{filelist.apply}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�漰��Ա" style="width:100px"/>
                </f:facet>
                <h:outputText value="#{filelist.linkPerson}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�⴦��" style="width:200px"/>
                </f:facet>
                <h:outputText value="#{filelist.process}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="������" style="width:100px"/>
                </f:facet>
                <h:outputText value="#{filelist.processor}"></h:outputText>
            </h:column>


            <h:column>
                <f:facet name="header">
                    <h:outputText value="�ϼ����" style="width:200px"/>
                </f:facet>
                <h:outputText value="#{filelist.leaderop}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�ϼ����ʱ��" style="width:90px"/>
                </f:facet>
                <h:outputText value="#{filelist.leadDate}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�������" style="width:200px"/>
                </f:facet>
                <h:outputText value="#{filelist.superop}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�������ʱ��" style="width:90px"/>
                </f:facet>
                <h:outputText value="#{filelist.superDate}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="���ʱ��" style="width:90px"/>
                </f:facet>
                <h:outputText value="#{filelist.resultDate}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="������" style="width:90px"/>
                </f:facet>
                <h:outputText value="#{filelist.resultOper}"></h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="������" style="width:200px"/>
                </f:facet>
                <h:outputText value="#{filelist.result}"></h:outputText>
            </h:column>

          </x:dataTable>
   <c:verbatim>
       </div>
       </td></tr>
        </table>
   </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
