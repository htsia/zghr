<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.emp.util.PersonTool" %>
<%@ page import="java.util.HashMap" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
    TableVO table = (TableVO) request.getAttribute("batch_new");
    String pid = (String) session.getAttribute("batch_perlist");
    boolean isEdit = true;
    boolean boolSelf = false;
    String flag = request.getParameter("flag");
    String fk = request.getParameter("fk");
    String setId = request.getParameter("setId");
    String pk = request.getParameter("pk");
    String photo = "display:none";
    String itemIdName = "";
    if (table != null) {
        int tableright = table.getPermission();
        if (tableright == TableVO.PERMISSON_REFUSE) {
            //拒绝的权限
            out.println("<font color=#0033CC>对不起，您没有权限查看该指标集！</font>");
            return;
        }

        String tableRt = "";
        switch (tableright) {
            case TableVO.PERMISSON_READ://读的权限
                tableRt = "disabled";
                break;
            case TableVO.PERMISSON_WRITE://写的权限
                tableRt = "";
                break;
        }

        //out.println("<form name=\"activeForm\" "+encode+"  method=\"post\" action=\"/per/infoDetail.do\">");

        //1:1 表
        RecordVO[] rsv = table.getRowData();
        CellVO[] row = null;
        //如果TableVO的行记录没有数据，则把TableVO的头部赋给RecordVO
        if (rsv == null || rsv.length == 0) {
            rsv = new RecordVO[1];
            rsv[0] = new RecordVO(table.getHeader());
            table.setRowData(rsv);
        }
        row = rsv[0].getCell();
        int colnum = row.length;
        int count = 0;

        out.println("<br><table width=95% align=center border=0 cellpadding=0 cellspacing=0>");
        //画表格
        StringBuffer input = new StringBuffer();
        StringBuffer check = new StringBuffer();
        StringBuffer id = new StringBuffer();
        StringBuffer next = new StringBuffer();
        StringBuffer value = new StringBuffer();

        String itemId = null;
        String itemName = null;

        String cellRight = "";

        String cellType = "";
        String property = null;
        String maskValue = null;
        String realValue = null;

        String formula = null;
        String datatype = null;
        //修改参数
        RecordVO [] rows = table.getRowData();

        String rsType = table.getSet_rsType();//子集是单记录还是多记录
        if (InfoSetBO.RS_TYPE_SINGLE.equals(rsType)) {
            pk = ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).getValue();
            if (pk == null) {
                ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).setValue(fk);
                pk = fk;
            } else {
                fk = pk;
            }
            flag = "2";
        } else {
            pk = ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).getValue();
        }
        for (int j = 0; j < colnum; j++) {
            CellVO cell = row[j];
            if (boolSelf && InfoItemBO.INFO_ITEM_SELF.equals(cell.getItemSelf())) {
                continue;
            }
            cellType = cell.getItemDataType();//指标的数据类型
            property = cell.getItemProperty();//指标的属性
            itemId = CommonFuns.filterNull(cell.getItemId());//指标的数据库代码
            itemName = CommonFuns.filterNull(cell.getItemName());//指标的中文名称
            maskValue = CommonFuns.filterNull(cell.getValue());//指标的值

            formula = " formula='" + CommonFuns.filterNull(cell.getItemFormula()) + "' ";//指标对应的要调用的javascript方法
            if (cell.getValue() == null) {
                maskValue = CommonFuns.filterNull(cell.getItemDefaultValue());
            }
            realValue = maskValue;

            if (InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode("OU", maskValue);  //翻译机构型指标
            } else if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {
                if (maskValue != null && !"".equals(maskValue)) {
                    maskValue = CodeUtil.interpertCode("CODE", maskValue);//翻译代码型指标
                }
            } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode("PE", maskValue);  //翻译人员型指标
            } else if (InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode("PO", maskValue);//翻译岗位型指标
            } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode("PA", maskValue);//翻译党组织型指标
            } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode("OU", maskValue); //翻译发薪机构
            }

            String msg = " <font color=red>" + CommonFuns.filterNull(cell.getItemDesc()) + "</font>";//指标的注释
            String nextType = "";
            String operRight = "";
            //指标的不同权限，在页面不同显示(隐藏、只读、可写)
            switch (cell.getPermission()) {
                case CellVO.PERMISSION_REFUSE:
                    if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(cell.getItemProperty())) {
                        cellRight = " readonly ";
                        maskValue = "**********";
                        operRight = "disabled";
                    }
                    break;
                case CellVO.PERMISSION_READ:
                    cellRight = " readonly ";
                    operRight = "disabled";
                    break;
                case CellVO.PERMISSION_WRITE:
                    cellRight = " ";
                    operRight = "";
                    break;
                default:
                    cellRight = " ";
                    operRight = "";
                    break;
            }
            if (InfoItemBO.PROPERTY_CONTROL_SHOW.equals(cell.getItemProperty())) {
                cellRight = " readonly ";
                operRight = "disabled";
            }
            if (!isEdit) {
                cellRight = " readonly ";
                msg = "";
            }
             if(InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_DATE.equals(cell.getItemDataType())||InfoItemBO.DATA_TYPE_DATE6.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType())||InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())
                    || InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType())){
                cellRight = " readonly ";
            }
            check.delete(0, check.length());//指标的校验（非空、数字、日期等）
            //指标的长度
            String length = cell.getItemDataLength();
            if (length == null || "".equals(length)) {
                if (InfoItemBO.DATA_TYPE_REMARK.equals(cellType)) {
                    length = "1000";
                } else if (InfoItemBO.DATA_TYPE_STRING.equals(cellType)) {
                    length = "100";
                }
            }
            //指标的校验（非空、数字、日期等）
              //指标的校验（非空、数字、日期等）
            String notNull = CommonFuns.filterNull(cell.getItemNotNull());
            if("1".equals(notNull)){
                 notNull = "0";
            }else{
                 notNull = "1";
            }
            check.append(" alt=\"")
                    .append(CommonFuns.filterNull(cell.getItemName())).append("|")
                    .append(CommonFuns.filterNull(notNull)).append("|")
                    .append(InfoItemBO.getHtmlDataType(cell.getItemDataType())).append("|")
                    .append(CommonFuns.filterNull(length)).append("|")
                    .append(CommonFuns.filterNull(cell.getItemMin())).append("|")
                    .append(CommonFuns.filterNull(cell.getItemMax())).append("\"");

            id.delete(0, id.length());
            id.append(" id=\"").append(cell.getItemId()).append("\"");

            next.delete(0, next.length());
            next.append(" next=\"");

            value.delete(0, value.length());
            value.append(" value=\"").append(maskValue).append("\"");
            //指标对应的表单含的javascript函数
            String event = " ";

            if (j < colnum - 1) {
                nextType = row[j + 1].getItemDataType();
                next.append(row[j + 1].getItemId()).append("\"");
            } else if (j == colnum - 1) {
                next.append("\"");
            }
            //隐藏指标
            if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(property)) {
                out.print("<input " + id.toString() + " "
                        + next.toString()
                        + " name=\"" + cell.getItemId()
                        + "\" type=\"hidden\" class=\"input\" value='" + CommonFuns.filterNull(realValue) + "'>");
            } else {
                if (count % 2 == 0) {
                    out.println("<tr nowrap>");
                }
                input.delete(0, input.length());
                //clob类型的指标,照片
                if (InfoItemBO.DATA_TYPE_CLOB.equals(cellType)) {
                    photo = "";
                    itemIdName = cell.getItemId();
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" type=\"hidden\" class=\"input\">");
                    out.println("<td class=td_form01  >" + itemName + "</td>");
                    out.print(input.toString());
                    out.print("<td  class=td_form02  nowrap >");
                    if (isEdit) {
                        out.print("<iframe name=uploadPhoto frameBorder=0 width=280 height=22 scrolling=no src='/jsp/common/uploadPhoto.jsp?itemId=" + itemIdName + "&pkvalue=" + CommonFuns.filterNull(pk) + "'></iframe>");
                    }
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_CODE.equals(cellType)) {//代码型指标处理
                    // todo 代码的显示格式
                    if ("1".equals(cell.getItemIsSelect())) {

                        out.println("<td class=td_form01 >" + itemName + "</td>");
                        out.print("<td class=td_form02 >");
                        out.println("<select name=" + itemId + " style='width:140'   " + cellRight + ">");
                        if (!isEdit || "readonly".equals(cellRight)) {   //如果是只读的
                            if ("".equals(CommonFuns.filterNull(realValue))) {
                                out.println("<option  value=\"\">---请选择---</option>");
                            } else {
                                out.println("<option  value=" + realValue + ">" + value + "</option>");
                            }

                        } else { //可编辑的
                            List list = SysCacheTool.queryCodeItemBySetId(cell.getItemCodeSet());
                            out.println("<option  value=\"\">---请选择---</option>");
                            if (list != null) {
                                for (int i = 0; i < list.size(); i++) {
                                    CodeItemBO cb = (CodeItemBO) list.get(i);
                                    if (cb != null) {
                                        String sel = "";
                                        if (CommonFuns.filterNull(cb.getItemId()).equals(realValue)) {
                                            sel = "selected";
                                        }
                                        out.println("<option  value=" + CommonFuns.filterNull(cb.getItemId()) + " " + sel + ">" + CommonFuns.filterNull(cb.getItemName()) + "</option>");
                                    }
                                }
                            }
                        }

                    } else {
                        input.append("<input name=\"")
                                .append(itemId).append("\"")
                                .append(" type=\"text\" class=\"input\" ")
                                .append(cellRight)
                                .append(id)
                                .append(next)
                                .append(check)
                                .append(event)
                                .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                                .append(" code=\"").append(realValue).append("\" ")
                                .append(value)
                                .append(">");

                        out.println("<td class=td_form01 >" + itemName + "</td>");
                        out.print("<td class=td_form02 >");
                        out.print(input.toString());
                        if (isEdit) {
                            out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCodeDlgOneControl('" + cell.getItemId().trim() + "')\">");
                        }
                    }
                    out.println(msg);
                    out.println("</td>");

                } else if (InfoItemBO.DATA_TYPE_POST.equals(cellType)) {//岗位型指标的处理
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                            .append(" code=\"").append(realValue).append("\" ")
                            .append(value)
                            .append(">");
                    out.println("<td class=td_form01 >" + itemName + "</td>");
                    out.print("<td class=td_form02 >");
                    out.print(input.toString());
                    if (isEdit) {
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" if onclick=\"fPopUpPostDlg('" + cell.getItemId().trim() + "')\">");


                    }
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_COMPUTE.equals(cellType)) {//计算型指标
                    input.append("<input  name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(formula)
                            .append(value)
                            .append(">");
                    out.println("<td  class=td_form01 >" + itemName + "</td>");
                    out.print("<td  class=td_form02>");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_DATE.equals(cellType)) {//日期型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(value)
                            .append(event)
                            .append(">");
                    out.println("<td  class=td_form01 >" + itemName + "</td>");
                    out.print("<td  class=td_form02>");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCalendarDialog('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                }else if (InfoItemBO.DATA_TYPE_DATE6.equals(cellType)) {//六位日期型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(value)
                            .append(event)
                            .append(">");
                    out.println("<td  class=td_form01 width=\"20%\" >" + itemName + "</td>");
                    out.print("<td  class=td_form02 width=\"30%\" >");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCalendarDlg_OnlyMonth('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else
                if (InfoItemBO.DATA_TYPE_FLOAT.equals(cellType) || InfoItemBO.DATA_TYPE_INT.equals(cellType)) {//数值型
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(formula)
                            .append(value)
                            .append(event)
                            .append(">");
                    out.println("<td  class=td_form01 >" + itemName + "</td>");
                    out.print("<td  class=td_form02>");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_ORG.equals(cellType)) { //机构型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("OU").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    out.println("<td  class=td_form01 >" + itemName + "</td>");
                    out.print("<td  class=td_form02>");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpOrgDlg('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_REMARK.equals(cellType)) { //备注型指标
                    input.append("<textarea name=\"")
                            .append(itemId).append("\"")
                            .append(" cols=\"80\" rows=\"3\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
//                      .append(event)
                            .append(">")
                            .append(maskValue)
                            .append("</textarea>");
                    out.println("<td  class=td_form01 >" + itemName + "</td>");
                    out.print("<td  class=td_form02 colspan=\"3\">");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                    count++;
                } else if (InfoItemBO.DATA_TYPE_STRING.equals(cellType)) { //字符型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(value)
                            .append(">");
                    out.println("<td class=td_form01 >" + itemName + "</td>");
                    out.print("<td  class=td_form02>");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cellType)) { //人员型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" readOnly")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                            .append(" code=\"").append(realValue).append("\" ")
                            .append(value)
                            .append(">");
                    out.println("<td class=td_form01 >" + itemName + "</td>");
                    out.print("<td  class=td_form02>");
                    out.print(input.toString());
                    if (isEdit) {
                        String click = "fPopUpPerDlg('" + itemId + "')";
                        out.print("<input type=\"button\" " + operRight + " class=\"buttonface03\" value=\"选择人员\" onclick=\"" + click + "\" >");
                    }
                    out.println(msg);
                    out.println("</td>");
                }
                if (InfoItemBO.DATA_TYPE_REMARK.equals(nextType) && !InfoItemBO.DATA_TYPE_REMARK.equals(cellType) && count % 2 != 1)
                {
                    out.println("<td class=td_form01 >&nbsp;</td>");
                    out.print("<td class=td_form02>");
                    out.print("&nbsp;");
                    out.println("</td>");
                    count++;
                }
                if (count % 2 == 1) {
                    out.println("</tr>");
                }
                count++;
            }
        }
        out.println("</table><br>");
        if (isEdit) {
            out.println("<table width=95% border=0 align=center cellpadding=0 cellspacing=0>");
            out.println("<tr><td height=12></td></tr>");
            out.println("<tr>");
            out.println("<td align=right>");
            out.println("<input name=save  type=button class=button01 value= '保存' " + tableRt + " onclick=forsave(document.forms(0))>");
            if (InfoSetBO.RS_TYPE_MANY.equals(table.getSet_rsType())) {
                out.println("<input name=back  type=button class=button01 value= '返回' " + tableRt + " onclick=forBack(document.forms(0))>");
            }
            out.println("</td>");
            out.println("</tr>");
            out.println("</table>");
        }
        out.println("<input type=hidden name=flag value='" + CommonFuns.filterNull(flag) + "'>");
        out.println("<input type=hidden name=fk value='" + CommonFuns.filterNull(fk) + "'>");
        out.println("<input type=hidden name=setId value='" + CommonFuns.filterNull(setId) + "'>");
        out.println("<input type=hidden name=pk value='" + CommonFuns.filterNull(pk) + "'>");
        out.println("<input type=hidden name=chk value='" + CommonFuns.filterNull(pid) + "'>");
        //修改parent页面参数
        out.println("<script language=\"javascript\">");
        //out.println(" parent.document.all.fk.value=document.all.fk.value;");
        out.println("</script >");

    }


    if (setId != null && !"".equals(setId)) {
        ArrayList list = (ArrayList) request.getAttribute("batch_pers");
        if (list != null && list.size() > 0) {

            TableVO table2 = (TableVO) request.getAttribute("batch_cur");
            String[] pids = pid.split(",");
            HashMap map = PersonTool.setTable(table2, pids);
            int[] ff = new int[map.size()];
            RecordVO[] r2 = new RecordVO[map.size()];
            for (int m = 0; m < map.size(); m++) {
                if ((RecordVO) map.get(pids[m]) == null) {
                    ff[m] = 1;
                } else {
                    r2[m] = (RecordVO) map.get(pids[m]);
                }
            }
            CellVO[] header = table2.getHeader();
            int colnum = header.length;

            out.println("<table width=95% border=0 cellspacing=0 cellpadding=0 align=center>");
            //draw  header 画列表头
            out.println("<tr>");
            if (!setId.equals("A001"))
                out.println("<td class=td_top nowrap>姓名</td>");
            for (int i = 0; i < colnum; i++) {
                if (InfoItemBO.DATA_TYPE_CLOB.equals(header[i].getItemDataType())
                        || InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[i].getItemProperty())) {
                    continue;
                }
                out.println("<td class=td_top nowrap>" + header[i].getItemName() + "</td>");
            }
            out.println("</tr>");
            //end 画表头
            //draw table body
            int k = 0;
            for (int i = 0; i < list.size(); i++) {
                PersonBO bo = (PersonBO) list.get(i);
                out.println("<tr>");
                if (!setId.equals("A001")) {
                    out.println("<td class=td_02 nowrap>");
                    out.println(CommonFuns.filterNull(bo.getName()));
                    out.println("</td>");
                }
                if (ff[i] == 1) {
                    for (int j = 0; j < colnum; j++) {

                        out.println("<td class=td_02 nowrap >");
                        out.println("  ");
                        out.println("</td>");
                    }

                } else {
                    RecordVO r3 = null;
                    if (r2.length < list.size()) {
                        r3 = r2[k++];
                    } else {
                        r3 = r2[i];
                    }
                    //    String idValue=((CellVO)row.cellArray2Hash().get(table1.getSetPk())).getValue();
                    for (int j = 0; j < colnum; j++) {
                        CellVO cell = r3.getCell()[j];
                        int right = cell.getPermission();
                        String value = CommonFuns.filterNull(cell.getValue());
                        switch (right) {
                            case 1:
                                value = "********";
                                break;
                            case 2:
                            case 3:
                                break;
                        }

                        if (InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType()) || InfoItemBO.PROPERTY_CONTROL_HIDE.equals(cell.getItemProperty()))
                        {
                            continue;
                        } else if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {

                            out.println("<td class=td_middle nowrap   >");
                            out.println(CodeUtil.interpertCode(CommonFuns.filterNull(cell.getItemCodeSet()), value));
                            out.println("&nbsp;</td>");
                        } else
                        if (InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType()))
                        {
                            out.println("<td class=td_middle nowrap   > ");
                            out.println(CodeUtil.interpertCode("OU", value));
                            out.println("&nbsp;</td>");
                        } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType())) {
                            out.println("<td class=td_middle nowrap   > ");
                            out.println(CodeUtil.interpertCode("PE", value));
                            out.println("&nbsp;</td>");
                        } else if (InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType())) {
                            out.println("<td class=td_middle nowrap  > ");
                            out.println(CodeUtil.interpertCode("PO", value));
                            out.println("&nbsp;</td>");
                        } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                            out.println("<td class=td_middle nowrap > ");
                            out.println(CodeUtil.interpertCode("PA", value));
                            out.println("&nbsp;</td>");
                        } else if (InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType())) {
                            continue;
                        } else if (InfoItemBO.DATA_TYPE_REMARK.equals(cell.getItemDataType())) {
                            continue;
                        } else {
                            out.println("<td class=td_middle nowrap >" + value + "&nbsp;</td>");
                        }
                    }
                }//end 画表体

            }
            out.println("</tr>");
            out.println("</table>");
        }

    }

%>
<script language=javascript>

    function selPost(idf, org) {
        obj = document.all(org);
        if (obj.value == null || obj.value == "") {
            alert("在选岗位时，部门不能为空");
            return;
        }
        var arg = parent.CSApp;
        fPopUpPostDlgByOrg(idf, obj.code, arg);
    }
    function selPostNo(idf) {
        var arg = parent.CSApp;
        fPopUpPostDlg(idf, arg);
    }
</script>
