<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.qry.pojo.bo.QueryConditionBO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
 <script type="text/javascript" language="javascript" src="/js/setQueryCond.js" charset="gbk"></script>
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
    if("".equals(dialog))
        dialog = "111";

    String orgHidden = "none";
    String itemHidden = "none";
    String saveHidden = "";
    String conditionHidden = "none";
    if("1".equals(dialog.substring(0,1)))
        orgHidden = "";
    if("1".equals(dialog.substring(1,2)))
        conditionHidden="";
    if("1".equals(dialog.substring(2,3)))
        itemHidden = "";

    if("Y".equals(request.getParameter("hideSave")))
        saveHidden = "none";
%>

<script type="text/javascript">
    function forBack(){
        if("Y" == "<%=CommonFuns.filterNull(request.getParameter("pop"))%>"){
            window.returnValue = false;
            window.close();
        }else{
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
</script>
<c:verbatim>
<table width="100%" border="0" cellspacing="6" cellpadding="0">
    <tr>
        <td class="td_title"> <img src="/images/tips.gif" > 设定查询条件 </td>
    </tr>
</table>

<table width="98%" height="85%" border="0" align="center">
    <tr valign="top">
        <td width="25%" rowspan="2">
            <iframe src="/pages/qry/InfoItemList.jsp?setType=<%=setType%>" style="width:100%;height:350px;"></iframe>
        </td>
        <td width="75%" align="left" valign="top">
            <table width="100%" border="0" align="left" cellpadding="1" cellspacing="1" class="td02">
                <tr class="td_top" align=center>
                    <td width="65" height="25">方案名称</td>
                    <td align="left" valign="middle">
                    	<input id="qryName" name="qryName" value="<%=qryName%>" class="input" style="width: 300px;"/>
                    </td>
                </tr>
                <tr id="setCond" class="td_top" align=center style="display:none;">
                    <td width="65" height="25">输入括号</td>
                    <td align="left" valign="middle">
                    	<input id="condValue" value="" class="input" />
                    	<input type="button" onclick="setCond();" value="确定" class="button01"/>
                    </td>
                </tr>
                <tr class="td_top" align=center>
                    <td width="65">条件组合</td>
                    <td align="left" id="groupField" valign="middle"></td>
                </tr>
            </table>
        </td>
    </tr>

    <tr>
        <td align="left" valign="top">
            <div style="height:340px; overflow-y:scroll;">
                <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" class="td02" id=PLList>
                    <tr class="td_top">
                        <td colspan="6" class="F08">查询条件列表：</td>
                    </tr>
                    <tr class="td_top" align="center">
                        <td width=10%><strong>编号</strong></td>
                        <td><strong>指标项名称</strong></td>
                        <td width=9%><strong>条件</strong></td>
                        <td width=26%><strong>关键字</strong></td>
                        <td width=18%><strong>操作</strong></td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="right">
            <span style="display:<%=saveHidden%>">
                <input type="button" name="rest2" value="&nbsp;取消&nbsp;" class="button01" onclick="forBack();">
            </span>
            <span style="display:<%=orgHidden%>">
            </c:verbatim>
            <h:commandButton action="#{qry_querySettingBB.toOrgPage}" value=" 上一步:设置机构范围 " id="toOrg"
                             onclick="return toSubmit('form1:toCondition')" styleClass="button01"/>
            <c:verbatim>
            </span>
            <span style="display:<%=itemHidden%>">
            </c:verbatim>
                <h:commandButton action="#{qry_querySettingBB.toItemPage}" value=" 下一步:设置显示项目 " id="toItem"
                             onclick="return toSubmit('form1:toItem');" styleClass="button01"/>
            <c:verbatim>
            </span>
            <span style="display:<%=saveHidden%>">
            </c:verbatim>
                <h:commandButton action="#{qry_querySettingBB.doSave}" value=" 保存 "
                             onclick="return forSave();" styleClass="button01"/>
            <c:verbatim>
            </span>
            </c:verbatim>
            <h:commandButton action="#{qry_querySettingBB.doQuery}" value=" 查询 " id="doQuery"
                             onclick="return forQuery('form1:doQuery');"
                             styleClass="button01"/>
             <c:verbatim>
        </td>
    </tr>
</table>
</c:verbatim>
<script type="text/javascript">
    <%
      String staticId = "";
      String staticName= "";
      try{
            QueryVO qvo = (QueryVO) session.getAttribute("QUERY_VO");
            staticId = (String) request.getAttribute("LAST_STATIC_ID");
            StaticVO vo = new StaticVO();
            if(staticId == null || "".equals(staticId)){
                vo = qvo.getStatics()[0];
                staticId = vo.getStatics().getStaticId();
            }else {
                for(int i=0;i<qvo.getStatics().length;i++){
                    if(staticId.equalsIgnoreCase(qvo.getStatics()[i].getStatics().getStaticId())){
                        vo = qvo.getStatics()[i];
                        break;
                    }
                }
            }

            QueryConditionBO[] cbo = vo.getCondi();
            if(cbo != null && cbo.length >0){
                    for(int i=0;i<cbo.length;i++){
                        String itemId = cbo[i].getItemId();
                        if(itemId == null) continue;
                        InfoItemBO item = SysCacheTool.findInfoItem(itemId.substring(0,4),itemId);
                        out.println("insertConditionRow('" + cbo[i].getItemId() + "', '" + item.getItemName() + "','" + item.getItemDataType() + "','" + item.getItemCodeSet() + "','" + cbo[i].getOperator() + "','" + CommonFuns.filterNull(cbo[i].getValue()) + "','" + CommonFuns.filterNull(cbo[i].getText()) + "','" + CommonFuns.filterNull(cbo[i].getValue2()) + "','" + CommonFuns.filterNull(cbo[i].getText2()) + "');");
                    }
            }
            String groupshow=CommonFuns.filterNull(vo.getStatics().getGroupShow());
            out.println("groupField.innerHTML = '" +groupshow + "';");
        }catch(Exception e){

        }
    %>
</script>
<c:verbatim>
<input type="hidden" name="staticId" value="<%=CommonFuns.filterNull(staticId)%>">
<input type="hidden" name="staticName" value="<%=CommonFuns.filterNull(staticName)%>">
<input type="hidden" name="group" value="">
<input type="hidden" name="groupShow" value="">
<input type="hidden" name="qsType" value="<%=qsType%>">
<input type="hidden" name="setType" value="<%=setType%>">
<input type="hidden" name="classId" value="<%=classId%>">
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
<input type="hidden" name="operFlag" value="<%=CommonFuns.filterNull(request.getParameter("operFlag"))%>">
<input type="hidden" name="historySet" value="<%=CommonFuns.filterNull(request.getParameter("historySet"))%>">
<input type="hidden" name="historySetName" value="<%=CommonFuns.filterNull(request.getParameter("historySetName"))%>">
<input type="hidden" name="flag" value="condition">
</c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>


