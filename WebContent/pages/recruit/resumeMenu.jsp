<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<link href="../css/style1.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
    body {
        padding: 0;
        margin: 0;
    }

    .STYLE1 {
        color: #FFFFFF
    }
</style>

<script language="javascript"
        src="<%=request.getContextPath()%>/js/maininterface.js"></script>
<script language="javascript"
        src="<%=request.getContextPath()%>/js/index.js"></script>
<script language="javascript">
    function showsubmenu(sid) {
        whichEl = eval("submenu" + sid);
        imgmenu = eval("imgmenu" + sid);
        if (whichEl.style.display == "none") {
            eval("submenu" + sid + ".style.display=\"\";");
            imgmenu.background = "/images/maininterface/hd_main_47.gif";
        }
        else {
            eval("submenu" + sid + ".style.display=\"none\";");
            imgmenu.background = "/images/maininterface/hd_main_48.gif";
        }
    }

    function hide() {
        A = document.getElementById('hide').style.display
        if (A == "none") {
            document.getElementById('hide').style.display = "block"
            document.getElementById('frameshow').src = "/images/button_1.gif";
        }
        if (A == "block") {
            document.getElementById('hide').style.display = "none"
            document.getElementById('frameshow').src = "/images/button_2.gif";
        }
    }
    function parentclick(id) {
        alert(id);
        parent.refreshList(id);
    }
    function changePage(page) {
        parent.main.location.href = page;
    }
</script>
<h:form id="form1">
<f:verbatim>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td height="23" background="/images/maininterface/hd_main_47.gif"
        id="imgmenu2" onmouseover="this.className='menu_title2';"
        onclick="showsubmenu(2)" onmouseout="this.className='menu_title';"
        style="cursor: hand">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="18%">&nbsp;</td>
                <td width="82%" align="left" class="STYLE1">简历信息</td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td background="/images/maininterface/hd_main_51.gif" id="submenu2">
        <div class="sec_menu">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table width="90%" border="0" align="center" cellpadding="0"
                               cellspacing="0">
                            <tr>
                                <td width="16%" height="23" align="center"><img
                                        src="/images/maininterface/menu/remind.gif" width="13"
                                        height="13" alt=""/></td>
                                <td width="84%" height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeManageBase.jsf')"><span
                                                    class="STYLE3">基础信息</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="23" align="center"><img
                                        src="/images/maininterface/menu/zhicheng.gif" width="13"
                                        height="13"/></td>
                                <td height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeManageEdu.jsf')"><span
                                                    class="STYLE3">受教育情况</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="23" align="center"><img
                                        src="/images/maininterface/menu/log.gif" width="13" height="13"/></td>
                                <td height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeMgrWork.jsf')"><span
                                                    class="STYLE3">工作经历</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td width="16%" height="23" align="center"><img
                                        src="/images/maininterface/menu/InfoManage.gif" width="13"
                                        height="13"/></td>
                                <td width="84%" height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeMgrLanguage.jsf');"
                                                    ><span
                                                    class="STYLE3">语言能力</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="16%" height="23" align="center"><img
                                        src="/images/maininterface/menu/InfoManage.gif" width="13"
                                        height="13"/></td>
                                <td width="84%" height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeMgrComputer.jsf');"
                                                    ><span
                                                    class="STYLE3">计算机能力</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="16%" height="23" align="center"><img
                                        src="/images/maininterface/menu/InfoManage.gif" width="13"
                                        height="13"/></td>
                                <td width="84%" height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeMgrLetter.jsf');"
                                                    ><span
                                                    class="STYLE3">专业技术资格</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="16%" height="23" align="center"><img
                                        src="/images/maininterface/menu/InfoManage.gif" width="13"
                                        height="13"/></td>
                                <td width="84%" height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeMgrA837.jsf');"
                                                    ><span
                                                    class="STYLE3">科研论文情况</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="16%" height="23" align="center"><img
                                        src="/images/maininterface/menu/InfoManage.gif" width="13"
                                        height="13"/></td>
                                <td width="84%" height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeMgrA838.jsf');"
                                                    ><span
                                                    class="STYLE3">参与课题情况</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="16%" height="23" align="center"><img
                                        src="/images/maininterface/menu/InfoManage.gif" width="13"
                                        height="13"/></td>
                                <td width="84%" height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeMgrA836.jsf');"
                                                    ><span
                                                    class="STYLE3">成果奖励（含科研成果）</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="16%" height="23" align="center"><img
                                        src="/images/maininterface/menu/InfoManage.gif" width="13"
                                        height="13"/></td>
                                <td width="84%" height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="20" style="cursor: hand"
                                                onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
                                                onmouseout="this.style.borderStyle='none'"><a href="#"
                                                                                              onclick="changePage('/recruit/resume/resumeMgrBook.jsf');"
                                                    ><span
                                                    class="STYLE3">证书及相关材料</span></a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td height="5"><img src="/images/maininterface/hd_main_52.gif" width="151" height="5"/></td>
                </tr>
            </table>
        </div>
    </td>

</tr>
</table>


</f:verbatim>

</h:form>