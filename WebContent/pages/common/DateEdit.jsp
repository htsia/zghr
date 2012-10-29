<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doSelect(){
            PopUpCalendarDialog(form1.all('form1:date'));
            if (form1.all('form1:date').value!=null && form1.all('form1:date').value.length>6){
                form1.all('form1:desc').value=form1.all('form1:date').value.substr(0,4)+"年"+form1.all('form1:date').value.substr(5,2)+"月薪资";
            }
        }
        function forSave() {
            if (forsubmit(form1)) {
                form1.all("form1:yearMonth").value=form1.all("form1:date").value.substring(0,7);
                window.returnValue = form1.all("form1:date").value + "|" + form1.all("form1:yearMonth").value + "|" + form1.all("form1:desc").value;
                window.close();
            }
        }
     </script>
<h:form id="form1">
    <h:inputHidden id="yearMonth" value=""/>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" align="center">
        <h:panelGrid columns="2" width="100%" align="center" styleClass="table03"  columnClasses="td_top,td_middle">
            <h:outputText value="业务日期"/>
            <h:panelGroup>
                <h:inputText id="date" value="" alt="业务日期|0|d" readonly="true" />
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="doSelect()"/>
            </h:panelGroup>
            <h:outputText value="描述"/>
            <h:inputTextarea id="desc" value="" cols="40" rows="3"/>
        </h:panelGrid>
        <h:panelGrid cellspacing="2" columns="2" align="right">
            <h:commandButton type="button" styleClass="button01" value="保存" onclick="forSave()"/>
            <h:commandButton type="button" styleClass="button01" value="关闭" onclick="window.close()"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>