package com.hr319wg.lead.batch;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.lead.LeadPublicFun;
import com.hr319wg.lead.pojo.bo.GraphFileBO;
import com.hr319wg.lead.pojo.bo.GraphResourceBO;
import com.hr319wg.lead.pojo.bo.GraphResultBO;
import com.hr319wg.lead.pojo.bo.LeadResourceBO;
import com.hr319wg.lead.ucc.IFmtMaintenanceUCC;
import com.hr319wg.lead.ucc.IGraphGetUCC;
import com.hr319wg.lead.ucc.IResMaintenanceUCC;

public class LeadCreateChart
{
  private LeadPublicFun leadp;
  private JdbcTemplate jdbcTemplate;
  private IResMaintenanceUCC resmaintenanceucc;
  private IFmtMaintenanceUCC fmtmaintenanceucc;
  private IGraphGetUCC graphgetucc;

  public IGraphGetUCC getGraphgetucc()
  {
    return this.graphgetucc;
  }
  public void setGraphgetucc(IGraphGetUCC resmaintenanceucc) {
    this.graphgetucc = resmaintenanceucc;
  }

  public IResMaintenanceUCC getResmaintenanceucc() {
    return this.resmaintenanceucc;
  }
  public void setResmaintenanceucc(IResMaintenanceUCC resmaintenanceucc) {
    this.resmaintenanceucc = resmaintenanceucc;
  }

  public IFmtMaintenanceUCC getFmtmaintenanceucc() {
    return this.fmtmaintenanceucc;
  }
  public void setFmtmaintenanceucc(IFmtMaintenanceUCC fmtmaintenanceucc) {
    this.fmtmaintenanceucc = fmtmaintenanceucc;
  }

  public JdbcTemplate getJdbcTemplate() {
    return this.jdbcTemplate;
  }
  public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  LeadCreateChart() {
    this.leadp = new LeadPublicFun();
  }

  public int createChart(String orgid, String archivesdate, String webrootdir) throws Exception
  {
    clearGraphFile(orgid, archivesdate);
    List graphList = this.resmaintenanceucc.findAllGraphRes();
    for (int i = 0; i < graphList.size(); i++) {
      LeadResourceBO fmtbo = (LeadResourceBO)graphList.get(i);
      if (!"1".equals(fmtbo.getIsuse()))
        continue;
      List chartlist = this.graphgetucc.findShowGraphData(fmtbo.getResId(), orgid, archivesdate);

      String basename = baseFileNameForLead(fmtbo.getResId(), orgid, archivesdate);
      GraphResourceBO grbo = (GraphResourceBO)(GraphResourceBO)this.fmtmaintenanceucc.queryGraphByResID(fmtbo.getResId()).get(0);
      createChartByObj(chartlist, grbo, orgid, fmtbo.getResId(), archivesdate, basename, webrootdir);
    }

    return 0;
  }

  private String createChartByObj(List chartlist, GraphResourceBO fmtbo, String orgcode, String resID, String archive, String basename, String webrootdir)
  {
    String title = "";
    String fname = "none.jpg"; String fname2 = "none.jpg";
    int swidth = 10; int sheight = 10; int lwidth = 10; int lheight = 10;
    int charttype = 0;
    String[] serieName = new String[100];
    String[] optionName = new String[100];
    int[] optionValue = new int[100];

    HrChart hrchart = new HrChart();
    hrchart.clearData(serieName, optionName, optionValue);
    int total=0;
    for (int i = 0; (i < chartlist.size()) && (i < 100); i++) {
      GraphResultBO bo = (GraphResultBO)chartlist.get(i);
      serieName[i] = bo.getGraphXLabel();
      optionName[i] = bo.getGraphYLabel();
      int v= Integer.parseInt(bo.getGraphValue());
      optionValue[i] = v;
      total+=v;
    }

    fname = webrootdir + "\\file" + this.leadp.fullFileNameForLead(basename) + ".jpg";
    fname2 = webrootdir + "\\file" + this.leadp.fullFileNameForLead(basename) + "_big.jpg";

    swidth = fmtbo.getSmallWidth().intValue();
    sheight = fmtbo.getSmallHeight().intValue();
    lwidth = fmtbo.getLargeWidth().intValue();
    lheight = fmtbo.getLargeHeight().intValue();

    charttype = fmtbo.getGraphType().intValue();
    title = fmtbo.getGraphTitle()+"    合计:"+total;
    hrchart.setXName(fmtbo.getLabelTitleX());
    hrchart.setYName(fmtbo.getLabelTitleY());

    try
    {
      hrchart.setData(title, fname, serieName, optionName, optionValue, swidth, sheight, charttype);
      if ((charttype == 1) || (charttype == 2) || (charttype == 3))
      {
        hrchart.createPie3DChart();
      }if (charttype == 4)
        hrchart.createCategory3DChart();
      if (charttype == 5)
        hrchart.createAreaChart();
      if (charttype == 6)
        hrchart.createLine3DChart();
      if (charttype == 7)
        hrchart.createLineChart();
      if (charttype == 8)
        hrchart.createMCategory3DChart();
      if (charttype == 9) {
        hrchart.createStackedCategory3DChart();
      }
      fname = "/file" + this.leadp.fullFileNameForLead(basename) + ".jpg";
      insertFileNameToTbl(orgcode, fmtbo.getResId(), archive, fname);
      hrchart.setData(title, fname2, serieName, optionName, optionValue, lwidth, lheight, charttype);
      if ((charttype == 1) || (charttype == 2) || (charttype == 3))
      {
        hrchart.createPie3DChart();
      }if (charttype == 4)
        hrchart.createCategory3DChart();
      if (charttype == 5)
        hrchart.createAreaChart();
      if (charttype == 6)
        hrchart.createLine3DChart();
      if (charttype == 7)
        hrchart.createLineChart();
      if (charttype == 8)
        hrchart.createMCategory3DChart();
      if (charttype == 9) {
        hrchart.createStackedCategory3DChart();
      }
      fname2 = "/file" + this.leadp.fullFileNameForLead(basename) + "_big.jpg";
      insertFileNameToTbl(orgcode, fmtbo.getResId(), archive, fname2);
    } catch (Exception e) {
      return "数据与图像格式不匹配,创建图像不成功!title,fname,swidth,sheight,charttype:" + title + "," + fname + "," + swidth + "," + sheight + "," + charttype;
    }

    return "OK";
  }

  private String baseFileNameForLead(String showcode, String orgcode, String archive) {
    String name = orgcode + showcode + archive;
    return name;
  }

  private void clearGraphFile(String orgcode, String archivesdate) throws Exception {
    String sql_str = "delete from  LEAD_GRAPH_FILE where ";
    sql_str = sql_str + "org_Id ='" + orgcode + "'";
    sql_str = sql_str + " and " + "CALC_DATE='" + archivesdate + "'";
    this.jdbcTemplate.execute(sql_str);
  }

  private void insertFileNameToTbl(String orgid, String resid, String archivesdate, String graphname) {
    try {
      GraphFileBO gfb = new GraphFileBO();
      gfb.setArchivesDate(archivesdate);
      gfb.setGraphName(graphname);
      gfb.setOrgId(orgid);
      gfb.setResId(resid);
      this.graphgetucc.saveGraphFile(gfb);
    }
    catch (Exception e)
    {
    }
  }
}