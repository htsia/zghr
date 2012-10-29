<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.org.util.OrgTool" %>

<%@ include file="/pages/include/taglib.jsp" %>
<script language=javascript src="/js/list.js"></script>
<%
    //  -------------------------------  �б���ʾ2 ------------------------------------------
    //�Ƿ�Ա������
    String isSelf = "";
    try {
        isSelf = CommonFuns.filterNull(request.getParameter("isSelf"));
    } catch (Exception e) {
        isSelf = "";
    }
    //�Ƿ�input
    boolean hasOperSign = false;
    String operSignType = "check";
    try {
        hasOperSign = Boolean.valueOf(request.getParameter("hasOperSign")).booleanValue();
    } catch (Exception e) {
    }

    //�Ƿ��в���
    boolean hasEdit = false;
    try {
        hasEdit = Boolean.valueOf(request.getParameter("hasEdit")).booleanValue();
    } catch (Exception e) {
    }

    //�Ƿ��в���
    boolean isSelect = false;
    try {
        isSelect = Boolean.valueOf(request.getParameter("isSelect")).booleanValue();
    } catch (Exception e) {
    }

    int fixcol=-1;
    try {
        fixcol = Integer.parseInt(request.getParameter("fixcol"));
    } catch (Exception e) {
        fixcol=-1;
    }
    String selectFucName = "";
    try {
        selectFucName = CommonFuns.filterNull(request.getParameter("selectFucName"));
    } catch (Exception e) {
        selectFucName = "";
    }
    //��ά���������鿴���ȶ��б�ĳ�н��д����չʾ��
    String[] editName = null;
    //��ά���������鿴���ȶ��б�ĳ�н��д����javascript����������forView()
    String[] editFuncName = null;

    //��ʶ�����Ƿ����б��ǰ�����Ǻ󲿣������true�����ǰ��������Ϊ��
    boolean isForward = true;
    try {
        if (request.getParameter("isForward") != null && !"".equals(request.getParameter("isForward"))) {
            isForward = Boolean.valueOf(request.getParameter("isForward")).booleanValue();
        }
    } catch (Exception e) {

    }

    //��ʶ�Ƿ���������б��������б���Ĳ���
    boolean isRow = true;
    try {
        if (request.getParameter("isRow") != null && !"".equals(request.getParameter("isRow"))) {
            isRow = Boolean.valueOf(request.getParameter("isRow")).booleanValue();
        }
    } catch (Exception e) {

    }

    //���������б����õ�javascript����������Ŀֻ����һ��

    String rowFuncName = "";
    String trFuncName = "";

    //����������
    if (hasEdit) {
        editName = request.getParameterValues("editName");
        editFuncName = request.getParameterValues("editFuncName");
        if (isRow) {
            rowFuncName = request.getParameter("rowFuncName");
            trFuncName = request.getParameter("trFuncName");
        }

    }
    //�Ƿ������Ȩ��
    boolean isCheckRight = true;
    try {
        isCheckRight = Boolean.valueOf(request.getParameter("isCheckRight")).booleanValue();
    } catch (Exception e) {
    }
    //�Ƿ��ҳ
    boolean isPage = true;
    try {
        if (request.getParameter("isPage") != null && !"".equals(request.getParameter("isPage"))) {
            isPage = Boolean.valueOf(request.getParameter("isPage")).booleanValue();
        }
    } catch (Exception e) {
    }

    //�Ƿ�༭�б�
    boolean isEditList = false;
    try {
        isEditList = Boolean.valueOf(request.getParameter("isEditList")).booleanValue();
    } catch (Exception e) {
    }
    //�б�ҳ���Ƿ����
    boolean isScroll = true;
    try {
        if (request.getParameter("isScroll") != null && !"".equals(request.getParameter("isScroll"))) {
            isScroll = Boolean.valueOf(request.getParameter("isScroll")).booleanValue();
        }
    } catch (Exception e) {
        isScroll = true;
    }
    //��request��õ�TableVO,��ֵrequest.getAttribute(tableId)
    String tableId = request.getParameter("target");
    if (tableId == null || "".equals(tableId.trim())) {
        tableId = Constants.OBJECT2;
    }
    //��request�õ�TableVO
    TableVO table = (TableVO) request.getAttribute(tableId);
    //���request��û�У����session��ȡ
    if (table == null) {
        table = (TableVO) session.getAttribute(tableId);
    }

    //������Ӧ���ֶ���
    String keyName = request.getParameter("keyName");
    //Ա������
    boolean self = false;
    if (table != null && table.getSetId() != null) {
        self = isSelf.indexOf(table.getSetId()) != -1;
    }

    //�б�ҳ���������checkBox����radioButton
    if (hasOperSign || self) {
        operSignType = request.getParameter("operSignType"); //checkBox����radioButton
    }
    //ÿҳ��ʾ�ļ�¼��
    String rowNum = (String) session.getAttribute("rowNum2");
    if (rowNum == null) {
        rowNum = "" + Constants.ACTIVE_PAGE_SIZE;
    }
    if (table != null) {
        //�õ��б��ͷ��
        CellVO[] header = table.getHeader();
        //�õ��б�ļ�¼
        RecordVO [] rows = table.getRowData();
        //�б������
        int colnum = header.length;
        //�б�ļ�¼��
        int rownum = rows.length;
        String divId = "";
        //��������б�ҳ������Ļ�������б�λ��div����һ��idֵ
        if (isScroll) {
            divId = "id=datatable";
        }
        out.println("<div style='width:100%;height:100%;overflow:auto' " + divId + ">");

        //draw table ��ʼ��ҳ��
        //turn page  ��ҳ
        if (isPage) {
            out.println("<table width=95% border=0 cellpadding=0 cellspacing=0 align=center class='table03' id='paget'>");
            //�ڼ�ҳ
            String pageNum = (String) session.getAttribute("pageNum2");
            //��ҳ��
            int toalPageNum = table.getRecordNum() / Integer.parseInt(rowNum);
            if (table.getRecordNum() % Integer.parseInt(rowNum) > 0) {
                toalPageNum++;
            }
            //��ҳ�������б�ҳ��ռһ��,����ֻռһ��
            out.println("<tr>");
            //�����ǰ̨���������ҳ���ֺϲ���Ԫ���ԭ��������һ��
            out.println("<td id=\"locked\" nowrap class=locked_top >");
            //����ҳ����
            StringBuffer turnpage = new StringBuffer("<font color=red>��" + table.getRecordNum() + "����¼&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
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
            if (Integer.parseInt(pageNum) > 10 && Integer.parseInt(pageNum) < toalPageNum && toalPageNum > 10 && upper > 0)
            {
                turnpage.append("<a style='cursor:hand' onclick=\"forpage2('" + upper + "')\">��һҳ</a>&nbsp;");
            }
            for (int k = upper + 1; k <= toalPageNum && k < next; k++) {
                turnpage.append("<a style='cursor:hand' onclick=\"forpage2('" + k + "')\">" + k + "</a>&nbsp;");
            }
            if (Integer.parseInt(pageNum) > 0 && Integer.parseInt(pageNum) < toalPageNum && toalPageNum > 10 && next < toalPageNum)
            {
                turnpage.append("<a style='cursor:hand' onclick=\"forpage2('" + next + "')\">��һҳ</a>&nbsp;");
            }
            out.println(turnpage.toString());
            out.println("</font></td>");

            out.println("</tr>");
            out.println("</table>");
        }
        out.println("<table width=95% border=0 cellpadding=0 cellspacing=0 align=center class='table03' id='list'>");

        //draw header ���б�ҳ���ͷ����ռ����һ��
        String trFubc = "";
        if (hasEdit && isRow) {
            if (trFuncName != null && !"".equals(trFuncName)) {
                trFubc = trFuncName;
            }
        }
        out.println("<tr> ");
        //��ͷ���ĸ�ѡ��һ����ζ����ȫѡ����ѡ���û���û��ȫѡ
        if (hasOperSign || self) {
            out.println("<td id=\"locked\" class='locked_top' width=45px align=center nowrap>");
            if ("radio".equals(operSignType)) {
                out.println("&nbsp;");
            } else {
                out.println("<input type=" + operSignType + " name=allchk onclick=selectAll(document.forms(0).allchk,document.forms(0).chk)>");
            }
            out.println("</td>");
        }
        //�������༭�Ļ������б�ά������,��ǰ��
        if (hasEdit && isForward) {
            if (editName != null && editName.length > 0) {
                for (int e = 0; e < editName.length; e++) {
                    out.println("<td id=\"locked\"  class=locked_top align=center nowrap>");
                    if (editName[e].equals("view")) editName[e] = "�鿴";
                    out.println(editName[e]);
                    out.println("</td>");
                }
            }
        }
        //��ͷ������
        for (int i = 0; i < colnum; i++) {
            if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[i].getItemProperty()) || InfoItemBO.DATA_TYPE_CLOB.equals(header[i].getItemDataType()))
            {
                continue;
            } else {
                if (header[i].isShowId()) {
                    if (InfoItemBO.DATA_TYPE_CODE.equals(header[i].getItemDataType())) {
                        out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "����</td>");
                    }
                    out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "</td>");
                } else {
                    out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "</td>");
                }
            }
        }

        //�������༭�Ļ������б�ά������,�ں�
        if (hasEdit && !isForward) {
            if (editName != null && editName.length > 0) {
                for (int e = 0; e < editName.length; e++) {
                    out.println("<td id=\"locked\" class=locked_top align=center nowrap>");
                    if (editName[e].equals("view")) editName[e] = "�鿴";
                    out.println(editName[e]);
                    out.println("</td>");
                }
            }
        }
        out.println("</tr> ");
        // ��������
        if (keyName == null || "".equals(keyName)) {
            if (table.getSetId() != null && !"".equals(table.getSetId())) {
                keyName = table.getSetPk();//�Ӽ�������
            } else if (rownum>0){
                String setType = rows[0].getCell()[0].getSetId().substring(0, 1);//�Ӽ���A�໹��B��
                keyName = InfoSetBO.getPkType(setType);
            }
        }

        for (int i = 0; i < rownum; i++) {
            RecordVO row = rows[i]; //�õ�ĳһ��
            out.println("<tr onclick=" + trFubc + ">");
            String rowId = "[" + i + "]";
            if (rownum == 1) {
                rowId = "";
            }

            String backValue = "";
            for (int j = 0; j < colnum; j++) {
                Hashtable tmphash = row.cellArray2Hash();//�õ�ĳ��
                CellVO cell = row.getCell()[j];
                int right = cell.getPermission();//ָ���Ȩ��
                String idValue = "";
                //�õ�������ֵ
                idValue = ((CellVO) tmphash.get(keyName)).getValue();
                backValue = ((CellVO) tmphash.get(keyName)).getValue();

                //�õ���һ�е�ֵ
                String value = CommonFuns.filterNull(cell.getValue());
                switch (right) {
                    case 1:
                        value = "*****";
                        break;
                    case 2:
                    case 3:
                        break;
                }
                //��һ�л�checkBox����radioButton ����ά������
                if (j == 0) {
                    if (hasOperSign || self) {
                        out.println("<td align=center class=td_middle width=45px>");
                        // ����ǰ��¼���
                        CellVO curCV=(CellVO)(tmphash.get(table.getSetId()+"000"));
                        if (curCV!=null){ // �и���
                            if ("00901".equals(curCV.getValue())){
                                out.println("<img src='/images/arrow1.gif'>");
                            }
                        }

                        if (row.getPermission() == 1 && isCheckRight)
                            out.println("<input type=" + operSignType + " name=chk disabled >");
                        else
                            out.println("<input type=" + operSignType + " name=chk value=" + idValue + ">");
                        out.println("</td>");
                    }
                    //��ά����������ǰ��
                    if (hasEdit && isForward) {
                        if (editName != null && editName.length > 0) {
                            for (int e = 0; e < editName.length; e++) {
                                out.println("<td align=center class=td_middle nowrap>");
                                String oper = editFuncName[e] + "(document.forms(0),'" + idValue + "','" + row.getPermission() + "')";
                                if (!isCheckRight) {
                                    oper = editFuncName[e] + "(document.forms(0),'" + idValue + "','" + 0 + "')";
                                }
                                out.println("<a href=\"javascript:" + oper + "\" class=a04>" + editName[e] + "</a>");
                                out.println("</td>");
                            }
                        }
                    }
                }

                //����������б�ҳ��༭
                //������༭�б�
                String func = "";
                String styleEvent = "onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)";
                if (hasEdit && isRow) {
                    if (rowFuncName != null && !"".equals(rowFuncName)) {
                        func = rowFuncName + "(document.forms(0),'" + idValue + "','" + row.getPermission() + "')";
                        if (!isCheckRight) {
                            func = rowFuncName + "(document.forms(0),'" + idValue + "','" + 0 + "')";
                        }
                    }
                }
                if (isSelect) {
                    func = selectFucName;
                }
                String align = "";
                // ��ֵ�Ͳ����Ҷ���
                if (InfoItemBO.DATA_TYPE_FLOAT.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_INT.equals(cell.getItemDataType())){
                    align = "align=right";
                }
                if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[j].getItemProperty())) {
                    if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) {   //�߼���ѯʹ��
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            if (value.length() > 4) {
                                out.println(value.substring(4, value.length()));
                            } else {
                                out.println(CommonFuns.filterNull(value));
                            }
                            out.println("&nbsp;</td>");
                            out.println("<td class=td_middle  nowrap " + styleEvent + "  onclick=\"javascript:" + func + "\" >");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode(CommonFuns.filterNull(cell.getItemCodeSet()), value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=td_middle  nowrap " + styleEvent + "  onclick=\"javascript:" + func + "\" >");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode(CommonFuns.filterNull(cell.getItemCodeSet()), value)));
                            out.println("&nbsp;</td>");
                        }
                    } else
                    if (InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType()))
                    {
                        if (cell.isShowId()) { //�߼���ѯʹ��
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(value));
                            out.println("&nbsp;</td>");
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("OU", value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            if ("C001010".equals(cell.getItemId())) {
                                out.println(CommonFuns.filterNull(OrgTool.getOrgByDeptName(value)));
                            } else {
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("OU", value)));
                            }
                            out.println("&nbsp;</td>");
                        }
                    } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) {
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(value));
                            out.println("&nbsp;</td>");
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PE", value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PE", value)));
                            out.println("&nbsp;</td>");
                        }
                    } else if (InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) {
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(value));
                            out.println("&nbsp;</td>");
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PO", value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=td_middle nowrap  " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PO", value)));
                            out.println("&nbsp;</td>");
                        }
                    } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) {
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(value));
                            out.println("&nbsp;</td>");
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PA", value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PA", value)));
                            out.println("&nbsp;</td>");
                        }
                    } else if (InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType())) {
                        continue;
                    } else if ("A815712".equals(cell.getItemId())) {  //ʵ������(A815712)
                       if (value.indexOf("-")>=0){  // ��ֵ
                           out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + "<img src='/images/common/unvalidate.gif'><font color='red'>"+value + "&nbsp;</font></td>");
                       }
                       else {
                          out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                       }
                    }  else if ("A001001".equals(cell.getItemId())) {
                        if (idValue.startsWith("@")){
                           out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value +"(��ְ)"+ "</font>&nbsp;</td>");
                        }
                        else if (idValue.startsWith("#")){
                           out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value +"(����)"+ "</font>&nbsp;</td>");
                        }
                        else{
                           out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                        }
                    }else if (InfoItemBO.DATA_TYPE_WAGEDEPT.equals(cell.getItemDataType())) {  //A001743	A001	н�ʲ���
                        if (value.length()>Integer.parseInt(Constants.WAGE_DEPT_CODELEN)){
                           out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value.substring(Integer.parseInt(Constants.WAGE_DEPT_CODELEN)) + "&nbsp;</td>");
                        }
                        else{
                           out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                        }
                    }
                    else {
                        out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                    }



                }
            }

            //��ά���������ں�
            if (colnum > 0) {
                if (hasEdit && !isForward) {
                    if (editName != null && editName.length > 0) {
                        for (int e = 0; e < editName.length; e++) {
                            out.println("<td align=center class=td_middle nowrap>");
                            String oper = editFuncName[e] + "(document.forms(0),'" + backValue + "','" + row.getPermission() + "')";
                            if (!isCheckRight) {
                                oper = editFuncName[e] + "(document.forms(0),'" + backValue + "','" + 0 + "')";
                            }
                            out.println("<a href=\"javascript:" + oper + "\" class=a04>" + editName[e] + "</a>");
                            out.println("</td>");
                        }
                    }
                }
            }


            out.println("</tr>");
        }

        out.println("</table>");
        out.println("</div>");
        // ������
        if (fixcol!=-1){
           out.println("<script language=javascript>setFixCol("+fixcol+");</script>");
        }
    }

%>

<input type="hidden" name="pageFlag">
<input type="hidden" name="pageNum2">

<script language=javascript>
    window.setInterval("setFix()", 500);
    var rowNum2 = <%=rowNum%>
</script>