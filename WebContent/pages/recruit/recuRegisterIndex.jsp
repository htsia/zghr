<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>

<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/recruit/recuRegisterPlanList.jsf?superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 34;            
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";         
        }
        function beginInput(){      	
            var url="/recruit/resumePlanInfoList.jsf";
            document.all('main').src=url;          
        }
    </script>
<x:saveState value="#{recu_registerManageBB}"></x:saveState>
<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 招聘管理 ->报道处理</td>
        </tr>
    </table>
     </c:verbatim>
  <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                               src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            <td align="center" valign="top">
             <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/recruit/recuRegisterPlanList.jsf"></iframe>
           </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>


