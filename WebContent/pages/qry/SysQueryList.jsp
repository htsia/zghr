<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.qry.pojo.bo.QueryBO" %>
<%@ page import="com.hr319wg.qry.ucc.IQueryUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="org.springframework.orm.hibernate3.HibernateTemplate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ include file="../include/taglib.jsp" %>
<%
    List list = new ArrayList();
    try{
    HibernateTemplate ht = (HibernateTemplate) SysContext.getBean("hibernateTemplate");

    String flag = request.getParameter("delFlag");
    if("del".equals(flag)){
        String[] ids = request.getParameterValues("qryId");
        if(ids != null && ids.length > 0){
            IQueryUCC ucc = (IQueryUCC) SysContext.getBean("qry_queryUCC");
            ucc.deleteQuery(ids);
        }
    }

    list = ht.find("from QueryBO q where q.sysFlag = '1' order by q.qryId");
    }catch(Exception e){
        e.getMessage();
    }
%>

<html>
<head><title>
</title></head>
<link href="../../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../js/Appclient.js"></script>
<script type="text/javascript">
    dialogPara = "dialogWidth:800px; dialogHeight:500px;";
    function forNew() {
        window.showModalDialog("/qry/QueryOrgSetting.jsf?pop=Y&resetFlag=Y&sysFlag=1&flag=org&qsType=Q&setType=" + document.all("setType").value + "&classId=Q" + document.all("setType").value + "SYSTEM&unitType=" + document.all("unitType").value, "", dialogPara);
        location.href = "/pages/qry/SysQueryList.jsp";
    }
    function forDel() {
        if(!confirm("确认删除?"))
            return false;
        document.forms(0).submit();
    }
    function forEdit(qryId) {
        window.showModalDialog("/qry/QueryOrgSetting.jsf?pop=Y&resetFlag=Y&qryId=" + qryId + "&unitType=" + document.all("unitType").value, "", dialogPara);
        location.href = "/pages/qry/SysQueryList.jsp";
    }
    function forQuery(qryId) {

    }
</script>

<body>
<center>
    <form action="SysQueryList.jsp" method="post">
        <input type="hidden" name="delFlag" value="del">
        <table width="90%"><tr><td align="right">
            <select name="unitType">
                <option value="ORG">使用行政机构范围</option>
                <option value="PARTY">使用组织机构范围</option>
            </select>

            <select name="setType">
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
            </select>
            <input type="button" value="新增" onclick="forNew()">
            <input type="button" value="删除" onclick="forDel()">
            <input type="button" value="查询" onclick="javascript:location.href = '/pages/qry/SysQueryList.jsf';">
        </td></tr></table>
        <BR>
        <table width="90%" class="table03">
            <tr>
                <td class="td_top">&nbsp;</td>
                <td class="td_top" align="center">序号</td>
                <td class="td_top" align="center">编号</td>
                <td class="td_top">名称</td>
                <td class="td_top">指标集类别</td>
                <td class="td_top">查询统计类别</td>
                <td class="td_top">操作</td>
            </tr>
            <%
                int count = list.size();
                for (int i = 0; i < count; i++) {
                    QueryBO b = (QueryBO) list.get(i);
            %>
            <tr>
                <td class="td_middle" align="center"><input type="checkbox" name="qryId" value="<%=b.getQryId()%>"></td>
                <td class="td_middle" align="center"><%=i + 1%></td>
                <td class="td_middle" align="center"><%=CommonFuns.filterNull(b.getQryId())%></td>
                <td class="td_middle"><%=CommonFuns.filterNull(b.getName())%></td>
                <td class="td_middle"><%=CommonFuns.filterNull(b.getSetType())%></td>
                <td class="td_middle"><%=CommonFuns.filterNull(b.getQsType())%></td>
                <td class="td_middle"><input type="button" value="修改" onclick="forEdit('<%=b.getQryId()%>')">
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </form>
</center>
</body>
</html>