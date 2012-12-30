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
	response.setContentType("application/x-msdownload;charset=UTF-8");
	String filename = URLEncoder.encode("现金工资.xls", "utf-8");
	response.setHeader("Content-Disposition","Disposition; filename=" + filename);
%>
				
<%
					String path = request.getRealPath("/");
					WritableWorkbook book = Workbook.createWorkbook(new File(path+"file\\export\\result.xls"));
					WritableSheet sheet = book.createSheet("现金工资明细", 0);
					
					String[]heads={"序号","员工编号", "姓名", "身份证号", "所在部门", "应发工资", "其他", "应发合计", "实发合计", "签字", "备注"};
					
					for(int i=0;i<heads.length;i++){
						Label label = new Label(i, 0, heads[i]);
						sheet.addCell(label);
					}
					JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
					String sql = "select a.a001735,a.a001001,a.a001077,b.b001005,nvl(w.a239200,0) base,nvl(w.a239201,0) other,nvl(w.a239200,0)+nvl(w.a239201,0) wage from a239 w left join a001 a on w.id=a.id left join b001 b on a.a001735=b.orguid where (nvl(w.a239200,0)<>0 or nvl(w.a239201,0)<>0) and a.a001201='1' and a.a001054='0135700572'";
					List list = jdbc.queryForList(sql);
					
					for(int i=0;list!=null && i<list.size();i++){
						Map m = (Map)list.get(i);
						Label labelindex = new Label(0, i+1, i+1+"");
						sheet.addCell(labelindex);
						
						Label labelcode = new Label(1, i+1, m.get("a001735").toString());
						sheet.addCell(labelcode);
						
						Label labelname = new Label(2, i+1, m.get("a001001").toString());
						sheet.addCell(labelname);
						
						if(m.get("a001077")!=null){
							Label labelcard = new Label(3, i+1, m.get("a001077").toString());
							sheet.addCell(labelcard);
						}
						
						if(m.get("b001005")!=null){
							Label labeldept = new Label(4, i+1, m.get("b001005").toString());
							sheet.addCell(labeldept);
						}
						
						Label labelbase = new Label(5, i+1, m.get("base").toString());
						sheet.addCell(labelbase);
						
						Label labelother = new Label(6, i+1, m.get("other").toString());
						sheet.addCell(labelother);
						
						Label labelwage = new Label(7, i+1, m.get("wage").toString());
						sheet.addCell(labelwage);
						
						Label labelwage2 = new Label(8, i+1, m.get("wage").toString());
						sheet.addCell(labelwage2);
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

