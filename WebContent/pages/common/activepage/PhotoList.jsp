<%@page import="java.io.File"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.emp.ucc.IAddressUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.emp.pojo.vo.AddressVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<script language=javascript src="/js/list.js"></script>
<input type="hidden" name="pageFlag">
<input type="hidden" name="pageNum">

<%
    String basepath = application.getRealPath("/");
    AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");

    //��request��õ�TableVO,��ֵrequest.getAttribute(tableId)
    String tableId = request.getParameter("target");
    if (tableId == null || "".equals(tableId.trim())) {
        tableId = Constants.OBJECT;
    }
    //��request�õ�TableVO
    TableVO table = (TableVO) request.getAttribute(tableId);
    //���request��û�У����session��ȡ
    if (table == null) {
        table = (TableVO) session.getAttribute(tableId);
    }
    //ÿҳ��ʾ�ļ�¼��
    String rowNum = (String) session.getAttribute("rowNum");

    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    out.println("<table width=100% border=0 cellpadding=0 cellspacing=0 align=center class='table03' id='paget'>");
    //�ڼ�ҳ
    String pageNum = (String) session.getAttribute("pageNum");
    //��ҳ��
    int toalPageNum = table.getRecordNum() / Integer.parseInt(rowNum);
    if (table.getRecordNum() % Integer.parseInt(rowNum) > 0) {
        toalPageNum++;
    }
    //��ҳ�������б�ҳ��ռһ��,����ֻռһ��
    out.println("<tr >");
    //�����ǰ̨���������ҳ���ֺϲ���Ԫ���ԭ��������һ��
    out.println("<td id=\"locked\" nowrap style='z-index:3' class='locked_top' >");
    //����ҳ����
    StringBuffer turnpage = new StringBuffer("&nbsp;<font color=red>����" + table.getRecordNum() + "����¼&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    turnpage.append("��" + toalPageNum + "ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    turnpage.append("<input  class=input type=text size=5 name=rowNum value=" + Integer.parseInt(rowNum) + " onkeypress=\"gotoNextPage('1')\">��/ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    turnpage.append("��ǰ�� " + pageNum + " ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

    if (pageNum == null)
        pageNum = "1";
    int next = (Integer.parseInt(pageNum) / 10 + 1) * 10 + 1;
    int upper = (Integer.parseInt(pageNum) / 10) * 10;
    if (Integer.parseInt(pageNum) % 10 == 0) {
        next = Integer.parseInt(pageNum) + 1;
        upper = Integer.parseInt(pageNum) - 10;
    }
    if (Integer.parseInt(pageNum) > 10 && Integer.parseInt(pageNum) < toalPageNum && toalPageNum > 10 && upper > 0) {
        turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + upper + "')\">��һҳ</a>&nbsp;");
    }
    for (int k = upper + 1; k <= toalPageNum && k < next; k++) {
        turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + k + "')\">" + k + "</a>&nbsp;");
    }
    if (Integer.parseInt(pageNum) > 0 && Integer.parseInt(pageNum) < toalPageNum && toalPageNum > 10 && next < toalPageNum) {
        turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + next + "')\">��һҳ</a>&nbsp;");
    }
    out.println(turnpage.toString());
    out.println("</font></td>");

    out.println("</tr>");
    out.println("</table>");

%>
   <table  cellspacing=10 border=0>
        <%
            IAddressUCC rc = (IAddressUCC) SysContext.getBean("emp_addressUCC");
            if (table != null && table.getRowData()!=null && table.getRowData().length>0) {
                RecordVO[] rows = table.getRowData();
                String keyName = request.getParameter("keyName");
                int rownum = rows == null ? 0 : rows.length;
                // ��������
                if (keyName == null || "".equals(keyName)) {
                    if (table.getSetId() != null && !"".equals(table.getSetId())) {
                        keyName = table.getSetPk();//�Ӽ�������
                    } else if (rownum > 0) {
                        String setType = rows[0].getCell()[0].getSetId().substring(0, 1);//�Ӽ���A�໹��B��
                        keyName = InfoSetBO.getPkType(setType);
                    }
                }


                int idIndex = rows[0].getCellIndex(keyName);
                for (int i = 0; i < rows.length; i++) {
                    PersonBO pb = SysCacheTool.findPersonById(rows[i].getCell()[idIndex].getValue());
                    String id = pb.getPersonId();
                    String name = pb.getName();
                    String dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId());
                    String post = CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                    String img = "/images/common/nophoto.JPG";
                    if (pb.getImageId() != null) {
                        img = "/file/tmp/" + pb.getImageId() + ".JPG";
                        if (!aucc.checkAttachFileExist(basepath, pb.getImageId())) {
                            aucc.getFileContentToFile(basepath, pb.getImageId());
                        }
                    }
                    File f = new File(basepath+img);
                    if(!f.exists()){
                    	img = "/images/common/nophoto.JPG";
                    }
                    AddressVO avo = rc.getAddressInfo(pb.getPersonId());
                    String officetel = "";
                    String mobile = "";
                    String email = "";
                    if (avo != null) {
                        officetel = CommonFuns.filterNull(avo.getOfficeTel());
                        mobile = CommonFuns.filterNull(avo.getMobile());
                        email = CommonFuns.filterNull(avo.getEmail());
                    }
        %>
                <tr>
                    <td width=180 align="left" valign="top">
                            <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                            <strong>����:</strong><%=name%><br>
                            <strong>����:</strong><%=dept%><br>
                            <strong>��λ:</strong><%=post%><br>
                            <strong>�칫�绰:</strong><%=officetel%><br>
                            <strong>�ƶ��绰:</strong><%=mobile%><br>
                            <strong>�����ʼ�:</strong><br><%=email%><br>
                     </td>
         <%
                    i++;
                    if (i>=rows.length) break;
                    pb = SysCacheTool.findPersonById(rows[i].getCell()[idIndex].getValue());
                    id = pb.getPersonId();
                    name = pb.getName();
                    dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                    post = CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                    img="/images/common/nophoto.JPG";
                    avo = rc.getAddressInfo(pb.getPersonId());
                    officetel="";
                    mobile="";
                    email="";
                    if (avo!=null){
                         officetel=CommonFuns.filterNull(avo.getOfficeTel());
                         mobile=CommonFuns.filterNull(avo.getMobile());
                         email=CommonFuns.filterNull(avo.getEmail());
                     }
             if (pb.getImageId() != null) {
                 img = "/file/tmp/" + pb.getImageId() + ".JPG";
                 if (!aucc.checkAttachFileExist(basepath, pb.getImageId())) {
                     aucc.getFileContentToFile(basepath, pb.getImageId());
                 }
             }
             f = new File(basepath+img);
             if(!f.exists()){
             	img = "/images/common/nophoto.JPG";
             }

        %>
                    <td width=180 align="left" valign="top">
                            <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                            <strong>����:</strong><%=name%><br>
                            <strong>����:</strong><%=dept%><br>
                            <strong>��λ:</strong><%=post%><br>
                            <strong>�칫�绰:</strong><%=officetel%><br>
                            <strong>�ƶ��绰:</strong><%=mobile%> <br>
                            <strong>�����ʼ�:</strong><br><%=email%> <br>
                     </td>
                  <%
                               i++;
                               if (i>=rows.length) break;
                               pb = SysCacheTool.findPersonById(rows[i].getCell()[idIndex].getValue());
                               id = pb.getPersonId();
                               name = pb.getName();
                               dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                               post=CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                              img="/images/common/nophoto.JPG";
                      if (pb.getImageId() != null) {
                          img = "/file/tmp/" + pb.getImageId() + ".JPG";
                          if (!aucc.checkAttachFileExist(basepath, pb.getImageId())) {
                              aucc.getFileContentToFile(basepath, pb.getImageId());
                          }
                      }
                      f = new File(basepath+img);
                      if(!f.exists()){
                      	img = "/images/common/nophoto.JPG";
                      }       
                              avo = rc.getAddressInfo(pb.getPersonId());
                              officetel="";
                              mobile="";
                              email="";
                              if (avo!=null){
                                   officetel=CommonFuns.filterNull(avo.getOfficeTel());
                                   mobile=CommonFuns.filterNull(avo.getMobile());
                                   email=CommonFuns.filterNull(avo.getEmail());
                               }
                   %>
                               <td width=180 align="left" valign="top">
                                   <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                   <strong>����:</strong><%=name%><br>
                                   <strong>����:</strong><%=dept%><br>
                                   <strong>��λ:</strong><%=post%><br>
                                   <strong>�칫�绰:</strong><%=officetel%> <br>
                                   <strong>�ƶ��绰:</strong><%=mobile%> <br>
                                   <strong>�����ʼ�:</strong><br><%=email%><br>
                                </td>

                    <%
                                 i++;
                                 if (i>=rows.length) break;
                                 pb = SysCacheTool.findPersonById(rows[i].getCell()[idIndex].getValue());
                                 id = pb.getPersonId();
                                 name = pb.getName();
                                 dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                                 post=CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                                 img="/images/common/nophoto.JPG";
                        if (pb.getImageId() != null) {
                            img = "/file/tmp/" + pb.getImageId() + ".JPG";
                            if (!aucc.checkAttachFileExist(basepath, pb.getImageId())) {
                                aucc.getFileContentToFile(basepath, pb.getImageId());
                            }
                        }
                        f = new File(basepath+img);
                        if(!f.exists()){
                        	img = "/images/common/nophoto.JPG";
                        }
                                avo = rc.getAddressInfo(pb.getPersonId());
                                officetel="";
                                mobile="";
                                email="";
                                if (avo!=null){
                                     officetel=CommonFuns.filterNull(avo.getOfficeTel());
                                     mobile=CommonFuns.filterNull(avo.getMobile());
                                     email=CommonFuns.filterNull(avo.getEmail());
                                 }
                     %>
                                 <td width=180 align="left" valign="top">
                                     <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                     <strong>����:</strong><%=name%><br>
                                     <strong>����:</strong><%=dept%><br>
                                     <strong>��λ:</strong><%=post%><br>
                                     <strong>�칫�绰:</strong><%=officetel%> <br>
                                     <strong>�ƶ��绰:</strong><%=mobile%><br>
                                     <strong>�����ʼ�:</strong><br><%=email%><br>
                                  </td>

                </tr>
        <%
                }
            }
        %>
    </table>
    <script type="text/javascript">
        var rowNum = <%=rowNum%>;
    </script>