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
            document.main.location.href = "/xys/eva/caclEvaObj.jsf?superId="+orgId
                    +"&planId="+planId+"&showMode="+document.all("form1:showMode").value;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
        function showProcessBar() {
       	    x = document.body.clientWidth / 2 - 150;
       	    y = document.body.clientHeight / 2;
       	    document.all('processbar').style.top = y;
       	    document.all('processbar').style.left = x;
       	    document.all('processbar').style.display = "";
       	 }
        function exportobj(){
        	window.open("/pages/xys/eva/EvaObjExport.jsp?planId="+document.all("form1:planId").value);
        }
        function uploadGrade(){
            var planId=document.all('form1:planId').value;
            window.showModalDialog("/xys/eva/EvaGradeUpLoad.jsf?planId="+planId, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{xys_evaPlanCaclBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="initIndex" value="#{xys_evaPlanCaclBB.initEvaObjIndex}"/>
    <h:inputHidden id="superId" value="#{xys_evaPlanCaclBB.superId}"/>
    <h:inputHidden id="planId" value="#{xys_evaPlanCaclBB.planId}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                         绩效管理 ->综合计算&nbsp;&nbsp;&nbsp;&nbsp;浏览模式：
            </c:verbatim>
            		 <h:selectOneMenu id="showMode" value="#{xys_evaPlanCaclBB.showMode}" onchange="submit();" valueChangeListener="#{xys_evaPlanCaclBB.changMode}">
            		 	<c:selectItem itemLabel="自然分布" itemValue="1"/>
            		 	<c:selectItem itemLabel="强制分布" itemValue="2"/>
            		 </h:selectOneMenu>
            <c:verbatim>            
           </td>
           <td class="td_title" >
                 </c:verbatim>
                     <h:commandButton styleClass="button01" rendered="#{xys_evaPlanCaclBB.showMode=='1'&&xys_evaPlanCaclBB.deptDesabled=='0'}" action="#{xys_evaPlanCaclBB.caclEvaObj}" value="计算" onclick="showProcessBar();"/>
                     <h:outputText value=" "></h:outputText>
                     <h:commandButton styleClass="button01" rendered="#{xys_evaPlanCaclBB.showMode=='2'&&xys_evaPlanCaclBB.deptDesabled=='0'}" action="#{xys_evaPlanCaclBB.caclEvaObj2}" value="强制分布计算" onclick="showProcessBar();"/>
                     <h:outputText value=" "></h:outputText>
                     <h:commandButton value=" 导出Excel"  styleClass="button01"  onclick="exportobj();"  type="button"></h:commandButton>
                     <h:outputText value=" "></h:outputText>
                     <h:commandButton styleClass="button01"  value="导入考核等级" onclick="uploadGrade();"/>
                 <c:verbatim>
           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
           </td>

           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                            <iframe name="main" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src='/xys/eva/caclEvaObj.jsf?showMode=</c:verbatim><h:outputText value="#{xys_evaPlanCaclBB.showMode}"/><c:verbatim>'></iframe>
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
