<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.post.pojo.bo.PostBO" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.post.ucc.impl.PostUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    PostBO post = (PostBO) request.getAttribute("PostBO");
    PersonBO person = (PersonBO) request.getAttribute("PersonBO");
    if (post == null || person == null) {
        return;
    }
    OrgBO org = SysCacheTool.findOrgById(post.getOrgId());
    PostBO superPost = new PostBO();
    if (post.getSuperId() != null && !"".equals(post.getSuperId())) {
        superPost = SysCacheTool.findPost(post.getSuperId());
    }
    PostUCC postucc = (PostUCC) SysContext.getBean("post_postUCCImpl");
    PostBO[] child = postucc.queryPost(" and p.superId='" + post.getPostId() + "'");
    String childdes = "";
    if (child != null && child.length > 0) {
        for (int i = 0; i < child.length; i++) {
            childdes += " " + child[i].getName();
        }
    }
    //��ѯ ��λ����ְ���Ӽ� C008 ���¼
    User user = (User) session.getAttribute(Constants.USER_INFO);
    TableVO tablec008 = postucc.queryPageInfo("C008", null, post.getPostId(), user, "C008000='00901'", null);
    TableVO tablec014 = postucc.queryPageInfo("C014", null, post.getPostId(), user, null, null);
    TableVO tablec701 = postucc.queryPageInfo("C701", null, post.getPostId(), user, null, "C701701");
    TableVO tablec702 = postucc.queryPageInfo("C702", null, post.getPostId(), user, "C702701='224001'", null);
    String  updatePost="";
    if (tablec702!=null && tablec702.getRowData()!=null && tablec702.getRowData().length>0){
        for(int i=0;i<tablec702.getRowData().length;i++){
            Hashtable ht=tablec702.getRowData()[i].cellArray2Hash();
            CellVO vo=(CellVO)ht.get("C702702");
            if (vo!=null && vo.getValue()!=null && !"".equals(vo.getValue())) updatePost+=" "+CodeUtil.interpertCode(CodeUtil.TYPE_POST,vo.getValue());
        }
    }
    tablec702 = postucc.queryPageInfo("C702", null, post.getPostId(), user,  "C702701='224002'",null);
    String  changePost="";
    if (tablec702!=null && tablec702.getRowData()!=null && tablec702.getRowData().length>0){
        for(int i=0;i<tablec702.getRowData().length;i++){
            Hashtable ht=tablec702.getRowData()[i].cellArray2Hash();
            CellVO vo=(CellVO)ht.get("C702702");
            if (vo!=null && vo.getValue()!=null && !"".equals(vo.getValue())) changePost+=" "+CodeUtil.interpertCode(CodeUtil.TYPE_POST,vo.getValue());
        }
    }


    String c014703 = "";
    String c014705 = "";    // Ҫ��רҵ
    String c014010="";      // ֪ʶ����
    String c014001="";      // ��������
    String c014706="";      //  ��������
    String c014707="";      //  ����Ҫ��
    String c014708="";      //  ְҵ�ʸ�

    if (tablec014 != null && tablec014.getRowData() != null && tablec014.getRowData().length > 0) {
        Hashtable ht = tablec014.getRowData()[0].cellArray2Hash();
        CellVO cv = (CellVO) ht.get("C014703");
        if (cv != null && cv.getValue() != null && !"".equals(cv.getValue())) c014703 += cv.getValue() + "����";

        cv = (CellVO) ht.get("C014705");
        if (cv != null && cv.getValue() != null && !"".equals(cv.getValue())) c014705 = CodeUtil.interpertCode(cv.getValue());

        cv = (CellVO) ht.get("C014010");
        if (cv != null && cv.getValue() != null && !"".equals(cv.getValue())) c014010 = cv.getValue();

        cv = (CellVO) ht.get("C014001");
        if (cv != null && cv.getValue() != null && !"".equals(cv.getValue())) c014001 = cv.getValue();

        cv = (CellVO) ht.get("C014706");
        if (cv != null && cv.getValue() != null && !"".equals(cv.getValue())) c014706 = cv.getValue();

        cv = (CellVO) ht.get("C014707");
        if (cv != null && cv.getValue() != null && !"".equals(cv.getValue())) c014707 = cv.getValue();

        cv = (CellVO) ht.get("C014708");
        if (cv != null && cv.getValue() != null && !"".equals(cv.getValue())) c014708 = cv.getValue();
    }
%>
   <table width=600 class="style1" align="center">
       <tr><td colspan=8 align="center" bgcolor="gray"><strong>��λ˵����</strong></td></tr>
       <tr>
           <td><strong>��λ����</strong></td><td><%=post.getName()%></td>
           <td><strong>��λ����</strong></td><td><%=CommonFuns.filterNull(post.getWorkOut())%></td>
           <td><strong>���ڲ���</strong></td><td><%=org.getName()%></td>
           <td><strong>��׼����</strong></td><td><%=CommonFuns.filterNull(post.getUpdateDate())%></td>
       </tr>

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>��λ��Ҫ</strong></td></tr>
       <tr><td colspan=8 height=60 align="center"><%=CommonFuns.filterNull(post.getDescription())%></td></tr>

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>��λλ��</strong></td></tr>
       <tr><td><strong>ֱ���ϼ�</strong></td><td colspan=7><%=CommonFuns.filterNull(superPost.getName())%></td></tr>
       <tr><td><strong>ֱ���¼�</strong></td><td colspan=7><%=childdes%></td></tr>

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>Э����ϵ</strong></td></tr>
       <tr><td align="center"><strong>��Χ</strong></td><td  align="center"><strong>����</strong></td><td colspan=6 align="center"><strong>����</strong></td></tr>
        <%
            if (tablec701!=null && tablec701.getRowData()!=null && tablec701.getRowData().length>0){
                for(int i=0;i<tablec701.getRowData().length;i++){
                   Hashtable row=tablec701.getRowData()[i].cellArray2Hash();
                   CellVO cvo;
                   String scope="";
                   cvo=(CellVO)row.get("C701701");
                   if (cvo!=null && "00901".equals(cvo.getValue())){
                       scope="��˾�ڲ�";
                   }
                   else{
                       scope="��˾�ⲿ";
                   }
                   String object="";
                   cvo=(CellVO)row.get("C701702");
                   if (cvo!=null) object=CommonFuns.filterNull(cvo.getValue());
                   String content="";
                   cvo=(CellVO)row.get("C701703");
                   if (cvo!=null) content=CommonFuns.filterNull(cvo.getValue());
                   out.print("<tr><td align=center>"+scope+"</td><td  align=center>"+object+"</td><td colspan=6 align=center>"+content+"</td></tr>");
                }
            }
        %>
       <tr><td align="center">&nbsp;</td><td  align="center"></td><td colspan=6 align="center"></td></tr>

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>��λְ��</strong></td></tr>
       <tr><td colspan=8 align="center" height=120 valign="top">
       <%if (tablec008 != null && tablec008.getRowData() != null && tablec008.getRowData().length > 0) {
           String des = "";
           Hashtable ht = tablec008.getRowData()[0].cellArray2Hash();
           CellVO cv=(CellVO)ht.get("C008001");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008701");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008705");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008709");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008713");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008717");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008721");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008725");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008729");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
           cv=(CellVO)ht.get("C008733");
           if (cv!=null && cv.getValue()!=null) des+="<br>"+cv.getValue();
            out.print(des);
         }%>
        </td></tr>

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>��ְ�ʸ������</strong></td></tr>
       <tr><td colspan=2 align="center"><strong>��Ŀ</strong></td><td colspan=6 align="center"><strong>����</strong></td></tr>
       <tr><td colspan=2 align="center"><strong>����ˮƽ</strong></td><td colspan=6 align="center"><%=c014703%></td></tr>
       <tr><td colspan=2 align="center"><strong>רҵҪ��</strong></td><td colspan=6 align="center"><%=c014705%></td></tr>
       <tr><td colspan=2 align="center"><strong>ְҵ�ʸ�</strong></td><td colspan=6 align="center"><%=c014708%></td></tr>
       <tr><td colspan=2 align="center"><strong>֪ʶ����</strong></td><td colspan=6 align="center"><%=c014010%></td></tr>
       <tr><td colspan=2 align="center"><strong>��������</strong></td><td colspan=6 align="center"><%=c014001%></td></tr>
       <tr><td colspan=2 align="center"><strong>��������</strong></td><td colspan=6 align="center"><%=c014706%></td></tr>
       <tr><td colspan=2 align="center"><strong>����Ҫ��</strong></td><td colspan=6 align="center"><%=c014707%></td></tr>

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>ְҵ��չ</strong></td></tr>
       <tr><td><strong>������λ</strong></td><td colspan=7><%=updatePost%></td></tr>
       <tr><td><strong>�ֻ���λ</strong></td><td colspan=7><%=changePost%></td></tr>
       

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>��ע</strong></td></tr>
       <tr><td colspan=8 align="center" height=80><%=CommonFuns.filterNull(post.getMemo())%></td></tr>
   </table>