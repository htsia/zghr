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
	String searchtime = request.getParameter("searchtime");
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
	 
	 //最后发薪时间
	 String activeSql ="select substr(a815701,1,7) from ( select a815701 from a815 order by a815701 desc) where rownum=1";
     String lastwagetime=api.queryForString(activeSql);
	 activeSql = "select a.A001735,substr(w.A815701,1,7) wagetime,a.a001001,a.A001701,a.A001705,a.A001239,b.A754002,w.A815291,w.A815221,w.A815739,w.A815741,w.A815224 from a815 w left join a001 a on w.id=a.id left join a754 b on a.id=b.id where (b.A754010 ='00901' or b.A754015='00901' or b.A754025='00901' or A754030 ='00901' or b.A754035='00901') ";
	 if(searchtime == null){		 
		 //全部查询
		 activeSql += "and substr(w.A815701,1,7)='"+lastwagetime+"'";
		 if(orgId != null){
			//按部门查询
			 String sql = "select b001002 from b001 where orguid="+orgId;
			 int result = api.queryForInt(sql);
			 if(result != -1){
				activeSql += "and (a.A001701= '"+orgId+"' or A001239 = '"+orgId+"' or A001705= '"+orgId+"' or A001704= '"+orgId+"' or A001703= '"+orgId+"') and substr(w.A815701,1,7)='"+lastwagetime+"'";
			 }else{
				activeSql += "and substr(w.A815701,1,7)='"+lastwagetime+"'";
			 }
		 }
	 }else{//按时间查询
		activeSql += "and substr(w.A815701,1,7)='"+searchtime+"'";
	 }
     TableVO table = new TableVO();        
	 String[] columns = {"A001.A001001","A001.A001701","A001.A001239","A001.A001705","A754.A754002","A815.A815291","A815.A815221","A815.A815739","A815.A815741","A815.A815224"};
	 CellVO[] col=new CellVO[columns.length+2]; 
	 col[0] = new CellVO();
     col[0].setItemId("A001735"); 
     col[0].setItemName("员工编号"); 
     col[1] = new CellVO();
     col[1].setItemId("wagetime"); 
     col[1].setItemName("发薪时间"); 
	 
	 for(int i=0;i<columns.length;i++){
		col[i+2]=new CellVO();
		InfoItemBO item=SysCacheTool.findInfoItem(columns[i].substring(0,4),columns[i].substring(5)); 
		CommonFuns.copyProperties(col[i+2],item);		 
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
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
<script type="text/javascript">
    function forView(form, id, type) {
       
    }
	function search() {
       var searchtime = document.getElementById("form1:inputDate").value;
	   if(searchtime==null || searchtime == ""){
			alert("请输入查询时间");
	   }else{
			location.href="PayQuery.jsf?searchtime="+searchtime;
	   }
    }
	function showTable1(){
		var rptValue=document.all("rpt").value;
		if(rptValue!=-1){
			url="/pages/report/ServerReportShow.jsp?RptCode="+rptValue+"&ID="+<%=user.getUserId()%>;
			window.open(url);
		}
	}
</script>
<x:saveState value="#{wage_personQueryBB}"></x:saveState>
<c:verbatim>
<form>
     <table height=98%  width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=8 class="td_title">
				<select name="rpt">
				   
					<%
						for(SelectItem item : list){
							%>
							<option value=<%=item.getValue()%>><%=item.getLabel()%></option>
							<%
						 }
					%>
				</select>
				<input class="button01" type="button" value="导出表格" onclick="javascript:showTable1();" />
				查询时间：
				<input id="form1:inputDate" name="form1:inputDate" type="text" value="" readonly="readonly" /><input id="form1:_id14" name="form1:_id14" type="button" onclick="PopUpCalendar_OnlyMonth('form1:inputDate');" class="button_select" />
				<input class="button01" type="button" value="查询" onclick="search();" />
		
</c:verbatim>
			<h:outputText value="姓名或员工编号："/>

<c:verbatim>
			<input type="text" alt="姓名|0" name="form1:nameStr" onkeypress="enterKeyDown('form1:btnSearch')">
</c:verbatim>
			<h:commandButton id="btnSearch" styleClass="button01" value="查询"
							 action="#{wage_personQueryBB.queryPersonByName}" />
			<h:commandButton styleClass="button01" value="自定义查询"
							 onclick="return doAdvanceQuery('A','ORG','011','Y','TABLEOBJECT','','N','','Y')"
							 action="#{wage_personQueryBB.queryAdvance}"/>
<c:verbatim>
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
                      <jsp:param name="keyName" value="A001735"/>
                </jsp:include>
            </td>
        </tr>
    </table>
</form>
</c:verbatim>