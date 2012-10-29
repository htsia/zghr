<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doSaveAs(setID,dateId){
            var setId = form1.all("form1:setId").value
            if(setId==null||setId==""){
                alert("请选择帐套");
                return false;
            }
            reval = window.showModalDialog("/insurace/SaveDataToDisk.jsf?dateId="+dateId+"&setID="+setID, null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
            return false;            
        }
        function forAddDate() {
            var setId = form1.all("form1:setId").value
            if(setId==null||setId==""){
                alert("请选择帐套");
                return false;
            }
            reval = window.showModalDialog("/wage/payoff/DateEdit.jsf", null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
            if (reval != null && reval != "") {
                var arg = reval.split("|");
                form1.all('form1:date').value = arg[0];
                form1.all('form1:yearMonth').value = arg[1];
                form1.all('form1:desc').value = arg[2];
                return true;
            } else {
                return false;
            }
        }
        function forFinanceDate() {
            var setId = form1.all("form1:setId").value
            if(setId==null||setId==""){
                alert("请选择帐套");
                return false;
            }
            reval = window.showModalDialog("/wage/payoff/DateFinanceItem.jsf?setId=" + setId, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            if (reval != null && reval != "") {
                form1.all("form1:str").value = reval;
                return true;
            } else {
                form1.all("form1:str").value = "cancel";
                return false;
            }
        }
        function doDetailPopup(id) {
            var dateId = id;
            popup = window.open("/insurce/InsurceDetailView.jsf?dateId=" + dateId, "员工工资发放明细", "top="+screen.height*0.07+",left="+screen.width*0.07+",height=600,width="+screen.width*0.85+",toolbar=no,menubar=no,scrollbars=yes,resizable=no");
            popup.focus();
        }
        function doNotePopup(id) {
            var dateId = id;
            popup = window.open("/wage/payoff/WageNoteView.jsf?dateId=" + dateId, "", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }
    </script>

<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_dateBB.pageInit}"/>
    <h:inputHidden id="str" value=""/>
    <h:inputHidden id="date" value="#{wage_dateBB.date.date}"/>
    <h:inputHidden id="desc" value="#{wage_dateBB.date.desc}"/>
    <h:inputHidden id="yearMonth" value="#{wage_dateBB.date.yearMonth}"/>
    <h:inputHidden id="yearMonth" value="#{wage_dateBB.setName}"/>

    <h:panelGrid width="98%" align="center"  columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" 保险管理 ->  保险信息处理"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="2" cellspacing="2" width="90%"  align="center" >
        <h:panelGroup>
            <h:outputText escape="false" value="<strong>薪资账套：</strong>"></h:outputText>
            <h:selectOneMenu id = "setId" value="#{wage_dateBB.setId}"  onchange="submit()"
                      valueChangeListener="#{wage_dateBB.queryDateList}">
                 <c:selectItems value="#{wage_dateBB.setList}"/>
            </h:selectOneMenu>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="2" align="center" width="90%" >
        <h:panelGrid columns="5" cellspacing="2">
            <h:outputText escape="false" value="<strong>开始时间</strong>"/>
            <h:panelGroup>
                <h:inputText value="#{wage_dateBB.startDate}" id="startDate" alt="开始时间|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date"  onclick="PopUpCalendarDialog('form1:startdate')"/>
            </h:panelGroup>
            <h:outputText escape="false" value="<strong>结束时间</strong>"/>
            <h:panelGroup>
                <h:inputText value="#{wage_dateBB.endDate}" id="endDate" alt="结束时间|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:endDate')"/>
            </h:panelGroup>
            <h:commandButton value="查询" action="#{wage_dateBB.dateList}" styleClass="button01" onclick="return forsubmit(document.forms(0))"/>
        </h:panelGrid>
    </h:panelGrid>

    <h:dataTable value="#{wage_dateBB.dateList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="业务处理日期"/></c:facet>
            <h:outputText value="#{list.date}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="描述"/></c:facet>
            <h:outputText value="#{list.desc}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.status}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="复核意见"/></c:facet>
            <h:outputText value="#{list.checkContent}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="审批意见"/></c:facet>
            <h:outputText value="#{list.approveContent}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="报盘" type="button" styleClass="button01" onclick="doSaveAs('#{wage_dateBB.setId}','#{list.dateId}');" rendered="#{list.status!='结束'}"></h:commandButton>
                <h:commandButton value="打开" action="#{ins_computelistBB.queryInsuranceBySetId}" rendered="#{list.status=='计算中'}"
                                 styleClass="button01" >
                    <x:updateActionListener property="#{ins_computelistBB.dateId}" value="#{list.dateId}"/>
                    <x:updateActionListener property="#{ins_computelistBB.payoffDate}" value="#{list.date}"/>
                    <x:updateActionListener property="#{ins_computelistBB.setId}" value="#{wage_dateBB.setId}"/>
                    <x:updateActionListener property="#{ins_computelistBB.unitId}" value="#{wage_dateBB.unitId}"/>
                    <x:updateActionListener property="#{ins_computelistBB.setName}" value="#{wage_dateBB.setName}"/>
                    <x:updateActionListener property="#{ins_computelistBB.unitName}" value="#{wage_dateBB.unitName}"/>
                    <x:updateActionListener property="#{ins_computelistBB.operCompute}" value="#{list.operCompute}"/>
                </h:commandButton>
                <h:commandButton value="查看明细" styleClass="button01" rendered="#{list.status!='计算中'}"
                                 type="button" onclick="doDetailPopup('#{list.dateId}')"/>

            </h:panelGrid>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>