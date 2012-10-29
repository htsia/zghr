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
          alert("请输入开始时间和结束时间");
          return false;
        }else if(startDate>endDate){
          alert("开始时间晚于结束时间");
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
                <td align="center" width="30%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQueryByMonth.jsf">薪资查询－按月份查询工资发放明细</a></td>
                <td align="center" width="30%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQuerySum.jsf">薪资查询－按时间段查询工资汇总情况</a></td>
                <td align="center" width="30%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\TaxQuerySum.jsf">薪资查询-个人所得税申报查询</a></td>
            </tr>
        <tr>
            <td colspan=3>
                <div class="tabbody" height="100%" width="100%"  id=datatable>
</f:verbatim>
            <h:panelGrid width="98%" columns="1" border="0" align="left"  cellpadding="3" >
        <h:panelGroup>
             <h:outputText value="开始时间" />
             <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|d" value="#{self_querypaybb.beginTime}" readonly="true"/>
             <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginTime')"></f:verbatim>

             <h:outputText value="  " />

            <h:outputText value="结束时间" />
            <h:inputText styleClass="input" id="endTime" alt="结束时间|0|d" size="12" value="#{self_querypaybb.endTime}" readonly="true"/>
            <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endTime')"></f:verbatim>

            <h:outputText value="  " />
            <h:outputText value="输入验证码:" rendered="#{sys_commonInfoBB.enableWageQueryCheck}"></h:outputText>
            <h:inputText value="#{self_querypaybb.inputCode}"></h:inputText>
            <h:commandButton value="查询" onclick ="return checkDate();" styleClass="button01" action="#{self_querypaybb.queryByTime}" />
        </h:panelGroup>

        <h:panelGroup>
            <h:panelGrid align="center" width="50%">
              <h:outputText value="工资汇总情况"	style="font-weight:bold;font-size:12pt" />
            </h:panelGrid>

            <h:panelGrid columns="1" align="right">
               <h:commandButton  value="导出成Excel" onclick="return toExcel('#{self_querypaybb.ym}','#{self_querypaybb.payNum}')" styleClass="button01" />
            </h:panelGrid>
        </h:panelGroup>

        <x:dataTable rowIndexVar="index" id="userdata" width="100%" align="center"
             value="#{self_querypaybb.payList}" var="paylist"  headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03">
           <h:column>
                <f:facet name="header">
                    <h:outputText value="序号"></h:outputText>
                </f:facet>
                <h:outputText value="#{index+1}"  style="#{paylist[3]}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="发薪项目"></h:outputText>
                </f:facet>
                <h:outputText value="#{paylist[0]}"  style="#{paylist[3]}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="金额"></h:outputText>
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
