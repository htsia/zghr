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

				/*------��������-------*/

    //��������ڻ���
    BigDecimal bz1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal bz2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal bz3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal bz4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal bz5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal bz6 = new BigDecimal(0.0);//��������
    BigDecimal bz7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal bz8 = new BigDecimal(0.0);//��������
    BigDecimal bz9 = new BigDecimal(0.0);//�ϼ�
    //ʡ����֧����
    BigDecimal bs1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal bs2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal bs3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal bs4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal bs5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal bs6 = new BigDecimal(0.0);//��������
    BigDecimal bs7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal bs8 = new BigDecimal(0.0);//��������
    BigDecimal bs9 = new BigDecimal(0.0);//�ϼ�
    //���м���֧����
    BigDecimal bd1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal bd2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal bd3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal bd4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal bd5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal bd6 = new BigDecimal(0.0);//��������
    BigDecimal bd7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal bd8 = new BigDecimal(0.0);//��������
    BigDecimal bd9 = new BigDecimal(0.0);//�ϼ�
    //����ϼ�
    BigDecimal bsum1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal bsum2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal bsum3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal bsum4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal bsum5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal bsum6 = new BigDecimal(0.0);//��������
    BigDecimal bsum7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal bsum8 = new BigDecimal(0.0);//��������
    BigDecimal bsum9 = new BigDecimal(0.0);//�ϼ�
    
     /*------����֧��-------*/
    
    //��������ڻ���
    BigDecimal lz1 = new BigDecimal(0.0);//�Ͻ�����
    BigDecimal lz2 = new BigDecimal(0.0);//�Ͻ���������ڻ�����ί
    BigDecimal lz3 = new BigDecimal(0.0);//�Ͻɵط���ί
    BigDecimal lz4 = new BigDecimal(0.0);//�Ͻ�ʡ����֧������ί
    BigDecimal lz5 = new BigDecimal(0.0);//�²���
    BigDecimal lz6 = new BigDecimal(0.0);//ѧϰ����
    BigDecimal lz7 = new BigDecimal(0.0);//�������֧��
    BigDecimal lz8 = new BigDecimal(0.0);//��������֧��
    BigDecimal lz9 = new BigDecimal(0.0);//���Ѳ���֧��
    BigDecimal lz10 = new BigDecimal(0.0);//����֧��
    BigDecimal lz11 = new BigDecimal(0.0);//С��
    BigDecimal lz12 = new BigDecimal(0.0);//�ϼ�
    BigDecimal lz13 = new BigDecimal(0.0);//����ĩ��浳����
    //ʡ����֧����
    BigDecimal ls1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal ls2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal ls3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal ls4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal ls5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal ls6 = new BigDecimal(0.0);//��������
    BigDecimal ls7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal ls8 = new BigDecimal(0.0);//��������
    BigDecimal ls9 = new BigDecimal(0.0);//�ϼ�
    BigDecimal ls10 = new BigDecimal(0.0);//����֧��
    BigDecimal ls11 = new BigDecimal(0.0);//С��
    BigDecimal ls12 = new BigDecimal(0.0);//�ϼ�
    BigDecimal ls13 = new BigDecimal(0.0);//����ĩ��浳����
    //���м���֧����
    BigDecimal ld1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal ld2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal ld3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal ld4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal ld5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal ld6 = new BigDecimal(0.0);//��������
    BigDecimal ld7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal ld8 = new BigDecimal(0.0);//��������
    BigDecimal ld9 = new BigDecimal(0.0);//�ϼ�
    BigDecimal ld10 = new BigDecimal(0.0);//����֧��
    BigDecimal ld11 = new BigDecimal(0.0);//С��
    BigDecimal ld12 = new BigDecimal(0.0);//�ϼ�
    BigDecimal ld13 = new BigDecimal(0.0);//����ĩ��浳����
  //֧���ϼ�
    BigDecimal lsum1 = new BigDecimal(0.0);//�Ͻ�����
    BigDecimal lsum2 = new BigDecimal(0.0);//�Ͻ���������ڻ�����ί
    BigDecimal lsum3 = new BigDecimal(0.0);//�Ͻɵط���ί
    BigDecimal lsum4 = new BigDecimal(0.0);//�Ͻ�ʡ����֧������ί
    BigDecimal lsum5 = new BigDecimal(0.0);//�²���
    BigDecimal lsum6 = new BigDecimal(0.0);//ѧϰ����֧��
    BigDecimal lsum7 = new BigDecimal(0.0);//�������֧��
    BigDecimal lsum8 = new BigDecimal(0.0);//��������֧��
    BigDecimal lsum9 = new BigDecimal(0.0);//���Ѳ���֧��
    BigDecimal lsum10 = new BigDecimal(0.0);//����֧��
    BigDecimal lsum11 = new BigDecimal(0.0);//С��
    BigDecimal lsum12 = new BigDecimal(0.0);//�ϼ�
    BigDecimal lsum13 = new BigDecimal(0.0);//����ĩ��浳����
    
    try {
        IPartyUCC partyucc = (IPartyUCC) SysContext.getBean("ccp_partyUCC");
        String sd = CommonFuns.filterNull(request.getParameter("sdate"));
        String ed = CommonFuns.filterNull(request.getParameter("edate"));
        
        List list = partyucc.queryPartyFeeReport(request.getParameter("pid"),sd,ed);
        if (list == null || list.size() == 0) {
        	out.print("û�����ݿ��Ե���!");
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

                if (partyType.equals("0891101")){//�ϼ�
                    //�跽��Ŀ
                    if (bsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                        bz1 = bz1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10453002")) {//��ĩ��浳����
                        lz13 = lz13.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455001")) {//��Ա���ɵ���
                        bz2 = bz2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                        bz3 = bz3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                        bz4 = bz4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455004")) {//�ϼ�����֯����
                        bz5 = bz5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455005")) {//��������
                        bz6 = bz6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455006")) {//��Ϣ����
                        bz7 = bz7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455007")) {//��������
                        bz8 = bz8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456001")) {//�Ͻ�����
                        lz1 = lz1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                        lz2 = lz2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                        lz2 = lz2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                        lz4 = lz4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456005")) {//�Ͻɵط���ί
                        lz3 = lz3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456006")) {//�²���
                        lz5 = lz5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456007")) {//ѧϰ����֧��
                        lz6 = lz6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456008")) {//�������֧��
                        lz7 = lz7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456009")) {//��������֧��
                        lz8 = lz8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456010")) {//���Ѳ���֧��
                        lz9 = lz9.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456099")) {//����֧��
                        lz10 = lz10.add(new BigDecimal(bvalue));
                    }
                    //������Ŀ
                    if (lsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                        bz1 = bz1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10453002")) {//��ĩ��浳����
                        lz13 = lz13.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455001")) {//��Ա���ɵ���
                        bz2 = bz2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                        bz3 = bz3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                        bz4 = bz4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455004")) {//�ϼ�����֯����
                        bz5 = bz5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455005")) {//��������
                        bz6 = bz6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455006")) {//��Ϣ����
                        bz7 = bz7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455007")) {//��������
                        bz8 = bz8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456001")) {//�Ͻ�����
                        lz1 = lz1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                        lz2 = lz2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                        lz2 = lz2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                        lz4 = lz4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456005")) {//�Ͻɵط���ί
                        lz3 = lz3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456006")) {//�²���
                        lz5 = lz5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456007")) {//ѧϰ����֧��
                        lz6 = lz6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456008")) {//�������֧��
                        lz7 = lz7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456009")) {//��������֧��
                        lz8 = lz8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456010")) {//���Ѳ���֧��
                        lz9 = lz9.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456099")) {//����֧��
                        lz10 = lz10.add(new BigDecimal(lvalue));
                    }
                }else if (partyType.substring(5,6).equals("1") || partyType.substring(5,6).equals("9") || partyType.equals("0891900") && superId.equals("100")){//ʡ����֧����
                    //�跽��Ŀ
                    if (bsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                        bs1 = bs1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10453002")) {//��ĩ��浳����
                        ls13 = ls13.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455001")) {//��Ա���ɵ���
                        bs2 = bs2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                        bs3 = bs3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                        bs4 = bs4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455004")) {//�ϼ�����֯����
                        bs5 = bs5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455005")) {//��������
                        bs6 = bs6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455006")) {//��Ϣ����
                        bs7 = bs7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455007")) {//��������
                        bs8 = bs8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456001")) {//�Ͻ�����
                        ls1 = ls1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                        ls2 = ls2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                        ls2 = ls2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                        ls4 = ls4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456005")) {//�Ͻɵط���ί
                        ls3 = ls3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456006")) {//�²���
                        ls5 = ls5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456007")) {//ѧϰ����֧��
                        ls6 = ls6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456008")) {//�������֧��
                        ls7 = ls7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456009")) {//��������֧��
                        ls8 = ls8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456010")) {//���Ѳ���֧��
                        ls9 = ls9.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456099")) {//����֧��
                        ls10 = ls10.add(new BigDecimal(bvalue));
                    }
                    //������Ŀ
                    if (lsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                        bs1 = bs1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10453002")) {//��ĩ��浳����
                        ls13 = ls13.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455001")) {//��Ա���ɵ���
                        bs2 = bs2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                        bs3 = bs3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                        bs4 = bs4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455004")) {//�ϼ�����֯����
                        bs5 = bs5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455005")) {//��������
                        bs6 = bs6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455006")) {//��Ϣ����
                        bs7 = bs7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455007")) {//��������
                        bs8 = bs8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456001")) {//�Ͻ�����
                        ls1 = ls1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                        ls2 = ls2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                        ls2 = ls2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                        ls4 = ls4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456005")) {//�Ͻɵط���ί
                        ls3 = ls3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456006")) {//�²���
                        ls5 = ls5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456007")) {//ѧϰ����֧��
                        ls6 = ls6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456008")) {//�������֧��
                        ls7 = ls7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456009")) {//��������֧��
                        ls8 = ls8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456010")) {//���Ѳ���֧��
                        ls9 = ls9.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456099")) {//����֧��
                        ls10 = ls10.add(new BigDecimal(lvalue));
                    }
                }else{//���м���֧����
                    //�跽��Ŀ
                    if (bsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                        bd1 = bd1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10453002")) {//��ĩ��浳����
                        ld13 = ld13.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455001")) {//��Ա���ɵ���
                        bd2 = bd2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                        bd3 = bd3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                        bd4 = bd4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455004")) {//�ϼ�����֯����
                        bd5 = bd5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455005")) {//��������
                        bd6 = bd6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455006")) {//��Ϣ����
                        bd7 = bd7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10455007")) {//��������
                        bd8 = bd8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456001")) {//�Ͻ�����
                        ld1 = ld1.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                        ld2 = ld2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                        ld2 = ld2.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                        ld4 = ld4.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456005")) {//�Ͻɵط���ί
                        ld3 = ld3.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456006")) {//�²���
                        ld5 = ld5.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456007")) {//ѧϰ����֧��
                        ld6 = ld6.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456008")) {//�������֧��
                        ld7 = ld7.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456009")) {//��������֧��
                        ld8 = ld8.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456010")) {//���Ѳ���֧��
                        ld9 = ld9.add(new BigDecimal(bvalue));
                    }else if (bsubject.equals("10456099")) {//����֧��
                        ld10 = ld10.add(new BigDecimal(bvalue));
                    }
                    //������Ŀ
                    if (lsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                        bd1 = bd1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10453002")) {//��ĩ��浳����
                        ld13 = ld13.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455001")) {//��Ա���ɵ���
                        bd2 = bd2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                        bd3 = bd3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                        bd4 = bd4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455004")) {//�ϼ�����֯����
                        bd5 = bd5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455005")) {//��������
                        bd6 = bd6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455006")) {//��Ϣ����
                        bd7 = bd7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10455007")) {//��������
                        bd8 = bd8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456001")) {//�Ͻ�����
                        ld1 = ld1.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                        ld2 = ld2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                        ld2 = ld2.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                        ld4 = ld4.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456005")) {//�Ͻɵط���ί
                        ld3 = ld3.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456006")) {//�²���
                        ld5 = ld5.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456007")) {//ѧϰ����֧��
                        ld6 = ld6.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456008")) {//�������֧��
                        ld7 = ld7.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456009")) {//��������֧��
                        ld8 = ld8.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456010")) {//���Ѳ���֧��
                        ld9 = ld9.add(new BigDecimal(lvalue));
                    }else if (lsubject.equals("10456099")) {//����֧��
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

            bsum1 = bz1.add(bs1).add(bd1);//����ʵ�浳����
            bsum2 = bz2.add(bs2).add(bd2);//����ȵ�Ա���ɵ����ܶ�
            bsum3 = bz3.add(bs3).add(bd3);//���м���֧������ί�Ͻ�
            bsum4 = bz4.add(bs4).add(bd4);//ʡ����֧������ί�Ͻ�
            bsum5 = bz5.add(bs5).add(bd5);//�ϼ�����֯����
            bsum6 = bz6.add(bs6).add(bd6);//��������
            bsum7 = bz7.add(bs7).add(bd7);//��Ϣ
            bsum8 = bz8.add(bs8).add(bd8);//��������
            bsum9 = bz9.add(bs9).add(bd9);//�ϼ�

            lsum1 = lz1.add(ls1).add(ld1);//�Ͻ�����
            lsum2 = lz2.add(ls2).add(ld2);//�Ͻ���������ڻ�����ί
            lsum3 = lz3.add(ls3).add(ld3);//�Ͻɵط���ί
            lsum4 = lz4.add(ls4).add(ld4);//�Ͻ�ʡ����֧������ί
            lsum5 = lz5.add(ls5).add(ld5);//�²���
            lsum6 = lz6.add(ls6).add(ld6);//ѧϰ����֧��
            lsum7 = lz7.add(ls7).add(ld7);//�������֧��
            lsum8 = lz8.add(ls8).add(ld8);//��������֧��
            lsum9 = lz9.add(ls9).add(ld9);//���Ѳ���֧��
            lsum10 = lz10.add(ls10).add(ld10);//����֧��
            lsum11 = lz11.add(ls11).add(ld11);//С��
            lsum12 = lz12.add(ls12).add(ld12);//�ϼ�
            lsum13 = lz13.add(ls13).add(ld13);//����ĩ��浳����

            Hashtable ht = new Hashtable();
            ht.put("<����֯>", CommonFuns.filterNull(CommonFuns.filterNull(CodeUtil.interpertCode("PA", request.getParameter("pid")))));
            if (sd.equals("")){
                sd = CommonFuns.getSysDate("yyyy")+"-01-01";
            }
            if (ed.equals("")){
                ed = CommonFuns.getSysDate("yyyy")+"-12-31";
            }
            ht.put("<���>", sd.substring(0,4) + "��"+sd.substring(5,7)+"��"+sd.substring(8)+"����" + ed.substring(0,4) + "��"+ed.substring(5,7)+"��"+ed.substring(8)+"��");
            ht.put("<���1>", CommonFuns.getSysDate("yyyy") + "�� "+CommonFuns.getSysDate("MM")+"�� "+CommonFuns.getSysDate("dd")+" ��");
            ht.put("<��������ʵ��>", CommonFuns.filterNull(String.valueOf(bz1)));
            ht.put("<���뽻�ɵ���>", CommonFuns.filterNull(String.valueOf(bz2)));
            ht.put("<������м��Ͻ�>", CommonFuns.filterNull(String.valueOf(bz3)));
            ht.put("<����ʡ���Ͻ�>", CommonFuns.filterNull(String.valueOf(bz4)));
            ht.put("<������֯����>", CommonFuns.filterNull(String.valueOf(bz5)));
            ht.put("<������������>", CommonFuns.filterNull(String.valueOf(bz6)));
            ht.put("<������Ϣ>", CommonFuns.filterNull(String.valueOf(bz7)));
            ht.put("<������������>", CommonFuns.filterNull(String.valueOf(bz8)));
            ht.put("<����ϼ�>", CommonFuns.filterNull(String.valueOf(bz9)));

            ht.put("<ʡ������ʵ��>", CommonFuns.filterNull(String.valueOf(bs1)));
            ht.put("<ʡ�����ɵ���>", CommonFuns.filterNull(String.valueOf(bs2)));
            ht.put("<ʡ�����м��Ͻ�>", CommonFuns.filterNull(String.valueOf(bs3)));
            ht.put("<ʡ��ʡ���Ͻ�>", CommonFuns.filterNull(String.valueOf(bs4)));
            ht.put("<ʡ����֯����>", CommonFuns.filterNull(String.valueOf(bs5)));
            ht.put("<ʡ����������>", CommonFuns.filterNull(String.valueOf(bs6)));
            ht.put("<ʡ����Ϣ>", CommonFuns.filterNull(String.valueOf(bs7)));
            ht.put("<ʡ����������>", CommonFuns.filterNull(String.valueOf(bs8)));
            ht.put("<ʡ���ϼ�>", CommonFuns.filterNull(String.valueOf(bs9)));

            ht.put("<��������ʵ��>", CommonFuns.filterNull(String.valueOf(bd1)));
            ht.put("<���н��ɵ���>", CommonFuns.filterNull(String.valueOf(bd2)));
            ht.put("<���е��м��Ͻ�>", CommonFuns.filterNull(String.valueOf(bd3)));
            ht.put("<����ʡ���Ͻ�>", CommonFuns.filterNull(String.valueOf(bd4)));
            ht.put("<������֯����>", CommonFuns.filterNull(String.valueOf(bd5)));
            ht.put("<������������>", CommonFuns.filterNull(String.valueOf(bd6)));
            ht.put("<������Ϣ>", CommonFuns.filterNull(String.valueOf(bd7)));
            ht.put("<������������>", CommonFuns.filterNull(String.valueOf(bd8)));
            ht.put("<���кϼ�>", CommonFuns.filterNull(String.valueOf(bd9)));

            ht.put("<�����Ͻ�>", CommonFuns.filterNull(String.valueOf(lz1)));
            ht.put("<�����Ͻ�����>", CommonFuns.filterNull(String.valueOf(lz2)));
            ht.put("<�����Ͻɵط�>", CommonFuns.filterNull(String.valueOf(lz3)));
            ht.put("<�����Ͻ�ʡ��>", CommonFuns.filterNull(String.valueOf(lz4)));
            ht.put("<�����²���>", CommonFuns.filterNull(String.valueOf(lz5)));
            ht.put("<����ѧϰ>", CommonFuns.filterNull(String.valueOf(lz6)));
            ht.put("<�������>", CommonFuns.filterNull(String.valueOf(lz7)));
            ht.put("<���봴��>", CommonFuns.filterNull(String.valueOf(lz8)));
            ht.put("<��������>", CommonFuns.filterNull(String.valueOf(lz9)));
            ht.put("<��������>", CommonFuns.filterNull(String.valueOf(lz10)));
            ht.put("<����С��>", CommonFuns.filterNull(String.valueOf(lz11)));
            ht.put("<����ϼ�1>", CommonFuns.filterNull(String.valueOf(lz12)));
            ht.put("<���뱾��ĩ���>", CommonFuns.filterNull(String.valueOf(lz13)));

            ht.put("<ʡ���Ͻ�>", CommonFuns.filterNull(String.valueOf(ls1)));
            ht.put("<ʡ���Ͻ�����>", CommonFuns.filterNull(String.valueOf(ls2)));
            ht.put("<ʡ���Ͻɵط�>", CommonFuns.filterNull(String.valueOf(ls3)));
            ht.put("<ʡ���Ͻ�ʡ��>", CommonFuns.filterNull(String.valueOf(ls4)));
            ht.put("<ʡ���²���>", CommonFuns.filterNull(String.valueOf(ls5)));
            ht.put("<ʡ��ѧϰ>", CommonFuns.filterNull(String.valueOf(ls6)));
            ht.put("<ʡ������>", CommonFuns.filterNull(String.valueOf(ls7)));
            ht.put("<ʡ������>", CommonFuns.filterNull(String.valueOf(ls8)));
            ht.put("<ʡ������>", CommonFuns.filterNull(String.valueOf(ls9)));
            ht.put("<ʡ������>", CommonFuns.filterNull(String.valueOf(ls10)));
            ht.put("<ʡ��С��>", CommonFuns.filterNull(String.valueOf(ls11)));
            ht.put("<ʡ���ϼ�1>", CommonFuns.filterNull(String.valueOf(ls12)));
            ht.put("<ʡ������ĩ���>", CommonFuns.filterNull(String.valueOf(ls13)));

            ht.put("<�����Ͻ�>", CommonFuns.filterNull(String.valueOf(ld1)));
            ht.put("<�����Ͻ�����>", CommonFuns.filterNull(String.valueOf(ld2)));
            ht.put("<�����Ͻɵط�>", CommonFuns.filterNull(String.valueOf(ld3)));
            ht.put("<�����Ͻ�ʡ��>", CommonFuns.filterNull(String.valueOf(ld4)));
            ht.put("<�����²���>", CommonFuns.filterNull(String.valueOf(ld5)));
            ht.put("<����ѧϰ>", CommonFuns.filterNull(String.valueOf(ld6)));
            ht.put("<���н���>", CommonFuns.filterNull(String.valueOf(ld7)));
            ht.put("<���д���>", CommonFuns.filterNull(String.valueOf(ld8)));
            ht.put("<��������>", CommonFuns.filterNull(String.valueOf(ld9)));
            ht.put("<��������>", CommonFuns.filterNull(String.valueOf(ld10)));
            ht.put("<����С��>", CommonFuns.filterNull(String.valueOf(ld11)));
            ht.put("<���кϼ�1>", CommonFuns.filterNull(String.valueOf(ld12)));
            ht.put("<���б���ĩ���>", CommonFuns.filterNull(String.valueOf(ld13)));

            ht.put("<�ܼ�����ʵ��>", CommonFuns.filterNull(String.valueOf(bsum1)));
            ht.put("<�ܼƽ��ɵ���>", CommonFuns.filterNull(String.valueOf(bsum2)));
            ht.put("<�ܼƵ��м��Ͻ�>", CommonFuns.filterNull(String.valueOf(bsum3)));
            ht.put("<�ܼ�ʡ���Ͻ�>", CommonFuns.filterNull(String.valueOf(bsum4)));
            ht.put("<�ܼ���֯����>", CommonFuns.filterNull(String.valueOf(bsum5)));
            ht.put("<�ܼ���������>", CommonFuns.filterNull(String.valueOf(bsum6)));
            ht.put("<�ܼ���Ϣ>", CommonFuns.filterNull(String.valueOf(bsum7)));
            ht.put("<�ܼ���������>", CommonFuns.filterNull(String.valueOf(bsum8)));
            ht.put("<�ܼƺϼ�>", CommonFuns.filterNull(String.valueOf(bsum9)));

            ht.put("<�ܼ��Ͻ�>", CommonFuns.filterNull(String.valueOf(lsum1)));
            ht.put("<�ܼ��Ͻ�����>", CommonFuns.filterNull(String.valueOf(lsum2)));
            ht.put("<�ܼ��Ͻɵط�>", CommonFuns.filterNull(String.valueOf(lsum3)));
            ht.put("<�ܼ��Ͻ�ʡ��>", CommonFuns.filterNull(String.valueOf(lsum4)));
            ht.put("<�ܼ��²���>", CommonFuns.filterNull(String.valueOf(lsum5)));
            ht.put("<�ܼ�ѧϰ>", CommonFuns.filterNull(String.valueOf(lsum6)));
            ht.put("<�ܼƽ���>", CommonFuns.filterNull(String.valueOf(lsum7)));
            ht.put("<�ܼƴ���>", CommonFuns.filterNull(String.valueOf(lsum8)));
            ht.put("<�ܼ�����>", CommonFuns.filterNull(String.valueOf(lsum9)));
            ht.put("<�ܼ�����>", CommonFuns.filterNull(String.valueOf(lsum10)));
            ht.put("<�ܼ�С��>", CommonFuns.filterNull(String.valueOf(lsum11)));
            ht.put("<�ܼƺϼ�1>", CommonFuns.filterNull(String.valueOf(lsum12)));
            ht.put("<�ܼƱ���ĩ���>", CommonFuns.filterNull(String.valueOf(lsum13)));

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
