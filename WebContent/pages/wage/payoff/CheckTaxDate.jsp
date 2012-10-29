<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function showSum(unitId,setId,dateId){
            var url="/wage/payoff/ShowSumInfo.jsf?unitId="+unitId+"&setId="+setId+"&dateId="+dateId;
            window.open(url,'','toolbar=0,height='+screen.height*0.8+',width='+screen.width*0.9+',top='+screen.height*0.1+',left='+screen.width*0.05);
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
        function queryPersonChange(){
           window.showModalDialog("/wage/payoff/showPersonChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
        }
        function queryDeptChange(){
           window.showModalDialog("/wage/payoff/showDeptChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
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
        function doPopupTax(id) {
            var dateId = id;
            window.showModalDialog("/wage/payoff/WageTaxView.jsf?dateId=" + dateId, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function doPopupFinalTax(id) {
            var dateId = id;
            window.showModalDialog("/wage/payoff/WageTaxView.jsf?final=true&dateId=" + dateId, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>
</head>

<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_dateBB.pageInit}"/>
    <h:inputHidden id="finalTax" value="#{wage_dateBB.finalTax}"/>
    <h:inputHidden id="str" value=""/>
    <h:inputHidden id="date" value="#{wage_dateBB.date.date}"/>
    <h:inputHidden id="desc" value="#{wage_dateBB.date.desc}"/>
    <h:inputHidden id="yearMonth" value="#{wage_dateBB.date.yearMonth}"/>

    <f:verbatim>
    <table height=98% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
            <tr>
                <td class=td_title>
    </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 薪酬管理 -> #{wage_dateBB.name0679}"/>
    <f:verbatim>
                </td>
                <td class=td_title align="right">
    </f:verbatim>
                    <h:outputText value="发薪单位：#{wage_dateBB.unitName}"/>
                    <h:outputText value="薪资账套："></h:outputText>

                    <h:selectOneMenu id = "setId" value="#{wage_dateBB.setId}"  onchange="submit()"
                              valueChangeListener="#{wage_dateBB.queryDateList}">
                         <c:selectItems value="#{wage_dateBB.setList}"/>
                    </h:selectOneMenu>
                    <h:inputHidden id="setName" value="#{wage_dateBB.setName}"/>
     <f:verbatim>
                </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="right">
    </f:verbatim>
                <h:outputText value="开始时间"/>
                <h:panelGroup>
                    <h:inputText value="#{wage_dateBB.startDate}" id="startDate" alt="开始时间|0|d"/>
                    <h:outputText value=" "/>
                    <h:commandButton type="button" styleClass="button_date"  onclick="PopUpCalendarDialog('form1:startdate')"/>
                </h:panelGroup>
                <h:outputText value="结束时间"/>
                <h:panelGroup>
                    <h:inputText value="#{wage_dateBB.endDate}" id="endDate" alt="结束时间|0|d"/>
                    <h:outputText value=" "/>
                    <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:endDate')"/>
                </h:panelGroup>
                <h:commandButton value="查询" action="#{wage_dateBB.dateList}" styleClass="button01" onclick="return forsubmit(document.forms(0))"/>
    <f:verbatim>
            </td>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
     </f:verbatim>
        <h:dataTable value="#{wage_dateBB.dateList}" var="list" align="center"   id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="发放日期"/></c:facet>
                <h:outputText value="#{list.date}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="最后计算时间"/></c:facet>
                <h:outputText value="#{list.calcDate}"/>
            </h:column>


            <h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.status}"/>
            </h:column>

            <h:column rendered="#{wage_dateBB.name0651!=''}">
                <c:facet name="header" ><h:outputText value="#{wage_dateBB.name0651}"/></c:facet>
                <h:outputText value="#{list.checkContent}"/>
            </h:column>

            <h:column rendered="#{wage_dateBB.name0679!=''}">
                <c:facet name="header"><h:outputText value="#{wage_dateBB.name0679}"/></c:facet>
                <h:outputText value="#{list.taxCheckResultDes}"/>
            </h:column>

            <h:column rendered="#{wage_dateBB.name0678!=''}">
                <c:facet name="header"><h:outputText value="#{wage_dateBB.name0678}"/></c:facet>
                <h:outputText value="#{list.taxAuditResultDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="#{wage_dateBB.name0654}"/></c:facet>
                <h:outputText value="#{list.approveContent}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:panelGrid columns="5" align="center" cellspacing="2">
                    <h:commandButton value="打开" styleClass="button01"   rendered="#{wage_dateBB.finalTax!='true'}" action="#{wage_dateBB.dateList}" onclick="return doPopupTax('#{list.dateId}');"/>
                    <h:commandButton value="打开" styleClass="button01"   rendered="#{wage_dateBB.finalTax=='true'}" action="#{wage_dateBB.dateList}" onclick="return doPopupFinalTax('#{list.dateId}');"/>
                    <h:commandButton value="查看流程" id="showFlow" type="button" onclick="return showWorkFlowLogByLinkID('#{list.dateId}')" styleClass="button01" rendered="#{wage_dateBB.workFlow=='1'}"></h:commandButton>
                </h:panelGrid>
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