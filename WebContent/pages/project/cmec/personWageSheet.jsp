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
    <tr><td align="center"><span style="font-size: 14pt; font-family: ����_GB2312"><strong>�й���е�豸���̹ɷ����޹�˾ְ������̨��</strong></span></td></tr>
</table>
<br>

<table class="table02" width="95%" align="center">
    <tr>
        <td  align="center" class=td_middle><strong>����</strong></td>
        <td class=td_middle colspan=2 align="center">&nbsp;</td>
        <td class=td_middle align="center"><strong>�Ա�</strong></td>
        <td align="center" colspan=2 class=td_middle>&nbsp;</td>
        <td class=td_middle colspan=2 align="center"><strong>�μӹ���ʱ��</strong></td>
        <td align="center" colspan=3 class=td_middle>&nbsp;</td>
        <td class=td_middle colspan=2 align="center"><strong>����������</strong></td>
        <td  align="center" colspan=3 class=td_middle>&nbsp;</td>
        <td  align="center" colspan=5 class=td_middle>&nbsp;</td>
     </tr>
    <tr>
    <td  align="center" colspan=2 class=td_middle><strong>���֤��</strong></td>
    <td class=td_middle colspan=4 align="center">&nbsp;</td>
    <td  align="center" colspan=5 class=td_middle><strong>�ɷ�����</strong></td>
    <td class=td_middle colspan=10 align="center">&nbsp;</td>
    </tr>

    <tr>
        <td  align="center" class=td_middle rowspan=2><strong>�·�</strong></td>
        <td  align="center" class=td_middle colspan="13"><strong>ְ������������(Ԫ)</strong></td>
        <td  align="center" class=td_middle colspan="3"><strong>���˽�����ᱣ�շ���</strong></td>
        <td  align="center" class=td_middle colspan="3"><strong>��������</strong></td>
        <td  align="center" class=td_middle rowspan="2"><strong>ʵ�����</strong></td>
    </tr>
    <tr>
        <td align="center" class=td_middle><strong>������</strong></td>
        <td align="center" class=td_middle><strong>��������</strong></td>
        <td align="center" class=td_middle><strong>��λ����</strong></td>
        <td align="center" class=td_middle><strong>��Ŀ�������</strong></td>
        <td align="center" class=td_middle><strong>���乤��</strong></td>
        <td align="center" class=td_middle><strong>����</strong></td>
        <td align="center" class=td_middle><strong>ס������</strong></td>
        <td align="center" class=td_middle><strong>��ͨ����</strong></td>
        <td align="center" class=td_middle><strong>����</strong></td>
        <td align="center" class=td_middle><strong>����һ���Խ���</strong></td>
        <td align="center" class=td_middle><strong>ȡů��</strong></td>
        <td align="center" class=td_middle><strong>��������</strong></td>
        <td align="center" class=td_middle><strong>���ڷ�</strong></td>
        <td align="center" class=td_middle><strong>С��</strong></td>
        <td align="center" class=td_middle><strong>���ϱ���</strong></td>
        <td align="center" class=td_middle><strong>ҽ�Ʊ���</strong></td>
        <td align="center" class=td_middle><strong>ס��������</strong></td>
        <td align="center" class=td_middle><strong>���</strong></td>
        <td align="center" class=td_middle><strong>��������˰</strong></td>
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