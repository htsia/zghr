<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.ccp.util.CcpConstants" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.ccp.ucc.IPartyUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.ccp.pojo.bo.PartyBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.ccp.util.CcpTools" %>
<%@ page import="java.math.BigDecimal"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
</head>

<body>
<%

				/*------党费收入-------*/

    //中央各金融机构
    BigDecimal bz1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal bz2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal bz3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal bz4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal bz5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal bz6 = new BigDecimal(0.0);//行政拨款
    BigDecimal bz7 = new BigDecimal(0.0);//利息
    BigDecimal bz8 = new BigDecimal(0.0);//其他收入
    BigDecimal bz9 = new BigDecimal(0.0);//合计
    //省级分支机构
    BigDecimal bs1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal bs2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal bs3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal bs4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal bs5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal bs6 = new BigDecimal(0.0);//行政拨款
    BigDecimal bs7 = new BigDecimal(0.0);//利息
    BigDecimal bs8 = new BigDecimal(0.0);//其他收入
    BigDecimal bs9 = new BigDecimal(0.0);//合计
    //地市级分支机构
    BigDecimal bd1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal bd2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal bd3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal bd4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal bd5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal bd6 = new BigDecimal(0.0);//行政拨款
    BigDecimal bd7 = new BigDecimal(0.0);//利息
    BigDecimal bd8 = new BigDecimal(0.0);//其他收入
    BigDecimal bd9 = new BigDecimal(0.0);//合计
    //收入合计
    BigDecimal bsum1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal bsum2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal bsum3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal bsum4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal bsum5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal bsum6 = new BigDecimal(0.0);//行政拨款
    BigDecimal bsum7 = new BigDecimal(0.0);//利息
    BigDecimal bsum8 = new BigDecimal(0.0);//其他收入
    BigDecimal bsum9 = new BigDecimal(0.0);//合计
    
     /*------党费支出-------*/
    
    //中央各金融机构
    BigDecimal lz1 = new BigDecimal(0.0);//上缴中央
    BigDecimal lz2 = new BigDecimal(0.0);//上缴中央各金融机构党委
    BigDecimal lz3 = new BigDecimal(0.0);//上缴地方党委
    BigDecimal lz4 = new BigDecimal(0.0);//上缴省级分支机构党委
    BigDecimal lz5 = new BigDecimal(0.0);//下拨款
    BigDecimal lz6 = new BigDecimal(0.0);//学习资料
    BigDecimal lz7 = new BigDecimal(0.0);//管理教育支出
    BigDecimal lz8 = new BigDecimal(0.0);//创先争优支出
    BigDecimal lz9 = new BigDecimal(0.0);//困难补助支出
    BigDecimal lz10 = new BigDecimal(0.0);//其他支出
    BigDecimal lz11 = new BigDecimal(0.0);//小计
    BigDecimal lz12 = new BigDecimal(0.0);//合计
    BigDecimal lz13 = new BigDecimal(0.0);//本年末结存党费数
    //省级分支机构
    BigDecimal ls1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal ls2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal ls3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal ls4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal ls5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal ls6 = new BigDecimal(0.0);//行政拨款
    BigDecimal ls7 = new BigDecimal(0.0);//利息
    BigDecimal ls8 = new BigDecimal(0.0);//其他收入
    BigDecimal ls9 = new BigDecimal(0.0);//合计
    BigDecimal ls10 = new BigDecimal(0.0);//其他支出
    BigDecimal ls11 = new BigDecimal(0.0);//小计
    BigDecimal ls12 = new BigDecimal(0.0);//合计
    BigDecimal ls13 = new BigDecimal(0.0);//本年末结存党费数
    //地市级分支机构
    BigDecimal ld1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal ld2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal ld3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal ld4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal ld5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal ld6 = new BigDecimal(0.0);//行政拨款
    BigDecimal ld7 = new BigDecimal(0.0);//利息
    BigDecimal ld8 = new BigDecimal(0.0);//其他收入
    BigDecimal ld9 = new BigDecimal(0.0);//合计
    BigDecimal ld10 = new BigDecimal(0.0);//其他支出
    BigDecimal ld11 = new BigDecimal(0.0);//小计
    BigDecimal ld12 = new BigDecimal(0.0);//合计
    BigDecimal ld13 = new BigDecimal(0.0);//本年末结存党费数
  //支出合计
    BigDecimal lsum1 = new BigDecimal(0.0);//上缴中央
    BigDecimal lsum2 = new BigDecimal(0.0);//上缴中央各金融机构党委
    BigDecimal lsum3 = new BigDecimal(0.0);//上缴地方党委
    BigDecimal lsum4 = new BigDecimal(0.0);//上缴省级分支机构党委
    BigDecimal lsum5 = new BigDecimal(0.0);//下拨款
    BigDecimal lsum6 = new BigDecimal(0.0);//学习资料支出
    BigDecimal lsum7 = new BigDecimal(0.0);//管理教育支出
    BigDecimal lsum8 = new BigDecimal(0.0);//创先争优支出
    BigDecimal lsum9 = new BigDecimal(0.0);//困难补助支出
    BigDecimal lsum10 = new BigDecimal(0.0);//其他支出
    BigDecimal lsum11 = new BigDecimal(0.0);//小计
    BigDecimal lsum12 = new BigDecimal(0.0);//合计
    BigDecimal lsum13 = new BigDecimal(0.0);//本年末结存党费数
    
    try {
        IPartyUCC partyucc = (IPartyUCC) SysContext.getBean("ccp_partyUCC");
        String sd = CommonFuns.filterNull(request.getParameter("sdate"));
        String ed = CommonFuns.filterNull(request.getParameter("edate"));
        
        List list = partyucc.queryPartyFeeReport(request.getParameter("pid"),sd,ed);
        if (list == null || list.size() == 0) {
        	out.print("没有数据可以导出!");
        }
        else {
            for (int i = 0; i < list.size(); i++) {
                Map map = (Map) list.get(i);
                PartyBO bo = SysCacheTool.findParty(CommonFuns.filterNull((String) map.get("PARTYID")));
                if (bo == null) {
                    bo = SysCacheTool.findParty(request.getParameter("pid"));
                }
                String partyType = bo.getMemberType();
				String superId = bo.getSuperId();
                String bsubject = CommonFuns.filterNull((String) map.get(CcpConstants.D015015));
                String lsubject = CommonFuns.filterNull((String) map.get(CcpConstants.D015020));
                String bvalue = CommonFuns.filterNull(String.valueOf(map.get(CcpConstants.D015025)));
                if (bvalue.trim().equals("")) {
                    bvalue = "0.0";
                }
                String lvalue = CommonFuns.filterNull(String.valueOf(map.get(CcpConstants.D015030)));
                if (lvalue.trim().equals("")) {
                    lvalue = "0.0";
                }

                if (partyType.equals("0891101")){//上级
                    //借方科目
                    if (bsubject.equals("10453001")) {//期初实存党费数
                        bz1 = bz1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10453002")) {//期末结存党费数
                        lz13 = lz13.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455001")) {//党员缴纳党费
                        bz2 = bz2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455002")) {//地市级分支机构党委上缴
                        bz3 = bz3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455003")) {//省级分支机构党委上缴
                        bz4 = bz4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455004")) {//上级党组织拨款
                        bz5 = bz5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455005")) {//行政拨款
                        bz6 = bz6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455006")) {//利息收入
                        bz7 = bz7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455007")) {//其他收入
                        bz8 = bz8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456001")) {//上缴中央
                        lz1 = lz1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456002")) {//上缴中央各金融机构党委
                        lz2 = lz2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456003")) {//上缴上级党委
                        lz2 = lz2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456004")) {//上缴省级分支机构党委
                        lz4 = lz4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456005")) {//上缴地方党委
                        lz3 = lz3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456006")) {//下拨款
                        lz5 = lz5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456007")) {//学习资料支出
                        lz6 = lz6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456008")) {//管理教育支出
                        lz7 = lz7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456009")) {//创先争优支出
                        lz8 = lz8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456010")) {//困难补助支出
                        lz9 = lz9.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456099")) {//其他支出
                        lz10 = lz10.add(new BigDecimal(bvalue));
                    }
                    //贷方科目
                    if (lsubject.equals("10453001")) {//期初实存党费数
                        bz1 = bz1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10453002")) {//期末结存党费数
                        lz13 = lz13.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455001")) {//党员缴纳党费
                        bz2 = bz2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455002")) {//地市级分支机构党委上缴
                        bz3 = bz3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455003")) {//省级分支机构党委上缴
                        bz4 = bz4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455004")) {//上级党组织拨款
                        bz5 = bz5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455005")) {//行政拨款
                        bz6 = bz6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455006")) {//利息收入
                        bz7 = bz7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455007")) {//其他收入
                        bz8 = bz8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456001")) {//上缴中央
                        lz1 = lz1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456002")) {//上缴中央各金融机构党委
                        lz2 = lz2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456003")) {//上缴上级党委
                        lz2 = lz2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456004")) {//上缴省级分支机构党委
                        lz4 = lz4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456005")) {//上缴地方党委
                        lz3 = lz3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456006")) {//下拨款
                        lz5 = lz5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456007")) {//学习资料支出
                        lz6 = lz6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456008")) {//管理教育支出
                        lz7 = lz7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456009")) {//创先争优支出
                        lz8 = lz8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456010")) {//困难补助支出
                        lz9 = lz9.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456099")) {//其他支出
                        lz10 = lz10.add(new BigDecimal(lvalue));
                    }
                }else if (partyType.substring(5,6).equals("1") || partyType.substring(5,6).equals("9") || partyType.equals("0891900") && superId.equals("100")){//省级分支机构
                    //借方科目
                    if (bsubject.equals("10453001")) {//期初实存党费数
                        bs1 = bs1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10453002")) {//期末结存党费数
                        ls13 = ls13.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455001")) {//党员缴纳党费
                        bs2 = bs2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455002")) {//地市级分支机构党委上缴
                        bs3 = bs3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455003")) {//省级分支机构党委上缴
                        bs4 = bs4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455004")) {//上级党组织拨款
                        bs5 = bs5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455005")) {//行政拨款
                        bs6 = bs6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455006")) {//利息收入
                        bs7 = bs7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455007")) {//其他收入
                        bs8 = bs8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456001")) {//上缴中央
                        ls1 = ls1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456002")) {//上缴中央各金融机构党委
                        ls2 = ls2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456003")) {//上缴上级党委
                        ls2 = ls2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456004")) {//上缴省级分支机构党委
                        ls4 = ls4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456005")) {//上缴地方党委
                        ls3 = ls3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456006")) {//下拨款
                        ls5 = ls5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456007")) {//学习资料支出
                        ls6 = ls6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456008")) {//管理教育支出
                        ls7 = ls7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456009")) {//创先争优支出
                        ls8 = ls8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456010")) {//困难补助支出
                        ls9 = ls9.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456099")) {//其他支出
                        ls10 = ls10.add(new BigDecimal(bvalue));
                    }
                    //贷方科目
                    if (lsubject.equals("10453001")) {//期初实存党费数
                        bs1 = bs1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10453002")) {//期末结存党费数
                        ls13 = ls13.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455001")) {//党员缴纳党费
                        bs2 = bs2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455002")) {//地市级分支机构党委上缴
                        bs3 = bs3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455003")) {//省级分支机构党委上缴
                        bs4 = bs4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455004")) {//上级党组织拨款
                        bs5 = bs5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455005")) {//行政拨款
                        bs6 = bs6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455006")) {//利息收入
                        bs7 = bs7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455007")) {//其他收入
                        bs8 = bs8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456001")) {//上缴中央
                        ls1 = ls1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456002")) {//上缴中央各金融机构党委
                        ls2 = ls2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456003")) {//上缴上级党委
                        ls2 = ls2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456004")) {//上缴省级分支机构党委
                        ls4 = ls4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456005")) {//上缴地方党委
                        ls3 = ls3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456006")) {//下拨款
                        ls5 = ls5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456007")) {//学习资料支出
                        ls6 = ls6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456008")) {//管理教育支出
                        ls7 = ls7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456009")) {//创先争优支出
                        ls8 = ls8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456010")) {//困难补助支出
                        ls9 = ls9.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456099")) {//其他支出
                        ls10 = ls10.add(new BigDecimal(lvalue));
                    }
                }else{//地市级分支机构
                    //借方科目
                    if (bsubject.equals("10453001")) {//期初实存党费数
                        bd1 = bd1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10453002")) {//期末结存党费数
                        ld13 = ld13.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455001")) {//党员缴纳党费
                        bd2 = bd2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455002")) {//地市级分支机构党委上缴
                        bd3 = bd3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455003")) {//省级分支机构党委上缴
                        bd4 = bd4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455004")) {//上级党组织拨款
                        bd5 = bd5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455005")) {//行政拨款
                        bd6 = bd6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455006")) {//利息收入
                        bd7 = bd7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455007")) {//其他收入
                        bd8 = bd8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456001")) {//上缴中央
                        ld1 = ld1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456002")) {//上缴中央各金融机构党委
                        ld2 = ld2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456003")) {//上缴上级党委
                        ld2 = ld2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456004")) {//上缴省级分支机构党委
                        ld4 = ld4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456005")) {//上缴地方党委
                        ld3 = ld3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456006")) {//下拨款
                        ld5 = ld5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456007")) {//学习资料支出
                        ld6 = ld6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456008")) {//管理教育支出
                        ld7 = ld7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456009")) {//创先争优支出
                        ld8 = ld8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456010")) {//困难补助支出
                        ld9 = ld9.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456099")) {//其他支出
                        ld10 = ld10.add(new BigDecimal(bvalue));
                    }
                    //贷方科目
                    if (lsubject.equals("10453001")) {//期初实存党费数
                        bd1 = bd1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10453002")) {//期末结存党费数
                        ld13 = ld13.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455001")) {//党员缴纳党费
                        bd2 = bd2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455002")) {//地市级分支机构党委上缴
                        bd3 = bd3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455003")) {//省级分支机构党委上缴
                        bd4 = bd4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455004")) {//上级党组织拨款
                        bd5 = bd5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455005")) {//行政拨款
                        bd6 = bd6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455006")) {//利息收入
                        bd7 = bd7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455007")) {//其他收入
                        bd8 = bd8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456001")) {//上缴中央
                        ld1 = ld1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456002")) {//上缴中央各金融机构党委
                        ld2 = ld2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456003")) {//上缴上级党委
                        ld2 = ld2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456004")) {//上缴省级分支机构党委
                        ld4 = ld4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456005")) {//上缴地方党委
                        ld3 = ld3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456006")) {//下拨款
                        ld5 = ld5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456007")) {//学习资料支出
                        ld6 = ld6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456008")) {//管理教育支出
                        ld7 = ld7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456009")) {//创先争优支出
                        ld8 = ld8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456010")) {//困难补助支出
                        ld9 = ld9.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456099")) {//其他支出
                        ld10 = ld10.add(new BigDecimal(lvalue));
                    }
                }
            }
            bz9 = bz2.add(bz3).add(bz4).add(bz5).add(bz6).add(bz7).add(bz8);
            lz11 = lz6.add(lz7).add(lz8).add(lz9).add(lz10);
            lz12 = lz1.add(lz2).add(lz3).add(lz4).add(lz5).add(lz11);
            lz13 = bz1.add(bz9).add(lz12.multiply(new BigDecimal(-1)));

            bs9 = bs2.add(bs3).add(bs4).add(bs5).add(bs6).add(bs7).add(bs8);
            ls11 = ls6.add(ls7).add(ls8).add(ls9).add(ls10);
            ls12 = ls1.add(ls2).add(ls3).add(ls4).add(ls5).add(ls11);
            ls13 = bs1.add(bs9).add(ls12.multiply(new BigDecimal(-1)));

            bd9 = bd2.add(bd3).add(bd4).add(bd5).add(bd6).add(bd7).add(bd8);
            ld11 = ld6.add(ld7).add(ld8).add(ld9).add(ld10);
            ld12 = ld1.add(ld2).add(ld3).add(ld4).add(ld5).add(ld11);
            ld13 = bd1.add(bd9).add(ld12.multiply(new BigDecimal(-1)));

            bsum1 = bz1.add(bs1).add(bd1);//上年实存党费数
            bsum2 = bz2.add(bs2).add(bd2);//本年度党员交纳党费总额
            bsum3 = bz3.add(bs3).add(bd3);//地市级分支机构党委上缴
            bsum4 = bz4.add(bs4).add(bd4);//省级分支机构党委上缴
            bsum5 = bz5.add(bs5).add(bd5);//上级党组织拨款
            bsum6 = bz6.add(bs6).add(bd6);//行政拨款
            bsum7 = bz7.add(bs7).add(bd7);//利息
            bsum8 = bz8.add(bs8).add(bd8);//其他收入
            bsum9 = bz9.add(bs9).add(bd9);//合计

            lsum1 = lz1.add(ls1).add(ld1);//上缴中央
            lsum2 = lz2.add(ls2).add(ld2);//上缴中央各金融机构党委
            lsum3 = lz3.add(ls3).add(ld3);//上缴地方党委
            lsum4 = lz4.add(ls4).add(ld4);//上缴省级分支机构党委
            lsum5 = lz5.add(ls5).add(ld5);//下拨款
            lsum6 = lz6.add(ls6).add(ld6);//学习资料支出
            lsum7 = lz7.add(ls7).add(ld7);//管理教育支出
            lsum8 = lz8.add(ls8).add(ld8);//创先争优支出
            lsum9 = lz9.add(ls9).add(ld9);//困难补助支出
            lsum10 = lz10.add(ls10).add(ld10);//其他支出
            lsum11 = lz11.add(ls11).add(ld11);//小计
            lsum12 = lz12.add(ls12).add(ld12);//合计
            lsum13 = lz13.add(ls13).add(ld13);//本年末结存党费数

            Hashtable ht = new Hashtable();
            ht.put("<党组织>", CommonFuns.filterNull(CommonFuns.filterNull(CodeUtil.interpertCode("PA", request.getParameter("pid")))));
            if (sd.equals("")){
                sd = CommonFuns.getSysDate("yyyy")+"-01-01";
            }
            if (ed.equals("")){
                ed = CommonFuns.getSysDate("yyyy")+"-12-31";
            }
            ht.put("<年度>", sd.substring(0,4) + "年"+sd.substring(5,7)+"月"+sd.substring(8)+"日至" + ed.substring(0,4) + "年"+ed.substring(5,7)+"月"+ed.substring(8)+"日");
            ht.put("<年度1>", CommonFuns.getSysDate("yyyy") + "年 "+CommonFuns.getSysDate("MM")+"月 "+CommonFuns.getSysDate("dd")+" 日");
            ht.put("<中央上年实存>", CommonFuns.filterNull(String.valueOf(bz1)));
            ht.put("<中央交纳党费>", CommonFuns.filterNull(String.valueOf(bz2)));
            ht.put("<中央地市级上缴>", CommonFuns.filterNull(String.valueOf(bz3)));
            ht.put("<中央省级上缴>", CommonFuns.filterNull(String.valueOf(bz4)));
            ht.put("<中央组织拨款>", CommonFuns.filterNull(String.valueOf(bz5)));
            ht.put("<中央行政拨款>", CommonFuns.filterNull(String.valueOf(bz6)));
            ht.put("<中央利息>", CommonFuns.filterNull(String.valueOf(bz7)));
            ht.put("<中央其他收入>", CommonFuns.filterNull(String.valueOf(bz8)));
            ht.put("<中央合计>", CommonFuns.filterNull(String.valueOf(bz9)));

            ht.put("<省级上年实存>", CommonFuns.filterNull(String.valueOf(bs1)));
            ht.put("<省级交纳党费>", CommonFuns.filterNull(String.valueOf(bs2)));
            ht.put("<省级地市级上缴>", CommonFuns.filterNull(String.valueOf(bs3)));
            ht.put("<省级省级上缴>", CommonFuns.filterNull(String.valueOf(bs4)));
            ht.put("<省级组织拨款>", CommonFuns.filterNull(String.valueOf(bs5)));
            ht.put("<省级行政拨款>", CommonFuns.filterNull(String.valueOf(bs6)));
            ht.put("<省级利息>", CommonFuns.filterNull(String.valueOf(bs7)));
            ht.put("<省级其他收入>", CommonFuns.filterNull(String.valueOf(bs8)));
            ht.put("<省级合计>", CommonFuns.filterNull(String.valueOf(bs9)));

            ht.put("<地市上年实存>", CommonFuns.filterNull(String.valueOf(bd1)));
            ht.put("<地市交纳党费>", CommonFuns.filterNull(String.valueOf(bd2)));
            ht.put("<地市地市级上缴>", CommonFuns.filterNull(String.valueOf(bd3)));
            ht.put("<地市省级上缴>", CommonFuns.filterNull(String.valueOf(bd4)));
            ht.put("<地市组织拨款>", CommonFuns.filterNull(String.valueOf(bd5)));
            ht.put("<地市行政拨款>", CommonFuns.filterNull(String.valueOf(bd6)));
            ht.put("<地市利息>", CommonFuns.filterNull(String.valueOf(bd7)));
            ht.put("<地市其他收入>", CommonFuns.filterNull(String.valueOf(bd8)));
            ht.put("<地市合计>", CommonFuns.filterNull(String.valueOf(bd9)));

            ht.put("<中央上缴>", CommonFuns.filterNull(String.valueOf(lz1)));
            ht.put("<中央上缴中央>", CommonFuns.filterNull(String.valueOf(lz2)));
            ht.put("<中央上缴地方>", CommonFuns.filterNull(String.valueOf(lz3)));
            ht.put("<中央上缴省级>", CommonFuns.filterNull(String.valueOf(lz4)));
            ht.put("<中央下拨款>", CommonFuns.filterNull(String.valueOf(lz5)));
            ht.put("<中央学习>", CommonFuns.filterNull(String.valueOf(lz6)));
            ht.put("<中央教育>", CommonFuns.filterNull(String.valueOf(lz7)));
            ht.put("<中央创先>", CommonFuns.filterNull(String.valueOf(lz8)));
            ht.put("<中央困难>", CommonFuns.filterNull(String.valueOf(lz9)));
            ht.put("<中央其他>", CommonFuns.filterNull(String.valueOf(lz10)));
            ht.put("<中央小计>", CommonFuns.filterNull(String.valueOf(lz11)));
            ht.put("<中央合计1>", CommonFuns.filterNull(String.valueOf(lz12)));
            ht.put("<中央本年末结存>", CommonFuns.filterNull(String.valueOf(lz13)));

            ht.put("<省级上缴>", CommonFuns.filterNull(String.valueOf(ls1)));
            ht.put("<省级上缴中央>", CommonFuns.filterNull(String.valueOf(ls2)));
            ht.put("<省级上缴地方>", CommonFuns.filterNull(String.valueOf(ls3)));
            ht.put("<省级上缴省级>", CommonFuns.filterNull(String.valueOf(ls4)));
            ht.put("<省级下拨款>", CommonFuns.filterNull(String.valueOf(ls5)));
            ht.put("<省级学习>", CommonFuns.filterNull(String.valueOf(ls6)));
            ht.put("<省级教育>", CommonFuns.filterNull(String.valueOf(ls7)));
            ht.put("<省级创先>", CommonFuns.filterNull(String.valueOf(ls8)));
            ht.put("<省级困难>", CommonFuns.filterNull(String.valueOf(ls9)));
            ht.put("<省级其他>", CommonFuns.filterNull(String.valueOf(ls10)));
            ht.put("<省级小计>", CommonFuns.filterNull(String.valueOf(ls11)));
            ht.put("<省级合计1>", CommonFuns.filterNull(String.valueOf(ls12)));
            ht.put("<省级本年末结存>", CommonFuns.filterNull(String.valueOf(ls13)));

            ht.put("<地市上缴>", CommonFuns.filterNull(String.valueOf(ld1)));
            ht.put("<地市上缴中央>", CommonFuns.filterNull(String.valueOf(ld2)));
            ht.put("<地市上缴地方>", CommonFuns.filterNull(String.valueOf(ld3)));
            ht.put("<地市上缴省级>", CommonFuns.filterNull(String.valueOf(ld4)));
            ht.put("<地市下拨款>", CommonFuns.filterNull(String.valueOf(ld5)));
            ht.put("<地市学习>", CommonFuns.filterNull(String.valueOf(ld6)));
            ht.put("<地市教育>", CommonFuns.filterNull(String.valueOf(ld7)));
            ht.put("<地市创先>", CommonFuns.filterNull(String.valueOf(ld8)));
            ht.put("<地市困难>", CommonFuns.filterNull(String.valueOf(ld9)));
            ht.put("<地市其他>", CommonFuns.filterNull(String.valueOf(ld10)));
            ht.put("<地市小计>", CommonFuns.filterNull(String.valueOf(ld11)));
            ht.put("<地市合计1>", CommonFuns.filterNull(String.valueOf(ld12)));
            ht.put("<地市本年末结存>", CommonFuns.filterNull(String.valueOf(ld13)));

            ht.put("<总计上年实存>", CommonFuns.filterNull(String.valueOf(bsum1)));
            ht.put("<总计交纳党费>", CommonFuns.filterNull(String.valueOf(bsum2)));
            ht.put("<总计地市级上缴>", CommonFuns.filterNull(String.valueOf(bsum3)));
            ht.put("<总计省级上缴>", CommonFuns.filterNull(String.valueOf(bsum4)));
            ht.put("<总计组织拨款>", CommonFuns.filterNull(String.valueOf(bsum5)));
            ht.put("<总计行政拨款>", CommonFuns.filterNull(String.valueOf(bsum6)));
            ht.put("<总计利息>", CommonFuns.filterNull(String.valueOf(bsum7)));
            ht.put("<总计其他收入>", CommonFuns.filterNull(String.valueOf(bsum8)));
            ht.put("<总计合计>", CommonFuns.filterNull(String.valueOf(bsum9)));

            ht.put("<总计上缴>", CommonFuns.filterNull(String.valueOf(lsum1)));
            ht.put("<总计上缴中央>", CommonFuns.filterNull(String.valueOf(lsum2)));
            ht.put("<总计上缴地方>", CommonFuns.filterNull(String.valueOf(lsum3)));
            ht.put("<总计上缴省级>", CommonFuns.filterNull(String.valueOf(lsum4)));
            ht.put("<总计下拨款>", CommonFuns.filterNull(String.valueOf(lsum5)));
            ht.put("<总计学习>", CommonFuns.filterNull(String.valueOf(lsum6)));
            ht.put("<总计教育>", CommonFuns.filterNull(String.valueOf(lsum7)));
            ht.put("<总计创先>", CommonFuns.filterNull(String.valueOf(lsum8)));
            ht.put("<总计困难>", CommonFuns.filterNull(String.valueOf(lsum9)));
            ht.put("<总计其他>", CommonFuns.filterNull(String.valueOf(lsum10)));
            ht.put("<总计小计>", CommonFuns.filterNull(String.valueOf(lsum11)));
            ht.put("<总计合计1>", CommonFuns.filterNull(String.valueOf(lsum12)));
            ht.put("<总计本年末结存>", CommonFuns.filterNull(String.valueOf(lsum13)));

            String docName = CommonFuns.getSysDate("yyyyMMddHHmmss") + "_" + new Random().nextInt(10000);
            String ret = CcpTools.filefillCard(docName, ht, "partyfeereport.xls", getServletConfig().getServletContext().getRealPath("/"));
            response.sendRedirect(ret);
     }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
