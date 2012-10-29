<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script language="javascript">
        function DoSelectAll(isSelect){
                 var i=0;
                 var len=form1.chk.length;
                 for(i=0;i<len;i++){
                    form1.chk[i].checked=isSelect;
                 }
                 return false;
             }
        function ClickOK(){
             var arg="Command=9&UnitID="+document.all('form1:UnitID').value+"&ReportList="+document.all('form1:rptids').value+"~"+document.all('form1:processDate').value;
                     window.showModalDialog("/report/ProcessReport.jsf?" + arg, null, "dialogWidth:750px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
             return true;
        }
    </script>

<x:saveState value="#{Rpt_InfoIndexBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{Rpt_InfoIndexBB.initDocument}"/>
    <h:inputHidden id="UnitID" value="#{Rpt_InfoIndexBB.unitId}"/>
    <h:inputHidden id="processDate" value="#{Rpt_InfoIndexBB.processDate}"/>
    <h:inputHidden id="rptids" value="#{Rpt_InfoIndexBB.docRptids}"/>
    <h:inputHidden id="dateId" value="#{Rpt_InfoIndexBB.dateId}"/>
     <h:inputHidden id="setID" value="#{Rpt_InfoIndexBB.setID}"/>
    <br>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td align="left">
                <h:outputText value="��ǰͳ�Ƶ�λ:"/>
                <h:outputText value="#{Rpt_InfoIndexBB.unitName}"/>
            </td>

            <td>
               <h:outputText value="ͳ�����ڣ�"></h:outputText>
               <h:outputText value="#{Rpt_InfoIndexBB.processDate}"></h:outputText>
            </td>

            <td align="right">
                <h:commandButton onclick="return ClickOK();" action="#{Rpt_InfoIndexBB.doApply}" rendered="#{Rpt_InfoIndexBB.canApply}" styleClass="button01" value="�鵵" />
                <h:outputText value="�޷��ϱ�" rendered="#{!Rpt_InfoIndexBB.canApply}"></h:outputText>
                <h:commandButton  type="button" onclick="window.close();" styleClass="button01" value="����" />
            </td>
        </tr>
        <tr><td height=10 colspan=3>
            <h:outputText escape="false" value="<strong>Ҫ�ϱ��ı���:</strong>"></h:outputText>
            <br>
            <h:inputTextarea readonly="true" rows="30" cols="120" value="#{Rpt_InfoIndexBB.docRptnames}"></h:inputTextarea>
        </td></tr>
    <tr>
    <td colspan=3>
    </td>
    </tr>
    </table>
</h:form>
