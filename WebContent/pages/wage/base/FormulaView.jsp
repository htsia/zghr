<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFormulaBO" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_formulaviewBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_formulaviewBB.pageInit}"/>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid align="right">
            <c:verbatim>
            <input type="button" class="button01" value="返回" onclick="window.close()"/>
            </c:verbatim>
        </h:panelGrid>
        <h:panelGrid align="center" width="100%"  columns="2" styleClass="table03"
                        columnClasses="td_form01,td_form02">
            <h:outputText value="公式名称" style="width:100px;"/>
            <h:outputText value="#{wage_formulaviewBB.formula.name}"/>

            <h:outputText value="公式描述" style="width:100px;"/>
            <h:outputText value="#{wage_formulaviewBB.formula.desc}"/>

            <h:outputText value="公式结果指标项" style="width:100px;"/>
            <%
                WageFormulaBO formula = (WageFormulaBO) request.getAttribute("formula");
                String fld = formula.getRsField();
                String sld = fld.substring(0, 4);
                String content = formula.getDescReport();
            %>

            <c:verbatim>
                <%=SysCacheTool.findInfoItem(sld, fld).getItemName()%>
            </c:verbatim>
            <h:outputText value="公式内容" style="width:100px;"/>
            <c:verbatim>
                <div id="cont1" style="display:none">
                    <%
                        out.println(CommonFuns.filterNull(content));
                    %>
                </div>
                <TEXTAREA ROWS=6 COLS=80 id="content" readonly>
                </TEXTAREA>

            </c:verbatim>
            <h:outputText value="公式表达式" style="width:100px;"/>
            <c:verbatim>
                <div id="cont2" style="display:none">
                    <%=CommonFuns.filterNull(formula.getHtmlDesc())%>
                </div>
                <TEXTAREA ROWS=6 COLS=80 id="content2" readonly>
                </TEXTAREA>

            </c:verbatim>
            <h:outputText value="使用该公式帐套" style="width:100;"/>
            <h:outputText value="#{wage_formulaviewBB.scope}"/>

        </h:panelGrid>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    form1.content.value =document.all("cont1").innerText;
    form1.content2.value =document.all("cont2").innerText;
</script>
