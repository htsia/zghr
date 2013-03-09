<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.NumberFormat"%>
<%@page import="jxl.write.Number"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="com.hr319wg.sys.pojo.vo.RecordVO"%>
<%@page import="com.hr319wg.wage.ucc.IWagePersonQueryUCC"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.api.ActivePageAPI"%>
<%@page import="com.hr319wg.sys.pojo.vo.CellVO"%>
<%@page import="com.hr319wg.sys.pojo.vo.TableVO"%>
<%@page import="com.hr319wg.wage.pojo.bo.WageSetBO"%>
<%@page import="com.hr319wg.sys.cache.SysCache"%>
<%@page import="jxl.write.Label"%>
<%@page import="java.io.File"%>
<%@page import="jxl.Workbook"%>
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
	String setId=request.getParameter("setId");
	String exportField=request.getParameter("exportField");
	exportField+=",A001735,A001001,A001743,A001242";
	String file="result";
	Map setMap= SysCache.wageSetMap;
	WageSetBO bo= (WageSetBO)setMap.get(setId);
	if(bo!=null){
		file=bo.getName();
	}
	String filename = URLEncoder.encode(file+".xls", "utf-8");
	response.setHeader("Content-Disposition","Disposition; filename=" + filename);
%>
				
<%
					String path = request.getRealPath("/");
					WritableWorkbook book = Workbook.createWorkbook(new File(path+"file\\export\\result.xls"));
					WritableSheet sheet = book.createSheet("sheet", 0);
					TableVO table=(TableVO)session.getAttribute("OBJECT");
					CellVO[]cells= table.getHeader();
					
					int index=0;
					
					List<CellVO> cellList=new ArrayList<CellVO>();
					
					//显示表头
					for(int i=0;i<cells.length;i++){
						CellVO c=cells[i];
						if(exportField.indexOf(c.getItemId())!=-1){
							Label label = new Label(index++, 0, c.getItemName());
							sheet.addCell(label);
							cellList.add(c);
						}
					}
					
					index=0;
					int index1=0;
					String field="";
					String totalField="";
					String totalField2="";
					table=new TableVO();
					TableVO totalTable=new TableVO();
					TableVO totalTable2=new TableVO();
					CellVO[]cells2=new CellVO[cellList.size()];
					CellVO[]totalCell=new CellVO[cellList.size()-3];
					CellVO[]totalCell2=new CellVO[cellList.size()-4];
					for(int i=0;i<cellList.size();i++){
						cells2[i]=cellList.get(i);
						String itemId=cellList.get(i).getItemId();
						field+=itemId+",";
						if(i==2 || itemId.startsWith("A815")){
							totalCell[index++]=cellList.get(i);
							if(i==2){
								totalField+=itemId+",";
							}else{
								totalField+="sum(replace("+itemId+",' ','')) "+itemId+",";
								totalCell2[index1++]=cellList.get(i);
								totalField2+="sum(replace("+itemId+",' ','')) "+itemId+",";
							}
						}
					}
					table.setHeader(cells2);
					totalTable.setHeader(totalCell);
					totalTable2.setHeader(totalCell2);
					field=field.substring(0, field.length()-1);
					totalField=totalField.substring(0, totalField.length()-1);
					totalField2=totalField2.substring(0, totalField2.length()-1);
					
					String sql=String.valueOf(session.getAttribute("activeSql"));
					sql="select "+field+" "+sql.substring(sql.indexOf("FROM"));
					IWagePersonQueryUCC wagepersonqueryucc=(IWagePersonQueryUCC)SysContext.getBean("wage_PersonQueryUcc");
					table=wagepersonqueryucc.queryPersonBySql(table, sql, 1, 9999);
					sql="select "+totalField+" "+sql.substring(sql.indexOf("FROM"), sql.indexOf("ORDER BY"))+" group by A001743";
					totalTable=wagepersonqueryucc.queryPersonBySql(totalTable, sql, 1, 9999);
					sql="select "+totalField2+" "+sql.substring(sql.indexOf("FROM"), sql.indexOf("group by"));
					totalTable2=wagepersonqueryucc.queryPersonBySql(totalTable2, sql, 1, 1);
					
					
					RecordVO[]data= table.getRowData();
					
					if(data.length>0){//begin-if
						Map totalMap=new HashMap();
						RecordVO[]totalData= totalTable.getRowData();
						for(int i=0;i<totalData.length;i++){
							CellVO[]c=totalData[i].getCell();
							totalMap.put(c[0].getValue(), c);
						}
						
						index=0;
						CellVO[]first=data[0].getCell();
						String wageDept=first[2].getValue();
						for(int i=0;i<data.length;i++){
							//小计
							CellVO[]cells3=data[i].getCell();
							String wageDept2=cells3[2].getValue();
							if(!wageDept.equals(wageDept2)){
								WritableCellFormat wcf = new WritableCellFormat();
								wcf.setAlignment(Alignment.CENTRE);
								Label label = new Label(0, index+1, "小计", wcf);
								sheet.addCell(label);
// 								sheet.mergeCells(0, index+1, 2, 0);
								
								CellVO[]cell=(CellVO[])totalMap.get(wageDept);
								if(cell!=null){
									wcf = new WritableCellFormat();
									for(int j=0;j<cell.length;j++){
										CellVO c=cell[j];
										if(c.getItemId().startsWith("A815")){
											wcf = new WritableCellFormat();
											Number num=new Number(j+2, index+1, Double.valueOf(c.getValue().replaceAll(" ", "")), wcf);
											sheet.addCell(num);
										}
									}
								}
								wageDept=wageDept2;
								index++;
							}
							//明细
							for(int j=0;j<cells3.length;j++){
								if(cells3[j].getItemId().startsWith("A815")){
									WritableCellFormat wcf = new WritableCellFormat();
									String v=cells3[j].getValue().replaceAll(" ", "");
									v="".equals(v)?"0":v;
									Number num=new Number(j, index+1, Double.valueOf(v), wcf);
									sheet.addCell(num);
								}else{
									String v=cells3[j].getValue();
									if(j==2){
										String regEx = "[0-9]";
								        Pattern p = Pattern.compile(regEx);
								        Matcher m = p.matcher(v);
								        v= m.replaceAll("").trim();
									}
									Label label = new Label(j, index+1, v);
									sheet.addCell(label);
								}
							}
							index++;
						}//end-if
						
						//最后小计
						CellVO[]lastCells=data[data.length-1].getCell();
						WritableCellFormat wcf = new WritableCellFormat();
						wcf.setAlignment(Alignment.CENTRE);
						Label label = new Label(0, index+1, "小计", wcf);
						sheet.addCell(label);
// 						sheet.mergeCells(0, index+1, 2, 0);
						
						CellVO[]cell=(CellVO[])totalMap.get(wageDept);
						if(cell!=null){
							wcf = new WritableCellFormat();
							for(int j=0;j<cell.length;j++){
								CellVO c=cell[j];
								if(cell[j].getItemId().startsWith("A815")){
									wcf = new WritableCellFormat();
									Number num=new Number(j+2, index+1, Double.valueOf(c.getValue().replaceAll(" ", "")), wcf);
									sheet.addCell(num);
								}
							}
						}
						index++;
						
						CellVO[]total=totalTable2.getRowData()[0].getCell();
						wcf = new WritableCellFormat();
						wcf.setAlignment(Alignment.CENTRE);
						Label label2 = new Label(0, index+1, "合计", wcf);
						sheet.addCell(label2);
// 						sheet.mergeCells(0, index+1, 2, 0);
						
						wcf = new WritableCellFormat();
						for(int j=0;j<total.length;j++){
							CellVO c=total[j];
							wcf = new WritableCellFormat();
							Number num=new Number(j+3, index+1, Double.valueOf(c.getValue().replaceAll(" ", "")), wcf);
							sheet.addCell(num);
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

