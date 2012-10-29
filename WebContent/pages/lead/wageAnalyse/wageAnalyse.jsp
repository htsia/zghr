<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.service.ActivePageService" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultItemVO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.hr319wg.lead.service.LeadAnaService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.lead.pojo.bo.LeadWageAnalyseBO" %>

<html>
<head>
<script language="javascript">
   	    var sel1;
        var xmlHttp;
        var superId = "";

        //创建XMLHttpRequest对象
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest(); 
            }
        }

        function handleStateChange() {
            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                    //解析从xml文件得到的结果,动态画树
                    parseResults();
            }
            }
        }

        //解析从xml文件得到的结果 ，动态画树
        function parseResults() {
            var results = xmlHttp.responseXML;
            document.dataDisplay.location.href="/pages/qry/StaticResultBar.jsp?height=130&width=600&valueType=sum";

        }

        function refreshData(superId,orgName){
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("GET", "/pages/project/hrtn/refreshData.jsp?superId=" + superId, true);
	        document.all('legend').innerHTML="<strong>图例："+orgName+"</strong>";
            xmlHttp.send(null);
        }

         function showDes(){
            window.showModalDialog("/lead/itemDescription.jsf?items="+document.all("sel").value, null, "dialogHeight=320px,dialogWidth=550px,center=1");
         }
        //管理人员工资
	function refreshGovern(){
	    form.submit();
	}
	//对比
	function contrast(){
	    var winValue = window.showModalDialog("wageAnalyseYear.jsp", null, "dialogHeight=200px,dialogWidth=200px,center=1"); 
		document.all('monthStr').value=winValue;
		form.submit();
   }

	
</script>
</head>

<body>
<link href="/css/styleDesktop.css" rel="stylesheet" type="text/css"/>
<style type="text/css">

.style1
{
    font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border:2px solid #555555;
}
.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style1 TR {
	FONT-SIZE: 9pt; COLOR: #555555; 
	border:1px solid #555555;
}
.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	vertical-align:middle;
	font-family: "宋体";
	border:1px solid #555555;
}

</style>
<form id="form">
<input type="hidden" name="monthStr" id="monthStr"></input>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    ActivePageService activepageservice = (ActivePageService) SysContext.getBean("sys_activePageService");
    LeadAnaService leadservice = (LeadAnaService) SysContext.getBean("lead_anaservice");
    List anaitems = leadservice.getAllList();
    String sql = "";
    CellVO[] cv = new CellVO[1];
    String sel = request.getParameter("sel");
    if (sel == null) sel = ((LeadWageAnalyseBO)anaitems.get(0)).getItemID();
    String[] month = null;
    String hide = CommonFuns.filterNull(request.getParameter("monthStr"));
    if (hide != null && !"".equals(hide)) {
        month = hide.split(",");
    } else {
        sql = "select distinct(substring(b721702,1,4)) as b721702 from b721 order by substring(b721702,1,4)";
        cv[0] = new CellVO();
        cv[0].setItemId("b721702");
        Vector vtmonth = activepageservice.getDataListBySql(cv, sql);
        month = new String[vtmonth.size()];
        for (int i = 0; i < vtmonth.size(); i++) {
            CellVO[] row = (CellVO[]) vtmonth.get(i);
            month[i] = row[0].getValue();
        }
    }
    session.setAttribute("month", month);
    int iwidth = 140 + month.length * 120;
    String width = String.valueOf(iwidth);

    // 合计数据
    LeadWageAnalyseBO lbo=leadservice.getLeadWageAnalyseBO(sel);
    String sumfield="0";
    String []fields=lbo.getFields().split(",");
    for(int k=0;k<fields.length;k++){
        sumfield+="+ISNULL("+fields[k]+",0)";
    }
    sumfield=" sum("+sumfield+") as wagesum ";
    sql = "select substring(b721702,1,4) as b721702,"+sumfield+" from b721 group by substring(b721702,1,4) order by substring(b721702,1,4)";
    cv = new CellVO[2];
    cv[0] = new CellVO();
    cv[0].setItemId("b721702");
    cv[1] = new CellVO();
    cv[1].setItemId("wagesum");
    Vector vtsum = activepageservice.getDataListBySql(cv, sql);
    Hashtable htsum = new Hashtable();
    for (int i = 0; i < vtsum.size(); i++) {
        CellVO[] row = (CellVO[]) vtsum.get(i);
        htsum.put(row[0].getValue(), row[1].getValue());
    }

    // 显示合计行图像
    StaticResultVO[] resultvo = new StaticResultVO[month.length];
    for (int i = 0; i < month.length; i++) {
        String value = (String) htsum.get(month[i]);
        resultvo[i] = new StaticResultVO();
        StaticResultItemVO[] items = new StaticResultItemVO[1];
        items[0] = new StaticResultItemVO();
        items[0].setAllValue(month[i] + "年");   // 设置标题
        items[0].setSum(value);      // 设置数值
        resultvo[i].setItems(items);
    }
    session.setAttribute("STATIC_RESULT", resultvo);

    //明细数据
    sql = "select orguid||'|'||substring(b721702,1,4) as b721702,"+sumfield+" from b721 group by orguid,substring(b721702,1,4)";

    cv = new CellVO[2];
    cv[0] = new CellVO();
    cv[0].setItemId("b721702");
    cv[1] = new CellVO();
    cv[1].setItemId("wagesum");

    Vector vtdetail = activepageservice.getDataListBySql(cv, sql);
    Hashtable htdetail = new Hashtable();
    for (int i = 0; i < vtdetail.size(); i++) {
        CellVO[] row = (CellVO[]) vtdetail.get(i);
        htdetail.put(row[0].getValue(), row[1].getValue());
    }
    session.setAttribute("htdetail", htdetail);

%>
 <table align="center" border="0" width="98%">
   <tr>
    <td align="center">
         <span style="font-size: 18pt; font-family: 楷体_GB2312"><strong>薪  酬  分  析</strong></span>
    </td>
   </tr>

   <tr>
    <td align="right">
         <span style="font-size: 11pt; font-family: 楷体_GB2312">请选择分析模型</span>
         <select id="sel" name="sel">
            <%
                for (int k = 0; k < anaitems.size(); k++) {
                    LeadWageAnalyseBO lwbo = (LeadWageAnalyseBO)anaitems.get(k);
                    out.println("<option value=\""+lwbo.getItemID()+"\">"+lwbo.getItemName()+"</option>");
                }
            %>
         </select>
        <input type="button" onclick="showDes()" value="项目解释" class="button01"/>
        <input type="button" onclick="refreshGovern()" value="刷新" class="button01"/>
        <input type="button" onclick="contrast()" value="对比" class="button01"/>
    </td>
  </tr>

  <tr>
    <td>
     <iframe id="dataDisplay" name="dataDisplay" frameborder="0" height="180" width="100%" src="/pages/qry/StaticResultBar.jsp?height=130&width=600&valueType=sum"></iframe>
    </td>
  </tr>

  <tr>
    <td align="center">
      <span id="legend" style="font-size: 8pt; font-family: 楷体_GB2312"><strong>图例：合计</strong></span>
    </td>
  </tr>
 </table>


 <table align="center" border="1" class='style1' >
  <tr>
     <td width=140 align="center" valign="middle"></td>
        <%
          for(int i=0;i<month.length;i++){
            out.println("<td align=center valign=middle height=20 width=120><strong>"+month[i]+"</strong></td>");
          }
        %>
  </tr>
     
  <tr>
     <td width=80 align="center" valign="middle"><strong>合计</strong></td>
         <%
            for(int i=0;i<month.length;i++){
              out.println("<td align=center valign=middle height=20 width=120>"+CommonFuns.filterNull(htsum.get(month[i]).toString())+"</td>");
            }
         %>
  </tr>
	
	<%
	 	String sql2="select orguid,b001005 from b001 where b001002='1007588' order by b001010";
        CellVO []cv2=new CellVO[2];
        cv2[0]=new CellVO();
        cv2[0].setItemId("orguid");
        cv2[1]=new CellVO();
        cv2[1].setItemId("b001005");

        Vector vt2=activepageservice.getDataListBySql(cv2,sql2);
        for(int i=0;i<vt2.size();i++){
            CellVO[]rowc=(CellVO[])vt2.get(i);
            String row2="<tr><td align=center  valign=middle height=20><A href=\"javascript:refreshData('"+rowc[0].getValue()+"','"+rowc[1].getValue()+"')\">";
            row2+=rowc[1].getValue();
	    	row2+="</A></td>";
            for(int j=0;j<month.length;j++){
                String index=rowc[0].getValue()+"|"+month[j];
                if (htdetail.get(index)!=null){
                      row2+="<td align=center valign=middle height=20 width=120>"+htdetail.get(index).toString()+"</td>";
                }
                else{
                      row2+="<td align=center valign=middle height=20 width=120></td>";
                }
            }
            row2+="</tr>"; 
	        out.println(row2);
	  }
    %>
</table>
</form>
<script language="javascript">
    <%
        for(int k=0;k<anaitems.size();k++){
            LeadWageAnalyseBO lwbo = (LeadWageAnalyseBO)anaitems.get(k);
            if (sel.equals(lwbo.getItemID())){
                out.println("document.all(\"sel\").selectedIndex="+k+";");
                break;
            }
        }
    %>

    document.all("monthStr").value="<%=hide%>";
</script>
</body>
</html>
