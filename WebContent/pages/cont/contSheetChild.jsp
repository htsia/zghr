<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<f:verbatim>
    <script type="text/javascript">
        function forSel() {
           if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                  document.forms(0).all('form1:queryPerson').click();
           }
        }
    </script>
</f:verbatim>
<x:saveState value="#{cont_contSheetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{cont_contSheetBB.pageInit}"></h:inputHidden>
<f:verbatim>
 <table width="100%" height="98%" border="0" cellpadding="0" cellspacing="0">
    <tr>
         <td height="12" colspan="2" align="right">
         </td>
    </tr>

    <tr>
         <td colspan="2" height="8" align="left">&nbsp;&nbsp;
          <input name="simple1" type="button" id=15  class="button01" value="<%=LanguageSupport.getResource("XTGL-1012","选择人员类别") %>"
           onclick="forSel();">
</f:verbatim>
    <h:inputHidden id="personType" value="#{cont_contSheetBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{cont_contSheetBB.personTypeValue}"/>
    <h:outputText value="#{cont_contSheetBB.personTypeDesc}"></h:outputText>
<f:verbatim>
         </td>
   </tr>

    <tr>
         <td height="8" colspan="2" align="right">
         </td>
    </tr>

    <tr>
        <td height="8" align="left">
</f:verbatim>
            <h:outputText escape="false" value="&nbsp;&nbsp;姓名或员工编号"></h:outputText>
            <h:inputText id="name" value="#{cont_contSheetBB.name}"
                            size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
            <h:commandButton value="查询" id="queryPerson" onclick="javascript:return true;" styleClass="button01"
                             action="#{cont_contSheetBB.queryPerson}"/>
<f:verbatim>
        </td>
         <td height="8" align="right">
</f:verbatim>
                  <h:commandButton id="export" value="导出" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
<f:verbatim>

         </td>
    </tr>

    <tr>
         <td height="12" colspan="2" align="right">
         </td>
    </tr>

    <tr>
        <td colspan="2">
            <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                <jsp:param name="para" value="true"/>
            </jsp:include>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>