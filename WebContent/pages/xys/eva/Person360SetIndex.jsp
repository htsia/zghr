<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    User user=(User)session.getAttribute(Constants.USER_INFO);
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.all('form1:superId').value=orgId;
            var planId=document.all('form1:planId').value;
            document.main.location.href = "/xys/eva/Person360SetList.jsf?f&superId="+orgId
                    +"&planId="+planId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
        function showProcessBar() {
       	    x = document.body.clientWidth / 2 - 150;
       	    y = document.body.clientHeight / 2;
       	    document.all('processbar').style.top = y;
       	    document.all('processbar').style.left = x;
       	    document.all('processbar').style.display = "";
       	 }
        function addPost(){
            var planId=document.all('form1:planId').value;
            var returnValue=window.showModalDialog("/xys/eva/SelPostIndex.jsf?planId="+planId, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
            if(returnValue!=null){
            	idNames=returnValue.split("|");
                document.all('form1:postIds').value=idNames[0];
            }
            return true;
        }
    </script>

<x:saveState value="#{xys_360SetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="initIndex" value="#{xys_360SetBB.initIndex}"/>
    <h:inputHidden id="superId" value="#{xys_360SetBB.superId}"/>
    <h:inputHidden id="planId" value="#{xys_360SetBB.planId}"/>
    <h:inputHidden id="postIds" value="#{xys_360SetBB.postIds}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 绩效管理 ->360考核设置 &nbsp;&nbsp;&nbsp;&nbsp;
           </td>
            <td class="td_title" align="center">
                 &nbsp;&nbsp;&nbsp;&nbsp;
                 </c:verbatim>
                     <h:commandButton styleClass="button01" action="#{xys_360SetBB.loadPost}" value="加载考核岗位" onclick="showProcessBar();"/>
                 <c:verbatim>
                 &nbsp;&nbsp;&nbsp;&nbsp;
                 </c:verbatim>
                     <h:commandButton styleClass="button01" action="#{xys_360SetBB.addPost}" value="增加考核岗位" onclick="return addPost();"/>
                 <c:verbatim>
           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
           </td>

           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/xys/eva/Person360SetList.jsf?act=init"></iframe>
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
              </tr>
          </table>
      </marquee>
    </c:verbatim>
</h:form>
