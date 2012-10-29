<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>

<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/eva/EvaResultpublishList.jsf?planId='"+document.all("form1:planId").value+"'&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 34;            
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";         
        }
        function beginInput(){      	
            var url="/eva/EvaResultAuditList.jsf";
            document.all('main').src=url;          
        }
    </script>
<x:saveState value="#{eva_resultAnalyseBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="planId" value="#{eva_resultAnalyseBB.planID}"></h:inputHidden>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 绩效管理 -> 绩效考核结果发布</td>
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
                                   src="/eva/EvaResultpublishList.jsf"></iframe>
           </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>


