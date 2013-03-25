package com.hr319wg.custom.extend.web;

import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.web.WageComputeBackingBean;

public class WageComputeBackingBeanByExtend extends WageComputeBackingBean {
	
	public String turnPageQuery(TableVO table, String sql, int pageNum, int rowNum) {
	    try {
	      if (pageNum == 0)
	        pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
	      if (pageNum == 0)
	        pageNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("pageNum")));
	      if (pageNum == 0)
	        pageNum = 1;
	      if (rowNum == 0)
	        rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("rowNum")));
	      if (rowNum == 0)
	        rowNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("rowNum")));
	      if (rowNum == 0)
	        rowNum = 500;
	      if (table == null)
	        table = (TableVO)super.getHttpSession().getAttribute("OBJECT");
	      if (sql == null) {
	        sql = (String)super.getHttpSession().getAttribute("activeSql");
	      }

	      if(sql.indexOf("A001242")==-1){
	    	  CellVO[]cells= table.getHeader();
	    	  CellVO[]cells2= new CellVO[table.getHeader().length+1];
	    	  for(int i=0;i<cells.length;i++){
	    		  cells2[i]=cells[i];
	    	  }
	    	  CellVO c=new CellVO();
	    	  CommonFuns.copyProperties(c, SysCacheTool.findInfoItem("A001", "A001242"));
	    	  cells2[table.getHeader().length]=c;
	    	  
	    	  String[]sql2=sql.split("FROM");
	    	  sql=sql2[0]+",A001242 FROM "+sql2[1];
	    	  table.setHeader(cells2);
	      }
	      
			table = this.getWagepersonqueryucc().queryPersonBySql(table, sql, pageNum, rowNum);
			table.setTag(this.getSetId());
			super.getHttpSession().setAttribute("activeSql", sql);
			super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
			super.getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			super.showMessageDetail("turnPageQuery´íÎó£º" + e.getMessage());
		}
		return null;
	}
}
