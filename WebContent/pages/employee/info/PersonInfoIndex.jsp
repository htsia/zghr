<%@page import="com.hr319wg.sys.pojo.bo.ParameterBO"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.dao.ParameterDAO"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.sys.cache.SysCache"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
    String rootid = user.getOrgId();
    
    String loaddata="0";
    String checked="";
    ParameterDAO dao = (ParameterDAO) SysContext.getBean("sys_parameterDAO");
    ParameterBO bo = dao.getParameter("EMP_DATA_LOAD");
    if(bo!=null && "1".equals(bo.getValue())){
    	loaddata="1";
    }
    bo = dao.getParameter("EMP_ORG_FILTER_CHECKED");
    if(bo!=null && "1".equals(bo.getValue())){
    	checked="1";
    }
    
%>
<c:verbatim>
    <script type="text/javascript">
        function refreshList(orgId) {
	        var orgFilter="0";
	        if(document.getElementById('orgFilter').checked){
	     	   orgFilter="1";
	     	   document.main.disPlayProcessBar();
	        }
	        if (document.getElementById("form1:displayMode").value=="2"){
	            document.main.location.href = "/employee/info/PersonInfoPhotoQuery.jsf?act=init&superId=" + orgId+"&orgFilter="+orgFilter+"&orgMode="+document.getElementById("form1:orgMode").value;
	        }
	        else{
	             document.main.location.href = "/employee/info/PersonInfoQuery.jsf?act=init&superId=" + orgId+"&orgFilter="+orgFilter+"&orgMode="+document.getElementById("form1:orgMode").value;
	        }
        }
        function forChange() {
            if (document.getElementById("form1:orgMode").value == "1") {
                document.tree.location.href = "/pages/common/ShowOrgTree.jsp";
            }else{
                document.tree.location.href = "/pages/common/ShowOrgTeamTree.jsp";
            }
        }
        function orgFilter2(){
             refreshList('-1');
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }

    </script>
</c:verbatim>

<h:form id="form1">
    <f:verbatim>
    <table  width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
              人员信息管理 ->
              <%=LanguageSupport.getResource("RYGL-0311","信息维护")%>   
              &nbsp;&nbsp;&nbsp;&nbsp;  
              <%=LanguageSupport.getResource("RYGL-1000","浏览方式：")%>   
    </f:verbatim>
                <h:selectOneMenu id="orgMode" onchange="forChange()">
                    <c:selectItems value="#{emp_personListBB2.orgBrowModeList}"></c:selectItems>
                </h:selectOneMenu>
    <f:verbatim>
                &nbsp;&nbsp;&nbsp;&nbsp;
                显示方式:
    </f:verbatim>
                <h:selectOneMenu id="displayMode">
                    <c:selectItem itemLabel="列表" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="照片" itemValue="2"></c:selectItem>
                </h:selectOneMenu>
    <f:verbatim>
             </td>
        </tr>
    </table>

    <table width="100%" border="0"  height="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210" height="100%" valign="top">
            	<div style="margin:5px 0 0 5px;color:blue;">
            	  <input id="orgFilter" type="checkbox" <%="1".equals(checked)?"checked":"" %> onclick="orgFilter2();"/>选择机构时调入员工信息            	
            	</div>
                  <iframe name="tree" height="400"  frameborder="0"  height="100%" scrolling="auto" width="100%"
                                    src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
            </td>

            <td align="center" valign="top" height="100%">
                 <iframe name="main" height="100%"  frameborder="0"  height="100%" scrolling="no" width="100%"
                     src="/employee/info/PersonInfoQuery.jsf?act=init&superId=<%=user.getOrgId()%>&loaddata=<%=loaddata%>&orgFilter=<%=checked%>"></iframe>
            </td>
        </tr>
    </table>
    </f:verbatim>    
</h:form>
