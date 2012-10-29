<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@page import="com.hr319wg.util.CodeUtil"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="com.hr319wg.custom.eva.pojo.bo.EvaWageBO"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.custom.eva.service.EvaWageService"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.Label"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="application/x-msdownload; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	response.setContentType("application/x-msdownload;charset=UTF-8");
	String filename = URLEncoder.encode("绩效工资.xls", "utf-8");
	response.setHeader("Content-Disposition","Disposition; filename=" + filename);
%>
				

<%
	String path = request.getRealPath("/");
	WritableWorkbook book = Workbook.createWorkbook(new File(path+"file\\export\\result.xls"));
	WritableSheet sheet = book.createSheet("绩效工资", 0);
	WritableSheet sheet2 = book.createSheet("绩效工资部门汇总", 1);
	
	//sheet1
	String[]heads={"员工编号", "身份证号", "姓名", "二级部门", "所在部门", "人员类别", "应发绩效工资", "代扣税", "实发绩效工资", "银行账号"};
	for(int i=0;i<heads.length;i++){
		Label label = new Label(i, 0, heads[i]);
		sheet.addCell(label);
	}
	EvaWageService eva = (EvaWageService)SysContext.getBean("evawageservice");
	List list = eva.getAllEvaWageBO();
	if(list!=null && list.size()>0){
		for(int i=0;i<list.size();i++){
			Object[]obj = (Object[]) list.get(i);
			EvaWageBO bo = (EvaWageBO) obj[0];
			PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
			
			Label labelcode = new Label(0, i+1, p.getPersonCode());
			sheet.addCell(labelcode);
			
			if(obj[3]!=null){
				Label labelcard = new Label(1, i+1, obj[3].toString());
				sheet.addCell(labelcard);
			}
			
			Label labelname = new Label(2, i+1, p.getName());
			sheet.addCell(labelname);

			Label labelsubdept = new Label(3, i+1, CodeUtil.interpertCode((String)obj[1]));
			sheet.addCell(labelsubdept);

			Label labeldept = new Label(4, i+1, CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
			sheet.addCell(labeldept);
			
			Label labelpersontype = new Label(5, i+1, CodeUtil.interpertCode(p.getPersonType()));
			sheet.addCell(labelpersontype);
			
			Label labelwage = new Label(6, i+1, bo.getEvaWage());
			sheet.addCell(labelwage);

			Label labelReduceWage = new Label(7, i+1, bo.getEvaReduceWage());
			sheet.addCell(labelReduceWage);
			
			Label labelRealWage = new Label(8, i+1, bo.getEvaRealWage());
			sheet.addCell(labelRealWage);
			
			if(obj[2]!=null){
				Label labelbank = new Label(9, i+1, obj[2].toString());
				sheet.addCell(labelbank);
			}
		}
	}
	
	//sheet2
	String[]heads2={"二级部门", "应发绩效工资", "代扣税", "实发绩效工资"};
	for(int i=0;i<heads2.length;i++){
		Label label = new Label(i, 0, heads2[i]);
		sheet2.addCell(label);
	}
	JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
	String sql = "select A001239 secdept,sum(A746201) wage,sum(A746202) reduce,sum(A746203) realwage from (select a.A001239,w.A746201,w.A746202,w.A746203 from a001 a,(select id,A746201,A746202,A746203 from a746 where a746000='00901' and A746203 is not null) w where a.id=w.id) group by A001239 order by realwage";
	list = jdbc.queryForList(sql);
	double wage=0;
	double reduce=0;
	double realwage=0;
	if(list!=null && list.size()>0){
		for(int i=0;i<list.size();i++){
			Map m = (Map)list.get(i);
			double w=Double.valueOf(m.get("wage").toString());
			wage+=w;
			double r=Double.valueOf(m.get("reduce").toString());
			reduce+=r;
			double rw=Double.valueOf(m.get("realwage").toString());
			realwage+=rw;
			
			Label labelsecdept = new Label(0, i+1, CodeUtil.interpertCode(m.get("secdept").toString()));
			sheet2.addCell(labelsecdept);
			
			Label labelwage = new Label(1, i+1, String.valueOf(w));
			sheet2.addCell(labelwage);
			
			Label labelreduce = new Label(2, i+1, String.valueOf(r));
			sheet2.addCell(labelreduce);
			
			Label labelrealwage = new Label(3, i+1, String.valueOf(rw));
			sheet2.addCell(labelrealwage);
		}
		Label labelall = new Label(0, list.size()+1, "合计");
		sheet2.addCell(labelall);
		
		Label labelallwage = new Label(1, list.size()+1, String.valueOf(wage));
		sheet2.addCell(labelallwage);
		
		Label labelallreduce = new Label(2, list.size()+1, String.valueOf(reduce));
		sheet2.addCell(labelallreduce);
		
		Label labelallrealwage = new Label(3, list.size()+1, String.valueOf(realwage));
		sheet2.addCell(labelallrealwage);
		
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

