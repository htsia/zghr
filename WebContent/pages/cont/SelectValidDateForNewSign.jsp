<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
<title>审查通过</title>
</head>
<script type="text/javascript" language="javascript">
     function selValidDate() {
            var ar = form1.all('form1:validDate');
            revalue = ar.value + ',0';
            window.returnValue = revalue;
            //alert(revalue);
            window.close();
     }
     function checkSubmit(form1) {
        flag = true;
        var validDate = form1.all("form1:validDate").value;
        if (validDate == "" || validDate == null) {
             alert("入职时间不能为空！");
             flag = false;
             return flag;
        }
        return flag;
    }
</script>
<body>
<c:view>
<base target="_self">
<h:form id="form1">
<center>
 <br/>
<h:panelGrid width="280" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="请输入生效日期 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>

<h:panelGrid width="280" border="0" cellpadding="0" cellspacing="0"  align="center" columns="1" >
    <h:panelGroup>
           <h:outputText value="生效日期：" />
           <h:inputText id="validDate" size="10" value="" readonly="true"/>
           <c:verbatim escape="false"><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:validDate')"></c:verbatim>
    </h:panelGroup>
    <h:panelGrid align="right" columns="1">
        <h:panelGroup>
            <h:commandButton type="button" styleClass="button01" value="确定" onclick="if(checkSubmit(document.forms(0))){selValidDate();}" />
            <h:commandButton styleClass="button01" type="button" value="取消" onclick="javascript:window.close();"/>
        </h:panelGroup>
    </h:panelGrid>
</h:panelGrid>

</h:form>
</center>
</c:view>
</body>
</html>
<script type="text/javascript" language="javascript">
    var field = form1.all('form1:validDate');
    field.value = '<%=CommonFuns.getSysDate("yyyy-MM-dd")%>';
</script>