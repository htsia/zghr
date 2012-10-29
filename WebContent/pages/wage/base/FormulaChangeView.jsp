<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFormulaBO" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFormulaChangeBO" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_formulaviewBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_formulaviewBB.viewChange}"/>
    <c:verbatim>
    <table width="95%">
        <tr><td align="right">
            <input type="button" class="button01" value="返回" onclick="window.close()"/>
        </td></tr>

        <%
            WageFormulaChangeBO formula = (WageFormulaChangeBO) request.getAttribute("formulachange");
            String old=WageFormulaBO.transDes(formula.getChnDescOld());
            String newcont=WageFormulaBO.transDes(formula.getChnDesc());
        %>

        <tr>
            <tr><td>
            原公式内容<br>
                <div id="cont1" style="display:none">
                    <%
                        out.println(CommonFuns.filterNull(old));
                    %>
                </div>
                <TEXTAREA ROWS=14 COLS=85 id="content" readonly>
                </TEXTAREA>
        </td></tr>
        <tr>

        <tr><td>
                新公式内容<br>
                <div id="cont2" style="display:none">
                    <%
                        out.println(CommonFuns.filterNull(newcont));
                    %>
                </div>
                <TEXTAREA ROWS=14 COLS=85 id="content2" readonly>
                </TEXTAREA>
        </td></tr>

    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
    form1.content.value =document.all("cont1").innerText;
    form1.content2.value =document.all("cont2").innerText;
</script>
