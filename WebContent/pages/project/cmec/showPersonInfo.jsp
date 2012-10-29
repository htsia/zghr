<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.org.ucc.impl.OrgUCC" %>
<%@ page import="com.hr319wg.post.ucc.impl.PostUCC" %>
<%@ page import="com.hr319wg.post.pojo.bo.PostBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>

<html>
<head>
<title></title>
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
	font-family: "����";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style1 TR {
	FONT-SIZE: 9pt; COLOR: #555555; 
	border:1px solid #555555;
}
.style1 TD {
	FONT-SIZE: 11pt;
	COLOR: #555555;
	vertical-align:middle;
	font-family: "����";
	border:1px solid #555555;
}
.style2
{
    font-family: verdana;
	font-size: 11pt;
	cursor: default;
	border-collapse: collapse;
	border:2px solid #555555;
}
.style2 TH {
	FONT-SIZE: 11pt;
	COLOR: #555555;
	font-family: "����";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style2 TR {
	FONT-SIZE: 11pt; COLOR: #555555;
	border:1px solid #555555;
}
.style2 TD {
	FONT-SIZE: 11pt;
	COLOR: #555555;
	vertical-align:middle;
	font-family: "����";
	border:1px solid #555555;
}
</style>

</head>
<body>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String pid=request.getParameter("fk");
    PersonBO po=SysCacheTool.findPersonById(pid);
    User user = (User) session.getAttribute(Constants.USER_INFO);
    OrgUCC ucc = (OrgUCC) SysContext.getBean("org_orgUCCImpl");
    PostUCC postucc = (PostUCC) SysContext.getBean("post_postUCCImpl");
    String classname="style1";
    if ("true".equals(request.getParameter("DeskTop"))){
       classname="style2";
    }

    String basepath = application.getRealPath("/");
    AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");
    String img = "/images/common/nophoto.JPG";
    if (po.getImageId() != null) {
        img = "/file/tmp/" + po.getImageId() + ".JPG";
    if (!aucc.checkAttachFileExist(basepath, po.getImageId())) {
        aucc.getFileContentToFile(basepath, po.getImageId());
    }
    }
	TableVO tablea079 = postucc.queryPageInfo("A079", null, pid, user, "", null);

    TableVO tablea019 = postucc.queryPageInfo("A019", null, pid, user, "", null);

    TableVO tablea004 = postucc.queryPageInfo("A004", null, pid, user, "", null);

    TableVO tablea010 = postucc.queryPageInfo("A010", null, pid, user, "", null);

	TableVO tablea080 = postucc.queryPageInfo("A080", pid, null, user, "", null);

    TableVO tablea081 = postucc.queryPageInfo("A081", null, pid, user, "", null);

	TableVO tablea840 = postucc.queryPageInfo("A840", null, pid, user, "", null);

	TableVO tablea202 = postucc.queryPageInfo("A202", null, pid, user, "", null);

	TableVO tablea001 = postucc.queryPageInfo("A001", pid, null, user, "", null);

	TableVO tablea708 = postucc.queryPageInfo("A708", pid, null, user, "", null);


	String a001803="";//�Ƿ�����ѧ
	String a001802="";//�Ƿ�ת����
	String a001801="";//�ڽ�����
	String a840701="";//���ѧλ
	String a840705="";//ѧλ��ҵʱ��
	String a708701="";//��ͬ��������
	String a708710="";//��ͬ��ʼʱ��
	String a708715="";//��ͬ����ʱ��

	String a079005 = "";    //����
    String a079010 = "";    // ��ϵ
    String a079030="";      // �Ա�
    String a079025="";      // ������ò
    String a079020="";      //  ������λ
    String a079701="";      //  ְ��
    String a079700="";      //  ��ϵ�绰

    String a019005 = "";    //����ʱ��
    String a019010="";      //�뿪ʱ��
    String a019015 = "";    // ������λ
    String a019705="";      // ְ��
    String a019025="";      // ֤����
    String a019702="";      //  ��ϵ�绰

    String a004015 = "";    //��ѧʱ��
    String a004030 ="";     //��ҵʱ�� 
    String a004035 = "";    // ��ҵѧУ
    String a004012="";      // רҵ����
    String a004005="";      // ѧ��
    String a004025="";      //  ѧ�� 
    String a004020="";      //  ��ҵ

    String a010706 = "";    //�ʸ�����
    String a010013 = "";    // ���赥λ
    String a010006="";      // ��������
    String a010015="";      // ���ʱ��
    String a010705="";      //  ֤����

    String a081701 = "";    //�ʸ����� ���˼�������
    String a081705 = "";    // ���赥λ
    String a081708="";      // ��������
    String a081703="";      // ���ʱ��

    String a202200 = "";    //����
    String a202201 = "";    // ��ϵ
    String a202205="";      // �Ա�
    String a202202="";      // �绰
    String a202203="";      //  ��ס��ַ 
    String a202204="";      //  ��������
    
%>
<table  class="<%=classname%>" align="center">
    <tr><td colspan="7" align="center" valign="middle" bgcolor="gray"><strong>��Ա�ǼǱ�</strong></td></tr>
    <tr>
        <td width="80" align="center" valign="middle"><strong>����</strong></td><td width="100" align="center" valign="middle"><%=po.getName()%></td>
        <td width="80" align="center" valign="middle"><strong>������</strong></td><td width="100" align="center" valign="middle"></td>
        <td width="80" align="center" valign="middle"><strong>�Ա�</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getSex())%></td>
    	<td rowspan="4" width="110" height="140" align="center" valign="middle"><img src="<%=img%>"></td>   
     </tr>
	 <tr>
        <td  width="80" align="center" valign="middle"><strong>����</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getHomeTown())%></td>
        <td  width="80" align="center" valign="middle"><strong>������</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getHomePlace())%></td>
        <td  width="80" align="center" valign="middle"><strong>��������</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getBirth())%></td>
        
     </tr>
	 <tr>
        <td  width="80" align="center" valign="middle"><strong>����</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getFolk())%></td>
        <td  width="80" align="center" valign="middle"><strong>������ò</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getPartyFigure())%></td>
        <td  width="80" align="center" valign="middle"><strong>����ְ��</strong></td><td width="100" align="center" valign="middle"></td>
     </tr>
     <tr>
        <td  width="80" align="center" valign="middle"><strong>��Ա���</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getPersonType())%></td>
        <td  width="80" align="center" valign="middle"><strong>����״��</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getMarriage())%></td>
        <td  width="80" align="center" valign="middle"><strong>�뵳(��)ʱ��</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getPartyTime())%></td>   
      </tr>
	  <tr>
         <td  width="80" align="center" valign="middle"><strong>�Ƿ�����ѧ</strong></td>
		 <%
         if(tablea001!= null && tablea001.getRowData() != null && tablea001.getRowData().length > 0) {
              boolean bfind=false;
	     for(int j = 0; j < tablea001.getRowData().length; j++) {
              Hashtable ht = tablea001.getRowData()[j].cellArray2Hash();
              CellVO cv =(CellVO)ht.get("A004000");
              cv =(CellVO)ht.get("A001803");
         if(cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
              String row="<td colspan=2 align=center valign=middle height=20>";
			  row+=CodeUtil.interpertCode(cv.getValue());
			  row+="</td>";
			  out.println(row);
			  break;
         }	 				
         }
	     if(!bfind){
			  out.println("<td colspan=2></td>");
	     }
         }else{
			   boolean bfind=false;
		 if(!bfind){
			   out.println("<td colspan=2></td>");
		 }
		 }
         %>
         <td  width="80" align="center" valign="middle"><strong>�Ƿ�ת����</strong></td>
		 <%
         if(tablea001!= null && tablea001.getRowData() != null && tablea001.getRowData().length > 0) {
               boolean bfind=false;
		 for(int j = 0; j < tablea001.getRowData().length; j++) {
               Hashtable ht = tablea001.getRowData()[j].cellArray2Hash();
               CellVO cv =(CellVO)ht.get("A004000");
               cv =(CellVO)ht.get("A001802");
         if(cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
               String row="<td align=center valign=middle height=20>";
			   row+=CodeUtil.interpertCode(cv.getValue());
			   row+="</td>";
			   out.println(row);
			   break;
          }	 				
          }
		  if(!bfind){
			   out.println("<td></td>");
		  }
          }else{
			   boolean bfind=false;
		  if(!bfind){
			   out.println("<td></td>");
		  }
		  }
          %>
          <td  width="80" align="center" valign="middle"><strong>�ڽ�����</strong></td>
		  <%
          if(tablea001!= null && tablea001.getRowData() != null && tablea001.getRowData().length > 0) {
               boolean bfind=false;
		  for(int j = 0; j < tablea001.getRowData().length; j++) {
               Hashtable ht = tablea001.getRowData()[j].cellArray2Hash();
               CellVO cv =(CellVO)ht.get("A004000");
               cv =(CellVO)ht.get("A001801");
          if(cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
               String row="<td align=center valign=middle height=20>";
			   row+=CodeUtil.interpertCode(cv.getValue());
			   row+="</td>";
			   out.println(row);
			   break;
           }	 				
           }
		   if(!bfind){
			    out.println("<td></td>");
		   }
           }else{
			    boolean bfind=false;
		   if(!bfind){
			    out.println("<td></td>");
		   }
		   }
           %>
       </tr>
	   <tr>
           <td  width="80" align="center" valign="middle"><strong>������λ</strong></td><td colspan=2 width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(CodeUtil.TYPE_ORG,po.getOrgId())%></td>
           <td  width="80" align="center" valign="middle"><strong>��λ����</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(CodeUtil.TYPE_POST,CommonFuns.filterNull(po.getPostLevel()))%></td>
           <td  width="80" align="center" valign="middle"><strong>רҵ��������</strong></td>
		   <%
           if(tablea010!= null && tablea010.getRowData() != null && tablea010.getRowData().length > 0) {
                  boolean bfind=false;
		   for(int j = 0; j < tablea010.getRowData().length; j++) {
                  Hashtable ht = tablea010.getRowData()[j].cellArray2Hash();
                  CellVO cv =(CellVO)ht.get("A004000");
		   if(cv!=null && cv.getValue()!=null && "00901".equals(cv.getValue())){
                   cv =(CellVO)ht.get("A010006");
           if(cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   String row="<td align=center valign=middle height=20>";
				   row+=CodeUtil.interpertCode(cv.getValue());
				   row+="</td>";
				   out.println(row);
				   break;
            }	 
			}
            }
			if(!bfind){
			       out.println("<td></td>");
			}
            }else{
			       boolean bfind=false;
		   if(!bfind){
			       out.println("<td></td>");
		   }
		   }
           %>  
        </tr>
	    <tr>
            <td  width="80" align="center" valign="middle"><strong>������λ</strong></td><td colspan=2 width="100" align="center" valign="middle">
		    <%=CodeUtil.interpertCode(CodeUtil.TYPE_POST,CommonFuns.filterNull(po.getPostId()))%></td>
            <td  width="80" align="center" valign="middle"><strong>��ְ��λ</strong></td><td width="100" align="center" valign="middle"></td>
            <td  width="80" align="center" valign="middle"><strong>�������˵ȼ�</strong></td>
            <%
            if(tablea081!= null && tablea081.getRowData() != null && tablea081.getRowData().length > 0) {
                   boolean bfind=false;
			for(int j = 0; j < tablea081.getRowData().length; j++) {
                   Hashtable ht = tablea081.getRowData()[j].cellArray2Hash();
                   CellVO cv =(CellVO)ht.get("A004000");
		    if(cv!=null && cv.getValue()!=null && "00901".equals(cv.getValue())){
                   cv =(CellVO)ht.get("A081701");
            if(cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   String row="<td align=center valign=middle height=20>";
				   row+=CodeUtil.interpertCode(cv.getValue());
				   row+="</td>";
				   out.println(row);
				   break;
            }	 
			}
            }
			if(!bfind){
			      out.println("<td></td>");
			}
            }else{
			      boolean bfind=false;
		   if(!bfind){
			      out.println("<td></td>");
		   }
		   }
           %>     
         </tr>

	 <tr>
	       <%
                   String maxSchool="&nbsp;"; // ���ѧ��
                   String maxSchoolDate="&nbsp;";
            if (tablea004!= null && tablea004.getRowData() != null && tablea004.getRowData().length > 0) {
	        for (int j = 0; j < tablea004.getRowData().length; j++) {
                   Hashtable ht = tablea004.getRowData()[j].cellArray2Hash();
                   CellVO cv =(CellVO)ht.get("A004000");
		    if (cv!=null && cv.getValue()!=null && "00901".equals(cv.getValue())){
                   cv =(CellVO)ht.get("A004005");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   maxSchool=CodeUtil.interpertCode(cv.getValue());
            }
                   cv =(CellVO)ht.get("A004030");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   maxSchoolDate=cv.getValue();
            }
            }		
            } 
            }
    
                    String maxDegree="&nbsp;";    // ���ѧλ
                    String maxDegreeDate="&nbsp;";
		    if (tablea840!= null && tablea840.getRowData() != null && tablea840.getRowData().length > 0) {
	        for (int j = 0; j < tablea840.getRowData().length; j++) {
                    Hashtable ht = tablea840.getRowData()[j].cellArray2Hash();
				    CellVO cv =(CellVO)ht.get("A004000");
		    if (cv!=null && cv.getValue()!=null && "00901".equals(cv.getValue())){
                    cv =(CellVO)ht.get("A840701");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     maxDegree=CodeUtil.interpertCode(cv.getValue());
            }
                     cv =(CellVO)ht.get("A840705");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     maxDegreeDate=cv.getValue();
            }
            }
            } 
            }

                     String cont="&nbsp;"; 
                     String contBegin="&nbsp;";
                     String contEnd="&nbsp;";      
		    if (tablea840!= null && tablea840.getRowData() != null && tablea840.getRowData().length > 0) {
	        for (int j = 0; j < tablea840.getRowData().length; j++) {
                     Hashtable ht = tablea840.getRowData()[j].cellArray2Hash();
				     CellVO cv =(CellVO)ht.get("A004000");
		    if (cv!=null && cv.getValue()!=null && "00901".equals(cv.getValue())){
                     cv =(CellVO)ht.get("A708701");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     cont=CodeUtil.interpertCode(cv.getValue());
            }
                     cv =(CellVO)ht.get("A708710");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     contBegin=cv.getValue();
            }
					 cv =(CellVO)ht.get("A708715");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     contEnd=cv.getValue();
            }
            }				
            } 
            }

            %>
            <td width="80" align="center" valign="middle"><strong>��˾ʱ��</strong></td><td width="100" colspan="2" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getUnitTime())%></td>
            <td width="80" align="center" valign="middle"><strong>�μӹ���ʱ��</strong></td><td width="100" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getWorkTime())%></td>
            <td width="80" rowspan="3" align="center" valign="middle"><strong>��ͬ(Э��)���޼���ֹ����</strong></td>
            <td><%=cont%></td>
         </tr>
      
         <tr>
            <td width="80" rowspan="2" align="center" valign="middle"><strong>���ѧ��</br>��ҵʱ��</strong></td>
            <td colspan="2" align="center" valign="middle"><%=maxSchool%></td>
            <td width="80" rowspan="2" align="center" valign="middle"><strong>���ѧλ</br>���ʱ��</strong></td> 
            <td><%=maxDegree%></td>
            <td><%=contBegin%></td>
         </tr>

	     <tr>
            <td colspan="2" align="center" valign="middle"><%=maxSchoolDate%></td>
            <td><%=maxDegreeDate%></td>
            <td><%=contEnd%></td>
         </tr>

	     <tr>
            <td width="80" align="center" valign="middle"><strong>���֤����</strong></td><td colspan="2" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getIdCard())%></td>
	        <td width="80" align="center" valign="middle"><strong>�ֻ�</strong></td>
		    <%
            if (tablea080!= null && tablea080.getRowData() != null && tablea080.getRowData().length > 0) {
                     boolean bfind=false;
			for (int j = 0; j < tablea080.getRowData().length; j++) {
                     Hashtable ht =tablea080.getRowData()[j].cellArray2Hash();
                     CellVO cv =(CellVO)ht.get("A004000");
		    if (cv!=null && cv.getValue()!=null && "00901".equals(cv.getValue())){
                     cv =(CellVO)ht.get("A080710");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     String row="<td align=center valign=middle height=20>";
		    		 row+=CodeUtil.interpertCode(cv.getValue());
			    	 row+="</td>";
					 out.println(row);
					 break;
    		}
            }	
            }
			if (!bfind){
			         out.println("<td></td>");
			}
            }else{
			         boolean bfind=false;
			if (!bfind){
			        out.println("<td></td>");
			}
		    }
            %>
            <td width="80" align="center" valign="middle"><strong>E-mail</strong></td>
		    <%
            if (tablea080!= null && tablea080.getRowData() != null && tablea080.getRowData().length > 0) {
                    boolean bfind=false;
			for (int j = 0; j < tablea080.getRowData().length; j++) {
                    Hashtable ht =tablea080.getRowData()[j].cellArray2Hash();
                    CellVO cv =(CellVO)ht.get("A004000");
		    if (cv!=null && cv.getValue()!=null && "00901".equals(cv.getValue())){
                    cv =(CellVO)ht.get("A080725");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                    String row="<td align=center valign=middle height=20>";
				    row+=CodeUtil.interpertCode(cv.getValue());
				    row+="</td>";
				    out.println(row);
				    break;
			}
            }
            }
			if (!bfind){
			       out.println("<td></td>");
			}
            }else{
			       boolean bfind=false;
			if (!bfind){
			      out.println("<td></td>");
			}
		    }
            %>
         </tr>
         <tr>
            <td width="80" align="center" valign="middle"><strong>��ͥסַ</strong></td><td colspan="4" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getFamilyAdd())%></td>
	        <td width="80" align="center" valign="middle"><strong>�ʱ�</strong></td><td align="center" valign="middle"><%=CodeUtil.interpertCode(po.getFamilyZip())%></td>
         </tr>
         <tr>
            <td width="80" align="center" valign="middle"><strong>�������ڵ�</strong></td><td colspan="4" align="center" valign="middle"><%=CodeUtil.interpertCode(po.getRprAdd())%></td>
	        <td width="80" align="center" valign="middle"><strong>�ʱ�</strong></td><td align="center" valign="middle"><%=CodeUtil.interpertCode(po.getFamilyZip())%></td>
         </tr>
       	 <tr><td colspan=7 align="center" valign="middle" bgcolor="gray"><strong>��ͥ��Ҫ��Ա(��ĸ��ż��Ů)</strong></td></tr>
	     <tr>
	         <td align="center" valign="middle"><strong>����</strong></td>
             <td  align="center" valign="middle"><strong>��ϵ</strong></td>
             <td  align="center" valign="middle"><strong>�Ա�</strong></td>
             <td  align="center" valign="middle"><strong>������ò</strong></td>
             <td  align="center" valign="middle"><strong>������λ</strong></td>
             <td  align="center" valign="middle"><strong>ְ��</strong></td>
             <td  align="center" valign="middle"><strong>��ϵ�绰</strong></td>
         </tr>
     	      <%
			
              if (tablea079!= null && tablea079.getRowData() != null && tablea079.getRowData().length > 0) {
              for (int j = 0; j < tablea079.getRowData().length; j++) {
                   Hashtable ht = tablea079.getRowData()[j].cellArray2Hash();
                   String row="<tr><td align=center valign=middle height=20>";
                   CellVO cv =(CellVO)ht.get("A079005");
              if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   row+=cv.getValue();
              }
                   row+="</td><td align=center valign=middle height=20>";
                   cv =(CellVO)ht.get("A079010");
              if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   row+=CodeUtil.interpertCode(cv.getValue());
              }
    	           row+="</td><td align=center valign=middle height=20>";
                   cv =(CellVO)ht.get("A079030");
              if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   row+=CodeUtil.interpertCode(cv.getValue());
              }
		           row+="</td><td align=center valign=middle height=20>";
                   cv =(CellVO)ht.get("A079025");
              if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   row+=CodeUtil.interpertCode(cv.getValue());
              }
		           row+="</td><td align=center valign=middle height=20>";
                   cv =(CellVO)ht.get("A079020");
              if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   row+=cv.getValue();
              }
		           row+="</td><td align=center valign=middle height=20>";
                   cv =(CellVO)ht.get("A079001");
              if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   row+=cv.getValue();
              }
		           row+="</td><td align=center valign=middle height=20>";
                   cv =(CellVO)ht.get("A079700");
              if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                   row+=cv.getValue();
               }		 
                   row+="</td></tr>";
                   out.println(row);
               }
               }
               %>

	       <tr><td colspan=7 align="center" valign="middle" bgcolor="gray"><strong>��Ҫ��������</strong></td></tr>
	       <tr>
	           <td align="center" valign="middle"><strong>��ֹʱ��</strong></td>
               <td  align="center" valign="middle" colspan="2"><strong>������λ</strong></td>
               <td  align="center" valign="middle" colspan="2"><strong>ְ��</strong></td>
               <td  align="center" valign="middle"><strong>֤����</strong></td>
               <td  align="center" valign="middle"><strong>��ϵ�绰</strong></td>
           </tr>
      	       <%
               if ( tablea019!= null &&  tablea019.getRowData() != null &&  tablea019.getRowData().length > 0) {
               for (int j = 0; j <  tablea019.getRowData().length; j++) {
                    Hashtable ht =  tablea019.getRowData()[j].cellArray2Hash();
                    String row="<tr><td align=center valign=middle height=20>";
                    CellVO cv =(CellVO)ht.get("A019005");
                    CellVO cv1 =(CellVO)ht.get("A019010");
               if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                    row+=cv.getValue()+"  "+cv1.getValue();
                }
                    row+="</td><td colspan=2 align=center valign=middle height=20>";
                    cv =(CellVO)ht.get("A019015");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     row+=cv.getValue();
                }
    	             row+="</td><td colspan=2 align=center valign=middle height=20>";
                     cv =(CellVO)ht.get("A019705");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     row+=cv.getValue();
                }
		             row+="</td><td align=center valign=middle height=20>";
                cv =(CellVO)ht.get("A019025");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     row+=cv.getValue();
                }
		             row+="</td><td align=center valign=middleheight=20>";
                     cv =(CellVO)ht.get("A019702");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                     row+=cv.getValue();
                }	
			         row+="</td></tr>";
                     out.println(row);
                }
                }
                %>
            <tr><td  colspan=7 align="center" valign="middle" bgcolor="gray"><strong>������ѵ����</strong></td></tr>
	        <tr>
	            <td  align="center" valign="middle"><strong>��ֹʱ��</strong></td>
                <td  align="center" valign="middle" colspan="2"><strong>��ҵԺУ</strong></td>
                <td  align="center" valign="middle"><strong>��ѧרҵ</strong></td>
                <td align="center" valign="middle"><strong>ѧ��</strong></td>
                <td  align="center" valign="middle"><strong>ȫ����/��ְ</strong></td>
                <td  align="center" valign="middle"><strong>��(��)ҵ</strong></td>
            </tr>
      	        <%
                if (tablea004!= null && tablea004.getRowData() != null && tablea004.getRowData().length > 0) {
                for (int j = 0; j < tablea004.getRowData().length; j++) {
                      Hashtable ht = tablea004.getRowData()[j].cellArray2Hash();
                      String row="<tr><td align=center valign=middle height=20>"; 
                      CellVO cv =(CellVO)ht.get("A004015");
		              CellVO cv1 =(CellVO)ht.get("A004030");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
			           row+=cv.getValue()+"  "+cv1.getValue();
                }
                       row+="</td><td colspan=2 align=center valign=middle height=20>";
                       cv =(CellVO)ht.get("A004035");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                       row+=cv.getValue();
                }
		               row+="</td><td align=center valign=middle height=20>";
                       cv =(CellVO)ht.get("A004012");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                       row+=cv.getValue();
                }
		               row+="</td><td align=center valign=middle height=20>";
                       cv =(CellVO)ht.get("A079005");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                       row+=cv.getValue();
                }
		               row+="</td><td align=center valign=middle height=20>";
                       cv =(CellVO)ht.get("A004025");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                       row+=cv.getValue();
                }
                       row+="</td><td align=center valign=middle height=20>";
                       cv =(CellVO)ht.get("A004020");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                       row+=cv.getValue();
                }	 
                        row+="</td></tr>";
                        out.println(row);
                }
                }
                %>
            <tr><td colspan=7 align="center" valign="middle" bgcolor="gray"><strong>רҵ�����ʸ�(רҵ������Ա��д)</strong></td></tr>
	        <tr>
	            <td  align="center" valign="middle"><strong>�ʸ�����</strong></td>
                <td  align="center" valign="middle" colspan="2"><strong>���赥λ</strong></td>
                <td  align="center" valign="middle"><strong>��������</strong></td>
                <td  align="center" valign="middle"><strong>���ʱ��</strong></td>
                <td  align="center" valign="middle"><strong>֤����</strong></td>
                <td align="center" valign="middle"><strong></strong></td>
            </tr>
                <%
                if (tablea010!= null && tablea010.getRowData() != null && tablea010.getRowData().length > 0) {
                for (int j = 0; j < tablea010.getRowData().length; j++) {
                         Hashtable ht = tablea010.getRowData()[j].cellArray2Hash();
                         String row="<tr><td align=center valign=middle height=20>";
                         CellVO cv =(CellVO)ht.get("A010706");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=CodeUtil.interpertCode(cv.getValue());
                }
                         row+="</td><td colspan=2 align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A010013");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
		                 row+="</td><td align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A010006");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=CodeUtil.interpertCode(cv.getValue());
                }
		                 row+="</td><td align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A010015");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
                         row+="</td><td align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A010705");
                 if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
	                     row+="</td><td align=center valign=middle height=20>";	 
                         row+="</td></tr>";
                         out.println(row);
                }
                }
                %>
            <tr><td  colspan=7 align="center" valign="middle" bgcolor="gray"><strong>���˼����ȼ�(������Ա��д)</strong></td></tr>
	        <tr>
	            <td align="center" valign="middle"><strong>�ȼ�����</strong></td>
                <td align="center" valign="middle" colspan="2"><strong>���赥λ</strong></td>
                <td  align="center" valign="middle"><strong>���ʱ��</strong></td>
                <td  align="center" valign="middle"><strong>֤����</strong></td>
                <td align="center" valign="middle"><strong></strong></td>
                <td  align="center" valign="middle"><strong></strong></td>
            </tr>
                <%
                if (tablea081!= null && tablea081.getRowData() != null && tablea081.getRowData().length > 0) {
                for (int j = 0; j < tablea081.getRowData().length; j++) {
                         Hashtable ht = tablea081.getRowData()[j].cellArray2Hash();
                         String row="<tr><td align=center valign=middle height=20>";
                         CellVO cv =(CellVO)ht.get("A081701");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=CodeUtil.interpertCode(cv.getValue());
                }
                         row+="</td><td colspan=2 align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A081705");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
		                 row+="</td><td align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A081708");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
		                 row+="</td><td align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A081730");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }	 
                         row+="</td></tr>";
                         out.println(row);
                }
                }
                %>
	
            <tr><td colspan=7 align="center" valign="middle" bgcolor="gray"><strong>�������֪ͨ��(��ż����)</strong></td></tr>
	        <tr>
	            <td  align="center" valign="middle"><strong>����</strong></td>
                <td  align="center" valign="middle"><strong>��ϵ</strong></td>
                <td  align="center" valign="middle"><strong>�Ա�</strong></td>
                <td  align="center" valign="middle"><strong>�绰</strong></td>
                <td  align="center" valign="middle" colspan="2"><strong>��ס��ַ</strong></td>
                <td  align="center" valign="middle"><strong>��������</strong></td>
            </tr>
                <%
                if (tablea202!= null && tablea202.getRowData() != null && tablea202.getRowData().length > 0) {
                for (int j = 0; j < tablea202.getRowData().length; j++) {
                         Hashtable ht = tablea202.getRowData()[j].cellArray2Hash();
                         String row="<tr><td align=center valign=middle height=20>";
                         CellVO cv =(CellVO)ht.get("A202200");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
                         row+="</td><td align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A202201");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
   	                     row+="</td><td align=center valign=middle height=20>";
                         cv =(CellVO)ht.get("A202205");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=CodeUtil.interpertCode(cv.getValue());
                }
		                 row+="</td><td align=center height=20>";
                         cv =(CellVO)ht.get("A202202");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
		                 row+="</td><td colspan=2 align=center height=20>";
                         cv =(CellVO)ht.get("A202203");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }
		                 row+="</td><td align=center height=20>";
                         cv =(CellVO)ht.get("202204");
                if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                         row+=cv.getValue();
                }		 
                         row+="</td></tr>";
                         out.println(row);
			    }
                }
                %>
	       <tr><td colspan=7 align="center" valign="middle" bgcolor="gray"><strong>����������Ϣ�Ѿ���������˶����󣬲���֤������ʵ�Ժ������ԡ�������٣�����Ը�е���������</strong></td></tr>
	       <tr><td colspan=7 align="right" bgcolor="gray"><strong>                                        ����ȷ��ǩ��:           ��   ��  ��</strong></td></tr>
   </table>
</body></html>