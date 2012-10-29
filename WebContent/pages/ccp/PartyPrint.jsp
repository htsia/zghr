<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.ccp.pojo.bo.PartyFlowInfoBO"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.ccp.ucc.ITransferUCC"%>
<%@ page import="com.hr319wg.ccp.pojo.vo.PartyRelationVO"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.cont.util.UnicodeToRtfcode"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="com.hr319wg.cont.util.RTFParser"%>
<%@ page import="com.hr319wg.util.FileUtil"%>
<%@ include file="../include/taglib.jsp" %>
<html>
<head>
<title>��ӡ������</title>
    <style type="text/css">
<!--
.STYLE2 {font-size: 12px}
.STYLE5 {font-size: 14px}
.STYLE9 {font-size: 12px; font-weight: bold; }
.STYLE11 {
	font-family: "����";
	font-size: 12px;
}
-->
    </style>
</head>

<body>

  <%
    User user = (User)session.getAttribute(Constants.USER_INFO);
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <%
    try {
        String intro = request.getParameter("intro");
        String flow = request.getParameter("flow");
        String rel = request.getParameter("rel");
        String sel = request.getParameter("seldoc");
        String pid = request.getParameter("pid");
        ITransferUCC transferucc = (ITransferUCC)SysContext.getBean("ccp_transferUCC");
        PartyRelationVO partyRelation = transferucc.findPartyRelationByIntroId(intro);
        if (partyRelation == null) {
            out.println("<div><font color=red>���ȱ����¼�ٴ�ӡ1</font></div>");
        } else {
            PartyFlowInfoBO flowInfo = transferucc.findFlowInfoByRelationId(flow, rel);
            if (flowInfo == null) {
                out.println("<div><font color=red>���ȱ����¼�ٴ�ӡ2</font></div>");
            } else {
                Hashtable ht = new Hashtable();
                String docid = CommonFuns.filterNull(partyRelation.getIntroduceDocId()).trim();
                 
                String sdate = CommonFuns.filterNull(partyRelation.getFeeStopDate());
                if (!sdate.equals("")){
                    sdate = sdate.substring(0,4) + "��" + sdate.substring(5,7);
                }
                
                PersonBO person = SysCacheTool.findPersonById(user.getUserId());
               
                
                String personTel = transferucc.queryForString("select A080710 from A080 where ID='"+ user.getUserId() +"'");
                String operater = "" ;
                if (person != null){
                	operater =  CommonFuns.filterNull(person.getName());
                }else{
                	operater = "" ;
                }
                
                %>
  <form action="">
  <div align="center" class="STYLE2"  > 
  
  <table width="550" border="0" id="control">
      <tr><td align="right">
         <input type="button" class="button01" onclick="print1()" value=" ��ӡ ">
         </td>
      </tr>
 </table>
    
   <table width="744" border="0" align="center" cellpadding="5" cellspacing="0" bordercolor="#000000" style="border-collapse:collapse">
  <tr>
    <td width="730" align="center" valign="top">
	<table width="550" border="0">
      <tr>
        <td align="center" valign="middle"><span class="STYLE5"><strong>��Ա��֯��ϵ������ </strong></span></td>
      </tr>
    </table>
	<br>
	
	<table width="550" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse">
      <tr>
        <td width="30" align="center" class="STYLE2">��<br>
Ա<br>
��<br>
��<br>
��<br>
��<br>
�� </td>
        <td width="470" align="center" valign="middle" class="STYLE5"><table width="100%" border="0">
          <tr>
            <td width="411" height="21" align="right" valign="baseline" class="STYLE2" ><strong>NO</strong><u>:<%= docid%></u></td>
          </tr>
          <tr>
            <td class="STYLE2"><u>&nbsp;<%= partyRelation.getPersonName() %></u> <strong>ͬ־ϵ��<%= CommonFuns.filterNull(CodeUtil.interpertCode("0120", partyRelation.getPartyFigure())) %>������֯��ϵ��</strong><u><%=CommonFuns.filterNull(partyRelation.getSendByUnit()) %></u></td>
          </tr>
          <tr>
            <td class="STYLE2"><strong>ת��</strong><u><%= CommonFuns.filterNull(CodeUtil.interpertCode("PA", partyRelation.getPartyUnit())) %> </u></td>
          </tr>
          <tr>
            <td align="right" class="STYLE2"><strong><%= CommonFuns.filterNull(CommonFuns.getSysDate("yyyy��MM��dd��")) %></strong></td>
          </tr>
        </table></td>
        <td width="18" align="center" valign="middle" class="STYLE2"> <div align="center">��<br>
          һ<br>
          ��<br>
        </div></td>
      </tr>
      
    </table>
	 
	<table width="550" border="0">
      <tr>
        <td align="center" valign="middle"><span class="STYLE11">������ִ������</span></td>
      </tr>
    </table>

	 
	<table  width="550" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse"  >
      
      <tr>
        <td align="right" valign="middle" class="STYLE5">���Ӹ�����£� </td>
      </tr>
    </table>
	<table width="550" border="0">
      <tr>
        <td align="center" valign="middle"><span class="STYLE5"><strong>�й���������Ա��֯��ϵ������</strong></span></td>
      </tr>
    </table>
	<table width="550" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse">
        <tr>
          <td width="508" align="center" valign="middle" class="STYLE5"><table width="100%" height="308" border="0" align="center">
            
            <tr>
              <td height="17" colspan="3" align="center" valign="top"><div align="right" class="STYLE2"><strong>NO:</strong><u><%=docid %></u> </div></td>
            </tr>
            <tr>
              <td height="29" colspan="3" align="center" valign="bottom"><div align="left" class="STYLE2"><u><%= CommonFuns.filterNull(partyRelation.getPersonName() ) %> : </u></div></td>
            </tr>
            <tr>
              <td height="17" colspan="3" align="left" valign="middle"><span class="STYLE2"><strong>&nbsp;&nbsp; ͬ־��<%= CommonFuns.filterNull(CodeUtil.interpertCode("0100",partyRelation.getPersonGender() )) %>���� </strong><u><%=  CommonFuns.filterNull(partyRelation.getPersonAge())%></u> <strong>�꣬</strong> <u><%= CommonFuns.filterNull(CodeUtil.interpertCode("0115",partyRelation.getPersonNation())) %></u> <strong>��
                ϵ��<%= CommonFuns.filterNull(CodeUtil.interpertCode("0120", partyRelation.getPartyFigure())) %>����</strong></span></td>
            </tr>
            <tr>
              <td height="20" colspan="3" align="left" valign="top"><span class="STYLE2"><strong>���֤���� </strong>&nbsp;<u><%= CommonFuns.filterNull(partyRelation.getPersonalCode())  %></u>,</span></td>
            </tr>
            <tr>
              <td height="17" colspan="3" align="left" valign="middle"><span class="STYLE2"><strong>&nbsp;&nbsp;��</strong><u> <%= CommonFuns.filterNull(partyRelation.getSendByUnit())  %></u><strong>ȥ</strong><u> <%=CommonFuns.filterNull( partyRelation.getSendUnit()) %></u><strong>����ת����֯��ϵ����ͬ־�����ѽ���</strong></span></td>
            </tr>
            <tr>
              <td height="17" colspan="3" align="left" valign="middle"><span class="STYLE2"><%= sdate %>��</span></td>
            </tr>
            <tr>
              <td height="20" colspan="3" align="left" valign="middle"><span class="STYLE2"><strong> ����Ч��</strong><%= CommonFuns.filterNull(partyRelation.getTransTime())  %> <strong>�죩 </strong></span></td>
            </tr>
            <tr>
              <td height="14" colspan="3" align="right" valign="top"><span class="STYLE2"><strong>&nbsp;������)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> </span></td>
            </tr>
            <tr>
              <td height="20" colspan="3" align="right" valign="top"><span class="STYLE2">&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp; <%= CommonFuns.getSysDate("yyyy��MM��dd��")   %> </span></td>
            </tr>
            <tr>
              <td height="15" colspan="3" align="left" valign="middle"><span class="STYLE2"><strong> &nbsp;��Ա��ϵ�绰��������ϵ��ʽ��</strong></span><span class="STYLE2"><%= CommonFuns.filterNull(partyRelation.getPartyTel()) %></span></td>
              </tr>
            <tr>
              <td height="17" colspan="3" align="left" valign="middle"><span class="STYLE2"><strong>&nbsp;��Աԭ���ڻ��㵳ίͨѶ��ַ��</strong></span><span class="STYLE2"><%= CommonFuns.filterNull(partyRelation.getPartyAddr()) %></span></td>
              </tr>
            <tr>
              <td width="174" height="20" align="left" valign="top"><span class="STYLE2"><strong>&nbsp;��ϵ�绰��<%=CommonFuns.filterNull(personTel)%></strong></span></td>
              <td width="128" align="left" valign="top"><span class="STYLE2"><strong>�ʱࣺ</strong> <%=CommonFuns.filterNull(partyRelation.getPartyPostalcode()) %> </span></td>
              <td width="182" height="20" align="left" valign="top"><span class="STYLE2"><strong>���棺<%=CommonFuns.filterNull(partyRelation.getPartyFax()) %></strong></span></td>
            </tr>
          </table></td>
          <td width="18" height="318" class="STYLE2"><div align="center">��<br>
            ��<br>
            ��</div></td>
        </tr>
      </table>
      <br>
	  	<table width="550" border="0">
      <tr>
        <td align="center" valign="middle"><span class="STYLE5"><strong>�й���������Ա��֯��ϵ�����Ż�ִ��</strong></span></td>
      </tr>
    </table>
      <table width="550" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse">
        <tr>
          <td class="STYLE5"><table width="100%" height="150" border="0" align="center">
            
            <tr>
              <td width="421" height="20" align="right" valign="top"><p align="right" class="STYLE2"><strong>NO:</strong><u><%= docid %></u> </p></td>
            </tr>
            <tr>
              <td height="20" align="left" valign="top"><u><span class="STYLE2"><%= CommonFuns.filterNull(partyRelation.getPersonName()) %></span></u></td>
            </tr>
            <tr>
              <td height="23" align="left" valign="top"><p align="left" class="STYLE2"><u><%= CommonFuns.filterNull(partyRelation.getPersonName()) %></u> <strong>ͬ־�ĵ�Ա��֯��ϵ��ת���Ҵ����ش˻ظ���</strong> </p></td>
            </tr>
            <tr>
              <td height="17" align="right" valign="top"><span class="STYLE2"><strong>&nbsp;������)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></span></td>
            </tr>
            <tr>
              <td height="20" align="right" valign="top"><span class="STYLE2">&nbsp;<%= CommonFuns.filterNull(CommonFuns.getSysDate("yyyy��MM��dd��")) %> </span></td>
            </tr>
            <tr>
              <td height="17" align="left" valign="top"><span class="STYLE2"><strong>�����ˣ�</strong><%=operater %> <strong>��ϵ�绰��<%= CommonFuns.filterNull(personTel) %> </strong></span></td>
            </tr>
          </table></td>
          <td width="18" class="STYLE2"><div align="center">��
             �� 
            ��</div></td>
        </tr>
      </table>
       
             <table width="550">
               <tr>
                 <td width="593"><span class="STYLE9">ע����ִ���ɽ��յ�Ա��֯��ϵ�Ļ��㵳ί�ڽ��յ�Ա��һ�������ʼĻ�������Աԭ����</span></td>
               </tr>
        <tr><td><span class="STYLE9">  ���㵳ί��</span></td>
        </tr></table>
	  </td>
  </tr>
   
</table>
</div>
</form>
                <%                
             
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script type="text/javascript">
    function print1() {
        document.all('control').style.display = "none";
        window.print();
        document.all('control').style.display = "";
    }
</script>

</body>
</html>