<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
</script>
<c:verbatim>
<style type="text/css">
<!--
.style1
{
    font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border:2px solid #555555;
}
.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "ËÎÌו";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style1 TR {
	FONT-SIZE: 9pt; COLOR: #555555;
	border:1px solid #555555;
}
.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	vertical-align:middle;
	font-family: "ËÎÌו";
	border:1px solid #555555;
}
-->
</style>
</c:verbatim>

<x:saveState value="#{post_PostNoteBB}" />
<h:form id="form1">
	<h:inputHidden value="#{post_PostNoteBB.pageInit}" />
	<h:inputHidden id = "personId" value="#{post_PostNoteBB.postId}"/>

    <f:verbatim>
        <table width="98%" height="100%" align="center" cellpadding="0" cellspacing="0" >
         <tr><td height=8></td></tr>
         <tr>
             <td colspan="3" valign="top" align="left">
             <div width="620" style="red;height:100%;" id=datatable>
                <br>
                <jsp:include page="/pages/doc/PostBookShow.jsp" >
                        <jsp:param name="Init" value="true"/>
                </jsp:include>
             </div>
             </td>
          </tr>
        </table>
    </f:verbatim>
</h:form>


