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
                    form1.all('form1:desc').value=form1.all('form1:date').value.substr(0,4)+"��"+form1.all('form1:date').value.substr(5,2)+"�µ�"+document.all('form1:week').value+"�ܱ���";
                }
                else{
                    form1.all('form1:desc').value=form1.all('form1:date').value.substr(0,4)+"��"+form1.all('form1:date').value.substr(5,2)+"�±���";
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
            <h:outputText value="ҵ������"/>
            <h:panelGroup>
                <h:inputText id="date" value="" alt="ҵ������|0|d6" readonly="true" />
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="doSelect();"/>
            </h:panelGroup>

            <h:outputText value="ѡ����" rendered="#{Rpt_InfoIndexBB.showWeek}"/>
            <h:selectOneMenu id="week" rendered="#{Rpt_InfoIndexBB.showWeek}">
                <c:selectItem itemValue="1" itemLabel="��һ��"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="�ڶ���"></c:selectItem>
                <c:selectItem itemValue="3" itemLabel="������"></c:selectItem>
                <c:selectItem itemValue="4" itemLabel="������"></c:selectItem>
                <c:selectItem itemValue="5" itemLabel="������"></c:selectItem>
            </h:selectOneMenu>
            
            <h:outputText value="����"/>
            <h:inputTextarea id="desc" value="" cols="40" rows="3"/>
        </h:panelGrid>
        <h:panelGrid cellspacing="2" columns="2" align="right">
            <h:commandButton type="button" styleClass="button01" value="����" onclick="forSave();"/>
            <h:commandButton type="button" styleClass="button01" value="�ر�" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
