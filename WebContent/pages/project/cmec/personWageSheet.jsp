<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.org.ucc.impl.OrgUCC" %>
<%@ page import="com.hr319wg.post.ucc.impl.PostUCC" %>
<%@ page import="com.hr319wg.post.pojo.bo.PostBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>

<html>
<head>
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%
    User user = (User) session.getAttribute(Constants.USER_INFO);
%>

<br>
<table width="95%" align="center">
    <tr><td align="center"><span style="font-size: 14pt; font-family: 楷体_GB2312"><strong>中国机械设备工程股份有限公司职工收入台帐</strong></span></td></tr>
</table>
<br>

<table class="table02" width="95%" align="center">
    <tr>
        <td  align="center" class=td_middle><strong>姓名</strong></td>
        <td class=td_middle colspan=2 align="center">&nbsp;</td>
        <td class=td_middle align="center"><strong>性别</strong></td>
        <td align="center" colspan=2 class=td_middle>&nbsp;</td>
        <td class=td_middle colspan=2 align="center"><strong>参加工作时间</strong></td>
        <td align="center" colspan=3 class=td_middle>&nbsp;</td>
        <td class=td_middle colspan=2 align="center"><strong>出生年月日</strong></td>
        <td  align="center" colspan=3 class=td_middle>&nbsp;</td>
        <td  align="center" colspan=5 class=td_middle>&nbsp;</td>
     </tr>
    <tr>
    <td  align="center" colspan=2 class=td_middle><strong>身份证号</strong></td>
    <td class=td_middle colspan=4 align="center">&nbsp;</td>
    <td  align="center" colspan=5 class=td_middle><strong>缴费年限</strong></td>
    <td class=td_middle colspan=10 align="center">&nbsp;</td>
    </tr>

    <tr>
        <td  align="center" class=td_middle rowspan=2><strong>月份</strong></td>
        <td  align="center" class=td_middle colspan="13"><strong>职工个人收入金额(元)</strong></td>
        <td  align="center" class=td_middle colspan="3"><strong>个人缴纳社会保险费用</strong></td>
        <td  align="center" class=td_middle colspan="3"><strong>其他扣项</strong></td>
        <td  align="center" class=td_middle rowspan="2"><strong>实发金额</strong></td>
    </tr>
    <tr>
        <td align="center" class=td_middle><strong>月收入</strong></td>
        <td align="center" class=td_middle><strong>基本工资</strong></td>
        <td align="center" class=td_middle><strong>岗位工资</strong></td>
        <td align="center" class=td_middle><strong>项目经理津贴</strong></td>
        <td align="center" class=td_middle><strong>工龄工资</strong></td>
        <td align="center" class=td_middle><strong>房补</strong></td>
        <td align="center" class=td_middle><strong>住房补贴</strong></td>
        <td align="center" class=td_middle><strong>交通补贴</strong></td>
        <td align="center" class=td_middle><strong>奖金</strong></td>
        <td align="center" class=td_middle><strong>年终一次性奖金</strong></td>
        <td align="center" class=td_middle><strong>取暖费</strong></td>
        <td align="center" class=td_middle><strong>补发工资</strong></td>
        <td align="center" class=td_middle><strong>过节费</strong></td>
        <td align="center" class=td_middle><strong>小计</strong></td>
        <td align="center" class=td_middle><strong>养老保险</strong></td>
        <td align="center" class=td_middle><strong>医疗保险</strong></td>
        <td align="center" class=td_middle><strong>住房公积金</strong></td>
        <td align="center" class=td_middle><strong>年金</strong></td>
        <td align="center" class=td_middle><strong>个人所得税</strong></td>
    </tr>
    <tr>
        <td align="center" class=td_middle>2008-01</td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
        <td align="center" class=td_middle></td>
    </tr>

</table>
</body>
</html>