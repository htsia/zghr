<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <c:verbatim>
    <script type="text/javascript">
    	function refreshList(personId) {
            document.main.location.href = "<%=Constants.LEAD_SHOW_PERSONURL%>?fk="+personId;
        }
        function refreshListOrg(orgId) {
            document.all("orgId").value=orgId;
        }

        with (window) onload = onresize = function(){
            var  mainHeight=document.body.offsetHeight-40;
            var treeHeight = mainHeight- 20;
            document.getElementById("tree").style.height = "" + treeHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
    </c:verbatim>

<h:form id="form1">
    <c:verbatim>
    <input name="orgId" type="hidden"/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="260">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td >姓名或员工编号:
                            <input type="text" name="input1Name" id="input1Name" class="input" onkeypress ="enterKeyDown('querybutton')">
                        </td>
                    </tr>

                    <tr>
                        <td class="td_title" align="right">
                            <input type="button" onclick="javascript:queryPerson();" class="button01" value=" 查询 " id="querybutton">
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                     src="/pages/doc/PersonTree.jsp?filterSQL=<%=request.getParameter("filterSQL")%>">
                            </iframe>
                        </td>
                    </tr>
                </table>
           </td>

           <td  width="10"  class="ctrlbar" valign="middle">
               <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
           </td>
            
            <td align="center" valign="top" >
                    <iframe name="main" height="100%"  frameborder="0" scrolling="yes" width="100%"
                                   src="<%=Constants.LEAD_SHOW_PERSONURL%>" />
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
    <script type="text/javascript">
        function queryPerson() {
        	var obj11 = document.all("input1Name");
        	var obj12 = document.all("orgId");
        	if (obj11.value==""){
                alert('请输入查询条件！');
                return false;
            }
            retval = window.showModalDialog("/doc/QueryPersonResult.jsf?filterSQL=<%=CommonFuns.filterNull(request.getParameter("filterSQL"))%>&orgId="+obj12.value+"&personName=" + obj11.value, "", "dialogWidth:800px; dialogHeight:600px; center:yes; status:1;");
            if(retval!=null){
			  document.tree.location.href = "/pages/doc/PersonTree.jsp?filterSQL=<%=com.hr319wg.util.CommonFuns.filterNull(request.getParameter("filterSQL"))%>&personId="+retval;
			  document.main.location.href = "/doc/PersonIndex.jsf?fk="+retval;
		    }
			else{
			 document.tree.location.href = "/pages/doc/PersonTree.jsp?filterSQL=<%=CommonFuns.filterNull(request.getParameter("filterSQL"))%>&";
             }
        }
    </script>
