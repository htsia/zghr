<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultItemVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.math.BigDecimal" %>
<%@ include file="../include/taglib.jsp" %>

<%
    String qsType = CommonFuns.filterNull(request.getParameter("qsType"));
    String setType = CommonFuns.filterNull(request.getParameter("setType"));
    String qryName = CommonFuns.filterNull(request.getParameter("qryName"));
    String sysFlag = CommonFuns.filterNull(request.getParameter("sysFlag"));
    String classId = CommonFuns.filterNull(request.getParameter("classId"));
    String qryId = CommonFuns.filterNull(request.getParameter("qryId"));
    String unitType = CommonFuns.filterNull(request.getParameter("unitType"));
    QueryVO queryvo = (QueryVO) session.getAttribute("QUERY_VO");
    qsType = (queryvo != null && queryvo.getQsType() != null ? queryvo.getQsType() : qsType);
    setType = (queryvo != null && queryvo.getSetType() != null ? queryvo.getSetType() : setType);
    qryName = (queryvo != null && queryvo.getName() != null ? queryvo.getName() : qryName);
    sysFlag = (queryvo != null && queryvo.getSysFlag() != null ? queryvo.getSysFlag() : sysFlag);
    classId = (queryvo != null && queryvo.getClassId() != null ? queryvo.getClassId() : classId);
    qryId = (queryvo != null && queryvo.getQryId() != null ? queryvo.getQryId() : qryId);
    unitType = (queryvo != null && queryvo.getUnitType() != null ? queryvo.getUnitType() : unitType);
    String hideSave = CommonFuns.filterNull((String) session.getAttribute("CONTRAL_SAVE"));
    String staticItemName = "";
    if (queryvo.getStaticItemId() != null && !"".equals(queryvo.getStaticItemId())) {
        InfoItemBO bo = SysCacheTool.findInfoItem(null, queryvo.getStaticItemId());
        if (bo != null)  staticItemName = bo.getItemName();
    }
%>
<script type="text/javascript">
    dialogPara = "dialogWidth:800px; dialogHeight:550px;";
    function forBack() {
        location.href = "/qry/QueryIndex.jsf?qsType=<%=qsType%>&setType=<%=setType%>&unitType=<%=unitType%>";
    }
    function forOrg() {
        flag = window.showModalDialog("/qry/QueryOrgSetting.jsf?pop=Y&flag=org&hideSave=<%=hideSave%>&qryId=<%=qryId%>", "", dialogPara);
        if(flag) location.href = "/qry/StaticResult.jsf";
    }
    function forCondition() {
        flag = window.showModalDialog("/qry/StaticListSetting.jsf?pop=Y&hideSave=<%=hideSave%>&qryId=<%=qryId%>", "", dialogPara);
        if(flag) location.href = "/qry/StaticResult.jsf";
    }
    function forDisp() {
        flag = window.showModalDialog("/qry/StaticItemSetting.jsf?pop=Y&flag=item&hideSave=<%=hideSave%>&qryId=<%=qryId%>&setType=<%=setType%>", "", dialogPara);
        if(flag) location.href = "/qry/StaticResult.jsf";
    }
    function forPic() {
        obj = document.all("chkId");
        flag = false;
        if (obj.length != undefined) {
            for (i = 0; i < obj.length; i++) {
                if (obj[i].checked) {
                    flag = true;
                    break;
                }
            }
        } else {
            if (obj.checked)
                flag = true;
        }
        if (!flag) {
            alert("请选择需要显示的项目");
            return false;
        }
        window.open("", "pic", "height=450,width=650,status=yes,toolbar=no,menubar=no,location=no");
        document.forms(0).target = "pic";
        if (document.forms(0).all("picType").value == "P")
            document.forms(0).action = "/pages/qry/StaticResultPie.jsp";
        else
            document.forms(0).action = "/pages/qry/StaticResultBar.jsp";
        document.forms(0).submit();
    }
</script>


<h:form id="form1">
<h:inputHidden value="#{qry_querySettingBB.resultPageInit}"/>
<c:verbatim>
<table width="95%" border="0" cellspacing="0" cellpadding="0" align=center>
    <tr>
        <td height=10></td>
    </tr>
    <tr>
        <td align=left>
            <input name="search2" type="button" class="button01" onclick="forOrg()" value="机构范围">
            <input name="search3" type="button" class="button01" onclick="forCondition()" value="统计对象">
            <input name="search32" type="button" class="button01" onclick="forDisp()" value="统计内容">
            <input name="search32" type="button" class="button01" onclick="forPic()" value="查看统计图">
            <select name="picType">
                <option value="P">饼图</option>
                <option value="B">柱图</option>
            </select>
        </td>
    </tr>
</table>
<br>

<table border="0" width="95%" cellpadding="0" cellspacing="0" align="center">
  <tr><td>
    <table border="1" width="95%" cellpadding="0" cellspacing="0" align="left" class="table03">
        <tr>
            <td class="td_top" align='center'><input type="checkbox" onclick="selectAll(this,document.all('chkId'))">
            </td>
            <td class="td_top" align='center'><strong>序号</strong></td>
            <td class="td_top" align='center'><strong>栏目名称</strong></td>
            <td class="td_top" align='center'><strong>栏目内容</strong></td>
            <%
                StaticResultVO[] resultvo = (StaticResultVO[]) session.getAttribute("STATIC_RESULT");
                if (resultvo != null) {
                    if ("checked".equals(resultvo[0].getCount())) {
                        out.println("<td class='td_top' align='center'><strong>个数</strong></td>");
                        out.println("<td class='td_top' align='center'><strong>百分比</strong></td>");
                    }
                    if ("checked".equals(resultvo[0].getMax())) {
                        out.println("<td class='td_top' align='center'><strong>" + staticItemName + "最大值</strong></td>");
                    }
                    if ("checked".equals(resultvo[0].getMin())) {
                        out.println("<td class='td_top' align='center'><strong>" + staticItemName + "最小值</strong></td>");
                    }
                    if ("checked".equals(resultvo[0].getSum())) {
                        out.println("<td class='td_top' align='center'><strong>" + staticItemName + "求和</strong></td>");
                    }
                }
            %>
        </tr>

        <%
            if (resultvo != null) {
                int i = 0;
                for (int scount = 0; scount < resultvo.length; scount++) {
                    String groupName = "";
                    if (scount == 0) {
                        groupName = "统计范围";
                    }
                    else {
                        if ("".equals(groupName))  groupName = "分项" + scount;
                    }
                    for (int rcount = 0; rcount < resultvo[scount].getItems().length; rcount++, i++) {
                        out.println("<tr>");
                        StaticResultItemVO resultItem = resultvo[scount].getItems()[rcount];
                        String disabled = "";
                        if (i == 0)
                            disabled = "disabled";
                        out.println("<td class='td_middle' align='center'><input type=checkbox name=chkId value='" + scount + "|" + rcount + "' " + disabled + "></td>");
                        out.println("<td class='td_middle' align='center'>" + (i == 0 ? "&nbsp;" : String.valueOf(i)) + "</td>");
                        out.println("<td class='td_middle'>" + CommonFuns.filterNull(groupName) + "</td>");
                        groupName = "&nbsp;";
                        String staticName = "";
                        if (resultItem.getAllValue() == null || "".equals(resultItem))
                            staticName = CommonFuns.filterNull(resultvo[scount].getName());
                        else {
                            InfoItemBO infoitem = SysCacheTool.findInfoItem(null, resultItem.getAllValueField());
                            if (infoitem != null) {
                                if (InfoItemBO.DATA_TYPE_ORG.equals(infoitem.getItemDataType()))
                                    resultItem.setAllValue(CodeUtil.interpertCode("OU", resultItem.getAllValue()));
                                if (InfoItemBO.DATA_TYPE_PARTY.equals(infoitem.getItemDataType()))
                                    resultItem.setAllValue(CodeUtil.interpertCode("OU", resultItem.getAllValue()));
                                if (InfoItemBO.DATA_TYPE_POST.equals(infoitem.getItemDataType()))
                                    resultItem.setAllValue(CodeUtil.interpertCode("OU", resultItem.getAllValue()));
                                if (InfoItemBO.DATA_TYPE_CODE.equals(infoitem.getItemDataType()))
                                    resultItem.setAllValue(CodeUtil.interpertCode(null, resultItem.getAllValue()));
                                staticName = resultItem.getAllValue();
                            }//将group后的取的分组值 翻译 如按性别分组, 翻译为男\女 ,如果不是全值统计则取分项的名称
                        }
                        resultvo[scount].getItems()[rcount].setAllValue(staticName);
                        out.println("<td class='td_middle'>" + staticName + "&nbsp;</td>");
                        if ("checked".equals(resultvo[0].getCount())) {
                            //求百分比
                            String precent = precent(String.valueOf(resultItem.getCount()), String.valueOf(resultvo[0].getItems()[0].getCount()), 3);
                            out.println("<td class='td_middle'>" + resultItem.getCount() + "</td>");
                            out.println("<td class='td_middle'>" + precent + "%</td>");
                        }
                        if ("checked".equals(resultvo[0].getMax())) {
                            out.println("<td class='td_middle'>" + CommonFuns.filterNull(resultItem.getMax()) + "</td>");
                        }
                        if ("checked".equals(resultvo[0].getMin())) {
                            out.println("<td class='td_middle'>" + CommonFuns.filterNull(resultItem.getMin()) + "</td>");
                        }
                        if ("checked".equals(resultvo[0].getAvg())) {
                            out.println("<td class='td_middle'>" + CommonFuns.filterNull(resultItem.getAvg()) + "</td>");
                        }
                        if ("checked".equals(resultvo[0].getSum())) {
                            out.println("<td class='td_middle'>" + CommonFuns.filterNull(resultItem.getSum()) + "</td>");
                        }

                        out.println("</tr>");
                    }
                }
                session.setAttribute("STATIC_RESULT", resultvo);
            }
        %>
    </table>
</td></tr>

</table>
</c:verbatim>
</h:form>
<%!
    /**
     * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指
     * <p/>
     * 定精度，以后的数字四舍五入。
     *
     * @param v1    被除数
     * @param v2    除数
     * @param scale 表示表示需要精确到小数点以后几位。
     * @return 两个参数的商
     */

    public static String precent(String v1, String v2, int scale) {
        v1 = CommonFuns.filterNullToZero(v1);
        v2 = CommonFuns.filterNullToZero(v2);

        if (v1.equals("0") || v2.equals("0"))
            return "0";
        if (scale < 0) {
            return "0";
        }
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        String rt = b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal("100")).toString();
        return rt.substring(0, rt.length() - 2);
    }
%>