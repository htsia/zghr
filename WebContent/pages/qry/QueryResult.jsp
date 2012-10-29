<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>

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
    String hideSave = CommonFuns.filterNull((String) session.getAttribute("CONTRAL_SAVE"));
    String linkDept=queryvo.getLinksuperdept();
%>

<script type="text/javascript">
    dialogPara="dialogWidth:800px; dialogHeight:550px;";
    function forOrg() {
        flag = window.showModalDialog("/qry/QueryOrgSetting.jsf?pop=Y&hideSave=<%=hideSave%>&flag=org&qryId=<%=qryId%>","",dialogPara);
        if(flag)
            location.href = "/qry/QueryResult.jsf";
    }
    function forCondition(){
        flag = window.showModalDialog("/qry/QueryConditionSetting.jsf?pop=Y&flag=condition&hideSave=<%=hideSave%>&qryId=<%=qryId%>","",dialogPara);
        if(flag)
            location.href = "/qry/QueryResult.jsf";
    }
    function forDisp(){
        flag = window.showModalDialog("/qry/QueryItemSetting.jsf?pop=Y&hideSave=<%=hideSave%>&flag=item&qryId=<%=qryId%>&setType=<%=setType%>","",dialogPara);
        if(flag)
            location.href = "/qry/QueryResult.jsf";
    }
    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ClientReportShow.jsp?RptCode="+document.all("form1:ReportID").value;
        window.open(url);
        return false;
    }
	//修改开始1
    function forView(frm,fk,other){
        var setType = '<%=setType%>';
        var url = "";
        if(setType == 'A'){
			//window.open(url,"","height=600,width=1000,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,left=50,top=50");
			windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + fk+"&type=0", "aa", "", "1000", "600", "no","10","1","yes");
        }else if(setType == 'B'){
			windowOpen("/org/info/OrgEditInfo.jsf?pk="+fk+"&type=0", "aa", "", "900", "600", "no","10","100","yes");
        }else if(setType == 'C'){
            windowOpen("/post/info/PostEditInfo.jsf?pk="+fk+"&type=0","aa","","900","600","no","10","100","yes");
        }else if(setType == 'D'){
            url = "/doc/PartyIndex.jsf?fk="+fk;
        //window.open(url,"","height=600,width=1000,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,left=50,top=50");
		}
    }
	//修改结束1
</script>


<h:form id="form1">
    <h:inputHidden value="#{qry_querySettingBB.resultPageInit}"/>
    <c:verbatim>
    <table width="98%" height=97% border="0" cellspacing="0" cellpadding="0" align=center>
        <tr>
            <td align=left class="td_page" height=8>
                <input name="search2" type="button" class="button01" onclick="forOrg()" value="机构范围">
                <input name="search3" type="button" class="button01" onclick="forCondition()" value="查询条件">
                <input name="search32" type="button" class="button01" onclick="forDisp()" value="查询显示项">
     </c:verbatim>
                <h:commandButton value="对查询结果进行统计" action="#{qry_staticSettingBB.toStaticResult}" styleClass="button01"/>
                <h:commandButton value="发邮件" type="button" styleClass="button01" onclick="sysSendMail('activeList');"></h:commandButton>
<c:verbatim>
            </td>

            <td align=right height=8 class="td_page">
 </c:verbatim>
                <h:selectOneMenu id="ReportID" style="width:190px">
                    <c:selectItems value="#{qry_querySettingBB.reportList}"/>
                </h:selectOneMenu>
                <h:commandButton value="按格式导出" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
<c:verbatim>
                <input type="button" onclick="doExport()" class="button01" value="直接导出">
            </td>
        </tr>

       <tr><td colspan=2 valign="top">
            <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                <jsp:param name="hasOperSign" value="false"/>
                <jsp:param name="operSignType" value="checkbox"/>
                <jsp:param name="hasEdit" value="true"/>
                <jsp:param name="isEditList" value="false"/>
                <jsp:param name="isCheckRight" value="true"/>
                <jsp:param name="isForward" value="true"/>
                <jsp:param name="isRow" value="true"/>
                <jsp:param name="rowFuncName" value="forView"/>
                <jsp:param name="isPage" value="true"/>
                <jsp:param name="isScroll" value="true"/>
                <jsp:param name="linkDept" value="<%=linkDept%>"/>
            </jsp:include>
        </td></tr>
    </table>
    </c:verbatim>
</h:form>
