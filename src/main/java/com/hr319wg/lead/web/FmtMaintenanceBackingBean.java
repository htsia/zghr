package com.hr319wg.lead.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import org.apache.log4j.Logger;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.lead.pojo.bo.GraphResourceBO;
import com.hr319wg.lead.pojo.bo.LeadResourceBO;
import com.hr319wg.lead.pojo.bo.TextResourceBO;
import com.hr319wg.lead.ucc.IFmtMaintenanceUCC;
import com.hr319wg.lead.ucc.IResMaintenanceUCC;

public class FmtMaintenanceBackingBean extends BaseBackingBean {
	private static Logger logger = Logger.getLogger("com.hr319wg.lead");
	private String showcode;
	private String showname;
	private String nouse;
	private List textlist;
	private List gridlist;
	private List chartitemlist;
	private List paralist;
	private String runquery;
	private String resId;
	private String graphID;
	private String sqlId;
	private String deleteID;
	private GraphResourceBO gbo;
	private IFmtMaintenanceUCC fmtmaintenanceucc;
	private IResMaintenanceUCC resmaintenanceucc;
	private static SelectItem[] freselects = { new SelectItem("02", "��Ƶ��ȡ"),
			new SelectItem("05", "��Ƶ��ȡ"), new SelectItem("01", "��Ƶ��ȡ"),
			new SelectItem("03", "��Ƶ��ȡ"), new SelectItem("04", "����Ƶ��ȡ") };

	private static SelectItem[] makselects = { new SelectItem("10", "Сͼ"),
			new SelectItem("01", "��ͼ"), new SelectItem("11", "��ͼ��Сͼ") };

	private static SelectItem[] graselects = {
			new SelectItem("1", "��ά������ҷ��ţ���ͼ"), new SelectItem("2", "��ά�ٷֱȱ�ͼ"),
			new SelectItem("3", "��άĬ�ϱ�ͼ"), new SelectItem("4", "��ά��ͼ"),
			new SelectItem("5", "���ͼ"), new SelectItem("6", "��ά��ά������ͼ"),
			new SelectItem("7", "��ά��ά������ͼ"), new SelectItem("8", "��ά��ά����ͼ"),
			new SelectItem("9", "��ά��ά�ȶ���ͼ") };

	private static SelectItem[] yesselects = { new SelectItem("1", "��(1)"),
			new SelectItem("0", "��(0)") };

	public String getGraphID() {
		return graphID;
	}

	public void setGraphID(String graphID) {
		this.graphID = graphID;
	}

	public GraphResourceBO getGbo() {
		if (this.gbo == null) {
			this.gbo = new GraphResourceBO();
		}
		return this.gbo;
	}

	public void setGbo(GraphResourceBO g) {
		this.gbo = g;
	}

	public String getSqlId() {
		return this.sqlId;
	}

	public void setSqlId(String id) {
		this.sqlId = id;
	}

	public String getDeleteID() {
		return this.deleteID;
	}

	public void setDeleteID(String id) {
		this.deleteID = id;
	}

	public String deleteSql() {
		try {
			this.fmtmaintenanceucc.deleteSqlBO(this.sqlId);
			refreshGraphParaList();
		} catch (Exception e) {
		}
		return "";
	}

	public String deleteGraphItem() {
		try {
			this.fmtmaintenanceucc.deleteGraphItem(this.deleteID);
			refreshChartItemList();
		} catch (Exception e) {
		}
		return "";
	}

	public void setRunquery(String id) {
		this.runquery = id;
	}

	public String refreshChartItemList() {
		try {
			this.chartitemlist = this.fmtmaintenanceucc
					.findAllGraphItem(this.gbo.getGraphID());
		} catch (Exception e) {
		}
		return "";
	}

	public String refreshGraphParaList() {
		try {
			this.paralist = this.fmtmaintenanceucc.queryAllSql(this.gbo.getResId());
		} catch (Exception e) {
		}
		return "";
	}

	public String getRunquery() {
		try {
			String resId1=getRequestParameter("res_id");
			if (resId1!= null && !"".equals(resId1)) {
				this.resId = resId1;
				LeadResourceBO lb = this.resmaintenanceucc.findLeadResource(this.resId);
				this.showcode = lb.getShowCode();
				String infotype = lb.getStoreTable();
				this.showname = lb.getShowName();
				if (infotype.equals("T")) {
					this.textlist = queryTextByScode(lb.getResId());
				} else if (infotype.equals("L")) {
					queryGridByScode(lb.getResId());
				} else if (infotype.equals("C")) {
					List chartlist = queryChartByScode(lb.getResId());
					if (chartlist != null && chartlist.size()>0) {
						this.gbo = ((GraphResourceBO)chartlist.get(0));
						this.graphID=this.gbo.getGraphID();
						this.chartitemlist = this.fmtmaintenanceucc.findAllGraphItem(this.gbo.getGraphID());
					}else{
						this.gbo = new GraphResourceBO();
						this.graphID=null;
						this.chartitemlist = new ArrayList();
					}
				}
				this.paralist = this.fmtmaintenanceucc.queryAllSql(lb.getResId());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.runquery;
	}

	private List queryTextByScode(String showname) {
		return this.fmtmaintenanceucc.queryTextByResID(showname);
	}

	private String queryGridByScode(String showname) {
		try {
			this.gridlist = this.fmtmaintenanceucc.queryGridByResID(showname);
		} catch (Exception e) {
			logger.warn("����չ�ָ�ʽ�����!", e);
			showMessageDetail("����չ�ָ�ʽ�����.");
		}
		return "";
	}

	private List queryChartByScode(String showname) {
		return this.fmtmaintenanceucc.queryGraphByResID(showname);
	}

	public String querylastarchives() {
		return "2006-12-31";
	}

	private boolean editTextByObj(List listobj) {
		try {
			this.fmtmaintenanceucc.editTextByObj(listobj);
		} catch (SysException e) {
			logger.warn("���ݶ���༭�ı���ʽ����", e);
			showMessageDetail("���ݶ���༭�ı���ʽ����.");
		} catch (Exception e) {
			logger.warn("���ݶ���༭�ı���ʽ����", e);
			showMessageDetail("���ݶ���༭�ı���ʽ����.");
		}
		return true;
	}

	private void deleGridByObj(List list) {
		try {
			this.fmtmaintenanceucc.deleGridByObj(list);
		} catch (SysException e) {
			logger.warn("���ݱ������", e);
			showMessageDetail("���ݱ������.");
			e.printStackTrace();
		} catch (Exception e) {
			logger.warn("���ݱ������", e);
			showMessageDetail("���ݱ������.");
			e.printStackTrace();
		}
	}

	public String editText() {
		editTextByObj(this.textlist);
		return "success";
	}

	public String deleGrid() {
		try {
			this.fmtmaintenanceucc.deleGridByObj(this.deleteID);
		} catch (Exception e) {
		}
		return "";
	}

	public void saveGrid() {
	}

	public String editChart() {
		try {
			if(this.gbo.getGraphID()==null){
				this.gbo.setResId(this.resId);
			}
			this.fmtmaintenanceucc.saveGraphResourceBO(this.gbo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String getShowcode() {
		return this.showcode;
	}

	public void setShowcode(String showcode) {
		this.showcode = showcode;
	}

	public String getNouse() {
		return this.nouse;
	}

	public void setNouse(String nouse) {
		this.nouse = nouse;
	}

	public String getResId() {
		return this.resId;
	}

	public void setResId(String id) {
		this.resId = id;
	}

	public String getShowname() {
		return this.showname;
	}

	public void setShowname(String name) {
		this.showname = name;
	}

	public List getTextlist() {
		return this.textlist;
	}

	public void setTextlist(List textlist) {
		this.textlist = textlist;
	}

	public TextResourceBO getTextBO() {
		if ((this.textlist != null) && (this.textlist.size() > 0)) {
			return (TextResourceBO) this.textlist.get(0);
		}

		return new TextResourceBO();
	}

	public void setTextBO(TextResourceBO bo) {
		if (this.textlist != null)
			this.textlist.set(0, bo);
	}

	public IFmtMaintenanceUCC getFmtmaintenanceucc() {
		return this.fmtmaintenanceucc;
	}

	public void setFmtmaintenanceucc(IFmtMaintenanceUCC fmtmaintenanceucc) {
		this.fmtmaintenanceucc = fmtmaintenanceucc;
	}

	public IResMaintenanceUCC getResmaintenanceucc() {
		return this.resmaintenanceucc;
	}

	public void setResmaintenanceucc(IResMaintenanceUCC resmaintenanceucc) {
		this.resmaintenanceucc = resmaintenanceucc;
	}

	public List getGridlist() {
		return this.gridlist;
	}

	public void setGridlist(List gridlist) {
		this.gridlist = gridlist;
	}

	public List getChartitemlist() {
		return this.chartitemlist;
	}

	public void setChartitemlist(List chartlist) {
		this.chartitemlist = chartlist;
	}

	public List getParalist() {
		return this.paralist;
	}

	public void setParalist(List list) {
		this.paralist = list;
	}

	public SelectItem[] getFreselects() {
		return freselects;
	}

	public SelectItem[] getMakselects() {
		return makselects;
	}

	public SelectItem[] getGraselects() {
		return graselects;
	}

	public SelectItem[] getYesselects() {
		return yesselects;
	}
}