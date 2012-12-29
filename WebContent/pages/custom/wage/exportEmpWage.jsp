<%@page import="com.hr319wg.custom.wage.service.IWageDataService"%>
<%@page import="jxl.write.Label"%>
<%@page import="java.io.File"%>
<%@page import="jxl.Workbook"%>
<%@page import="com.hr319wg.custom.pojo.bo.UserBO"%>
<%@page import="com.hr319wg.util.CodeUtil"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
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
	response.setContentType("application/x-msdownload;charset=UTF-8");
	String filename = URLEncoder.encode("现金工资.xls", "utf-8");
	response.setHeader("Content-Disposition","Disposition; filename=" + filename);
%>
				
<%
					String path = request.getRealPath("/");
					WritableWorkbook book = Workbook.createWorkbook(new File(path+"file\\export\\result.xls"));
					WritableSheet sheet = book.createSheet("现金工资明细", 0);
					
					String[]heads={"员工编号", "身份证号", "姓名", "二级部门", "所在部门", "人员类别", "职称等级", "超课时数", "应发超课时工资", "代扣税", "实发超课时工资", "银行账号"};
					for(int i=0;i<heads.length;i++){
						Label label = new Label(i, 0, heads[i]);
						sheet.addCell(label);
					}
					IWageDataService wage = (IWageDataService)SysContext.getBean("wage_dataservice");
					List list = wage.getAllClassWageBO();
					List list1 = new ArrayList();
					List list2 = new ArrayList();
					if(list!=null && list.size()>0){
						for(int i=0;i<list.size();i++){
							Map m = (Map)list.get(i);
							double realwage = Double.valueOf(String.valueOf(m.get("realwage")));
							if(realwage>0){
								list1.add(list.get(i));
							}else if(realwage<0){
								list2.add(list.get(i));								
							}
						}
					}
					for(int i=0;i<list1.size();i++){
						Map m = (Map)list1.get(i);
						Label labelcode = new Label(0, i+1, m.get("personcode").toString());
						sheet.addCell(labelcode);
						
						if(m.get("card")!=null){
							Label labelcard = new Label(1, i+1, m.get("card").toString());
							sheet.addCell(labelcard);
						}
						
						Label labelname = new Label(2, i+1, m.get("name").toString());
						sheet.addCell(labelname);
	
						Label labelsecdept = new Label(3, i+1, CodeUtil.interpertCode(m.get("secdept").toString()));
						sheet.addCell(labelsecdept);
						
						Label labeldept = new Label(4, i+1, CodeUtil.interpertCode(CodeUtil.TYPE_ORG, m.get("dept").toString()));
						sheet.addCell(labeldept);
						
						Label labeltype = new Label(5, i+1, CodeUtil.interpertCode(m.get("persontype").toString()));
						sheet.addCell(labeltype);
						
						if(m.get("zclevel")!=null){
							Label labellevel = new Label(6, i+1, CodeUtil.interpertCode(m.get("zclevel").toString()));
							sheet.addCell(labellevel);
						}
						
						if(m.get("classnum")!=null){
							Label labelnum = new Label(7, i+1, m.get("classnum").toString());
							sheet.addCell(labelnum);
						}
						
						Label labelwage = new Label(8, i+1, m.get("wage").toString());
						sheet.addCell(labelwage);
						
						Label labelreduce = new Label(9, i+1, m.get("reduce").toString());
						sheet.addCell(labelreduce);
						
						Label labelrealwage = new Label(10, i+1, m.get("realwage").toString());
						sheet.addCell(labelrealwage);
						
						if(m.get("bank")!=null){
							Label labelbank = new Label(11, i+1, m.get("bank").toString());
							sheet.addCell(labelbank);
						}
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

