<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageCessItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFormulaBO" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<x:saveState value="#{wage_taxmethodBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_taxmethodBB.pageInit}"></h:inputHidden>
    <c:verbatim>
    <table width=98% align="center">
       <tr>
           <td class="td_title"><img src="/images/tips.gif" alt="">计税项目及算法
           </td>
       </tr>

        <tr>
            <td>
                <strong>项目算法</strong>
                <div id="cont1" style="display:none">
                    <%
                        WageFormulaBO formula = (WageFormulaBO) request.getAttribute("formula");
                        if (formula!=null){
                            String fld = formula.getRsField();
                            String sld = fld.substring(0, 4);
                            String content = formula.getDescReport();
                            out.println(CommonFuns.filterNull(content));
                            out.println("<br>");
                        }
                        formula = (WageFormulaBO) request.getAttribute("formula2");
                        if (formula!=null){
                            String fld = formula.getRsField();
                            String sld = fld.substring(0, 4);
                            String content = formula.getDescReport();
                            out.println(CommonFuns.filterNull(content));
                            out.println("<br>");
                        }
                    %>
                </div>
                <TEXTAREA ROWS=6 COLS=120 id="content" readonly>
                </TEXTAREA>
            </td>
        </tr>
        <tr>
            <td>
                <table width="98%" border="0" cellspace="0">
                    <tr>
                        <td >
</c:verbatim>
                            <h:outputText escape="false" rendered="#{wage_taxmethodBB.actwcbo.description==null || wage_taxmethodBB.actwcbo.description==''}" value="<strong>个人所得税</strong>=(应纳税所得额-起征点)×对应税率-速算扣除"></h:outputText>
                            <h:outputText escape="false" rendered="#{wage_taxmethodBB.actwcbo.description!=null && wage_taxmethodBB.actwcbo.description!=''}" value="<strong>反算应发工资</strong>=(不含税所得额-起征点-速算扣除)/(1-对应税率)+起征点"></h:outputText>
                            <h:outputText escape="false" rendered="#{wage_taxmethodBB.actwcbo.description!=null && wage_taxmethodBB.actwcbo.description!=''}" value="<BR><strong>个人所得税</strong>=(反算应发工资-起征点)×对应税率-速算扣除"></h:outputText>

                            <h:outputText escape="false" value="<BR>#{wage_taxmethodBB.wcbo.description}"></h:outputText>
                            <h:outputText value="    "></h:outputText>
                            <h:outputText escape="false" value="<strong>起征点:</strong>"></h:outputText>
                            <h:outputText value="#{wage_taxmethodBB.wcbo.taxBegin}"></h:outputText>
                            <h:outputText value="         "></h:outputText>

<c:verbatim>
                        </td>
                    </tr>
                </table>
                 <br>
                    <%
                        String[] field = (String[]) session.getAttribute("field");
                        List rs = (List) session.getAttribute("data");
                        if (rs != null && field != null) {
                            int col = field.length;
                            int row = rs.size();
                    %>
                    <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
                        <tr>
                            <%
                                for (int j = 0; j < col; j++) {
                                    out.println("<td class=td_top>" +  field[j] + "</td>");
                                }
                            %>
                        </tr>
                        <%
                            for (int i = 0; i < row; i++) {
                                WageCessItemBO wi = (WageCessItemBO) rs.get(i);
                                out.println("<tr>");

                                out.println("<td class=td_middle>" + wi.getShowseq() + "</td>");
                                String fldname = wi.getItemID() + field[1];
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' readonly value='" + CommonFuns.filterNull(wi.getLow()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                                fldname = wi.getItemID() + field[2];
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' readonly value='" + CommonFuns.filterNull(wi.getHigh()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                                fldname = wi.getItemID() + field[3];
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' readonly value='" + CommonFuns.filterNull(wi.getRate()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                                fldname = wi.getItemID() + field[4];
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' readonly value='" + CommonFuns.filterNull(wi.getDeduction()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                                out.println("</tr>");
                            }
                        %>
                    </table>
                    <%
                        }
                    %>
                     <br>
                    <table width="98%" border="0" cellspace="0">
                        <tr>
                            <td >
</c:verbatim>
     <h:outputText escape="false" rendered="#{wage_taxmethodBB.actwcbo.description!=null && wage_taxmethodBB.actwcbo.description!=''}" value="#{wage_taxmethodBB.actwcbo.description}"></h:outputText>
     <h:outputText  rendered="#{wage_taxmethodBB.actwcbo.description!=null && wage_taxmethodBB.actwcbo.description!=''}" value="    "></h:outputText>
     <h:outputText  rendered="#{wage_taxmethodBB.actwcbo.description!=null && wage_taxmethodBB.actwcbo.description!=''}" escape="false" value="<strong>起征点:</strong>"></h:outputText>
     <h:outputText  rendered="#{wage_taxmethodBB.actwcbo.description!=null && wage_taxmethodBB.actwcbo.description!=''}" value="#{wage_taxmethodBB.actwcbo.taxBegin}"></h:outputText>
     <h:outputText  rendered="#{wage_taxmethodBB.actwcbo.description!=null && wage_taxmethodBB.actwcbo.description!=''}" value="         "></h:outputText>

    <c:verbatim>
                            </td>
                        </tr>
                    </table>
                   <br>
        <%
            String[] field = (String[]) session.getAttribute("field");
            List rs = (List) session.getAttribute("actdata");
            if (rs != null && field != null) {
                int col = field.length;
                int row = rs.size();
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
            <tr>
                <%
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top>" +  field[j] + "</td>");
                    }
                %>
            </tr>
            <%
                for (int i = 0; i < row; i++) {
                    WageCessItemBO wi = (WageCessItemBO) rs.get(i);
                    out.println("<tr>");

                    out.println("<td class=td_middle>" + wi.getShowseq() + "</td>");
                    String fldname = wi.getItemID() + field[1];
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' readonly value='" + CommonFuns.filterNull(wi.getLow()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                    fldname = wi.getItemID() + field[2];
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' readonly value='" + CommonFuns.filterNull(wi.getHigh()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                    fldname = wi.getItemID() + field[3];
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' readonly value='" + CommonFuns.filterNull(wi.getRate()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                    fldname = wi.getItemID() + field[4];
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' readonly value='" + CommonFuns.filterNull(wi.getDeduction()) + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");

                    out.println("</tr>");
                }
            %>
        </table>
        <%
            }
        %>





            </td>
        </tr>
     </table>
    
</c:verbatim>
    <script type="text/javascript">
        form1.content.value =document.all("cont1").innerText;
    </script>

</h:form>