<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<base target="_self">
<script type="text/javascript" language="javascript">
    function docheck(){
         if (document.all("form1:startNo").value==""){
             alert("û��¼����ʼ��ͬ��!");
             return false;
         }
        if (document.all("form1:endNo").value==""){
            alert("û����ֹ��ͬ��!");
            return false;
        }
        return true;
    }
    function getContNo(rownum){
        window.returnValue=document.all('form1:space_'+rownum+':link').innerText;
        window.close();
    }
</script>

<x:saveState value="#{cont_contNewSignBB}"/>
<h:form id="form1">
    <table height=98% width=98% >
        <tr>
            <td height=9>
                <h:outputText escape="false" value="<strong>��ʼ��ͬ��:</strong>"></h:outputText>
                <h:inputText id="startNo" value="#{cont_contNewSignBB.startNo}"></h:inputText><br/>

                <h:outputText escape="false" value="<strong>��ֹ��ͬ��:</strong>"></h:outputText>
                <h:inputText id="endNo" value="#{cont_contNewSignBB.endNo}"></h:inputText>

                <h:commandButton value="��ѯ" styleClass="button01"  onclick="return docheck();" action="#{cont_contNewSignBB.doListSpaceNo}"></h:commandButton>
                <h:commandButton id="export" value="����" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
            </td>
        </tr>
        <tr>
            <td>
                <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                    <jsp:param name="para" value="true"/>
                </jsp:include>
            </td>
        </tr>
    </table>
</h:form>

