<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doSelect(){
            PopUpCalendarDlg_OnlyMonth(form1.all('form1:date'));
            if (form1.all('form1:date').value!=null && form1.all('form1:date').value.length>=6){
                if (document.all('form1:week')!=null && document.all('form1:week')!=undefined){
                    form1.all('form1:desc').value=form1.all('form1:date').value.substr(0,4)+"年"+form1.all('form1:date').value.substr(5,2)+"月第"+document.all('form1:week').value+"周报表";
                }
                else{
                    form1.all('form1:desc').value=form1.all('form1:date').value.substr(0,4)+"年"+form1.all('form1:date').value.substr(5,2)+"月报表";
                }
            }
        }
        function forSave() {
            if (forsubmit(form1)) {
                var ret=form1.all("form1:date").value + "|"+ form1.all("form1:desc").value;
                if (document.all('form1:week')!=null && document.all('form1:week')!=undefined){
                    ret+= "|"+form1.all("form1:week").value;
                }
                else{
                    ret+= "|";
                }
                window.returnValue =ret;
                //alert(ret);
                window.close();
            }
        }
    </script>

<x:saveState value="#{Rpt_InfoIndexBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{Rpt_InfoIndexBB.initSelectMonth}"/>
    <h:inputHidden id="yearMonth" value=""/>

    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" align="center">
        <h:panelGrid columns="2" width="100%" align="center" styleClass="table03"  columnClasses="td_top,td_middle">
            <h:outputText value="业务日期"/>
            <h:panelGroup>
                <h:inputText id="date" value="" alt="业务日期|0|d6" readonly="true" />
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="doSelect();"/>
            </h:panelGroup>

            <h:outputText value="选择周" rendered="#{Rpt_InfoIndexBB.showWeek}"/>
            <h:selectOneMenu id="week" rendered="#{Rpt_InfoIndexBB.showWeek}">
                <c:selectItem itemValue="1" itemLabel="第一周"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="第二周"></c:selectItem>
                <c:selectItem itemValue="3" itemLabel="第三周"></c:selectItem>
                <c:selectItem itemValue="4" itemLabel="第四周"></c:selectItem>
                <c:selectItem itemValue="5" itemLabel="第五周"></c:selectItem>
            </h:selectOneMenu>
            
            <h:outputText value="描述"/>
            <h:inputTextarea id="desc" value="" cols="40" rows="3"/>
        </h:panelGrid>
        <h:panelGrid cellspacing="2" columns="2" align="right">
            <h:commandButton type="button" styleClass="button01" value="保存" onclick="forSave();"/>
            <h:commandButton type="button" styleClass="button01" value="关闭" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
