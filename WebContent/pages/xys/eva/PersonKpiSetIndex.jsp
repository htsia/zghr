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
            document.main.location.href = "/xys/eva/PersonKpiSetList.jsf?f&superId="+orgId
                    +"&planId="+planId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
        function uploadKeySet(){
            var planId=document.all('form1:planId').value;
            window.showModalDialog("/xys/eva/PersonKpiKeyUpLoad.jsf?planId="+planId, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
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

        function downLoad(){
            window.open("/pages/xys/file/xys_kpi_import_template.xls");
        }
        function showProcessBar() {
       	    x = document.body.clientWidth / 2 - 150;
       	    y = document.body.clientHeight / 2;
       	    document.all('processbar').style.top = y;
       	    document.all('processbar').style.left = x;
       	    document.all('processbar').style.display = "";
       	 }
    </script>

<x:saveState value="#{xys_KpiPersonSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="initIndex" value="#{xys_KpiPersonSetBB.initIndex}"/>
    <h:inputHidden id="superId" value="#{xys_KpiPersonSetBB.superId}"/>
    <h:inputHidden id="planId" value="#{xys_KpiPersonSetBB.planId}"/>
    <h:inputHidden id="postIds" value="#{xys_KpiPersonSetBB.postIds}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 绩效管理 ->个人KPI考核设置 &nbsp;&nbsp;&nbsp;&nbsp;
           </td>
           <td class="td_title" align="left">
            	</c:verbatim>
                     <h:commandButton styleClass="button01" type="button" value="下载导入模版" onclick="downLoad();"/>
                 <c:verbatim>
                 &nbsp;&nbsp;
                 </c:verbatim>
                     <h:commandButton styleClass="button01" type="button" value="导入考核指标" onclick="uploadKeySet();"/>
                 <c:verbatim>
                 &nbsp;&nbsp;
                 </c:verbatim>
                     <h:commandButton styleClass="button01" action="#{xys_KpiPersonSetBB.addPost}" value="增加考核岗位" onclick="return addPost();"/>
                 <c:verbatim>
                 &nbsp;&nbsp;
                 </c:verbatim>
                     <h:commandButton styleClass="button01" action="#{xys_KpiPersonSetBB.loadPost}" value="加载考核岗位" onclick="showProcessBar();"/>
                 <c:verbatim>
           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
           </td>

           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/xys/eva/PersonKpiSetList.jsf"></iframe>
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
