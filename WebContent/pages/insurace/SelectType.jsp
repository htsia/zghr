<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
   function DoSelectAll(isSelect){
        var size = document.all('form1:inputField').length;
        for (var i = 0; i < size; i++) {
            document.all('form1:inputField')[i].checked=isSelect;
        }
    }
    function doOK(){
        window.returnValue=getAllSelectValue(document.all('form1:inputField'),",");
        //alert(window.returnValue);
        window.close();
    }
    function doCancel(){
        window.returnValue="";
        window.close();
    }
</script>

<x:saveState value="#{ins_BaseInfoBB}"/>
<h:form id="form1">
    <c:verbatim>
    <table width="100%">
     <tr><td align="right">
    </c:verbatim>
         <h:commandButton styleClass="button01" value="全选" type="button" onclick="DoSelectAll(true);"></h:commandButton>
         <h:commandButton styleClass="button01" value="不选" type="button" onclick="DoSelectAll(false);"></h:commandButton>
         <h:commandButton styleClass="button01" value="确定" type="button" onclick="doOK();"></h:commandButton>
         <h:commandButton styleClass="button01" value="取消" type="button" onclick="doCancel();"></h:commandButton>
    <c:verbatim>
     </td></tr>

     <tr><td align="left">
    </c:verbatim>
    <h:outputText escape="false" value="<strong>请选择要计算的保险类型:</strong>"></h:outputText>
    <h:selectManyCheckbox  layout="pageDirection" id="inputField">
        <c:selectItem itemLabel="养老保险" itemValue="A755"></c:selectItem>
        <c:selectItem itemLabel="医疗保险" itemValue="A760"></c:selectItem>
        <c:selectItem itemLabel="工伤保险" itemValue="A765"></c:selectItem>
        <c:selectItem itemLabel="失业保险" itemValue="A770"></c:selectItem>
        <c:selectItem itemLabel="生育保险" itemValue="A775"></c:selectItem>
        <c:selectItem itemLabel="住房公积金" itemValue="A780"></c:selectItem>
    </h:selectManyCheckbox>
    <c:verbatim>
    </td></tr></table>
    </c:verbatim>
</h:form>