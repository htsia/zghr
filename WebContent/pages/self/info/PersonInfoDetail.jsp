<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language=javascript src="/js/hashtable.js"></script>
    <script type="text/javascript">
        function forSavePhoto(){
            document.all('form1:savePhoto').click();
        }
        function ModiInfo(setid,kid) {
            window.showModalDialog("/self/info/ModifyInfo.jsf?setId="+setid+"&keyId="+kid, null, "dialogWidth:330px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:no;");
            return false;
        }
        function BatchModiInfo(setid,kid){
            window.showModalDialog("/self/info/BatchModifyInfo.jsf?setId="+setid+"&keyId="+kid, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:auto;");
            return false;
        }
        function showChkList(fk){
            window.showModalDialog("/self/info/ChkList.jsf?fk="+fk, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<x:saveState value="#{self_personEditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{self_personEditBB.table}"></h:inputHidden>
    <h:inputHidden value="#{self_personEditBB.personID}"></h:inputHidden>
    <h:commandButton id="savePhoto" action="#{self_personEditBB.savePhoto}" style="display:none;"></h:commandButton>
<c:verbatim>
<jsp:include page="/pages/self/info/ActiveDetail.jsp"></jsp:include>
</c:verbatim>

<script language=javascript>
    function selPost(idf, org) {
        obj = document.all(org);
        if (obj.value == null || obj.value == "") {
            alert("在选岗位时，部门不能为空");
            return;
        }
        var arg = parent.CSApp;
        fPopUpPostDlgByOrg(idf, obj.code, arg);
    }
    function selPostNo(idf) {
        var arg = parent.CSApp;
        fPopUpPostDlg(idf, arg);
    }
</script>
</h:form>
