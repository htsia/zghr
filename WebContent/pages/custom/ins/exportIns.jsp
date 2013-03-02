<%@page import="com.hr319wg.util.CommonFuns"%>
<%@page import="com.hr319wg.util.CodeUtil"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="com.hr319wg.custom.ins.pojo.bo.InsMonthPayBO"%>
<%@page import="com.hr319wg.custom.ins.service.IInsDataService"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@page import="jxl.write.Label"%>
<%@page import="java.io.File"%>
<%@page import="jxl.Workbook"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="application/x-msdownload; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String setID=request.getParameter("setID");
	String date=request.getParameter("date");
	response.setContentType("application/x-msdownload;charset=UTF-8");
	String filename = URLEncoder.encode(date+"保险缴费.xls", "utf-8");
	response.setHeader("Content-Disposition","Disposition; filename=" + filename);
%>
				
<%
					String path = request.getRealPath("/");
					WritableWorkbook book = Workbook.createWorkbook(new File(path+"file\\export\\result.xls"));
					WritableSheet sheet = book.createSheet(date, 0);
					
					String[]heads={"序号", "员工编号", "姓名", "二级部门", "人员类别", "计算类别", "个人养老", "单位养老", "个人医疗", "单位医疗", "单位生育", "大额医疗", "个人公积金", "单位公积金", "单位工伤", "个人失业", "单位失业", "社保补缴 "};
					
					for(int i=0;i<heads.length;i++){
						Label label = new Label(i, 0, heads[i]);
						sheet.addCell(label);
					}
					
					IInsDataService ins=(IInsDataService)SysContext.getBean("ins_dataserviceImpl");
					List list= ins.getAllInsMonthPayBO(null, setID, date, null, null, null);
					
					for(int i=0;list!=null && i<list.size();i++){
						Object[]obj=(Object[]) list.get(i);
						InsMonthPayBO bo = (InsMonthPayBO)obj[0];
						PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
						Label index = new Label(0, i+1, i+1+"");
						sheet.addCell(index);
						Label code = new Label(1, i+1, p.getPersonCode());
						sheet.addCell(code);
						Label name = new Label(2, i+1, p.getName());
						sheet.addCell(name);
						Label subdept = new Label(3, i+1, CodeUtil.interpertCode(bo.getSecDeptID()));
						sheet.addCell(subdept);
						Label pType = new Label(4, i+1, CodeUtil.interpertCode(String.valueOf(obj[1])));
						sheet.addCell(pType);
						Label cType = new Label(5, i+1, CodeUtil.interpertCode(bo.getPayAddress()));
						sheet.addCell(cType);
						Label ylao = new Label(6, i+1, CommonFuns.filterNull(bo.getPersonYlao()));
						sheet.addCell(ylao);
						Label cylao = new Label(7, i+1, CommonFuns.filterNull(bo.getCompanyYlao()));
						sheet.addCell(cylao);
						Label yliao = new Label(8, i+1, CommonFuns.filterNull(bo.getPersonYliao()));
						sheet.addCell(yliao);
						Label cyliao = new Label(9, i+1, CommonFuns.filterNull(bo.getCompanyYliao()));
						sheet.addCell(cyliao);
						Label shengyu = new Label(10, i+1, CommonFuns.filterNull(bo.getCompanyShengyu()));
						sheet.addCell(shengyu);
						Label dejin = new Label(11, i+1, CommonFuns.filterNull(bo.getPersonDaejin()));
						sheet.addCell(dejin);
						Label gjj = new Label(12, i+1, CommonFuns.filterNull(bo.getPersonGongjijin()));
						sheet.addCell(gjj);
						Label cgjj = new Label(13, i+1, CommonFuns.filterNull(bo.getCompanyGongjijin()));
						sheet.addCell(cgjj);
						Label gongshang = new Label(14, i+1, CommonFuns.filterNull(bo.getCompanyGongshang()));
						sheet.addCell(gongshang);
						Label shiye = new Label(15, i+1, CommonFuns.filterNull(bo.getPersonShiye()));
						sheet.addCell(shiye);
						Label cshiye = new Label(16, i+1, CommonFuns.filterNull(bo.getCompanyShiye()));
						sheet.addCell(cshiye);
						Label other = new Label(17, i+1, CommonFuns.filterNull(bo.getInsOther()));
						sheet.addCell(other);
					}
					
					book.write();
					book.close();
					
					out.clear();    
					out = pageContext.pushBody();  
					FileInputStream in = new FileInputStream(path+"file\\export\\result.xls");
					OutputStream os = response.getOutputStream();
					byte[] b = new byte[1024];    
					int i = 0;    
					while((i = in.read(b)) > 0)    
					{    
						os.write(b, 0, i);    
					}    
					os.flush();
				%>

