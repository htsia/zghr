<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ include file="../include/taglib.jsp" %>
<c:verbatim>
<script type="text/javascript">
    function refreshList(key){
      document.main.location.href = "/user/OperateRoleList.jsf?OperateID="+key;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 50;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>
</c:verbatim>
<h:form id="formCreditOperate">
<h:inputHidden id="pageInit" value="#{SYS_OPERATEBB.initBatchOperate}"/>
   <c:verbatim>
   <table width="100%" border="0" cellspacing="2" cellpadding="0">
    <tr>
        <td width="300">
            <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"
                              src="/pages/user/BatchOperateTree.jsp"></iframe>
        </td>

        <td valign="top">
            <iframe name="main" height="100%"  frameborder="0"  scrolling="no" width="100%"
                               src="/user/OperateRoleList.jsf"></iframe>
        </td>
    </tr>
    </table>
 </c:verbatim>
</h:form>
