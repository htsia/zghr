<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.io.File" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultVO" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<table align=center border=0>
<tr><td align=center valign="middle">
<%
    StaticResultVO[] resultvo = (StaticResultVO[]) session.getAttribute("STATIC_RESULT");
    String[] ids = request.getParameterValues("chkId");
    String height = request.getParameter("height");
    String valueType=request.getParameter("valueType");  // count sum
    if (valueType==null){
        valueType="count";
    }
    if (height == null || "".equals(height)) height = "400";
    String width = request.getParameter("width");
    if (width == null || "".equals(width)) width = "600";

    if (resultvo != null) {
        DefaultCategoryDataset data = new DefaultCategoryDataset();

        int pos = 0;
        if (ids != null) {
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
                    data.addValue(count, "22", pos + ". " + name);
                }
            }
        } else {
            for (int i = 0; i < resultvo.length; i++) {
                String name = resultvo[i].getItems()[0].getAllValue();
                int count = resultvo[i].getItems()[0].getCount();
                double sum=Double.parseDouble(resultvo[i].getItems()[0].getSum());
                if (com.hr319wg.util.CommonFuns.filterNull(name).length() > 20)
                    name = name.substring(0, 20) + "...";
                pos++;
                if ("sum".equals(valueType)){
                    data.addValue(sum, "22", name);
                }
                else{
                    data.addValue(count, "22",name);
                }
            }
        }


        org.jfree.chart.JFreeChart chart = org.jfree.chart.ChartFactory.createBarChart("", "", "", data, org.jfree.chart.plot.PlotOrientation.VERTICAL, false, false, false);
        String basePath = application.getRealPath("/");
        String filename = CommonFuns.getUUID() + ".jpg";
        File file = new File(basePath + File.separator + "file" + File.separator + "tmp" + File.separator + filename);
        org.jfree.chart.ChartUtilities.saveChartAsJPEG(file, 100, chart, Integer.parseInt(width), Integer.parseInt(height), null);
        out.println("<img src='/file/tmp/" + filename + "'>");
    } else {
        out.println("没有数据,无法显示图片");
    }

%>
</td></tr>
</table>
