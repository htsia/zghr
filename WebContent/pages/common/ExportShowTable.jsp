<%@page import="com.hr319wg.sys.pojo.vo.RecordVO"%>
<%@page import="com.hr319wg.sys.pojo.vo.CellVO"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.hr319wg.sys.pojo.vo.TableVO"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.write.Label"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="application/x-msdownload; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	response.setContentType("application/x-msdownload;charset=UTF-8");
	String filename = URLEncoder.encode("result.xls", "utf-8");
	response.setHeader("Content-Disposition","Disposition; filename=" + filename);
%>
				

<%
	String path = request.getRealPath("/");
	WritableWorkbook book = Workbook.createWorkbook(new File(path+"file\\export\\result.xls"));
	WritableSheet sheet = book.createSheet("Sheet1", 0);
	TableVO tvo=(TableVO) session.getAttribute("ShowTable");
	if(tvo!=null){
		CellVO[]cell=tvo.getHeader();
		for(int i=0;i<cell.length;i++){
			Label label = new Label(i, 0, cell[i].getItemName());
			sheet.addCell(label);
		}
	}
	
	RecordVO[]rec= tvo.getRowData();
	for(int i=1;i<rec.length;i++){
		CellVO[] cell= rec[i].getCell();
		for(int j=0;j<cell.length;j++){
			Label label = new Label(j, i, cell[j].getValue());
			sheet.addCell(label);
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