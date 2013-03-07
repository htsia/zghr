<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.wage.pojo.vo.WageStandardVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.wage.pojo.bo.WageStdValueBO"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_standardBB}"></x:saveState>
<h:form id="form1">
<%
    String act=(String)request.getAttribute("act");
    String readonly=" ";
    if ("view".equals(act)){
         readonly="readonly";
    }

    WageStandardVO stdVO = (WageStandardVO) session.getAttribute("stdVO");


    ArrayList vItem = stdVO.getV_item();
    ArrayList HCode = stdVO.getHCode();
    Hashtable HColRep = new Hashtable();
    int count = HCode.size();
    int colNum = 1;
    for (int i = 0; i < count; i++) {
        colNum *= ((String[]) HCode.get(i)).length;
        HColRep.put(String.valueOf(i), String.valueOf(colNum));
    }

    ArrayList VCode = stdVO.getVCode();
    Hashtable VRowRep = new Hashtable();
    count = VCode.size();
    int rowNum = 1;
    for (int i = 0; i < count; i++) {
        rowNum *= ((String[]) VCode.get(i)).length;
        VRowRep.put(String.valueOf(i), String.valueOf(rowNum));
    }
%>

<h:inputHidden id="unitId" value="#{wage_standardBB.standard.unitId}"/>
<h:inputHidden id="stdId" value="#{wage_standardBB.standard.stdId}"/>
<c:verbatim>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr><td height=8></td></tr>
    <tr>
        <td align="right">
</c:verbatim>
            <h:commandButton styleClass="button01" value="上一步" rendered="#{wage_standardBB.canEdit}" action="#{wage_standardBB.step2_setCode}"/>
            <h:commandButton styleClass="button01" value="下一步" rendered="#{wage_standardBB.canEdit}" action="#{wage_standardBB.step4_setName}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" action="#{wage_standardBB.list}"/></td>
<c:verbatim>
    </tr>
</table>
<br>
 </c:verbatim>

<c:verbatim>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
</c:verbatim>
    <%
        if (vItem.size() > 0) {
    %>
    <c:verbatim><td class="td_top">&nbsp;</td></c:verbatim>
    <%
        }
    %>
<c:verbatim>
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center" class="td_top" colspan=<%=colNum%>>
                    <%=CommonFuns.filterNull(stdVO.getStandardName())%>
                </td>
            </tr>

            <tr>
</c:verbatim>
                <%
                    if (HCode.size() > 0) {
                        int rows = HCode.size();
                        for (int i = 0; i < rows; i++) {
                            String[] codeItem = (String[]) HCode.get(i);
                            int items = codeItem.length;
                            int cols = Integer.parseInt((String) HColRep.get(String.valueOf(i)));

                            for (int r = 0; r < cols / items; r++) {
                                for (int j = 0; j < items; j++) {
                %>
                <c:verbatim>
                <td align="center" class="td_top" colspan="<%=colNum/cols%>" width="<%=100/cols%>%">
                    <%=CodeUtil.interpertCode(null, codeItem[j])%>
                </td>
                </c:verbatim>
                <%
                                 }
                             }
                          }
                     }
            %>
<c:verbatim>
            </tr>
        </table>
    </td>
</tr>

<tr>
</c:verbatim>
    <%
        if (vItem.size() > 0) {
    %>
<c:verbatim>
    <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
</c:verbatim>
                <%
                    int v_col = VCode.size();
                    for (int i = 0; i < v_col; i++) {
                %>
<c:verbatim>
                <td >
                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
</c:verbatim>
                        <%
                            String[]codeItem = (String[]) VCode.get(i);
                            int rows = Integer.parseInt((String) VRowRep.get(String.valueOf(i)));
                            int items = codeItem.length;
                            for (int j = 0; j < rows / items; j++) {
                                for (int k = 0; k < items; k++) {

                        %>
<c:verbatim>
                        <tr>
                            <td align="center" class="td_top_noHeight" height="28" nowrap>
                                <%=CodeUtil.interpertCode(null, codeItem[k])%>
                            </td>
                        </tr>
</c:verbatim>
                        <%
                                }
                            }
                        %>
<c:verbatim>
                    </table>
                </td>
</c:verbatim>
                <%
                    }
                %>
<c:verbatim>
            </tr>
        </table>
    </td>
</c:verbatim>
    <%}%>
<c:verbatim>

    <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
</c:verbatim>
            <%
                ArrayList HColName = stdVO.getHColName();
                ArrayList VRowName = stdVO.getVRowName();
                Hashtable rsValue= stdVO.getRs_value();

                for (int i = 0; i < rowNum; i++) {
            %>
<c:verbatim>
            <tr>
</c:verbatim>
                <%
                    for (int j = 0; j < colNum; j++) {
                        String hcol_name = HColName!=null&&HColName.size()>j?(String) HColName.get(j):"";
                        String vrow_name = VRowName!=null&&VRowName.size()>i?(String) VRowName.get(i):"";
                        String name=hcol_name+"|"+vrow_name;
                        String value="";
                        WageStdValueBO stdValue=(WageStdValueBO)rsValue.get(name);
                        if(stdValue!=null){
                            value=CommonFuns.filterNull(stdValue.getCellValue());
                        }
                %>
<c:verbatim>
                 <td align="center" width="<%=100/colNum%>%"  height="28" class="td_Content_noHeight" >
                    <input type="text" size="10" <%=readonly%> alt="标准表单元值|0|f" value="<%=value%>" class="input" name="<%=name%>">
                 </td>
</c:verbatim>
                <%
                    }
                %>
<c:verbatim>   </tr></c:verbatim>
            <%
                }
            %>
<c:verbatim>
        </table>
        </td></tr>
        </table>
    </td>
</tr>
</table>
</c:verbatim>
</h:form>
