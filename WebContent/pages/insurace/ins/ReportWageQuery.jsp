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
<%@ page import="java.util.*"%>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
	String orgId = request.getParameter("orgId");
	String time = request.getParameter("time");
	String iscalc = request.getParameter("iscalc");
	String islock = request.getParameter("islock");
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
	 //检查是否为机构根节点
	 ActivePageAPI api = (ActivePageAPI) SysContext.getBean("sys_activePageApi"); 
	 if("1".equals(iscalc)){
		api.executeSql("BEGIN proc_add_paybaseinfo; END;");
		out.print("<script>location.href='ReportWageQuery.jsf'</script>");
	 }
	 
	 //最后发薪时间
	 String activeSql ="select substr(a815701,1,7) from ( select a815701 from a815 order by a815701 desc) where rownum=1";
     String lastwagetime=api.queryForString(activeSql);
	 if(time == null){		 
		 //全部查询
		 activeSql = "select * from a200 where a200210 like '"+lastwagetime+"%' order by cast(subid as int)";
		 if(orgId != null){
			//按部门查询
			 String sql = "select b001002 from b001 where orguid="+orgId;
			 int result = api.queryForInt(sql);
			 if(result != -1){
				activeSql = "select a1.* from a200 a1,a001 a where a.A001735=a1.A200220 and (a.A001701= '"+orgId+"' or A001239 = '"+orgId+"' or A001705= '"+orgId+"' or A001704= '"+orgId+"' or A001703= '"+orgId+"') and a1.a200210 like '"+lastwagetime+"%' order by cast(subid as int)";
			 } 
		 }
	 }else{//按时间查询
		activeSql = "select * from a200 where a200210 = '"+time+"' order by cast(subid as int)";
	 }
	 //检查是否锁定
     String statusSql = "select count(*) from a200 where A200221 =1 and a200210 like '"+lastwagetime+"%'";
	 String datastatus = api.queryForString(statusSql);
     //是否锁定数据
	 if("1".equals(islock)){
		String lockSql = "update a200 set A200221 =1 where a200210 like '"+lastwagetime+"%'";
		api.executeSql(lockSql);
		datastatus = "1";
	 }
     TableVO table = new TableVO();        
	 
	 ArrayList items=SysCacheTool.queryInfoItemBySetId("A200"); 
     for(int i=0;i<items.size();i++){
		 String status = ((InfoItemBO)items.get(i)).getItemStatus();
		 if("0".equals(status)){
			items.remove(i);
		 }
	 }
	 CellVO[] col=new CellVO[items.size()+1]; 
	 col[0] = new CellVO();
     col[0].setItemId("subid"); 
     col[0].setItemName("序号"); 
	 
	 for(int i=0;i<items.size();i++){
		col[i+1]=new CellVO();
		CommonFuns.copyProperties(col[i+1],items.get(i));		 	 
	 }              
	 table.setHeader(col); 
     
     api.querySql(table, activeSql, null,  Integer.valueOf(pageNum), Integer.valueOf(rowNum), true);
     session.setAttribute("ShowTable2", table); 
	 session.setAttribute(Constants.OBJECT2, table); 
     session.setAttribute("activeSql2", activeSql); 
     session.setAttribute("pageNum2", String.valueOf(pageNum)); 
     session.setAttribute("rowNum2", String.valueOf(rowNum)); 
%>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
<script type="text/javascript">
    function forView(form, id, type) {
       
    }
	function search() {
       var time = document.getElementById("form1:inputDate").value;
	   if(time==null || time == ""){
			alert("请输入查询时间");
	   }else{
			location.href="ReportWageQuery.jsf?time="+time;
	   }
    }
</script>

<form>
     <table height=98%  width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=8 class="td_title">
			    <input class="button01" type="button" value="拆分缴费基数" onclick="splitpayinfo();" />
				<input class="button01" type="button" value="锁定数据" onclick="clock();" />
				<input class="button01" type="button" value="导出Excel" onclick="ExportShowTable();" />
				查询时间：
				<input id="form1:inputDate" name="form1:inputDate" type="text" value="" readonly="readonly" /><input id="form1:_id14" name="form1:_id14" type="button" onclick="PopUpCalendar_OnlyMonth('form1:inputDate');" class="button_select" />
				<input class="button01" type="button" value="查询" onclick="search();" />
			</td>
        </tr>
        <tr>
            <td>
                <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
                      <jsp:param name="hasOperSign" value="false"/>
                      <jsp:param name="operSignType" value="checkbox"/>
                      <jsp:param name="hasEdit" value="true"/>
                      <jsp:param name="isEditList" value="false"/>
                      <jsp:param name="isCheckRight" value="false"/>
                      <jsp:param name="isForward" value="true"/>
                      <jsp:param name="isRow" value="true"/>
                      <jsp:param name="rowFuncName" value="forView"/>
                      <jsp:param name="isPage" value="true"/>
                      <jsp:param name="keyName" value="subid"/>
                </jsp:include>
            </td>
        </tr>
    </table>
</form>
