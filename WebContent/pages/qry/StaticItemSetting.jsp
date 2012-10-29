<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>

<h:inputHidden value="#{qry_querySettingBB.initVO}"/>
<%
    String qsType = CommonFuns.filterNull(request.getParameter("qsType"));
    String setType = CommonFuns.filterNull(request.getParameter("setType"));
    String qryName = CommonFuns.filterNull(request.getParameter("qryName"));
    String sysFlag = CommonFuns.filterNull(request.getParameter("sysFlag"));
    String classId = CommonFuns.filterNull(request.getParameter("classId"));
    String qryId = CommonFuns.filterNull(request.getParameter("qryId"));
    String unitType = CommonFuns.filterNull(request.getParameter("unitType"));
    String staticItemName = "";
    QueryVO queryvo = (QueryVO) session.getAttribute("QUERY_VO");
    if (queryvo.getStaticItemId() != null && !"".equals(queryvo.getStaticItemId())) {
        InfoItemBO bo = SysCacheTool.findInfoItem(null, queryvo.getStaticItemId());
        if (bo != null)
            staticItemName = bo.getItemName();
    }
    qsType = (queryvo != null && queryvo.getQsType() != null ? queryvo.getQsType() : qsType);
    setType = (queryvo != null && queryvo.getSetType() != null ? queryvo.getSetType() : setType);
    qryName = (queryvo != null && queryvo.getName() != null ? queryvo.getName() : qryName);
    sysFlag = (queryvo != null && queryvo.getSysFlag() != null ? queryvo.getSysFlag() : sysFlag);
    classId = (queryvo != null && queryvo.getClassId() != null ? queryvo.getClassId() : classId);
    qryId = (queryvo != null && queryvo.getQryId() != null ? queryvo.getQryId() : qryId);
    unitType = (queryvo != null && queryvo.getUnitType() != null ? queryvo.getUnitType() : unitType);
%>
<script language="javascript">
    function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
    function forQuery(){
        flag = toSubmit();
        if(flag)
            showProcessBar();
        return flag;
    }
    function forSave() {
        rt = window.prompt("请输入统计名称", document.all("qryName").value);
        if (rt == "" || rt == null)
            return false;
        document.all("qryName").value = rt;
        return toSubmit();
    }
    function toSubmit() {
        sm = document.all("staticMethod");
        if (document.all("staticItemId").value == "" && (sm[1].checked || sm[2].checked || sm[3].checked || sm[4].checked)) {
            alert("请选择统计项和统计方法")
            return false;
        }
        flag = false;
        for (i = 0; i < sm.length; i++) {
            if (sm[i].checked)
                flag = true;
        }
        if (!flag) {
            alert("必须选择一种统计方法")
            return false;
        }

        return true;
    }


    var node = null;
    function doSel(srcNode) {
        node = srcNode;
        tmp = srcNode.alt;
        datatype = tmp.split("|")[0].substring(1, 2);

        if (datatype == "1" || datatype == "2" || datatype == "9")
            document.all("staticMethod")[1].disabled = false;
        else
            document.all("staticMethod")[1].disabled = true;

        insertStaticItem(srcNode.getKey(), srcNode.label.innerText);
    }

    function insertStaticItem(itemId, itemName) {
        sitem.innerText = "统计项目:" + itemName;

        document.all("staticItemId").value = itemId;
    }
    function checkAvg(src) {
        if (src.checked) {
            tmp = node.alt;

            datatype = tmp.split("|")[0];
            if (datatype == "1" || datatype == "2" || datatype == "9")
                return true;
            else {
                alert("只有数值型指标才能求平均值");
                return false;
            }
        }
    }
    function setStaticMethod(count, avg, max, min,sum) {
        if (count == "checked")
            count = true;
        else
            count = false;

        if (avg == "checked")
            avg = true;
        else
            avg = false;

        if (max == "checked")
            max = true;
        else
            max = false;

        if (min == "checked")
            min = true;
        else
            min = false;

        if (sum == "checked")
            sum = true;
        else
            sum = false;

        document.all("staticMethod")[0].checked = count;
        document.all("staticMethod")[1].checked = avg;
        document.all("staticMethod")[2].checked = max;
        document.all("staticMethod")[3].checked = min;
        document.all("staticMethod")[4].checked = sum;
    }
</script>

<h:form id="form1">
<c:verbatim>
<table width="100%" border="0" cellspacing="6" cellpadding="0">
    <tr>
        <td class="td_title">设定统计项目</td>
    </tr>
</table>
</c:verbatim>

<c:verbatim>
<table width="98%" border="0" align="center">
    <tr>
        <td width="230">
            <iframe src="/pages/qry/InfoItemList.jsp?setType=<%=request.getParameter("setType")%>&dataType=1,2,9"
                    style="width:100%;height:400px;"></iframe>
        </td>
        <td align="left" valign="top">
            <div id="sitem">统计项目：</div>
            <br>
        <div>
            <input type="checkbox" name="staticMethod" value="count">计数<br>
            <input type="checkbox" name="staticMethod" value="avg">平均值<br>
            <input type="checkbox" name="staticMethod" value="max">最大值<br>
            <input type="checkbox" name="staticMethod" value="min">最小值<br>
            <input type="checkbox" name="staticMethod" value="sum">求和<br>
        </div>
        <td width="230" align="left" valign="top">
    </tr>
    <tr>
        <td colspan="5" align="center">
            <input type="button" name="rest2" value="&nbsp;取消&nbsp;" class="button01"
                   onclick="forBack();">
</c:verbatim>
            <h:commandButton id="toCondition" action="#{qry_staticSettingBB.toStaticList}" onclick="return toSubmit()"
                             value=" 上一步:设置条件 " styleClass="button01"/>
            <h:commandButton action="#{qry_staticSettingBB.doSave}" value=" 保存 " onclick="return forSave();"
                             styleClass="button01"/>
            <h:commandButton action="#{qry_staticSettingBB.doQuery}" value=" 统计 " id="doQuery"
                             onclick="return forQuery();" styleClass="button01"/>
<c:verbatim>
        </td>
    </tr>
</table>

<input type="hidden" name="qsType" value="<%=qsType%>">
<input type="hidden" name="setType" value="<%=setType%>">
<input type="hidden" name="classId" value="<%=classId%>">
<input type="hidden" name="qryName" value="<%=qryName%>">
<input type="hidden" name="sysFlag" value="<%=sysFlag%>">
<input type="hidden" name="qryId" value="<%=qryId%>">
<input type="hidden" name="unitType" value="<%=unitType%>">
<input type="hidden" name="pop" value="<%=CommonFuns.filterNull(request.getParameter("pop"))%>">
<input type="hidden" name="sessionKey" value="<%=CommonFuns.filterNull(request.getParameter("sessionKey"))%>">
<input type="hidden" name="staticItemId" value="">
<input type="hidden" name="flag" value="staticitem">
</c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr></table>
</marquee>

<SCRIPT LANGUAGE="JavaScript">
    function forBack() {
        if ("Y" == "<%=CommonFuns.filterNull(request.getParameter("pop"))%>") {
            window.returnValue = false;
            window.close();
        } else {
            location.href = '/qry/QueryIndex.jsf?qsType=<%=qsType%>&setType=<%=setType%>&unitType=<%=unitType%>';
        }
    }
    insertStaticItem('<%=CommonFuns.filterNull(queryvo.getStaticItemId())%>', '<%=staticItemName%>')
    setStaticMethod('<%=queryvo.getCount()%>', '<%=queryvo.getAvg()%>', '<%=queryvo.getMax()%>', '<%=queryvo.getMin()%>','<%=queryvo.getSum()%>');
</SCRIPT>
