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
         <h:commandButton styleClass="button01" value="ȫѡ" type="button" onclick="DoSelectAll(true);"></h:commandButton>
         <h:commandButton styleClass="button01" value="��ѡ" type="button" onclick="DoSelectAll(false);"></h:commandButton>
         <h:commandButton styleClass="button01" value="ȷ��" type="button" onclick="doOK();"></h:commandButton>
         <h:commandButton styleClass="button01" value="ȡ��" type="button" onclick="doCancel();"></h:commandButton>
    <c:verbatim>
     </td></tr>

     <tr><td align="left">
    </c:verbatim>
    <h:outputText escape="false" value="<strong>��ѡ��Ҫ����ı�������:</strong>"></h:outputText>
    <h:selectManyCheckbox  layout="pageDirection" id="inputField">
        <c:selectItem itemLabel="���ϱ���" itemValue="A755"></c:selectItem>
        <c:selectItem itemLabel="ҽ�Ʊ���" itemValue="A760"></c:selectItem>
        <c:selectItem itemLabel="���˱���" itemValue="A765"></c:selectItem>
        <c:selectItem itemLabel="ʧҵ����" itemValue="A770"></c:selectItem>
        <c:selectItem itemLabel="��������" itemValue="A775"></c:selectItem>
        <c:selectItem itemLabel="ס��������" itemValue="A780"></c:selectItem>
    </h:selectManyCheckbox>
    <c:verbatim>
    </td></tr></table>
    </c:verbatim>
</h:form>