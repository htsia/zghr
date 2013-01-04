<%@page import="com.hr319wg.custom.wage.service.IWageDataService"%>
<%@page import="com.hr319wg.custom.wage.pojo.bo.WageLitleBaseBO"%>
<%@page import="com.hr319wg.util.CodeUtil"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="com.hr319wg.custom.wage.pojo.bo.WageDataSetBO"%>
<%@page import="com.hr319wg.wage.pojo.bo.WageSetBO"%>
<%@page import="com.hr319wg.custom.wage.pojo.bo.WageDataRecordBO"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String wageDate = request.getParameter("date");
	String wageSetID = request.getParameter("setId");
	String p1 = request.getParameter("out");
	if(p1!=null){
		response.setContentType("application/msword;charset=UTF-8");
		String filename = URLEncoder.encode("工资发放说明.doc", "utf-8");
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
	IWageDataService service = (IWageDataService)SysContext.getBean("wage_dataservice");
%>
</head>
<body>
	<div id="main" style="margin-left:20px;height:400px;overflow-y:auto;">
<!-- 		其他1 -->
		<div class="big1">一、其他1(共<%=service.getWageOtherItemSum("1", wageDate, wageSetID) %>元)</div>
		<%
			List<WageDataSetBO> setList = service.getAllWageSetBO("1", wageDate);
			if(setList!=null){
				int i=1;
				for(WageDataSetBO setBo : setList){
					%>
					<div class='big2'><%=(i++)+"、"+setBo.getName() %>共<%=service.getWageOtherItemSumByID(setBo.getID(), wageDate, wageSetID) %>元</div>
					<table class="table03" border="<%=!"1".equals(p1)?"1":"0"%>">
						<tr>
							<th class="td_top">序号</th><th class="td_top">人员编号</th><th class="td_top">姓名</th><th class="td_top">所在部门</th><th class="td_top">金额</th><th class="td_top">备注</th>
						</tr>
						<%
							List<WageDataRecordBO> recList = service.getWageOtherItemDetail(null, setBo.getID(), wageDate, null, wageSetID);
							
							if(recList!=null){
								int index=0;
								for(WageDataRecordBO bo : recList){
									PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
									%>
									<tr>
										<td class="td_middle_center"><%=++index %></td>
										<td class="td_middle_center"><%=p.getPersonCode() %></td>
										<td class="td_middle_center"><%=p.getName() %></td>
										<td class="td_middle_center"><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()) %></td>
										<td class="td_middle_center"><%=bo.getMoney() %></td>
										<td class="td_middle_center"><%=bo.getRemark()==null?"":bo.getRemark() %></td>
									</tr>
									<%
								}
							}
						%>
					</table>
					<%
				}
			}
		%>
<!-- 		其他2 -->
		<div class="big1">二、其他2(共<%=service.getWageOtherItemSum("3", wageDate, wageSetID) %>元)</div>
		<%
			List<WageDataSetBO> setList2 = service.getAllWageSetBO("3", wageDate);
			if(setList!=null){
				int i=1;
				for(WageDataSetBO setBo : setList2){
					%>
					<div class='big2'><%=(i++)+"、"+setBo.getName() %>共<%=service.getWageOtherItemSumByID(setBo.getID(), wageDate, wageSetID) %>元</div>
					<table class="table03" border="<%=!"1".equals(p1)?"1":"0"%>">
						<tr>
							<th class="td_top">序号</th><th class="td_top">人员编号</th><th class="td_top">姓名</th><th class="td_top">所在部门</th><th class="td_top">金额</th><th class="td_top">备注</th>
						</tr>
						<%
							List<WageDataRecordBO> recList = service.getWageOtherItemDetail(null, setBo.getID(), wageDate, null, wageSetID);
							
							if(recList!=null){
								int index=0;
								for(WageDataRecordBO bo : recList){
									PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
									%>
									<tr>
										<td class="td_middle_center"><%=++index %></td>
										<td class="td_middle_center"><%=p.getPersonCode() %></td>
										<td class="td_middle_center"><%=p.getName() %></td>
										<td class="td_middle_center"><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()) %></td>
										<td class="td_middle_center"><%=bo.getMoney() %></td>
										<td class="td_middle_center"><%=bo.getRemark()==null?"":bo.getRemark() %></td>
									</tr>
									<%
								}
							}
						%>
					</table>
					<%
				}
			}
		%>
		<!-- 		扣其他1 -->
		<div class="big1">三、扣其他1(共<%=service.getWageOtherItemSum("4", wageDate, wageSetID) %>元)</div>
		<%
			List<WageDataSetBO> setList4 = service.getAllWageSetBO("4", wageDate);
			if(setList!=null){
				int i=1;
				for(WageDataSetBO setBo : setList4){
					%>
					<div class='big2'><%=(i++)+"、"+setBo.getName() %>共<%=service.getWageOtherItemSumByID(setBo.getID(), wageDate, wageSetID) %>元</div>
					<table class="table03" border="<%=!"1".equals(p1)?"1":"0"%>">
						<tr>
							<th class="td_top">序号</th><th class="td_top">人员编号</th><th class="td_top">姓名</th><th class="td_top">所在部门</th><th class="td_top">金额</th><th class="td_top">备注</th>
						</tr>
						<%
							List<WageDataRecordBO> recList = service.getWageOtherItemDetail(null, setBo.getID(), wageDate, null, wageSetID);
							
							if(recList!=null){
								int index=0;
								for(WageDataRecordBO bo : recList){
									PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
									%>
									<tr>
										<td class="td_middle_center"><%=++index %></td>
										<td class="td_middle_center"><%=p.getPersonCode() %></td>
										<td class="td_middle_center"><%=p.getName() %></td>
										<td class="td_middle_center"><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()) %></td>
										<td class="td_middle_center"><%=bo.getMoney() %></td>
										<td class="td_middle_center"><%=bo.getRemark()==null?"":bo.getRemark() %></td>
									</tr>
									<%
								}
							}
						%>
					</table>
					<%
				}
			}
		%>
		<!-- 		扣其他2 -->
		<div class="big1">四、扣其他2(共<%=service.getWageOtherItemSum("5", wageDate, wageSetID) %>元)</div>
		<%
			List<WageDataSetBO> setList5 = service.getAllWageSetBO("5", wageDate);
			if(setList!=null){
				int i=1;
				for(WageDataSetBO setBo : setList5){
					%>
					<div class='big2'><%=(i++)+"、"+setBo.getName() %>共<%=service.getWageOtherItemSumByID(setBo.getID(), wageDate, wageSetID) %>元</div>
					<table class="table03" border="<%=!"1".equals(p1)?"1":"0"%>">
						<tr>
							<th class="td_top">序号</th><th class="td_top">人员编号</th><th class="td_top">姓名</th><th class="td_top">所在部门</th><th class="td_top">金额</th><th class="td_top">备注</th>
						</tr>
						<%
							List<WageDataRecordBO> recList = service.getWageOtherItemDetail(null, setBo.getID(), wageDate, null, wageSetID);
							
							if(recList!=null){
								int index=0;
								for(WageDataRecordBO bo : recList){
									PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
									%>
									<tr>
										<td class="td_middle_center"><%=++index %></td>
										<td class="td_middle_center"><%=p.getPersonCode() %></td>
										<td class="td_middle_center"><%=p.getName() %></td>
										<td class="td_middle_center"><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()) %></td>
										<td class="td_middle_center"><%=bo.getMoney() %></td>
										<td class="td_middle_center"><%=bo.getRemark()==null?"":bo.getRemark() %></td>
									</tr>
									<%
								}
							}
						%>
					</table>
					<%
				}
			}
		%>
<!-- 		捐款 -->
		<div class="big1">五、捐款(共<%=service.getWageOtherItemSum("2", wageDate, wageSetID) %>元)</div>
		<%
			List<WageDataSetBO> setList6 = service.getAllWageSetBO("2", wageDate);
			if(setList!=null){
				int i=1;
				for(WageDataSetBO setBo : setList6){
					%>
					<div class='big2'><%=(i++)+"、"+setBo.getName() %>共<%=service.getWageOtherItemSumByID(setBo.getID(), wageDate, wageSetID) %>元</div>
					<table class="table03" border="<%=!"1".equals(p1)?"1":"0"%>">
						<tr>
							<th class="td_top">序号</th><th class="td_top">人员编号</th><th class="td_top">姓名</th><th class="td_top">所在部门</th><th class="td_top">金额</th><th class="td_top">备注</th>
						</tr>
						<%
							List<WageDataRecordBO> recList = service.getWageOtherItemDetail(null, setBo.getID(), wageDate, null, wageSetID);
							
							if(recList!=null){
								int index=0;
								for(WageDataRecordBO bo : recList){
									PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
									%>
									<tr>
										<td class="td_middle_center"><%=++index %></td>
										<td class="td_middle_center"><%=p.getPersonCode() %></td>
										<td class="td_middle_center"><%=p.getName() %></td>
										<td class="td_middle_center"><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()) %></td>
										<td class="td_middle_center"><%=bo.getMoney() %></td>
										<td class="td_middle_center"><%=bo.getRemark()==null?"":bo.getRemark() %></td>
									</tr>
									<%
								}
							}
						%>
					</table>
					<%
				}
			}
		%>
	</div>
</body>
</html>