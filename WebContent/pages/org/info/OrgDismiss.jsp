<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String ids = request.getParameter("ids");
%>

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>

    <x:saveState value="#{org_orgDismissBB}"/>
    <h:inputHidden value="#{org_orgDismissBB.pageInit}"/>
    <h:form id="form1">
<f:verbatim>
        <br>
        <input type="hidden" name="oids" value="<%=ids%>">

        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr nowrap>
                 <td width="90" class="td_form01 td_form_required">
                	  <%=LanguageSupport.getResource("JGGL-1103","  撤销类别")%>                         
                 </td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="B004205" code="" dict="yes" dict_num="0898"
                                 value="#{org_orgDismissBB.orgsetvo.cancelType}" alt="撤销类别|0|s|50||"/>
<f:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B004205')">
                </td>
                <td width="90" class="td_form01 td_form_required">
                   <%=LanguageSupport.getResource("JGGL-1104","撤销时间")%>    
                 </td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="B004045" value="#{org_orgDismissBB.orgsetvo.cancelTime}"
                                 alt="撤销时间|0|s|50||"/>
<f:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:B004045')"></td>
            </tr>
            <tr nowrap>
                <td class="td_form01 td_form_required">
                       <%=LanguageSupport.getResource("JGGL-1105"," 撤销批准单位")%>    
                         </td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="B004055" value="#{org_orgDismissBB.orgsetvo.cancelUnit}"
                                 alt="撤销批准单位|0|s|50||"/></td>
<f:verbatim>
                <td class="td_form01 td_form_required">
                    <%=LanguageSupport.getResource("JGGL-1106"," 撤销文号")%>            
                 </td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="B004050" value="#{org_orgDismissBB.orgsetvo.cancelNo}"
                                 alt="撤销文号|0|s|50||"/></td>
<f:verbatim>
            </tr>
            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("JGGL-1010","备注")%>     </td>
                <td class=td_form02 colspan="3">
</f:verbatim>
                    <h:inputTextarea rows="3" id="B004210" cols="80" value="#{org_orgDismissBB.orgsetvo.memo}"/>
<f:verbatim>
                </td>
            </tr>
        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</f:verbatim>
                    <h:commandButton id="save" styleClass="button01" onclick="return forsubmit(document.forms(0))" value="确定"  action="#{org_orgDismissBB.saveDismiss}" />
<f:verbatim>
                </td>
            </tr>
        </table>
</f:verbatim>
    </h:form>
