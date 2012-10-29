<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.train.ucc.IeLearnUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    User user = (User) session.getAttribute(Constants.USER_INFO);
%>
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
<script type="text/javascript">
    function refreshList(keyID) {
        var src="/eLearn/LearnInfo.jsf";
        if (keyID=='02'){
            src='/eLearn/studyList.jsf';
        }
        else if (keyID=='03'){
            src='/eLearn/testList.jsf';
        }
        document.main.location.href = src;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 60;
        document.getElementById("showTree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
</script>
 <c:verbatim>
<table width=98% border="0" cellpadding="0" cellspacing="0" background="/images/maininterface/hd_top.jpg" style="backgroud:#1F93B8" align="center">
    <tr>
        <td width=260 height=62 background="/images/maininterface/logo.jpg"></td>

        <td width=279 align="left" height=62 ></td>

        <td align="right">
            <%=user.getName()%>�����ã� ��ӭ��¼<% out.println(Constants.ELERRN_NAME);%>&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
 </table>
 </c:verbatim>
 <c:verbatim>
     <table width=98% border="0" cellpadding="0" cellspacing="0" align="center">

        <tr>
         <td width="200" id="showTree" valign="top">
             <table height=200 border=0   cellspacing=0 cellpadding=0 width="100%">
                 <tr>
                     <td height="25" align="left" colspan="3"><img src="/images/maininterface/menu/backperson.gif"  align="absmiddle"> <strong>ѧԱ��Ϣ</strong></td>
                 </tr>

                   <tr>
                     <td width="5"><img src="/images/maininterface/hd_main_65.gif" width="5" height="5"></td>
                     <td background="/images/maininterface/hd_main_66.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                     <td width="5"><img src="/images/maininterface/hd_main_69.gif" width="5" height="5"></td>
                   </tr>

                   <tr>
                   <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                   <td height="200px" valign="top">

    </c:verbatim>
                        <h:outputText escape="false" value="&nbsp;&nbsp;<strong>����:</strong>#{eLearn_learnInfoBB.myAddress.name}<br>"></h:outputText>
                                <h:outputText escape="false" value="&nbsp;&nbsp;<strong>���ڵ�λ:</strong><br>"></h:outputText>
                                <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;#{eLearn_learnInfoBB.myAddress.orgName}<br>"></h:outputText>
                                <h:outputText escape="false" value="&nbsp;&nbsp;<strong>���ڲ���:</strong><br>"></h:outputText>
                                <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;#{eLearn_learnInfoBB.myAddress.deptName}<br>"></h:outputText>
                                 <h:outputText escape="false" value="&nbsp;&nbsp;<strong>���ڸ�λ:</strong><br>"></h:outputText>
                                <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;#{eLearn_learnInfoBB.myAddress.postName}<br>"></h:outputText>
                                <h:outputText escape="false" value="&nbsp;&nbsp;<strong>���֤��:</strong><br>"></h:outputText>
                                <h:outputText escape="false" value="&nbsp;&nbsp;<strong>�칫�绰:</strong>#{eLearn_learnInfoBB.myAddress.officeTel}<br>"></h:outputText>
                                <h:outputText escape="false" value="&nbsp;&nbsp;<strong>eMail:</strong>#{eLearn_learnInfoBB.myAddress.email}<br>"></h:outputText>
    <c:verbatim>

                    </td>
                      <td background="/images/maininterface/hd_main_72.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                    </tr>

                   <tr>
                  <td><img src="/images/maininterface/hd_main_80.gif" width="5" height="5"></td>
                  <td background="/images/maininterface/hd_main_81.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                  <td><img src="/images/maininterface/hd_main_82.gif" width="5" height="5"></td>
                </tr>
              </table>

              <table height=200 border=0   cellspacing=0 cellpadding=0 width="200">
                 <tr>
                 <td height="25" align="left" colspan="3"><img src="/images/maininterface/menu/status.gif"  align="absmiddle"> <strong>���ܲ���</strong></td>
                 </tr>

                  <tr>
                    <td width="5"><img src="/images/maininterface/hd_main_65.gif" width="5" height="5"></td>
                    <td background="/images/maininterface/hd_main_66.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                    <td width="5"><img src="/images/maininterface/hd_main_69.gif" width="5" height="5"></td>
                  </tr>

                  <tr>
                   <td background="/images/maininterface/hd_main_70.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>

                   <td height="200px" valign="top">
</c:verbatim>
                       <h:outputText value="����ѡ����Ҫ�Ĺ��ܣ�"></h:outputText>
<c:verbatim>
                       <div id="tt"></div>
                    </td>
                    <td background="/images/maininterface/hd_main_72.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
                    </tr>

                  <tr>
<td><img src="/images/maininterface/hd_main_80.gif" width="5" height="5"></td>
<td background="/images/maininterface/hd_main_81.gif"><img src="/images/maininterface/hd_spacer.gif" width="1" height="1"></td>
<td><img src="/images/maininterface/hd_main_82.gif" width="5" height="5"></td>
</tr>
              </table>

        </td>

        <td width="5"></td>
        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
        </td>
        <td width="5"></td>

        <td align="center" valign="top">
             <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%" src="/eLearn/LearnInfo.jsf"></iframe>
        </td>

        </tr>
    </table>
</c:verbatim>

<script language="javascript">
    //��������ͼƬ����
    var images = getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, tt);
    var root = tree.root;
    var nNode01 = tree.add(root, 'last', '��ҳ', "n01", '01', '', 'book_open', '', '');
    var nNode02 = tree.add(root, 'last', '����ѧϰ', "n02", '02', '', 'book_open', '', '');
    var nNode03 = tree.add(root, 'last', '���߿���', "n03", '03', '', 'book_open', '', '');
    tree.onclick = function(srcNode) {
        refreshList(srcNode.key2);
    }
</script>
