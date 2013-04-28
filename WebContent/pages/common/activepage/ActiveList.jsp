<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.org.util.OrgTool" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageErrReportBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.qry.pojo.bo.QueryBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageNoteBO" %>


<script language=javascript src="/js/list.js"></script>
<%
    //  -------------------------------  �б���ʾ ------------------------------------------
    // ������ʾ��ʽ
    String linkDept = CommonFuns.filterNull(request.getParameter("linkDept"));
    String WageList=CommonFuns.filterNull(request.getParameter("WageList"));
    String BaseCountList=CommonFuns.filterNull(request.getParameter("BaseCountList"));
    if (linkDept != null && !"".equals(linkDept)) {
        session.setAttribute("linkDept", linkDept);
    }
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

    int fixcol = -1;
    try {
        fixcol = Integer.parseInt(request.getParameter("fixcol"));
    } catch (Exception e) {
        fixcol = -1;
    }
    String fixcolstyle = CommonFuns.filterNull(request.getParameter("fixcolstyle"));      //��������ʽ td_fixcol-���� ��-��ʾ
    String fixrowstyle = CommonFuns.filterNull(request.getParameter("fixrowstyle"));      //��������ʽ tr_fixrow-���� ��-��ʱˢ�·�ʽ

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

    String maskError = "false";     // �Ƿ�����������
    if (request.getParameter("maskError") != null && !"".equals(request.getParameter("maskError"))) {
        maskError = request.getParameter("maskError");
    }

    Hashtable errhr = (Hashtable) session.getAttribute("errData");
    if (errhr == null || errhr.size() == 0) {
        maskError = "false";
    }

    String maskWarn = "false";
    if (request.getParameter("maskWarn") != null && !"".equals(request.getParameter("maskWarn"))) {
        maskWarn = request.getParameter("maskWarn");
    }

    Hashtable warnhr = (Hashtable) session.getAttribute("warnData");
    if (warnhr == null || warnhr.size() == 0) {
        maskWarn = "false";
    }

    Hashtable tempPerson = (Hashtable) session.getAttribute("tempPerson");

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
    String rowNum = (String) session.getAttribute("rowNum");
    if (rowNum == null) {
        rowNum = "" + Constants.ACTIVE_PAGE_SIZE;
    }
    if (table != null) {
        //�õ��б��ͷ��
        CellVO[] header = table.getHeader();
        //�õ��б�ļ�¼
        RecordVO[] rows = table.getRowData();
        //�б������
        int colnum = header.length;
        //�б�ļ�¼��
        int rownum = rows == null ? 0 : rows.length;
        String divId = "";
        //��������б�ҳ������Ļ�������б�λ��div����һ��idֵ
        if (isScroll) {
            divId = "id=datatable";
        }
        out.println("<div style='width:100%;height:100%;overflow:auto' " + divId + ">");
        //draw table ��ʼ��ҳ��
        //turn page  ��ҳ
        out.println("<table width=100% border=0 cellpadding=0 cellspacing=0>");
        if (isPage) {
            out.println("<tr><td>");
            out.println("<table width=99% border=0 cellpadding=0 cellspacing=0 align=left  id='paget'>");
            //�ڼ�ҳ
            String pageNum = (String) session.getAttribute("pageNum");
            if (pageNum==null || "".equals(pageNum)) pageNum="1";
            //��ҳ��
            int toalPageNum = table.getRecordNum() / Integer.parseInt(rowNum);
            if (table.getRecordNum() % Integer.parseInt(rowNum) > 0) {
                toalPageNum++;
            }
            //��ҳ�������б�ҳ��ռһ��,����ֻռһ��
            out.println("<tr>");
            //�����ǰ̨���������ҳ���ֺϲ���Ԫ���ԭ��������һ��
            out.println("<td id=\"locked\" nowrap style='z-index:3' class='locked_top " + fixcolstyle + " " + fixrowstyle + "' >");
            //����ҳ����
            StringBuffer turnpage = new StringBuffer("<a onclick=\"window.open('/common/activepage/ShowGather.jsf');\"><img src='/images/maininterface/menu/calculate.gif' alt='����'></a>&nbsp;<font color=red>����" + table.getRecordNum() + "����¼&nbsp;&nbsp;&nbsp;&nbsp;");
            turnpage.append("<input  class=input type=text size=5 name=rowNum value=" + Integer.parseInt(rowNum) + " onkeypress=\"gotoNextPage('1')\">��/ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
            turnpage.append("��" + toalPageNum + "ҳ&nbsp;&nbsp;");
            turnpage.append("��ǰ��" + pageNum + "ҳ&nbsp;&nbsp;&nbsp;&nbsp;");

            if (toalPageNum>1){
                turnpage.append("<a style='cursor:hand' onclick=\"forpage('1');\"><img height='14' width='14' src='/images/maininterface/menu/first.gif' alt='��ҳ'></a>");
            }
            if (Integer.parseInt(pageNum)>1){
                turnpage.append("<a style='cursor:hand' onclick=\"forpage('"+String.valueOf(Integer.parseInt(pageNum)-1)+"');\"><img height='14' width='14' src='/images/maininterface/menu/up.gif' alt='��һҳ'></a>");
            }
            if (Integer.parseInt(pageNum)>=1 && Integer.parseInt(pageNum)<toalPageNum){
                turnpage.append("<a style='cursor:hand' onclick=\"forpage('"+String.valueOf(Integer.parseInt(pageNum)+1)+"');\"><img height='14' width='14' src='/images/maininterface/menu/down.gif' alt='��һҳ'></a>");
            }
            if (toalPageNum>1){
                turnpage.append("<a style='cursor:hand' onclick=\"forpage('"+String.valueOf(toalPageNum)+"');\"><img height='14' width='14' src='/images/maininterface/menu/last.gif' alt='βҳ'></a>");    
            }

            turnpage.append("&nbsp;&nbsp;");
            if (pageNum == null)
                pageNum = "1";
            int next = (Integer.parseInt(pageNum) / 10 + 1) * 10 + 1;
            int upper = (Integer.parseInt(pageNum) / 10) * 10;
            if (Integer.parseInt(pageNum) % 10 == 0) {
                next = Integer.parseInt(pageNum) + 1;
                upper = Integer.parseInt(pageNum) - 10;
            }
            if (Integer.parseInt(pageNum) > 10 && Integer.parseInt(pageNum) < toalPageNum && toalPageNum > 10 && upper > 0) {
                turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + upper + "')\">��һƪ</a>&nbsp;");
            }
            for (int k = upper + 1; k <= toalPageNum && k < next; k++) {
                turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + k + "')\">" + k + "</a>&nbsp;");
            }
            if (Integer.parseInt(pageNum) > 0 && Integer.parseInt(pageNum) < toalPageNum && toalPageNum > 10 && next < toalPageNum) {
                turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + next + "')\">��һƪ</a>&nbsp;");
            }
            out.println(turnpage.toString());
            out.println("</font></td>");

            out.println("</tr>");
            out.println("</table>");
            out.println("</td></tr>");
        }

        out.println("<tr><td><table width=99% border=0 cellpadding=0 cellspacing=0 align=left class='table03' id='list'>");

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
            if (fixcol > 0) {
                out.println("<td id=\"locked\" class='locked_top " + fixcolstyle + " " + fixrowstyle + "' style='z-index: 2' width=45px align=center nowrap>");
            } else {
                out.println("<td id=\"locked\" class='locked_top " + fixrowstyle + "' width=45px align=center nowrap>");
            }
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
                    if (fixcol > 0) {
                        out.println("<td id=\"locked\"  class='locked_top " + fixcolstyle + " " + fixrowstyle + "' style='z-index: 3' align=center nowrap>");
                    } else {
                        out.println("<td id=\"locked\"  class='locked_top " + fixrowstyle + "' align=center nowrap>");
                    }
                    if (editName[e].equals("view")) editName[e] = "�鿴";
                    out.println(editName[e]);
                    out.println("</td>");
                }
            }
        }

//         User user =(User)session.getAttribute(Constants.USER_INFO);
//         Map itemMap=user.getPmsInfoItem();
//         if(itemMap==null){
//         	itemMap=new HashMap();
//         }
        //��ͷ������
        for (int i = 0; i < colnum; i++) {
//         	if(!itemMap.containsKey(header[i].getItemId()) && header[i].getItemId().startsWith(header[i].getSetId())){
//             	continue;
//             }
            String fixstyle = "'locked_top " + fixrowstyle + "'";
            if (i < fixcol) {
                fixstyle = "'locked_top " + fixcolstyle + " " + fixrowstyle + "' style='z-index: 3' ";   // �̶���
            }
            if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[i].getItemProperty()) || InfoItemBO.DATA_TYPE_CLOB.equals(header[i].getItemDataType())) {
                continue;
            } else {
                if (header[i].isShowId()) {
                    if (InfoItemBO.DATA_TYPE_CODE.equals(header[i].getItemDataType())) {
                        out.println("<td align='center' id=\"locked\"  class=" + fixstyle + " nowrap >" + header[i].getItemName() + "����</td>");
                    }
                    out.println("<td id=\"locked\"  align='center' class=" + fixstyle + " nowrap >" + header[i].getItemName() + "</td>");
                } else {
                    if (InfoItemBO.DATA_TYPE_INT.equals(header[i].getItemDataType()) || InfoItemBO.DATA_TYPE_FLOAT.equals(header[i].getItemDataType())){
                        if ("true".equals(WageList)){
                            out.println("<td id=\"locked\"  align='center' class=" + fixstyle + " nowrap ><a style='COLOR: #2f547e;cursor:pointer;' onclick=\"window.showModalDialog('/pages/common/activepage/ShowWageItem.jsp?ColName="+header[i].getItemName()+"&Col="+header[i].getItemId()+"','','dialogTop:'+(event.screenY+20)+'px;dialogLeft:'+(event.screenX+20)+'px;dialogWidth:350px;dialogHeight:400px')\" >" + header[i].getItemName() + "</a></td>");
                        }
                        else if ("true".equals(BaseCountList)){
                            out.println("<td id=\"locked\"  align='center' class=" + fixstyle + " nowrap ><a style='COLOR: #2f547e;cursor:pointer;' onclick=\"window.showModalDialog('/pages/common/activepage/ShowCountItem.jsp?ColName="+header[i].getItemName()+"&Col="+header[i].getItemId()+"','','dialogTop:'+(event.screenY+20)+'px;dialogLeft:'+(event.screenX+20)+'px;dialogWidth:350px;dialogHeight:400px')\" >" + header[i].getItemName() + "</a></td>");
                        }
                        else{
                            out.println("<td id=\"locked\"  align='center' class=" + fixstyle + " nowrap ><a style='COLOR: #2f547e;cursor:pointer;' onclick=\"window.showModalDialog('/common/activepage/ShowStatic.jsf?ColName="+header[i].getItemName()+"&Col="+header[i].getItemId()+"','','dialogTop:'+(event.screenY+20)+'px;dialogLeft:'+(event.screenX+20)+'px;dialogWidth:250px;dialogHeight:250px')\" >" + header[i].getItemName() + "</a></td>");
                        }
                    }
                    else if (InfoItemBO.DATA_TYPE_CODE.equals(header[i].getItemDataType())) {
                       out.println("<td id=\"locked\"  align='center' class=" + fixstyle + " nowrap ><a style='COLOR: #2f547e;cursor:pointer;' onclick=\"window.showModalDialog('/common/activepage/ShowGroup.jsf?ColName="+header[i].getItemName()+"&Col="+header[i].getItemId()+"','','dialogTop:'+(event.screenY+20)+'px;dialogLeft:'+(event.screenX+20)+'px;dialogWidth:300px;dialogHeight:500px')\" >" + header[i].getItemName() + "</a></td>");
                    }
                    else if (InfoItemBO.DATA_TYPE_ORG.equals(header[i].getItemDataType())) {
                       out.println("<td id=\"locked\"  align='center' class=" + fixstyle + " nowrap ><a style='COLOR: #2f547e;cursor:pointer;' onclick=\"window.showModalDialog('/common/activepage/ShowOrg.jsf?ColName="+header[i].getItemName()+"&Col="+header[i].getItemId()+"','','dialogTop:'+(event.screenY+20)+'px;dialogLeft:'+(event.screenX+20)+'px;dialogWidth:300px;dialogHeight:500px')\" >" + header[i].getItemName() + "</a></td>");
                    }
                    else{
                        out.println("<td id=\"locked\"  align='center' class=" + fixstyle + " nowrap >" + header[i].getItemName() + "</td>");
                    }
                }
            }
        }

        //�������༭�Ļ������б�ά������,�ں�
        if (hasEdit && !isForward) {
            if (editName != null && editName.length > 0) {
                for (int e = 0; e < editName.length; e++) {
                    out.println("<td id=\"locked\" class='locked_top " + fixrowstyle + "' align=center nowrap>");
                    if (editName[e].equals("view")) editName[e] = "�鿴";
                    out.println(editName[e]);
                    out.println("</td>");
                }
            }
        }
        out.println("</tr> ");

        //�Ȱ���ѭ��
        // ��������
        if (keyName == null || "".equals(keyName)) {
            if (table.getSetId() != null && !"".equals(table.getSetId())) {
                keyName = table.getSetPk();//�Ӽ�������
            } else if (rownum > 0) {
                String setType = rows[0].getCell()[0].getSetId().substring(0, 1);//�Ӽ���A�໹��B��
                keyName = InfoSetBO.getPkType(setType);
            }
        }
        int idIndex = -1; // id��������
        int curIndex = -1; // �Ƿ�ǰ��¼��������
        if (rownum > 0) {
            idIndex = rows[0].getCellIndex(keyName);
            curIndex = rows[0].getCellIndex(table.getSetId() + "000");
        }
        for (int i = 0; i < rownum; i++) {
            RecordVO row = rows[i]; //�õ�ĳһ��
            out.println("<tr onclick=" + trFubc + ">");
            String rowId = "[" + i + "]";
            if (rownum == 1) {
                rowId = "";
            }

            String backValue = "";
            // �ٰ���
            for (int j = 0; j < colnum; j++) {
                CellVO cell = row.getCell()[j];
//             	if(!itemMap.containsKey(cell.getItemId()) && cell.getItemId().startsWith(cell.getSetId()) && !cell.getItemId().endsWith("000")){
//                 	continue;
//                 }
                String fixstyle = "'td_middle'";
                if (j < fixcol) {
                    fixstyle = "'td_relativemiddle " + fixcolstyle + "'";
                }
                fixstyle = fixstyle.trim();

                int right = cell.getPermission();//ָ���Ȩ��

                String idValue = "";

                //�õ�������ֵ
                idValue = row.getCell()[idIndex].getValue();
                backValue = idValue;

                //�õ���һ�е�ֵ
                String value = CommonFuns.filterNull(cell.getValue());
                switch (right) {
                    case 1:
//                         value = "*****";
                        break;
                    case 2:
                    case 3:
                        break;
                }

                //��һ�л�checkBox����radioButton ����ά������
                if (j == 0) {
                    if (hasOperSign || self) {
                        String title = "";
                        WageErrReportBO wbo = null;
                        WageNoteBO wagenote=null;
                        if ("true".equals(maskError)) {
                            wbo = (WageErrReportBO) errhr.get(idValue);
                            if (wbo != null) {
                                title = wbo.getErrDes() + "  ԭӦ��:" + CommonFuns.filterNull(wbo.getOldSalaray()) + " �޸ĺ�Ӧ��:" + CommonFuns.filterNull(wbo.getNewSalaray());
                            }
                        }
                        if ("true".equals(maskWarn)) {
                            wagenote=(WageNoteBO)warnhr.get(idValue);
                            if (wagenote!=null){
                                title+=wagenote.getDesc();
                            }
                            if (tempPerson!=null && tempPerson.get(idValue)!=null){
                                title+=" ��ʱ��н��Ա";
                            }
                        }

                        if (fixcol > 0) {
                            out.println("<td align=center style='position:relative' class='td_middle " + fixcolstyle + "' width=45px title='" + title + "'>");
                        } else {
                            out.println("<td align=center class='td_middle ' width=45px title='" + title + "'>");
                        }

                        // ����ǰ��¼���
                        if(!"A010".equals(table.getSetId()) && !"B200".equals(table.getSetId())){
	                        if (curIndex != -1) { // �и���
	                            CellVO curCV = row.getCell()[curIndex];
	                            if ("00901".equals(curCV.getValue())) {
	                                out.println("<img src='/images/arrow1.gif'>");
	                            }
	                        }
                        }

                        if (wbo != null) { // �����Ǵ���
                            out.println("<img src='/images/common/unvalidate.gif'>");
                        }
                        if (wagenote!=null || (tempPerson!=null && tempPerson.get(idValue)!=null)){   // �����Ǿ���
                            out.println("<img src='/images/common/warn.gif'>");
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
                                if (fixcol > 0) {
                                    out.println("<td align=center style='position:relative' class='td_middle " + fixcolstyle + "' nowrap>");
                                } else {
                                    out.println("<td align=center class=td_middle nowrap>");
                                }
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

                if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[j].getItemProperty())) {
                    // ��ֵ�Ͳ����Ҷ���
                    if (InfoItemBO.DATA_TYPE_FLOAT.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_INT.equals(cell.getItemDataType())) {
                        align = "align="+Constants.ACTIVE_LIST_ALIGN_NUMBER;
                    }
                    else{
                        align = "align="+Constants.ACTIVE_LIST_ALIGN_TEXT;
                    }

                    if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) {   //�߼���ѯʹ��
                            out.println("<td class=" + fixstyle + "  nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            if (value.length() > 4) {
                                out.println(value.substring(4, value.length()));
                            } else {
                                out.println(CommonFuns.filterNull(value));
                            }
                            out.println("&nbsp;</td>");
                            out.println("<td class=" + fixstyle + "   nowrap " + styleEvent + "  onclick=\"javascript:" + func + "\" >");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode(CommonFuns.filterNull(cell.getItemCodeSet()), value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=" + fixstyle + " "+align+" nowrap " + styleEvent + "  onclick=\"javascript:" + func + "\" >");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode(CommonFuns.filterNull(cell.getItemCodeSet()), value)));
                            out.println("&nbsp;</td>");
                        }
                    }
                    else  if (InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) { //�߼���ѯʹ��
                            out.println("<td class=" + fixstyle + " "+align+"  nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(value));
                            out.println("&nbsp;</td>");
                            out.println("<td class=" + fixstyle + " " +align+" nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            if (!"".equals(linkDept) && linkDept != null && !QueryBO.LINK_DEPT_NO.equals(linkDept) && "A001705".equals(cell.getItemId())) {     // ������ʾ����
                                OrgBO bo = SysCacheTool.findOrgById(value);
                                OrgBO superbo = SysCacheTool.findOrgById(bo.getSuperId());
                                if (superbo != null && OrgBO.DEPTTYPE.equals(superbo.getorgType())) {
                                    out.println(CommonFuns.filterNull(superbo.getName() + bo.getName()));
                                } else {
                                    out.println(CommonFuns.filterNull(bo.getName()));
                                }
                            } else {
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("OU", value)));
                            }

                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=" + fixstyle + "  "+align+" nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            if ("C001010".equals(cell.getItemId())) {
                                out.println(CommonFuns.filterNull(OrgTool.getOrgByDeptName(value)));
                            } else {
                                if (!"".equals(linkDept) && linkDept != null && !QueryBO.LINK_DEPT_NO.equals(linkDept) && "A001705".equals(cell.getItemId())) {     // ������ʾ����
                                    OrgBO bo = SysCacheTool.findOrgById(value);
                                    if (bo != null) {
                                        OrgBO superbo = SysCacheTool.findOrgById(bo.getSuperId());
                                        if (superbo != null && OrgBO.DEPTTYPE.equals(superbo.getorgType())) {
                                            out.println(CommonFuns.filterNull(superbo.getName() + bo.getName()));
                                        } else {
                                            out.println(CommonFuns.filterNull(bo.getName()));
                                        }
                                    }
                                } else {
                                    out.println(CommonFuns.filterNull(CodeUtil.interpertCode("OU", value)));
                                }
                            }
                            out.println("&nbsp;</td>");
                        }
                    } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) {
                            out.println("<td class=" + fixstyle + " "+align+" nowrap  " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(value));
                            out.println("&nbsp;</td>");
                            out.println("<td class=" + fixstyle + " nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PE", value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=" + fixstyle + "  "+align+" nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PE", value)));
                            out.println("&nbsp;</td>");
                        }
                    } else if (InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) {
                            out.println("<td class=" + fixstyle + " "+align+" nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(value));
                            out.println("&nbsp;</td>");
                            out.println("<td class=" + fixstyle + " "+align+" nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PO", value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=" + fixstyle + " "+align+" nowrap  " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PO", value)));
                            out.println("&nbsp;</td>");
                        }
                    } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                        if (cell.isShowId()) {
                            out.println("<td class=" + fixstyle + " nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(value));
                            out.println("&nbsp;</td>");
                            out.println("<td class=" + fixstyle + " "+align+" nowrap  " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PA", value)));
                            out.println("&nbsp;</td>");
                        } else {
                            out.println("<td class=" + fixstyle + " "+align+" nowrap  " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                            out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PA", value)));
                            out.println("&nbsp;</td>");
                        }
                    }
                    else if (InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType())) {
                        continue;
                    }
                    else if (InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType())) {   // ͼƬ
                        out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + " onclick='return EditPhotoField(\""+value+"\",\""+cell.getItemId()+"\",\""+idValue+"\")'>�鿴ͼƬ</td>");
                    }
                    else if ("A815712".equals(cell.getItemId())) {  //ʵ������(A815712)
                        if (value.indexOf("-") >= 0) {  // ��ֵ
                            out.println("<td class=" + fixstyle + align + " nowrap " + styleEvent + "  onclick=\"javascript:" + func + "\">" + "<img src='/images/common/unvalidate.gif'><font color='red'>" + value + "&nbsp;</font></td>");
                        } else {
                            out.println("<td class=" + fixstyle + align + " nowrap " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                        }
                    } else if ("A001001".equals(cell.getItemId())) {
                        if (idValue.startsWith("@")) {
                            out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value + "(��ְ)" + "</font>&nbsp;</td>");
                        } else if (idValue.startsWith("#")) {
                            out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value + "(����)" + "</font>&nbsp;</td>");
                        } else if (idValue.startsWith("!")) {
                            out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value + "(��Ƹ)" + "</font>&nbsp;</td>");
                        }
                        else {
                            out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                        }
                    } else if (InfoItemBO.DATA_TYPE_WAGEDEPT.equals(cell.getItemDataType())) {  //A001743	A001	н�ʲ���
                        if (value.length() > Integer.parseInt(Constants.WAGE_DEPT_CODELEN)) {
                            out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value.substring(Integer.parseInt(Constants.WAGE_DEPT_CODELEN)) + "&nbsp;</td>");
                        } else {
                            out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                        }
                    }
                    else if (InfoItemBO.DATA_TYPE_REMARK.equals(cell.getItemDataType())) {
                        if (value.length()<=80){
                            out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                        }
                        else{
                            out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value.substring(0,80) + " ...  &nbsp;</td>");
                        }
                    }
                    else {
                        out.println("<td class=" + fixstyle + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
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

        out.println("</table></td></tr>");
        out.println("</table>");
        out.println("</div>");
    }
%>

<input type="hidden" name="pageFlag">
<input type="hidden" name="pageNum">
<input type="hidden" name="sortField">

<script language=javascript>
    try{
        listControl=list;
    }
    catch(e){
                
    }
    <%
//        if ("".equals(fixrowstyle)){
//           out.print("FixID=window.setInterval('setFix()', 700);");
//        }
//         ������
        if (fixcol!=-1 && "".equals(fixcolstyle)){
           out.print("tableFixCol="+fixcol+";");
           out.print("FixColID=window.setInterval('setFixCol()', 1);");
        }

    %>
    var rowNum = <%=rowNum%>;
</script>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             