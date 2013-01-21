<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>

<x:saveState value="#{qry_querySettingBB}"/>
<h:form id="form1">
<h:inputHidden value="#{qry_querySettingBB.initVO}"/>
<%
    String qsType = CommonFuns.filterNull(request.getParameter("qsType"));
    String setType = CommonFuns.filterNull(request.getParameter("setType"));
    String qryName = CommonFuns.filterNull(request.getParameter("qryName"));
    String sysFlag = CommonFuns.filterNull(request.getParameter("sysFlag"));
    String classId = CommonFuns.filterNull(request.getParameter("classId"));
    String qryId = CommonFuns.filterNull(request.getParameter("qryId"));
    String unitType = CommonFuns.filterNull(request.getParameter("unitType"));
    String historySet = CommonFuns.filterNull(request.getParameter("historySet"));
    QueryVO queryvo = (QueryVO) session.getAttribute("QUERY_VO");
    qsType = (queryvo != null && queryvo.getQsType() != null ? queryvo.getQsType() : qsType);
    setType = (queryvo != null && queryvo.getSetType() != null ? queryvo.getSetType() : setType);
    qryName = (queryvo != null && queryvo.getName() != null ? queryvo.getName() : qryName);
    sysFlag = (queryvo != null && queryvo.getSysFlag() != null ? queryvo.getSysFlag() : sysFlag);
    classId = (queryvo != null && queryvo.getClassId() != null ? queryvo.getClassId() : classId);
    qryId = (queryvo != null && queryvo.getQryId() != null ? queryvo.getQryId() : qryId);
    unitType = (queryvo != null && queryvo.getUnitType() != null ? queryvo.getUnitType() : unitType);
    historySet = (queryvo != null && queryvo.getHistorySet() != null ? queryvo.getHistorySet() : historySet);

    String dialog = CommonFuns.filterNull(request.getParameter("dialog"));
    if ("".equals(dialog))
        dialog = "111";
    String orgHidden = "none";
    String itemHidden = "none";
    String saveHidden = "";
    String conditionHidden = "none";
    if ("1".equals(dialog.substring(0, 1)))
        orgHidden = "";
    if ("1".equals(dialog.substring(1, 2)))
        conditionHidden = "";
    if ("1".equals(dialog.substring(2, 3)))
        itemHidden = "";

    if ("Y".equals(request.getParameter("hideSave")))
        saveHidden = "none";

    QueryVO vo = (QueryVO) session.getAttribute("QUERY_VO");
    String orgIds = "";
    String orgNames = "";
    if (vo != null) {
        orgIds = vo.getOrgIds();
        orgNames = vo.getOrgNames();
    }
    String operFlag = request.getParameter("operFlag");
    if(operFlag==null)        operFlag = "1";
%>

<c:verbatim>
<table width="100%" border="0" cellspacing="6" cellpadding="0">
    <tr>
        <td class="td_title"> <img src="/images/tips.gif" > 设定机构范围 </td>
    </tr>
</table>

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="350" align="center" style="border:1px #CCCCCC solid; background-color:#EEEEEE">
            <table width="650" border="0" cellspacing="30" cellpadding="0">
                <tr>
                    <td style="line-height:150%">
                        <strong>请选择机构范围，如果不选择，将在您拥有查询权力的所有机构中进行查询</strong><br>
                        <strong>机构范围是自动包含所有下级，所以无需手动选择下级</strong>
</c:verbatim>
                        <h:selectOneMenu value="#{qry_querySettingBB.deptLink}" rendered="false">
                            <c:selectItem itemLabel="不做处理" itemValue="0"></c:selectItem>
                            <c:selectItem itemLabel="级联上级部门" itemValue="1"></c:selectItem>
                        </h:selectOneMenu>
<c:verbatim>
                    </td>
                </tr>

                <tr>
                    <td>
                        <input type="hidden" name="orgIds" value="<%=CommonFuns.filterNull(orgIds)%>">
                        <textarea rows="10" cols="80" name="orgNames" readonly><%=CommonFuns.filterNull(orgNames)%></textarea>
                        <% if ("ORG".equals(unitType)) {%>
                        <input name="Submit" type="button" class="button01" value="选择机构"
                               onclick="PopUpMutilOrgTwoControl(document.forms(0).all('orgIds'),document.forms(0).all('orgNames'),<%=operFlag%>,'')">
                        <%} else if ("PARTY".equals(unitType)) {%>
                        <input name="Submit" type="button" class="button01" value="选择组织"
                               onclick="fPopUpMutilParty2(document.forms(0).all('orgIds'),document.forms(0).all('orgNames'),<%=operFlag%>,'')">
                        <%} else if ("WAGE".equals(unitType)) {%>
                        <input name="Submit" type="button" class="button01" value="选择薪资发放单位"
                               onclick="fPopUpMutilParty2(document.forms(0).all('orgIds'),document.forms(0).all('orgNames'))">
                        <%}%></td>
                </tr>
            </table>
        </td>
    </tr>

    <tr>
        <td height="50">&nbsp;</td>
    </tr>
    <tr>
        <td align="center">
            <span style="display:<%=saveHidden%>">
            <input type="button" name="rest2" value=" 返回 " class="button01" onclick="forBack();">
            </span>
            <span style="display:<%=conditionHidden%>">
</c:verbatim>
            <h:commandButton action="#{qry_querySettingBB.toConditionPage}" value="修改定义" styleClass="button01"/>
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
<input type="hidden" name="dialog" value="<%=CommonFuns.filterNull(request.getParameter("dialog"))%>">
<input type="hidden" name="hideSave" value="<%=CommonFuns.filterNull(request.getParameter("hideSave"))%>">
<input type="hidden" name="addedCondition" value="<%=CommonFuns.filterNull(request.getParameter("addedCondition"))%>">
<input type="hidden" name="queryFlag" value="<%=CommonFuns.filterNull(request.getParameter("queryFlag"))%>">
<input type="hidden" name="pageFlag" value="<%=CommonFuns.filterNull(request.getParameter("pageFlag"))%>">
<input type="hidden" name="checkScale" value="<%=CommonFuns.filterNull(request.getParameter("checkScale"))%>">
<input type="hidden" name="operFlag" value="<%=operFlag%>">
<input type="hidden" name="historySet" value="<%=historySet%>">
<input type="hidden" name="historySetName" value="<%=CommonFuns.filterNull(request.getParameter("historySetName"))%>">
<input type="hidden" name="flag" value="org">
<input type="hidden" name="operFlag" value="<%=operFlag%>">    

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

</c:verbatim>
    <script type="text/javascript">
        function forSave() {
            var qname = window.prompt("请输入查询名称", document.forms(0).qryName.value);
            if (qname == null)
                return false;
            if (qname == "")
                forSave();

            document.forms(0).qryName.value = qname;
            return true;
        }
        function forQuery() {
            showProcessBar();
            return true;
        }
        function forBack() {
            if ("Y" == "<%=CommonFuns.filterNull(request.getParameter("pop"))%>") {
                window.returnValue = false;
                window.close();
            } else {
                <%
                   if ("QALEAD".equals(classId)){
                       out.println("location.href = '/qry/QueryIndex.jsf?classID="+classId+"&qsType="+qsType+"&setType="+setType+"&unitType="+unitType+"';");
                    }
                    else{
                       out.println("location.href = '/qry/QueryIndex.jsf?qsType="+qsType+"&setType="+setType+"&unitType="+unitType+"';");
                    }
                %>

            }
        }
        function showProcessBar() {
            x = document.body.clientWidth / 2 - 150;
            y = document.body.clientHeight / 2;
            document.all('processbar').style.top = y;
            document.all('processbar').style.left = x;
            document.all('processbar').style.display = "";
        }
    </script>
</h:form>
