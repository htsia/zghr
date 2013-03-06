<%@page import="com.hr319wg.util.CommonFuns"%>
<%@page import="com.hr319wg.sys.api.ActivePageAPI"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String year = request.getParameter("date");
	year=year==null?CommonFuns.getSysDate("yyyy"):year;
	String p1 = request.getParameter("out");
	if(p1!=null){
		response.setContentType("application/msword;charset=UTF-8");
		String filename = URLEncoder.encode("年度月工资台账.xls", "utf-8");
		response.setHeader("Content-Disposition","Disposition; filename=" + filename);
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>薪酬发放详情</title>
<style type="text/css">
	.big1{font-size:17px;font-weight:bold;margin-top:10px;}
	.big2{font-size:13px;font-weight:bold;margin:10px 0 0 20px;}
	table{margin:5px 0 0 20px;width: 600px;}
</style>
<%
	ActivePageAPI api=(ActivePageAPI)SysContext.getBean("sys_activePageApi");
%>
</head>
<body>
	<div id="main" style="margin-left:20px;height:400px;overflow-y:auto;">
		<table border="1">
			<tr align="center">
				<td>月份</td><td>类别</td><td>人数</td><td>人数对比</td><td>金额</td><td>金额对比</td>
			</tr>
			<%
				for(int i=1;i<13;i++){
					String date=null,ldate=null;
					if(i<10){
						date=year+"-0"+i;
					}else{
						date=year+"-"+i;
					}
					if(i!=1){
						if(i-1<10){
							ldate=year+"-0"+(i-1);
						}else{
							ldate=year+"-"+(i-1);
						}
					}
					%>
					<tr align="center"><td rowspan="5"><%=i %></td></tr>
					<%
					String[]type={"专职", "工勤", "兼职", "项目工"};
					String[]cond={
							"(A815212='0135700575' or A815210<>'0110700412')",
							"(A815212<>'0135700488' and A815210='0110700412')",
							"(A815212='0135700574')",
							"(A815212='0135700572')"
					};
					for(int j=0;j<4;j++){
						String sql=null,pnum=null,mnum=null,cpnum=null,cmnum=null;
						
						sql="select count(*) from a815 where "+cond[j]+" and a815701 like '"+date+"%'";
						pnum=api.queryForString(sql);
						sql="select sum(A815486) from a815 where "+cond[j]+" and a815701 like '"+date+"%'";
						mnum=api.queryForString(sql);
						if(i!=1){
							sql="select (select count(*) from a815 where "+cond[j]+" and a815701 like '"+date+"%')-(select count(*) from a815 where "+cond[j]+" and a815701 like '"+ldate+"%') from dual";
							cpnum=api.queryForString(sql);
							sql="select (select sum(A815486) from a815 where "+cond[j]+" and a815701 like '"+date+"%')-(select sum(A815486) from a815 where "+cond[j]+" and a815701 like '"+ldate+"%') from dual";
							cmnum=api.queryForString(sql);
						}
						%>
						<tr align="center">
						<td><%=type[j] %></td><td><%=CommonFuns.filterNullToZero(pnum) %></td><td><%=CommonFuns.filterNullToZero(cpnum) %></td><td><%=CommonFuns.filterNullToZero(mnum) %></td><td><%=CommonFuns.filterNullToZero(cmnum) %></td>
						</tr>
						<%
					}
				}
			%>
		</table>
	</div>
</body>
</html>