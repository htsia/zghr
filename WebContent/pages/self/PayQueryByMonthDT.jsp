<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
					
<script>
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
                <td align="center" width="30%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQueryByMonth.jsf"><strong>薪资查询－按月份查询工资发放明细</strong></a></td>
                <td align="center" width="30%" id="PayQuerySum" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQuerySum.jsf"><strong>薪资查询－按时间段查询工资汇总情况</strong></a></td>
                <td align="center" width="30%" id="TaxQuerySum" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\TaxQuerySum.jsf"><strong>薪资查询-个人所得税申报查询</strong></a></td>
                <script type="text/javascript">
                    <%
                       if ("0".equals(Constants.SELF_ENABLE_WAGE_QSUM)){
                           out.println("document.all('PayQuerySum').style.display=\"none\";");
                       }
                       if ("0".equals(Constants.SELF_ENABLE_WAGE_QTAX)){
                           out.println("document.all('TaxQuerySum').style.display=\"none\";");
                       }
                    %>
                </script>

            </tr>
            <tr>
                <td colspan=3>
                    <div class="tabbody" height="100%" width="100%"  id=datatable>
    </f:verbatim>
                    <h:panelGrid width="98%" columns="1" border="0" align="left"  cellpadding="3" >
                            <h:panelGroup>
                               <h:outputText value="请选择要查询的月份:" />
                               <h:inputText readonly="true" id="ym" value="#{self_querypaybb.ym}"  alt="增加日期|0|s|50||"/>
                <f:verbatim>
                                <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:ym')">
                </f:verbatim>

                               <h:outputText value=" " />
                                <h:outputText value="输入验证码:" rendered="#{sys_commonInfoBB.enableWageQueryCheck}"></h:outputText>
                                <h:inputText value="#{self_querypaybb.inputCode}"></h:inputText>
                               <h:commandButton value="查询" styleClass="button01" action="#{self_querypaybb.queryCurMonthList}" />
                            </h:panelGroup>

                        <h:panelGroup>
                            <h:panelGrid align="center" width="50%">
                              <h:outputText value="#{self_querypaybb.ym}第 #{self_querypaybb.payNum+1} 次[#{self_querypaybb.setName}]"	style="font-weight:bold;font-size:12pt" />
                            </h:panelGrid>

                            <h:panelGrid columns="1" align="right">
                                <h:panelGroup >
                                    <h:selectOneMenu id="payNum" value="#{self_querypaybb.payNum}">
                                      <f:selectItems value="#{self_querypaybb.condiments}"/>
                                    </h:selectOneMenu>
                                    <h:commandButton  value="发薪查询" action="#{self_querypaybb.queryPayNum}" styleClass="button01" />
                                    <h:commandButton  value="导出成Excel" onclick="return toExcel('#{self_querypaybb.ym}','#{self_querypaybb.payNum}')" styleClass="button01" />
                                </h:panelGroup>
                            </h:panelGrid>
                        </h:panelGroup>

                        <x:dataTable rowIndexVar="index" width="100%" align="center"  id="dateList"
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
   setDataTableOver("form1:dateList");
</script>
