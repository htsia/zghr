<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
					
<script>
     function checkDate(){
        var endDate = document.all("form1:endTime").value;
        var startDate = document.all("form1:beginTime").value;
        if(startDate==null||startDate==""||endDate==null||endDate==""){
          alert("�����뿪ʼʱ��ͽ���ʱ��");
          return false;
        }else if(startDate>endDate){
          alert("��ʼʱ�����ڽ���ʱ��");
          return false;
        }
        else
          return true;
     }
     function toExcel(ym,num){
         url="/pages/self/PayQueryPrint.jsf?subOneId="+ym+"&bakPayNum="+num;
         window.open(url);
     }
</script>

<x:saveState id="bb"  value="#{self_querypaybb}"/>
<h:form id="form1">
    <h:inputHidden value="#{self_querypaybb.initByMonth}"/>
    <f:verbatim>
        <br>
        <table width="90%"  cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td align="center" width="30%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQueryByMonth.jsf">н�ʲ�ѯ�����·ݲ�ѯ���ʷ�����ϸ</a></td>
                <td align="center" width="30%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQuerySum.jsf">н�ʲ�ѯ����ʱ��β�ѯ���ʻ������</a></td>
                <td align="center" width="30%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\TaxQuerySum.jsf">н�ʲ�ѯ-��������˰�걨��ѯ</a></td>
            </tr>
        <tr>
            <td colspan=3>
                <div class="tabbody" height="100%" width="100%"  id=datatable>
</f:verbatim>
            <h:panelGrid width="98%" columns="1" border="0" align="left"  cellpadding="3" >
        <h:panelGroup>
             <h:outputText value="��ʼʱ��" />
             <h:inputText styleClass="input" id="beginTime" size="12" alt="��ʼʱ��|0|d" value="#{self_querypaybb.beginTime}" readonly="true"/>
             <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginTime')"></f:verbatim>

             <h:outputText value="  " />

            <h:outputText value="����ʱ��" />
            <h:inputText styleClass="input" id="endTime" alt="����ʱ��|0|d" size="12" value="#{self_querypaybb.endTime}" readonly="true"/>
            <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endTime')"></f:verbatim>

            <h:outputText value="  " />
            <h:outputText value="������֤��:" rendered="#{sys_commonInfoBB.enableWageQueryCheck}"></h:outputText>
            <h:inputText value="#{self_querypaybb.inputCode}"></h:inputText>
            <h:commandButton value="��ѯ" onclick ="return checkDate();" styleClass="button01" action="#{self_querypaybb.queryByTime}" />
        </h:panelGroup>

        <h:panelGroup>
            <h:panelGrid align="center" width="50%">
              <h:outputText value="���ʻ������"	style="font-weight:bold;font-size:12pt" />
            </h:panelGrid>

            <h:panelGrid columns="1" align="right">
               <h:commandButton  value="������Excel" onclick="return toExcel('#{self_querypaybb.ym}','#{self_querypaybb.payNum}')" styleClass="button01" />
            </h:panelGrid>
        </h:panelGroup>

        <x:dataTable rowIndexVar="index" id="userdata" width="100%" align="center"
             value="#{self_querypaybb.payList}" var="paylist"  headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03">
           <h:column>
                <f:facet name="header">
                    <h:outputText value="���"></h:outputText>
                </f:facet>
                <h:outputText value="#{index+1}"  style="#{paylist[3]}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="��н��Ŀ"></h:outputText>
                </f:facet>
                <h:outputText value="#{paylist[0]}"  style="#{paylist[3]}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="���"></h:outputText>
                </f:facet>
                <h:outputText value="#{paylist[1]}"  style="#{paylist[3]}"/>
            </h:column>
        </x:dataTable>
    </h:panelGrid>
<f:verbatim>    
    </div>

</td>
</tr>
    
        </table>
    </f:verbatim>


</h:form>
<script type="text/javascript">
   setDataTableOver("form1:userdata");
</script>
