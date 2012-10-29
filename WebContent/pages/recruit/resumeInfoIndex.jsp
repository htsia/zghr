<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>

<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/recruit/resumePlanInfoList.jsf?superId=" + orgId;
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
        function forChange() {
            if (document.getElementById("form1:mType").value == "2") {
            	document.getElementById("showTree").style.display="none";
            	document.getElementById("img").style.display="none";
            	document.main.location.href = "/recruit/allRegisterResume.jsf";
            } else {
            	document.getElementById("showTree").style.display="block";
            	document.getElementById("img").style.display="block";
            	document.main.location.href = "/recruit/resumePlanInfoList.jsf";
            }
        }
    </script>
<x:saveState value="#{recu_outterRecruitBB}"></x:saveState>
<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> ��Ƹ���� ->�������&nbsp;&nbsp;&nbsp;&nbsp;�����ʽ��
            </c:verbatim>
                <h:selectOneMenu id="mType" onchange="forChange()">
                    <c:selectItem itemLabel="�ƻ���λ" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="������" itemValue="2"></c:selectItem>
                </h:selectOneMenu>
    		<c:verbatim>
            </td>
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
            <td width="10" class="ctrlbar" valign="middle" id="img">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            <td align="center" valign="top" >
             <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/recruit/resumePlanInfoList.jsf"></iframe>
           </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>


