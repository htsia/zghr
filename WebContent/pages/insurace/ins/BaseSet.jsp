<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.api.ActivePageAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %> 
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.common.Constants"%> 
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.user.pojo.vo.UserRptVO"%>
<%@ page import="com.hr319wg.user.ucc.impl.UserReportUCC"%>
<%@ page import="javax.faces.model.SelectItem"%>
<%@ page import="java.util.*"%>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
	String orgId = request.getParameter("orgId");
	String search = request.getParameter("search");
    String rowNum = CommonFuns.filterNull(request.getParameter("rowNum"));
	String pageNum = CommonFuns.filterNull(request.getParameter("pageNum2"));
	if("".equals(pageNum)){
		pageNum = "1";
	}
    if("".equals(rowNum)){
        rowNum = String.valueOf(Constants.ACTIVE_PAGE_SIZE);
    }
%>

<%
	 ActivePageAPI api = (ActivePageAPI) SysContext.getBean("sys_activePageApi"); 

	 //基本信息
	 String activeSql="select id,A001001,A001007,A001054,A001701,A001239,A001705 from a001 ";
	 
     TableVO table = new TableVO();        
	 String[] columns = {"A001001","A001007","A001054","A001701","A001239","A001705"};
	 if(orgId!=null){
		String sql = "select b001002 from b001 where orguid="+orgId;
		int result = api.queryForInt(sql);
		if(result != -1){
			activeSql += " where A001701= '"+orgId+"' or A001239 = '"+orgId+"' or A001705= '"+orgId+"' or A001704= '"+orgId+"' or A001703= '"+orgId+"'";
		}
	 }
	 if(search!=null){
		activeSql += " where a001001 like '%"+search+"%' or A001735 like '%"+search+"%'";
	 }
	 CellVO[] col=new CellVO[columns.length+1];
	 col[0] = new CellVO();
     col[0].setItemId("id"); 
     col[0].setItemName("员工编号"); 
	 
	 for(int i=0;i<columns.length;i++){
		col[i+1]=new CellVO();
		InfoItemBO item=SysCacheTool.findInfoItem(columns[i].substring(0,4),columns[i]); 
		CommonFuns.copyProperties(col[i+1],item);		 
	 }	 	 
	 
	 table.setHeader(col); 
     
     api.querySql(table, activeSql, null,  Integer.valueOf(pageNum), Integer.valueOf(rowNum), true);
     session.setAttribute("ShowTable2", table); 
	 session.setAttribute(Constants.OBJECT2, table); 
     session.setAttribute("activeSql2", activeSql); 
     session.setAttribute("pageNum2", String.valueOf(pageNum)); 
     session.setAttribute("rowNum2", String.valueOf(rowNum)); 

	 List<SelectItem> list = null;
	 User user = (User) session.getAttribute(Constants.USER_INFO);
	 try {		
		UserReportUCC upt = (UserReportUCC)SysContext.getBean("user_userReportUccImpl");
		list = upt.queryUserRptToWeb(user.getUserId(), "0311", UserRptVO.TYPE_ROSTER);
		if (list == null)
			list = new ArrayList();
	 } catch (Exception e) {
		list = new ArrayList();
	 }       	 
%>
<script type="text/javascript">
	function forView(form, id, type){
		var arg = "id=" + id;
        window.open("/pages/insurace/base/PersonInfoFrame.jsp?" + arg, null, "left="+screen.width*0.05+",top="+screen.height*0.01+",height="+screen.height*0.9+",width="+screen.width*0.9+",status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
        window.status = "";
	}
    function changeInfo(){
        if (checkMutilSelect(form1.chk)) {
            count = form1.chk.length;
            var perID = "";
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        perID = form1.chk[i].value;   // 取第一个
                        break;
                    }
            } else
                perID = form1.chk.value;
            var url="/employee/info/ChangeInfo.jsf?FieldList=A001001,A001077,A754001,A754005&ID="+perID;
            window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
			location.reload();
        } else {
            alert("请选择人员");
            return false;
        }
        return false;
    }

    function forUploadFile() {
        var arg = "moduleid=BXGL"
        reval = window.showModalDialog("/employee/import/PerDataUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        if (reval != null) {
            return true;
        } else {
            return false;
        }
    }
    function forEdit(form, id, right) {
        var arg = "id=" + id;
        window.open("/pages/insurace/base/PersonInfoFrame.jsp?" + arg, null, "left="+screen.width*0.05+",top="+screen.height*0.01+",height="+screen.height*0.9+",width="+screen.width*0.9+",status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
        window.status = "";
    }
    function forMutilEdit() {
        var frm = document.forms(0);
        if (checkMutilSelect(frm.chk)) {
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;
            windowOpen("", "plist", "", "900", "600", "no", "10", "0", "yes");

            var obj = document.forms(0).chk ;
            var ids = "";
            if (obj.length == null) {
                ids = obj.value + ",";
            } else {
                for (i = 0; i < obj.length; i++) {
                    if (obj[i].checked) {
                        ids += obj[i].value + ",";
                    }
                }
            }
            ids = ids.substr(0, ids.length - 1);
            document.forms(1).idStr.value = ids;
            document.forms(1).target = "plist";
            document.forms(1).method = "post";
            document.forms(1).action = "/pages/wage/base/PersonInfoFrame.jsf";
            document.forms(1).submit();
            document.forms(1).target = "_self";
        } else {
            alert("请选择人员");
            return false;
        }
    }

    function forExport() {
        window.open('/pages/common/ExportToExcel.jsp?sessionKey=<%=Constants.OBJECT%>');
        return null;
    }
	function search1(){
		var searchStr = document.getElementById("search").value;
		if(searchStr == null || searchStr == ""){
			alert("请输入查询内容");
		}else{
			location.href="BaseSet.jsf?search="+searchStr;
		}
	}
</script>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>

<h:form id="form1">
    <c:verbatim>
    <table height=98%  width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=8 class="td_title">
    </c:verbatim>
	<c:verbatim>
		<input class="button01" type="button" value="基本信息变更" onclick="changeInfo()" />
		<input class="button01" type="button" value="数据导入" onclick="return forUploadFile()" />
		<input class="button01" type="button" value="批量维护" onclick="return forMutilEdit()" />
		<input class="button01" type="button" value="导出到excel"/>
		姓名或员工编号：<input id="search" type="text" />
		<input class="button01" type="button" value="查询" onclick="search1();"/>
	</c:verbatim>
<c:verbatim>
		
    </td></tr>

    <tr><td>
			<jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
				  <jsp:param name="hasOperSign" value="true"/>
				  <jsp:param name="operSignType" value="checkbox"/>
				  <jsp:param name="hasEdit" value="true"/>
				  
				  <jsp:param name="isEditList" value="false"/>
				  <jsp:param name="isCheckRight" value="false"/>
				  <jsp:param name="isForward" value="true"/>
				  <jsp:param name="rowFuncName" value="forView"/>
				  <jsp:param name="isPage" value="true"/>
				  <jsp:param name="keyName" value="id"/>
			</jsp:include>
    </td></tr>
    </table>
</c:verbatim>           
</h:form>
<form id="form2">
    <input type="hidden" name="idStr"/>
</form>
