<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.qry.pojo.bo.QueryConditionBO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>

<c:verbatim>
    <script language="javascript" src="../../js/tree.js"></script>
    <script type="text/javascript">
        with (window) onload = onresize = function(){
            var mainHeight = document.body.clientHeight - 95;
            document.getElementById("dt").style.height = "" + mainHeight + "px";
        }
    </script>
</c:verbatim>

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
%>
<h:form id="form1">
    <h:inputHidden value="#{qry_staticSettingBB.staticListPageInit}"/>
<c:verbatim>
    <input type="hidden" name="qsType" value="<%=qsType%>">
    <input type="hidden" name="setType" value="<%=setType%>">
    <input type="hidden" name="classId" value="<%=classId%>">
    <input type="hidden" name="qryName" value="<%=qryName%>">
    <input type="hidden" name="sysFlag" value="<%=sysFlag%>">
    <input type="hidden" name="qryId" value="<%=qryId%>">
    <input type="hidden" name="unitType" value="<%=unitType%>">
    <input type="hidden" name="pop" value="<%=CommonFuns.filterNull(request.getParameter("pop"))%>">
    <input type="hidden" name="flag" value="staticsetting">
    <input type="hidden" name="newName" value="">
    <input type="hidden" name="staticId" value="">

    <table width="100%" border="0" cellspacing="6" cellpadding="0">
        <tr>
            <td class="td_title">设定统计对象</td>
        </tr>
    </table>

     <table width="98%" border="0" align="center">
        <tr>
            <td valign="top" >
                <div id="dt" style="width:98%;overflow-x:auto;"></div>
            </td>
        </tr>

        <tr>
            <td align="right">
                <input type="button" name="rest2" value="返回" class="button01" onclick="forBack();">
</c:verbatim>
                <h:commandButton action="org" value="上一步:设置机构范围" id="toOrg" styleClass="button01"/>
                <h:commandButton id="toStaticItem" value="下一步:设置统计项" action="#{qry_staticSettingBB.toStaticItem}" styleClass="button01"/>
                <h:commandButton id="doSave" value="保存" onclick="return forSave();" action="#{qry_staticSettingBB.doSave}" styleClass="button01"/>
                <h:commandButton id="doQuery" value="统计" action="#{qry_staticSettingBB.doQuery}" onclick="forQuery();" styleClass="button01"/>
<c:verbatim>
            </td>
        </tr>
</table>
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
</h:form>
<script language="JavaScript">
    function modifyTile(staticname,staticId){
        var newname = prompt("请输入分项名称",staticname);
        if(newname == null )
            newname="";

        document.all("flag").value = "modifyname";
        document.all("newName").value = newname;
        document.all("staticId").value = staticId;
        document.forms(0).submit();
    }

    //定义树的图片对象
    var flag = false;
    var images = getTreeImage();

    //初始化树
    var tree = new newtree(images, 16, dt)
    var root = tree.root
    <%
        String staticId;
        QueryVO vo = (QueryVO) session.getAttribute("QUERY_VO");
        staticId = CommonFuns.filterNull(vo.getStatics()[0].getStatics().getStaticId());
        out.println("var content='';");
        out.println("var troot = tree.add(root,\"last\",\"<a  href='/qry/StaticConditionSetting.jsf?pop="+ CommonFuns.filterNull(request.getParameter("pop"))+"&staticId=" + staticId + "'>设定范围:</a> [" + getStaticName(vo.getStatics()[0]) + "]\",\"S" + staticId + "\", \"S\",'"+ staticId +"',\"\",\"\");");
        for(int i=1;i<vo.getStatics().length;i++){
            staticId = CommonFuns.filterNull(vo.getStatics()[i].getStatics().getStaticId());
            String staticName = getStaticName(vo.getStatics()[i]);
            vo.getStatics()[i].getStatics().setName(staticName);
            out.println("content=\"<span style='v-align:bottom;'><a href='javascript:modifyTile(\"+'\"'+'"+staticName+"'+'\",\"'+'"+staticId+"'+'\");'+\"'>\"+\"修改名称</a> <a href='/qry/StaticConditionSetting.jsf?pop=" + CommonFuns.filterNull(request.getParameter("pop"))+"&staticId=" + staticId + "'>修改定义</a> <a href='/qry/StaticListSetting.jsf?flag=del&pop=" + CommonFuns.filterNull(request.getParameter("pop"))+ "&staticId="+ staticId +"'>删除:</a>" +i+"、" +staticName + "</span>\";");
            out.println("var t" + i + " = tree.add(troot,'last',content,'S" + staticId + "', 'S','"+ staticId +"','item','');");
        }
        session.setAttribute("QUERY_VO",vo);
    %>
    inew = tree.add(troot, "last", "<a href='/qry/StaticConditionSetting.jsf?flag=addnew&pop=<%=CommonFuns.filterNull(request.getParameter("pop"))%>'>新加定义</a>", "S104", 'O', '', "item", "");

    tree.onclick = function(node) {
        if (node.getKey() != null && node.getKey().length == 7) {
            parent.node = node;
        }
    }
    tree.ondblclick = function(srcNode) {
        if (srcNode.key2 == "S") {
            var staticname = srcNode.label.innerText;
            staticname = staticname.substring(staticname.indexOf("|") +1,staticname.length);
            modifyTile(staticname,srcNode.alt);
        }
    }
    function forSave() {
        var qname = window.prompt("请输入查询名称", document.forms(0).qryName.value);
        if (qname == null)
            return false;
        if (qname == "")
            forSave();

        document.forms(0).qryName.value = qname;
        return true;
    }
    function forBack(){
        if("Y" == "<%=CommonFuns.filterNull(request.getParameter("pop"))%>"){
            window.returnValue = false;
            window.close();
        }else{
            location.href = '/qry/QueryIndex.jsf?qsType=<%=qsType%>&setType=<%=setType%>&unitType=<%=unitType%>';
        }
    }
    function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
    function forQuery(){
        showProcessBar();
    }
</script>

<%!
    private String getStaticName(StaticVO vo) {
        if (vo.getStatics().getName() == null || "".equals(vo.getStatics().getName())) {
            String group = CommonFuns.filterNull(vo.getStatics().getGroup());
            group = group.replaceAll("与", "并且");
            group = group.replaceAll("\\)", " ）");
            group = group.replaceAll("\\(","（");

            if(vo.getCondi() != null){
                for (int i = 0; i < vo.getCondi().length; i++) {
                    group = group.replaceAll(vo.getCondi()[i].getGroupId(), getConditionName(vo.getCondi()[i]));
                }
            }
            vo.getStatics().setName(group);
        }
        return vo.getStatics().getName();
    }

    private String getConditionName(QueryConditionBO bo) {
        if (bo == null)
            return "";
        StringBuffer sb = new StringBuffer();

        InfoItemBO info = SysCacheTool.findInfoItem(null, bo.getItemId());
        bo.getOperator();
        sb.append(info.getItemName()).append(" ").append(getOperator(bo.getOperator())).append(" ").append(bo.getText());
        return sb.toString();
    }

    private String getOperator(String operator) {
        if ("equal".equals(operator))
            return "等于";
        else if ("notequal".equals(operator))
            return "不等于";
        else if ("morethan".equals(operator))
            return "大于";
        else if ("lessthan".equals(operator))
            return "小于";
        else if ("moreequal".equals(operator))
            return "大于等于";
        else if ("lessequal".equals(operator))
            return "小于等于";
        else if ("in".equals(operator))
            return "在列表中";
        else if ("notin".equals(operator))
            return "不在列表中";
        else if ("like".equals(operator))
            return "匹配";
        else if ("notlike".equals(operator))
            return "不匹配";
        else if ("exist".equals(operator))
            return "存在";
        else if ("notexist".equals(operator))
            return "不存在";
        else if ("isnull".equals(operator))
            return "为空";
        else if ("notisnull".equals(operator))
            return "不为空";
        else if ("allvalue".equals(operator))
            return "取全值";
        else
            return "";
    }
%>