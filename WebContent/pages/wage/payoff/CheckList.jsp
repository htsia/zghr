<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function viewFinish(payoffDate,unitId){
           window.showModalDialog("/wage/gross/GrossPlanStauts.jsf?Year="+payoffDate.substr(0,4)+"&orgID="+unitId, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
           return false;
       }

    function changeAll(){
        disPlayProcessBar();
        document.all('form1').submit();
        return true;
    }
    function dosetItem( ){
        window.showModalDialog("/wage/payoff/WageAuditItemList.jsf", "", "dialogWidth:580px; dialogHeight:330px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
        return true;
    }
    function dosetType( ){
        window.showModalDialog("/wage/payoff/WageAuditTypeList.jsf", "", "dialogWidth:430px; dialogHeight:330px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
        return true;
    }
       function doDetailPopup(id) {
           var dateId = id;
           popup = window.open("/wage/payoff/WageDetailView.jsf?dateId=" + dateId+"&showAllFLowRpt=true", "员工工资发放明细", "height=520,width="+0.9*screen.width+",top="+0.05*screen.height+",left="+0.05*screen.width+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
           popup.focus();
       }
       
    </script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.pageInit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="薪酬管理 -> #{wage_dateBB.name0651}"/>
       </h:panelGroup>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>

    <h:panelGrid width="80%" align="center">
        <h:panelGroup>
            <h:outputText escape="false" value="<strong>发薪单位：</strong>"></h:outputText>
            <h:inputText id="unitName" readonly="true" value="#{wage_flowBB.unitName}"/>
            <h:inputHidden id="unitId" value="#{wage_flowBB.unitId}"></h:inputHidden>
            <h:commandButton value="切换机构" styleClass="button01" rendered="#{wage_flowBB.canChangeOrg}" onclick="return fPopUpWageUnitDlg2('form1:unitId','form1:unitName','true');" action="#{wage_flowBB.list}"></h:commandButton>
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;"></h:outputText>

            <h:selectBooleanCheckbox value="#{wage_flowBB.showAll}" onclick="changeAll();" valueChangeListener="#{wage_flowBB.changeShowAll}"></h:selectBooleanCheckbox>
            <h:outputText value="显示全部"></h:outputText>
            
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;"></h:outputText>
            <h:commandButton value="机构汇总类别设置" styleClass="button01" onclick="return dosetType();" type="button"></h:commandButton>
            <h:commandButton value="机构汇总项目设置" styleClass="button01" onclick="return dosetItem();" type="button"></h:commandButton>
        </h:panelGroup>

        <c:verbatim><br></c:verbatim>
        <h:dataTable value="#{wage_flowBB.list}" var="list"  id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="100%" >
            <h:column>
                <c:facet name="header"><h:outputText value="账套名称"/></c:facet>
                <h:outputText value="#{list.setName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="业务日期"/></c:facet>
                <h:outputText value="#{list.date}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.statusName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                 <h:commandButton styleClass="button01" action="#{wage_flowBB.findDate}" value="打开" rendered="#{list.isChecking}">
                    <x:updateActionListener property="#{wage_flowBB.date.dateId}" value="#{list.dateId}"/>
                    <x:updateActionListener property="#{wage_flowBB.setName}" value="#{list.setName}"/>
                </h:commandButton>
                <h:commandButton type="button" value="总额情况" styleClass="button01"  rendered="#{sys_commonInfoBB.wagesumControl}" onclick="viewFinish('#{list.yearMonth}','#{list.unitID}');" />
                <h:commandButton value="查看流程" id="showFlow" type="button" onclick="return showWorkFlowLogByLinkID('#{list.dateId}')" styleClass="button01" rendered="#{wage_dateBB.workFlow=='1'}"></h:commandButton>
                <h:commandButton value="查看明细" styleClass="button01"     type="button" onclick="doDetailPopup('#{list.dateId}')"/>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
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
