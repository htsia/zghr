<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function queryConstChange(){
           window.showModalDialog("/wage/payoff/showConstChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:460px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        }

        function showCalcTime(){
            window.showModalDialog("/wage/payoff/showCalcTime.jsf?setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&dateId="+document.all("form1:dateId").value, null, "dialogWidth:560px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

        function exportDept(){
           window.showModalDialog("/wage/set/exportDeptInfo.jsf?setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&dateId="+document.all("form1:dateId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return false;
        }

        function doSetConst(){
            var url="/wage/set/SetConst.jsf?setId=WAGE_DATACHECK&setName=数据检查参数";
            //alert(url);
            window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

        function doCheckData(){
            var setid=form1.all("form1:setId").value;
            var dateId=form1.all("form1:dateId").value;
            window.showModalDialog("/wage/payoff/doCheckData.jsf?dateId="+dateId+"&setID="+setid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowOrgDiff(){
            var url="/wage/payoff/ShowOrgDiff.jsf?dateId="+form1.all("form1:dateId").value+"&unitId="+form1.all("form1:unitId").value;
            window.open(url,'','scrollbar=yes,toolbar=0,height=500,width='+screen.width*0.9+',top=40,left='+screen.width*0.05);
            return false;
        }

        function changeStatus(){
            if (form1.all("form1:status").value=="0"){
                form1.all("form1:idOK").value = "薪资审批未通过";
                form1.all("form1:message").value="薪资审批未通过";
            }
            else{
                form1.all("form1:idOK").value = "薪资审批通过";
                form1.all("form1:message").value="薪资审批通过";
            }
        }

        function doDetailPopup() {
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/AuditViewDetail.jsf?dateId=" + dateId, "员工工资发放明细", "height="+screen.height*0.85+",width="+screen.width*0.95+",left="+screen.width*0.0025+",top="+screen.height*0.05+",toolbar=no,menubar=no,scrollbars=auto,resizable=yes");
            popup.focus();
        }
        function doCheckInsurace(){
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/checkInsuraceRate.jsf?dateId=" + dateId, "员工保险基数", "height="+screen.height*0.75+",width="+screen.width*0.9+",left="+screen.width*0.05+",top="+screen.height*0.1+",toolbar=no,menubar=no,scrollbars=auto,resizable=yes");
            popup.focus();
        }
        function doNotePopup() {
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/WageNoteView.jsf?dateId=" + dateId, "", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }

        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var url="/pages/report/FlowReportShow.jsp?Title="+document.all("form1:ReportID").value;
            window.open(url);
            return false;
        }
        function OpenNowRpt(){
            if (document.all("form1:nowStaticID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:nowStaticID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                     +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:nowStaticID").value;
            window.open(url);
            return false;
        }

        function ViewItemSet(setid){
            var url="/wage/set/SetItemListView.jsf?setId="+setid;
            window.open(url);
            return false;
        }
        function showDeptdiff(){
            var url="/wage/payoff/ShowDeptDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height='+screen.height*0.8+',width='+screen.width*0.8+',top='+screen.height*0.1+',left='+screen.width*0.1+',scrollbars=auto');
            return false;
        }
        function doShowDiff(){
            var url="/wage/payoff/ShowDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height='+screen.height*0.8+',width='+screen.width*0.8+',top='+screen.height*0.1+',left='+screen.width*0.1+',scrollbars=auto');
            return false;
        }
    </script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
<c:verbatim>
<table height=98% width=100%  cellSpacing=0>
    <tr>
        <td height=2 class=td_title colspan=2>
</c:verbatim>
            <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="薪酬管理 -> 薪资审批:"/>
                <h:outputText value="#{wage_flowBB.setName}"/>
            </h:panelGroup>

            <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
            <h:inputHidden id="unitId" value="#{wage_flowBB.unitId}"/>
            <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
<c:verbatim>
         </td>
    </tr>

    <tr>
        <td height=2 width=80%>
</c:verbatim>
        <h:panelGrid columns="2"  align="center" width="80%" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="上传的审批表"/>
            <h:panelGroup>
                 <h:selectOneMenu id="ReportID" style="width:250px">
                    <c:selectItems value="#{wage_flowBB.reportList}"/>
                </h:selectOneMenu>
                 <h:commandButton value="显示审批表" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                 <h:commandButton value="显示生成时间" type="button" styleClass="button01" onclick="return showCalcTime();"></h:commandButton>
            </h:panelGroup>

            <h:outputText value="复核意见"/>
            <h:outputText escape="false"  value="已审核！#{wage_flowBB.date.checkContent} <br><div align=right> #{wage_flowBB.checkerName}</div>"/>

            <h:outputText value="审批意见"/>
            <h:selectOneMenu id="status" value="#{wage_flowBB.date.approveStatus}" onchange="changeStatus();">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="0" itemLabel="不同意"/>
            </h:selectOneMenu>

            <h:outputText value="原因"/>
            <h:inputTextarea value="#{wage_flowBB.date.approveContent}" rows="3" cols="80"/>

            <h:outputText value="通知"/>
            <h:panelGroup>
                <h:selectBooleanCheckbox value="#{wage_flowBB.sendSM}" ></h:selectBooleanCheckbox>
                <h:outputText value="自动发通知"></h:outputText>
                <h:commandButton value="暂存结果" action="#{wage_flowBB.submitApprove}" styleClass="button01">
                    <x:updateActionListener property="#{wage_flowBB.act}" value="save"/>
                </h:commandButton>
                <h:commandButton id="idOK" value="确定" action="#{wage_flowBB.submitApprove}" styleClass="button01" onclick="return confirm('您确认提交?')">
                    <x:updateActionListener property="#{wage_flowBB.act}" value="submit"/>
                </h:commandButton>
                <h:commandButton value="取消返回" action="#{wage_flowBB.list}" styleClass="button01">
                    <x:updateActionListener property="#{wage_flowBB.act}" value="2"/>
                </h:commandButton>

                <c:verbatim>
                <br>
                </c:verbatim>
                <h:inputTextarea id="message" value="#{wage_flowBB.message}" rows="3" cols="80"/>
            </h:panelGroup>
           </h:panelGrid>
<c:verbatim>
        </td>

        <td>
</c:verbatim>
            <h:commandButton type="button" styleClass="button01" value="查询常量" onclick="queryConstChange();"></h:commandButton>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="查看部门总额信息" type="button" onclick="return exportDept();" styleClass="button01"/>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="查看项目设置及算法" type="button" onclick="return ViewItemSet('#{wage_flowBB.date.setId}');" styleClass="button01"/>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="查看明细信息" type="button" onclick="doDetailPopup()" styleClass="button01"/>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="核对保险基数" type="button" onclick="doCheckInsurace()" styleClass="button01"/>
<c:verbatim>
        </td>
    </tr>

    <tr><td height=2 align=left  colspan=2>
         <table>
            <tr>
            <td>
</c:verbatim>
                <h:outputText escape="false" value="&nbsp;&nbsp;汇总信息："></h:outputText>
                <h:selectOneMenu value="#{wage_flowBB.itemType}" >
                    <c:selectItems value="#{wage_flowBB.itemTypeList}"></c:selectItems>
                </h:selectOneMenu>
<c:verbatim>
            </td>
            <td>
</c:verbatim>
                <h:commandButton value="过滤" styleClass="button01"  action="#{wage_flowBB.findDate}"></h:commandButton>
<c:verbatim>
            </td>

            <td>
</c:verbatim>
                    <h:commandButton value="机构对比" type="button" onclick="return doShowOrgDiff();" styleClass="button01"/>
                    <h:commandButton value="部门对比" type="button" onclick="return showDeptdiff();" styleClass="button01"/>
                    <h:commandButton value="人员对比" type="button" onclick="return doShowDiff();" styleClass="button01"/>
<c:verbatim>
            </td>

            <td>
</c:verbatim>
                <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;"></h:outputText>
                <h:commandButton value="检查参数" type="button" onclick="doSetConst()" styleClass="button01"/>
                <h:commandButton value="数据检查" type="button" onclick="doCheckData()" styleClass="button01"/>
<c:verbatim>
             </td>

             <td>
</c:verbatim>
                 <h:commandButton value="查看变动表" type="button" onclick="doNotePopup()" rendered="false" styleClass="button01"/>

                 <h:selectOneMenu id="nowStaticID" style="width:250px">
                    <c:selectItems value="#{wage_flowBB.nowReportList}"/>
                </h:selectOneMenu>
                 <h:commandButton value="显示" styleClass="button01" onclick="return OpenNowRpt();"></h:commandButton>
<c:verbatim>
             </td>

             </tr>
         </table>
     </td></tr>

    <tr><td colspan=2>
    <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
    </jsp:include>
    </td></tr>
</table>
</c:verbatim>
</h:form>
