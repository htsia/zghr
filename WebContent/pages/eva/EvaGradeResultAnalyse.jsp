<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>

<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/eva/GradeResultAnalyse.jsf?gradeId="+document.all("form1:gradeId").value+"&planID="+document.all("form1:planId").value+"&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 34;
            
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
            document.getElementById("tree").src="/pages/common/ShowOrgTree.jsp?rootId="+document.all("form1:planOrgId").value;
        }

        function beginInput(){
        	
            var url="/eva/GradeResultAnalyse.jsf";
            document.all('main').src=url;
           
        }
    </script>
<x:saveState value="#{eva_gradeResultAnalyseBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="planId" value="#{eva_gradeResultAnalyseBB.planID}"></h:inputHidden>
<h:inputHidden id="gradeId" value="#{eva_gradeResultAnalyseBB.gradeID}"></h:inputHidden>
<h:inputHidden id="planOrgId" value="#{eva_gradeResultAnalyseBB.planOrgId}"></h:inputHidden>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 绩效管理 -> 量表层次分析</td>
        </tr>
    </table>
     </c:verbatim>
  <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            <td align="center" valign="top">
             <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/eva/GradeResultAnalyse.jsf"></iframe>
           </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>


