<%@ page import="java.io.File" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<table align=center border=0>
<tr><td align=center valign="middle">
<%
    String sessionName="STATIC_RESULT";
    if (request.getParameter("sessionName")!=null){
        sessionName=request.getParameter("sessionName");
    }
    com.hr319wg.qry.pojo.vo.StaticResultVO[] resultvo = (com.hr319wg.qry.pojo.vo.StaticResultVO[]) session.getAttribute(sessionName);
    String[] ids = request.getParameterValues("chkId");
    String height=request.getParameter("height");
    if (height==null || "".equals(height))  height="400";
    String width=request.getParameter("width");
    if (width==null || "".equals(width))  width="600";

    if (resultvo != null) {
        org.jfree.data.general.DefaultPieDataset data = new org.jfree.data.general.DefaultPieDataset();
        int pos = 0;
        if (ids!=null){
            for (int i = 0; i < ids.length; i++) {
                String[] ida = ids[i].split("\\|");
                int scount = Integer.parseInt(ida[0]);
                int rcount = Integer.parseInt(ida[1]);

                if (scount < resultvo.length && rcount < resultvo[scount].getItems().length) {
                    String name = resultvo[scount].getItems()[rcount].getAllValue();
                    int count = resultvo[scount].getItems()[rcount].getCount();
                    if (com.hr319wg.util.CommonFuns.filterNull(name).length() > 15)
                        name = name.substring(0, 15) + "...";
                    pos++;
                    data.setValue(pos + ". " + name, count);
                }
            }
        }
        else{
            for (int i = 0; i < resultvo.length; i++) {
                    String name = resultvo[i].getItems()[0].getAllValue();
                    int count = resultvo[i].getItems()[0].getCount();
                    if (com.hr319wg.util.CommonFuns.filterNull(name).length() > 15)
                        name = name.substring(0, 15) + "...";
                    pos++;
                    data.setValue(pos + ". " + name, count);
            }
        }

        String basePath = application.getRealPath("/");
        String filename = CommonFuns.getUUID()+".jpg";
        org.jfree.chart.JFreeChart chart = org.jfree.chart.ChartFactory.createPieChart("", data, true, false, false);
        File file = new File(basePath+File.separator+"file"+File.separator+"tmp"+File.separator+filename);
        org.jfree.chart.ChartUtilities.saveChartAsJPEG(file, 100, chart, Integer.parseInt(width), Integer.parseInt(height), null);
        out.println("<img src='/file/tmp/"+filename+"'>");
    } else {
        out.println("没有数据,无法显示图片");
    }
%>
</td></tr>
</table>
